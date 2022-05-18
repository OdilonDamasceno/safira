import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:safira/app/data/models/cover.dart';
import 'package:safira/app/data/models/recording.dart';
import 'package:safira/app/data/providers/cover_provider.dart';
import 'package:safira/app/data/providers/youtube_provider.dart';
import 'package:safira/app/utils/cover_asset.dart';

class SafiraAudioService extends GetxController {
  final GetStorage _storage = GetStorage('queue_data');

  final AudioPlayer _audioPlayer = AudioPlayer();

  final YoutubeProvider _youtubeProvider = YoutubeProvider();

  final CoverProvider _coverProvider = Get.find<CoverProvider>();

  final Rx<ConcatenatingAudioSource> _playlist = ConcatenatingAudioSource(
    children: [],
  ).obs;

  final RxBool _playing = false.obs;

  final RxBool _isLastMusic = true.obs;

  final RxInt? _currentIndex = null;

  final RxBool _hasPrevious = false.obs;

  final RxBool _playable = false.obs;

  final RxBool _shuffleModeEnabled = false.obs;

  final Rx<Duration> _position = Duration(milliseconds: 0).obs;

  final Rx<Duration> _bufferedPosition = Duration(milliseconds: 0).obs;

  final Rx<MediaItem> _currentMusicMetadata = MediaItem(id: '', title: '').obs;

  final Rx<LoopMode> loopMode = LoopMode.off.obs;

  final CoverAsset _coverAsset = CoverAsset();

  late final File? defaultCover;

  @override
  void onInit() async {
    var queue = _storage.read<List<dynamic>>('queue');
    try {
      _playlist(await setAudioSource(
        ConcatenatingAudioSource(
          children: queue?.map((e) {
                return AudioSource.uri(
                  Uri.parse(e['url']),
                  tag: MediaItem(
                    id: e['tag']['id'],
                    title: e['tag']['title'],
                    album: e['tag']['album'],
                    artist: e['tag']['artist'],
                    artUri: (e['tag']['artUri'] as String).contains('file://')
                        ? Uri.file(e['tag']['artUri'])
                        : Uri.parse(e['tag']['artUri']),
                  ),
                );
              }).toList() ??
              [],
        ),
      ));
    } catch (_) {
      _storage.erase();
    }
    defaultCover = await _coverAsset.getFile('assets/noalbum.jpg');
    _listenCurrentIndex();
    _listenMusicIsPlaying();
    _listenIsLastMusic();
    _listenStateMusic();
    _listenPositon();
    _listenBufferedPosition();
    _listenShuffleMode();
    _listenPlaylistChanges();
    super.onInit();
  }

  @override
  void onClose() async {
    await clearQueue();
  }

  Rx<ConcatenatingAudioSource> get playlist => _playlist;

  AudioPlayer get audioPlayer => _audioPlayer;

  Rx<Duration> get position => _position;

  Rx<Duration> get bufferedPosition => _bufferedPosition;

  RxBool get playing => _playing;

  RxBool get isLastMusic => _isLastMusic;

  RxBool get hasPrevious => _hasPrevious;

  RxInt? get currentIndex => _currentIndex;

  RxBool get playable => _playable;

  RxBool get shuffleModeEnabled => _shuffleModeEnabled;

  Rx<MediaItem?>? get currentMusicMetadata => _currentMusicMetadata;

  Future<void> addAllToQueue(List<Recording> tracks) async =>
      Future.wait(tracks.map((track) => addToQueue(track)));

  Future<void> addToQueue(Recording? track) async {
    if (track != null) {
      Cover? cover = await _coverProvider.getCover(
        track.releases?.first.id ?? '',
      );

      String url = await _youtubeProvider.searchAndGetUrl(track);

      String? coverImage = cover?.images?.first.image;

      Uri artUri = coverImage != null
          ? Uri.parse(coverImage)
          : Uri.file(defaultCover?.path ?? '');

      await _playlist.value.add(AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: track.id!,
          title: track.title!,
          album: track.releases?.first.title,
          artist: track.artistCredit?.map((artist) => artist.name).join(', '),
          artUri: artUri,
        ),
      ));

      _playlist.refresh();
    }
  }

  Future<void> clearQueue() => _playlist.value.clear();

  Future<ConcatenatingAudioSource?> setAudioSource(
      [ConcatenatingAudioSource? audios]) async {
    await _audioPlayer.setAudioSource(audios ?? _playlist.value);
    return audios ?? _playlist.value;
  }

  Future<void> move(int oldIndex, int newIndex) async {
    await _playlist.value.move(oldIndex, newIndex);
    return _playlist.refresh();
  }

  Future<void> removeAt(int index) async {
    await _playlist.value.removeAt(index);
    return _playlist.refresh();
  }

  Future<void> play() => _audioPlayer.play();

  Future<void> pause() => _audioPlayer.pause();

  Future<void> stop() => _audioPlayer.stop();

  Future<void> seekToNext() => _audioPlayer.seekToNext();

  Future<void> seekToPrevious() => _audioPlayer.seekToPrevious();

  Future<void> setLoopMode(LoopMode mode) {
    loopMode(mode);
    return _audioPlayer.setLoopMode(mode);
  }

  Future<void> setShuffleModeEnabled(bool enabled) async {
    _playlist.value.children.shuffle();
    _audioPlayer.setAudioSource(_playlist.value);
    _playlist.refresh();
  }

  Future<void> seek(double value) => _audioPlayer.seek(
        Duration(milliseconds: value.toInt()),
      );

  void _listenCurrentIndex() {
    _audioPlayer.currentIndexStream.listen((index) {
      _currentIndex?.call(index);
    });
  }

  void _listenMusicIsPlaying() {
    _audioPlayer.playingStream.listen((playing) {
      _playing(playing);
    });
  }

  void _listenIsLastMusic() {
    _audioPlayer.sequenceStateStream.listen((state) {
      if (state?.currentSource != null) {
        _currentMusicMetadata(state?.currentSource?.tag as MediaItem);
      }

      _hasPrevious(_audioPlayer.previousIndex == null);
      _isLastMusic(_audioPlayer.nextIndex == null);
    });
  }

  void _listenStateMusic() {
    _audioPlayer.playerStateStream.listen((state) {
      print(state);
      if (state.playing ||
          state.processingState == ProcessingState.ready ||
          (_audioPlayer.audioSource?.sequence.isNotEmpty ?? false)) {
        _playable(true);
      } else {
        _playable(false);
      }
    });
  }

  void _listenPositon() {
    _audioPlayer.positionStream.listen((position) {
      _position(position);
    });
  }

  void _listenBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((position) {
      _bufferedPosition(position);
    });
  }

  void _listenShuffleMode() {
    _audioPlayer.shuffleModeEnabledStream.listen((enabled) {
      _shuffleModeEnabled(enabled);
    });
  }

  void _listenPlaylistChanges() {
    _playlist.listen((source) {
      var queue = source.children.map((audio) {
        var audioSource = (audio.sequence[0] as UriAudioSource);

        return <String, dynamic>{
          'url': audioSource.uri.toString(),
          'tag': {
            'id': audioSource.tag.id.toString(),
            'title': audioSource.tag.title.toString(),
            'album': audioSource.tag.album.toString(),
            'artist': audioSource.tag.artist.toString(),
            'artUri': audioSource.tag.artUri.toString(),
          }
        };
      }).toList();

      _storage.write('queue', queue);
    });
  }
}
