import 'artist.dart';

class ArtistQuery {
  String? created;
  int? count;
  int? offset;
  List<Artist>? artists;

  ArtistQuery({this.created, this.count, this.offset, this.artists});

  static fromJson(dynamic json) => ArtistQuery(
        created: json['created'] as String?,
        count: json['count'] as int?,
        offset: json['offset'] as int?,
        artists: (json['artists'] as List<dynamic>?)
            ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'created': created,
        'count': count,
        'offset': offset,
        'artists': artists?.map((e) => e.toJson()).toList(),
      };
}
