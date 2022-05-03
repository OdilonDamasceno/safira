import 'recording.dart';

class Recordings {
  String? created;
  int? count;
  int? offset;
  List<Recording>? recordings;

  Recordings({this.created, this.count, this.offset, this.recordings});

  static fromJson(dynamic json) => Recordings(
        created: json['created'] as String?,
        count: json['count'] as int?,
        offset: json['offset'] as int?,
        recordings: (json['recordings'] as List<dynamic>?)
            ?.map((e) => Recording.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'created': created,
        'count': count,
        'offset': offset,
        'recordings': recordings?.map((e) => e.toJson()).toList(),
      };
}
