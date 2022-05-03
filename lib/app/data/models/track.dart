class Track {
  String? id;
  String? number;
  String? title;
  int? length;

  Track({this.id, this.number, this.title, this.length});

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json['id'] as String?,
        number: json['number'] as String?,
        title: json['title'] as String?,
        length: json['length'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'title': title,
        'length': length,
      };
}
