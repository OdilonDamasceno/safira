import 'package:get/get.dart';

import 'package:safira/app/modules/home/bindings/home_binding.dart';
import 'package:safira/app/modules/home/views/home_view.dart';
import 'package:safira/app/modules/home_page/bindings/home_page_binding.dart';
import 'package:safira/app/modules/home_page/views/home_page_view.dart';
import 'package:safira/app/modules/player/bindings/player_binding.dart';
import 'package:safira/app/modules/player/views/player_view.dart';
import 'package:safira/app/modules/queue/bindings/queue_binding.dart';
import 'package:safira/app/modules/queue/views/queue_view.dart';
import 'package:safira/app/modules/search/bindings/search_binding.dart';
import 'package:safira/app/modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PLAYER,
      page: () => PlayerView(),
      binding: PlayerBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.QUEUE,
      page: () => QueueView(),
      binding: QueueBinding(),
    ),
  ];
}
