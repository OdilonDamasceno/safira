import 'artist_credit.dart';
import 'release.dart';

class Recording {
  String? id;
  int? score;
  String? title;
  int? length;
  dynamic video;
  List<ArtistCredit>? artistCredit;
  String? firstReleaseDate;
  List<Release>? releases;

  Recording({
    this.id,
    this.score,
    this.title,
    this.length,
    this.video,
    this.artistCredit,
    this.firstReleaseDate,
    this.releases,
  });

  factory Recording.fromJson(Map<String, dynamic> json) => Recording(
        id: json['id'] as String?,
        score: json['score'] as int?,
        title: json['title'] as String?,
        length: json['length'] as int?,
        video: json['video'] as dynamic,
        artistCredit: (json['artist-credit'] as List<dynamic>?)
            ?.map((e) => ArtistCredit.fromJson(e as Map<String, dynamic>))
            .toList(),
        firstReleaseDate: json['first-release-date'] as String?,
        releases: (json['releases'] as List<dynamic>?)
            ?.map((e) => Release.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'score': score,
        'title': title,
        'length': length,
        'video': video,
        'artist-credit': artistCredit?.map((e) => e.toJson()).toList(),
        'first-release-date': firstReleaseDate,
        'releases': releases?.map((e) => e.toJson()).toList(),
      };
}
