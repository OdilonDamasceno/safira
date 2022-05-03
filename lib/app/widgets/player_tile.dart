import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safira/app/routes/app_pages.dart';
import 'package:safira/app/services/audio_service.dart';

class PlayerTile extends StatelessWidget {
  final SafiraAudioService audioService;
  const PlayerTile({
    Key? key,
    required this.audioService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 0),
            color: Get.theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Obx(() => ListTile(
            enabled: audioService.playable.value,
            onTap: () => Get.toNamed(Routes.PLAYER),
            leading: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                audioService.currentMusicMetadata?.value?.artUri.toString() ??
                    '',
                errorBuilder: (_, __, ___) => Image.asset('assets/noalbum.jpg'),
              ),
            ),
            title: Text(
              audioService.currentMusicMetadata?.value?.title ?? '',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            subtitle: Text(
              audioService.currentMusicMetadata?.value?.artist ?? '',
              style: Theme.of(context).textTheme.overline,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  tooltip: 'Play/Pause',
                  onPressed: () => audioService.playing.isTrue
                      ? audioService.pause()
                      : audioService.play(),
                  icon: Icon(
                    audioService.playing.isTrue
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () => audioService.seekToNext(),
                  icon: audioService.isLastMusic.isFalse
                      ? Icon(Icons.skip_next_rounded)
                      : Icon(
                          Icons.skip_next_rounded,
                          color: Colors.grey.withAlpha(100),
                        ),
                ),
              ],
            ),
          )),
    );
  }
}
