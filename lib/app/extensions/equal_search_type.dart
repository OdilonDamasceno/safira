import 'package:safira/app/enums/search_type.dart';

import './search_type_to_string.dart';

extension EqualSearchType on SearchType {
  bool operator &(String type) {
    return toShortString() == type;
  }
}
