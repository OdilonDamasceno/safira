class LifeSpan {
  dynamic ended;

  LifeSpan({this.ended});

  factory LifeSpan.fromJson(Map<String, dynamic> json) => LifeSpan(
        ended: json['ended'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'ended': ended,
      };
}
