import 'image.dart';

class Cover {
  List<Image>? images;
  String? release;

  Cover({this.images, this.release});

  factory Cover.fromJson(Map<String, dynamic> json) => Cover(
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        release: json['release'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'images': images?.map((e) => e.toJson()).toList(),
        'release': release,
      };
}
