import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:safira/app/services/audio_service.dart';

class PlayerController extends GetxController {
  Rx<IconData> loopIconData = Icons.do_not_disturb.obs;
  final audioService = Get.put(SafiraAudioService(), tag: 'safiraaudioservice');

  RxBool opened = false.obs;

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  Future<void> setLoopMode() async {
    switch (audioService.loopMode.value) {
      case LoopMode.off:
        await audioService.setLoopMode(
          LoopMode.one,
        );
        loopIconData.call(Icons.repeat_one);
        break;
      case LoopMode.one:
        await audioService.setLoopMode(LoopMode.all);
        loopIconData.call(Icons.repeat);
        break;
      case LoopMode.all:
        await audioService.setLoopMode(LoopMode.off);
        loopIconData.call(Icons.do_not_disturb);
        break;
    }
  }

  @override
  void onInit() {
    switch (audioService.loopMode.value) {
      case LoopMode.off:
        loopIconData.call(Icons.do_not_disturb);
        break;
      case LoopMode.one:
        loopIconData.call(Icons.repeat_one);
        break;
      case LoopMode.all:
        loopIconData.call(Icons.repeat);

        break;
    }
    super.onInit();
  }
}
