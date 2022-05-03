import 'package:safira/app/enums/search_type.dart';

extension ParseToString on SearchType {
  String toShortString() {
    return toString().split('.').last;
  }
}
