class Thumbnails {
  String? large;
  String? small;

  Thumbnails({this.large, this.small});

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        large: json['large'] as String?,
        small: json['small'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'large': large,
        'small': small,
      };
}
