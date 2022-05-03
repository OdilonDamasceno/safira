class Area {
  String? id;
  String? name;
  String? sortName;
  List<dynamic>? iso31661Codes;

  Area({this.id, this.name, this.sortName, this.iso31661Codes});

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json['id'] as String?,
        name: json['name'] as String?,
        sortName: json['sort-name'] as String?,
        iso31661Codes: json['iso-3166-1-codes'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sort-name': sortName,
        'iso-3166-1-codes': iso31661Codes,
      };
}
