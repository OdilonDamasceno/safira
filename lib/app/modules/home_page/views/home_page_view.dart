import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  @override
  HomePageController get controller => Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePageView'),
        centerTitle: true,
      ),
      body: Center(
          child: Obx(
        () => ListView.builder(
          itemCount: controller.recentlyPlayed.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(
                controller.recentlyPlayed[index]['title'],
              ),
            );
          },
        ),
      )),
    );
  }
}
