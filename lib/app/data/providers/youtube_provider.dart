import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:safira/app/data/models/recording.dart';

class YoutubeProvider {
  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  Future<StreamManifest> getManifest(String id) async {
    return (await _youtubeExplode.videos.streamsClient.getManifest(id));
  }

  AudioOnlyStreamInfo getAudioInfo(StreamManifest manifest) {
    return manifest.audioOnly.withHighestBitrate();
  }

  Future<VideoSearchList> search(String query) async {
    return await _youtubeExplode.search.search(query);
  }

  Future<Video> topSearchResult(String query) async {
    return (await search(query)).first;
  }

  Future<String> getAudioUrl(StreamManifest manifest) async {
    return getAudioInfo(manifest).url.toString();
  }

  Future<String> searchAndGetUrl(Recording track) async {
    Video searched = await topSearchResult(
      '${track.title} - ${track.artistCredit?.map((artist) => artist.name).join(" ")}',
    );
    StreamManifest manifest = await getManifest(searched.id.value);
    return await getAudioUrl(manifest);
  }
}
