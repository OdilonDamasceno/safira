import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<PageController> pageController = PageController().obs;

  void jumpToPage(int index) {
    pageController.value.jumpToPage(index);
    pageController.refresh();
  }

  int? get pageIndex => pageController.value.page?.round();
}
