import 'dart:io';

import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';

class CoverAsset {
  late File file;
  CoverAsset() {
    getTemporaryDirectory().then((dir) => file = File(dir.path + '/cover'));
  }

  Future<File> getFile(String path) async {
    return await file
        .writeAsBytes((await rootBundle.load(path)).buffer.asUint8List());
  }
}
