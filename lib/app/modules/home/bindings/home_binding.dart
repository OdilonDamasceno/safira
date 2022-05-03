import 'package:get/get.dart';

import 'package:safira/app/data/providers/cover_provider.dart';
import 'package:safira/app/data/providers/recordings_provider.dart';
import 'package:safira/app/services/audio_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoverProvider>(() => CoverProvider());
    Get.put(SafiraAudioService(), tag: 'safiraaudioservice', permanent: true);
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<RecordingsProvider>(() => RecordingsProvider());
  }
}
