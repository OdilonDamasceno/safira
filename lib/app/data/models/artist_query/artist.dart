import 'alias.dart';
import 'area.dart';
import 'begin_area.dart';
import 'life_span.dart';
import 'tag.dart';

class Artist {
  String? id;
  String? type;
  String? typeId;
  int? score;
  String? name;
  String? sortName;
  String? country;
  Area? area;
  BeginArea? beginArea;
  String? disambiguation;
  LifeSpan? lifeSpan;
  List<Tag>? tags;
  List<Alias>? aliases;
  String? genderId;
  String? gender;

  Artist({
    this.id,
    this.type,
    this.typeId,
    this.score,
    this.name,
    this.sortName,
    this.country,
    this.area,
    this.beginArea,
    this.disambiguation,
    this.lifeSpan,
    this.tags,
    this.aliases,
    this.genderId,
    this.gender,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json['id'] as String?,
        type: json['type'] as String?,
        typeId: json['type-id'] as String?,
        score: json['score'] as int?,
        name: json['name'] as String?,
        sortName: json['sort-name'] as String?,
        country: json['country'] as String?,
        area: json['area'] == null
            ? null
            : Area.fromJson(json['area'] as Map<String, dynamic>),
        beginArea: json['begin-area'] == null
            ? null
            : BeginArea.fromJson(json['begin-area'] as Map<String, dynamic>),
        disambiguation: json['disambiguation'] as String?,
        lifeSpan: json['life-span'] == null
            ? null
            : LifeSpan.fromJson(json['life-span'] as Map<String, dynamic>),
        tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList(),
        aliases: (json['aliases'] as List<dynamic>?)
            ?.map((e) => Alias.fromJson(e as Map<String, dynamic>))
            .toList(),
        genderId: json['gender-id'] as String?,
        gender: json['gender'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'type-id': typeId,
        'score': score,
        'name': name,
        'sort-name': sortName,
        'country': country,
        'area': area?.toJson(),
        'begin-area': beginArea?.toJson(),
        'disambiguation': disambiguation,
        'life-span': lifeSpan?.toJson(),
        'tags': tags?.map((e) => e.toJson()).toList(),
        'aliases': aliases?.map((e) => e.toJson()).toList(),
        'gender-id': genderId,
        'gender': gender,
      };
}
