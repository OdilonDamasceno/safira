import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safira/app/services/audio_service.dart';

import '../controllers/queue_controller.dart';

class QueueView extends GetView<QueueController> {
  final SafiraAudioService _audioService = Get.put(
    SafiraAudioService(),
    tag: 'safiraaudioservice',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => ReorderableListView.builder(
            itemCount: _audioService.playlist.value.children.length,
            itemBuilder: (_, index) => ListTile(
              contentPadding: EdgeInsets.all(5),
              leading: Image.network(
                _audioService
                    .playlist.value.children[index].sequence[0].tag.artUri
                    .toString(),
              ),
              key: ValueKey(_audioService.playlist.value.children[index]),
              title: Text(
                _audioService
                    .playlist.value.children[index].sequence[0].tag.title,
              ),
              trailing: IconButton(
                onPressed: () async => await _audioService.removeAt(index),
                icon: Icon(Icons.delete),
              ),
            ),
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              _audioService.move(oldIndex, newIndex);
            },
          )),
    );
  }
}
