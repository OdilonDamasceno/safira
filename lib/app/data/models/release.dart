import 'media.dart';
import 'release_event.dart';
import 'release_group.dart';

class Release {
  String? id;
  String? statusId;
  int? count;
  String? title;
  String? status;
  ReleaseGroup? releaseGroup;
  String? date;
  String? country;
  List<ReleaseEvent>? releaseEvents;
  int? trackCount;
  List<Media>? media;

  Release({
    this.id,
    this.statusId,
    this.count,
    this.title,
    this.status,
    this.releaseGroup,
    this.date,
    this.country,
    this.releaseEvents,
    this.trackCount,
    this.media,
  });

  factory Release.fromJson(Map<String, dynamic> json) => Release(
        id: json['id'] as String?,
        statusId: json['status-id'] as String?,
        count: json['count'] as int?,
        title: json['title'] as String?,
        status: json['status'] as String?,
        releaseGroup: json['release-group'] == null
            ? null
            : ReleaseGroup.fromJson(
                json['release-group'] as Map<String, dynamic>),
        date: json['date'] as String?,
        country: json['country'] as String?,
        releaseEvents: (json['release-events'] as List<dynamic>?)
            ?.map((e) => ReleaseEvent.fromJson(e as Map<String, dynamic>))
            .toList(),
        trackCount: json['track-count'] as int?,
        media: (json['media'] as List<dynamic>?)
            ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status-id': statusId,
        'count': count,
        'title': title,
        'status': status,
        'release-group': releaseGroup?.toJson(),
        'date': date,
        'country': country,
        'release-events': releaseEvents?.map((e) => e.toJson()).toList(),
        'track-count': trackCount,
        'media': media?.map((e) => e.toJson()).toList(),
      };
}
