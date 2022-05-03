class Alias {
  String? sortName;
  String? name;
  dynamic locale;
  dynamic type;
  dynamic primary;
  dynamic beginDate;
  dynamic endDate;

  Alias({
    this.sortName,
    this.name,
    this.locale,
    this.type,
    this.primary,
    this.beginDate,
    this.endDate,
  });

  factory Alias.fromJson(Map<String, dynamic> json) => Alias(
        sortName: json['sort-name'] as String,
        name: json['name'] as String,
        locale: json['locale'] as dynamic,
        type: json['type'] as dynamic,
        primary: json['primary'] as dynamic,
        beginDate: json['begin-date'] as dynamic,
        endDate: json['end-date'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'sort-name': sortName,
        'name': name,
        'locale': locale,
        'type': type,
        'primary': primary,
        'begin-date': beginDate,
        'end-date': endDate,
      };
}
