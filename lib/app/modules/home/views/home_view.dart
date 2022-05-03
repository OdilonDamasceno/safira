import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safira/app/modules/home_page/views/home_page_view.dart';

import 'package:safira/app/modules/search/views/search_view.dart';
import 'package:safira/app/services/audio_service.dart';
import 'package:safira/app/widgets/custom_bottom_navigation_bar.dart';
import 'package:safira/app/widgets/player_tile.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _audioService = Get.put(
    SafiraAudioService(),
    tag: 'safiraaudioservice',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController.value,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePageView(),
          SearchView(),
          Container(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Visibility(
                visible: _audioService.playable.value,
                child: PlayerTile(audioService: _audioService),
              )),
          Obx(() => CustomBottomNavigationBar(
                onTap: controller.jumpToPage,
                currentIndex: controller.pageIndex ?? 0,
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Search',
                    icon: Icon(Icons.search),
                  ),
                  BottomNavigationBarItem(
                    label: 'Library',
                    icon: Icon(Icons.library_music),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
