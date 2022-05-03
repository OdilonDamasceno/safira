import 'thumbnails.dart';

class Image {
  List<dynamic>? types;
  bool? front;
  bool? back;
  int? edit;
  String? image;
  String? comment;
  bool? approved;
  dynamic id;
  Thumbnails? thumbnails;

  Image({
    this.types,
    this.front,
    this.back,
    this.edit,
    this.image,
    this.comment,
    this.approved,
    this.id,
    this.thumbnails,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        types: json['types'] as List<dynamic>?,
        front: json['front'] as bool?,
        back: json['back'] as bool?,
        edit: json['edit'] as int?,
        image: json['image'] as String?,
        comment: json['comment'] as String?,
        approved: json['approved'] as bool?,
        id: json['id'] as dynamic,
        thumbnails: json['thumbnails'] == null
            ? null
            : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'types': types,
        'front': front,
        'back': back,
        'edit': edit,
        'image': image,
        'comment': comment,
        'approved': approved,
        'id': id,
        'thumbnails': thumbnails?.toJson(),
      };
}
