import 'package:get/get.dart';
import 'package:spotify/spotify.dart' as spotify;

import 'package:safira/env.dart';

class SpotifyProvider extends GetConnect {
  final spotify.SpotifyApiCredentials _credentials =
      spotify.SpotifyApiCredentials(
    ENV.SPOTIFY_CLIENT_ID,
    ENV.CLIENT_SECRET,
  );
  late final spotify.SpotifyApi _spotifyApi;

  SpotifyProvider() {
    _spotifyApi = spotify.SpotifyApi(_credentials);
  }

  Future<List<spotify.Page<dynamic>>> search({
    required String query,
  }) async {
    return await _spotifyApi.search.get(query, types: [
      spotify.SearchType.artist,
      spotify.SearchType.track,
    ]).first();
  }
}
