import 'package:get/get.dart';

import '../models/cover.dart';

class CoverProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Cover.fromJson(map);
      if (map is List) return map.map((item) => Cover.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'https://coverartarchive.org';
  }

  Future<Cover?> getCover(String id) async {
    final response = await get('/release/$id');
    return response.body;
  }
}
