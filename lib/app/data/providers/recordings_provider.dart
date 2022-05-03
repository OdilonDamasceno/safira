import 'package:get/get.dart';

import 'package:safira/app/data/models/recordings.dart';

class RecordingsProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    baseUrl = 'https://musicbrainz.org';
  }

  Future<Recordings>? searchRecording(String query) async {
    var res = await get(
      '/ws/2/recording?query=$query&dismax=true&fmt=json',
      decoder: Recordings.fromJson,
    );
    return res.body ?? Recordings();
  }
}
