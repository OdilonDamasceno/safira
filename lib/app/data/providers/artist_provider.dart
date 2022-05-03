import 'package:get/get.dart';
import 'package:safira/app/data/models/artist_query/artist_query.dart';

class ArtistProvider extends GetConnect {
  @override
  void onInit() {
    defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return ArtistQuery.fromJson(map);
      if (map is List) {
        return map.map((item) => ArtistQuery.fromJson(item)).toList();
      }
    };
    baseUrl = 'https://musicbrainz.org';
  }

  Future<ArtistQuery?>? searchArtist(String query) async {
    var res = await get(
      '/ws/2/artist?query=$query&dismax=true&fmt=json',
      decoder: ArtistQuery.fromJson,
    );
    return res.body ?? ArtistQuery();
  }
}
