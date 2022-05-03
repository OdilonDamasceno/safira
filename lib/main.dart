import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:safira/app/modules/home/bindings/home_binding.dart';
import 'package:safira/app/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  // await GetStorage().erase();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.safira.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    preloadArtwork: true,
  );

  runApp(GetMaterialApp(
    title: 'Safira',
    initialRoute: AppPages.INITIAL,
    themeMode: ThemeMode.system,
    theme: AppTheme.THEME,
    darkTheme: AppTheme.DARK_THEME,
    initialBinding: HomeBinding(),
    getPages: AppPages.routes,
  ));
}
