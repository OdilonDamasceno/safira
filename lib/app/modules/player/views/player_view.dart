import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safira/app/routes/app_pages.dart';

import 'package:safira/app/widgets/music_slider.dart';

import '../controllers/player_controller.dart';

class PlayerView extends GetView<PlayerController> {
  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00000000),
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Obx(() => Image.network(
                        controller.audioService.currentMusicMetadata?.value
                                ?.artUri
                                .toString() ??
                            '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/noalbum.jpg',
                          fit: BoxFit.cover,
                        ),
                      )),
                  BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: kToolbarHeight),
                Visibility(
                  visible: portrait,
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 15, color: Colors.black26),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Obx(() => Image.network(
                                controller.audioService.currentMusicMetadata
                                        ?.value?.artUri
                                        .toString() ??
                                    '',
                                fit: BoxFit.scaleDown,
                                errorBuilder: (_, __, ___) => Image.asset(
                                  'assets/noalbum.jpg',
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor.withOpacity(
                        0.5,
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(blurRadius: 25, color: Colors.black26),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Obx(() => Text(
                                '${controller.audioService.currentMusicMetadata?.value?.title}',
                                style: Theme.of(context).textTheme.headline5,
                                textAlign: TextAlign.center,
                              )),
                          Obx(() => Text.rich(
                                TextSpan(
                                    text:
                                        '${controller.audioService.currentMusicMetadata?.value?.album} - ',
                                    children: [
                                      TextSpan(
                                        text:
                                            '${controller.audioService.currentMusicMetadata?.value?.artist}',
                                        style: Get.theme.textTheme.subtitle2
                                            ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                    ]),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                            flex: 10,
                            child: Obx(() => MusicSlider(
                                  position:
                                      controller.audioService.position.value,
                                  bufferedPosition: controller
                                      .audioService.bufferedPosition.value,
                                  duration: controller
                                          .audioService.audioPlayer.duration ??
                                      Duration(),
                                  onChanged: controller.audioService.seek,
                                )),
                          ),
                          Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.formatDuration(
                                        controller.audioService.position.value),
                                    style: Get.textTheme.caption,
                                  ),
                                  Text(
                                    controller.formatDuration(
                                      controller.audioService.audioPlayer
                                              .duration ??
                                          Duration(seconds: 0),
                                    ),
                                    style: Get.textTheme.caption,
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Obx(() => IconButton(
                                      onPressed: controller.setLoopMode,
                                      icon: Icon(controller.loopIconData.value),
                                    )),
                                Obx(() => IconButton(
                                      onPressed: controller
                                              .audioService.hasPrevious.value
                                          ? null
                                          : controller
                                              .audioService.seekToPrevious,
                                      icon: Icon(Icons.skip_previous_rounded),
                                    )),
                                Obx(() => IconButton(
                                      iconSize: 48,
                                      tooltip: 'Play/Pause',
                                      onPressed: () =>
                                          controller.audioService.playing.isTrue
                                              ? controller.audioService.pause()
                                              : controller.audioService.play(),
                                      icon: Icon(
                                        controller.audioService.playing.isTrue
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                      ),
                                    )),
                                Obx(() => IconButton(
                                      onPressed: controller
                                              .audioService.isLastMusic.value
                                          ? null
                                          : controller.audioService.seekToNext,
                                      icon: Icon(Icons.skip_next_rounded),
                                    )),
                                Obx(() => IconButton(
                                      onPressed: () async {
                                        await controller.audioService
                                            .setShuffleModeEnabled(
                                          !controller.audioService
                                              .shuffleModeEnabled.value,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.shuffle_rounded,
                                        color: controller.audioService
                                                .shuffleModeEnabled.value
                                            ? Get.theme.colorScheme.secondary
                                            : null,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => Get.toNamed(Routes.QUEUE),
                                  icon: Icon(Icons.playlist_play),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
