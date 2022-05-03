class ReleaseGroup {
  String? id;
  String? typeId;
  String? primaryTypeId;
  String? title;
  String? primaryType;

  ReleaseGroup({
    this.id,
    this.typeId,
    this.primaryTypeId,
    this.title,
    this.primaryType,
  });

  factory ReleaseGroup.fromJson(Map<String, dynamic> json) => ReleaseGroup(
        id: json['id'] as String?,
        typeId: json['type-id'] as String?,
        primaryTypeId: json['primary-type-id'] as String?,
        title: json['title'] as String?,
        primaryType: json['primary-type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type-id': typeId,
        'primary-type-id': primaryTypeId,
        'title': title,
        'primary-type': primaryType,
      };
}
