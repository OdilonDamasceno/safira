class Tag {
  int? count;
  String? name;

  Tag({this.count, this.name});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        count: json['count'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'name': name,
      };
}
