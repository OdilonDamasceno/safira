import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:safira/app/data/models/artist_query/artist_query.dart';
import 'package:safira/app/data/models/recordings.dart';
import 'package:safira/app/data/models/recording.dart';

import 'package:safira/app/extensions/search_type_to_string.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Queue _queue = Queue();
  @override
  final SearchController controller = Get.put(SearchController());

  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, double.maxFinite),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Get.theme.shadowColor.withOpacity(0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FocusScope(
                  node: _focusScopeNode,
                  child: Focus(
                    onFocusChange: controller.hasFocus,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: controller.textEditingController,
                                textInputAction: TextInputAction.search,
                                onFieldSubmitted: controller.search,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 48,
                                        child: VerticalDivider(
                                          width: 20,
                                        ),
                                      ),
                                      DropdownButton(
                                        underline: SizedBox(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                        ),
                                        style: Get.textTheme.caption,
                                        value: controller.searchType.value,
                                        onChanged: controller.changeSearchType,
                                        items: controller.searchTypes
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem<String>(
                                            value: value.toShortString(),
                                            child: Text(value.toShortString()),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                        Obx(
                          () => Visibility(
                            visible: controller.hasFocus.value,
                            child: Divider(),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.hasFocus.value,
                            child: Flexible(
                              child: ListView.builder(
                                reverse: true,
                                itemCount: controller.recentSearched.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      controller.search(
                                        controller.recentSearched[index],
                                      );
                                      _focusScopeNode.unfocus();
                                    },
                                    title: Text(
                                      controller.recentSearched[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.hasFocus.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: _focusScopeNode.unfocus,
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await controller.search();
                                    _focusScopeNode.unfocus();
                                  },
                                  child: Text('Search'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: GetBuilder<SearchController>(
          id: 'searchedlist',
          init: SearchController(),
          initState: (_) {},
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FutureBuilder<dynamic>(
                future: controller.futureSearch?.value,
                builder: (_, snapshot) {
                  if (controller.futureSearch?.value == null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(80),
                        child: SvgPicture.asset(
                          'assets/undraw_location_search_re_ttoj.svg',
                        ),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    switch (snapshot.data.runtimeType) {
                      case Recordings:
                        return ListView.separated(
                          separatorBuilder: (_, __) => Divider(),
                          itemCount: snapshot.data?.recordings?.length ?? 0,
                          addAutomaticKeepAlives: false,
                          itemBuilder: (ctx, index) {
                            return MusicListTile(
                                controller: controller,
                                recording: snapshot.data?.recordings?[index],
                                onTap: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Get.theme.primaryColor,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          LinearProgressIndicator(
                                            color: Get.theme.highlightColor,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 1,
                                            ),
                                            child: Text(
                                              'Adding ${snapshot.data?.recordings?[index].title} to queue',
                                              style:
                                                  Get.textTheme.caption?.apply(
                                                fontWeightDelta: 2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  );
                                  _queue.add<void>(
                                    () async {
                                      await controller.audioService.addToQueue(
                                          snapshot.data?.recordings?[index]);
                                    },
                                  );
                                });
                          },
                        );
                      case ArtistQuery:
                        return GridView.builder(
                          itemCount: (snapshot.data as ArtistQuery?)
                                  ?.artists
                                  ?.length ??
                              0,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                          ),
                          itemBuilder: (context, index) {
                            var artist = (snapshot.data as ArtistQuery?)
                                ?.artists?[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                    maxRadius: 50,
                                    child: Icon(Icons.person),
                                  ),
                                ),
                                Text(
                                  '${artist?.name}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        );
                      default:
                        return Text('');
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(80),
                        child: SvgPicture.asset(
                          'assets/undraw_mobile_login_ikmv.svg',
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class MusicListTile extends StatelessWidget {
  final Recording recording;
  final void Function()? onTap;
  const MusicListTile({
    Key? key,
    required this.controller,
    required this.recording,
    this.onTap,
  }) : super(key: key);

  final SearchController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.all(8),
      leading: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          'https://coverartarchive.org/release/${recording.releases?.first.id}/front-250',
          errorBuilder: (_, __, ___) {
            return Image.asset('assets/noalbum.jpg');
          },
        ),
      ),
      title: Text(recording.title ?? 'No Name'),
      subtitle: Text(
        recording.artistCredit?.map((artist) => artist.name).join(', ') ??
            'No Name',
      ),
      trailing: Icon(Icons.more_vert),
    );
  }
}
