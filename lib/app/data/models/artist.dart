class Artist {
  String? id;
  String? name;
  String? sortName;
  String? disambiguation;

  Artist({this.id, this.name, this.sortName, this.disambiguation});

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json['id'] as String?,
        name: json['name'] as String?,
        sortName: json['sort-name'] as String?,
        disambiguation: json['disambiguation'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sort-name': sortName,
        'disambiguation': disambiguation,
      };
}
