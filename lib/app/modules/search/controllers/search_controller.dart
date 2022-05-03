import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:safira/app/data/providers/artist_provider.dart';
import 'package:safira/app/data/providers/cover_provider.dart';
import 'package:safira/app/data/providers/recordings_provider.dart';
import 'package:safira/app/enums/search_type.dart';
import 'package:safira/app/extensions/search_type_to_string.dart';
import 'package:safira/app/services/audio_service.dart';

class SearchController extends GetxController {
  final RecordingsProvider _recordingsProvider = Get.put(RecordingsProvider());
  final ArtistProvider _artistProvider = Get.put(ArtistProvider());

  RxList<String> recentSearched = <String>[].obs;

  final GetStorage _storage = GetStorage();

  final CoverProvider coverProvider = Get.find<CoverProvider>();

  final audioService = Get.put(SafiraAudioService(), tag: 'safiraaudioservice');

  final TextEditingController textEditingController = TextEditingController();

  final searchTypes = SearchType.values;

  Rx<Future<dynamic>?>? futureSearch;
  final RxBool _hasFocus = false.obs;

  final RxString searchType = SearchType.Recording.toShortString().obs;

  RxBool get hasFocus => _hasFocus;

  @override
  void onInit() async {
    recentSearched(
      _storage
              .read<List<dynamic>?>(searchType.value)
              ?.toList()
              .cast<String>() ??
          <String>[],
    );
    super.onInit();
  }

  void changeSearchType(String? type) {
    searchType(type);
    recentSearched(
      _storage.read<List<String>?>(searchType.value) ?? <String>[],
    );
  }

  Future<dynamic> search([String? name]) async {
    String searchName = name ?? textEditingController.text;

    if ((name != null && name.isNotEmpty) ||
        textEditingController.text.isNotEmpty) {
      switch (searchType.value) {
        case 'Recording':
          futureSearch = _recordingsProvider.searchRecording(searchName).obs;
          recentSearched.removeWhere((element) => element == (searchName));
          recentSearched.add(searchName);
          break;
        case 'Artist':
          print(searchName);
          futureSearch = _artistProvider.searchArtist(searchName).obs;
          break;
      }
      await _storage.write(
        searchType.value,
        recentSearched.toList(),
      );
    }
    update(['searchedlist']);
  }
}
