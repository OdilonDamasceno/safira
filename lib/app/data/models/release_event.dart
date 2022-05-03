import 'area.dart';

class ReleaseEvent {
  String? date;
  Area? area;

  ReleaseEvent({this.date, this.area});

  factory ReleaseEvent.fromJson(Map<String, dynamic> json) => ReleaseEvent(
        date: json['date'] as String?,
        area: json['area'] == null
            ? null
            : Area.fromJson(json['area'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'area': area?.toJson(),
      };
}
