import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePageController extends GetxController {
  RxList<dynamic> recentlyPlayed = [].obs;
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    print(_storage.read(
      'recentlyPlayed',
    ));
    recentlyPlayed(_storage.read<List<dynamic>>('recentlyPlayed') ?? []);
    super.onInit();
  }
}
