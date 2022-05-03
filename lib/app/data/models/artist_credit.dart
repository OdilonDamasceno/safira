import 'artist.dart';

class ArtistCredit {
  String? name;
  Artist? artist;

  ArtistCredit({this.name, this.artist});

  factory ArtistCredit.fromJson(Map<String, dynamic> json) => ArtistCredit(
        name: json['name'] as String?,
        artist: json['artist'] == null
            ? null
            : Artist.fromJson(json['artist'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'artist': artist?.toJson(),
      };
}
