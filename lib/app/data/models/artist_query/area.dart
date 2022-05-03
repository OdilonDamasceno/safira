import 'life_span.dart';

class Area {
  String? id;
  String? type;
  String? typeId;
  String? name;
  String? sortName;
  LifeSpan? lifeSpan;

  Area({
    this.id,
    this.type,
    this.typeId,
    this.name,
    this.sortName,
    this.lifeSpan,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json['id'] as String?,
        type: json['type'] as String?,
        typeId: json['type-id'] as String?,
        name: json['name'] as String?,
        sortName: json['sort-name'] as String?,
        lifeSpan: json['life-span'] == null
            ? null
            : LifeSpan.fromJson(json['life-span'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'type-id': typeId,
        'name': name,
        'sort-name': sortName,
        'life-span': lifeSpan?.toJson(),
      };
}
