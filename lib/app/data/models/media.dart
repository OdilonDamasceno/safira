import 'track.dart';

class Media {
  int? position;
  String? format;
  List<Track>? track;
  int? trackCount;
  int? trackOffset;

  Media({
    this.position,
    this.format,
    this.track,
    this.trackCount,
    this.trackOffset,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        position: json['position'] as int?,
        format: json['format'] as String?,
        track: (json['track'] as List<dynamic>?)
            ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
            .toList(),
        trackCount: json['track-count'] as int?,
        trackOffset: json['track-offset'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'position': position,
        'format': format,
        'track': track?.map((e) => e.toJson()).toList(),
        'track-count': trackCount,
        'track-offset': trackOffset,
      };
}
