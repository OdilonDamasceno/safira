import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MusicSlider extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final Duration bufferedPosition;
  final Function(double) onChanged;
  final Color? sliderColor;
  const MusicSlider({
    Key? key,
    required this.position,
    required this.bufferedPosition,
    required this.duration,
    required this.onChanged,
    this.sliderColor,
  }) : super(key: key);

  @override
  State<MusicSlider> createState() => _MusicSliderState();
}

class _MusicSliderState extends State<MusicSlider> {
  late SliderThemeData _sliderTheme;
  final SliderController _sliderController = Get.put(SliderController());
  Color? textColor;

  @override
  void didChangeDependencies() {
    _sliderTheme = SliderTheme.of(context).copyWith(
      overlayShape: SliderComponentShape.noOverlay,
      trackShape: CustomTrackShape(),
      trackHeight: 1,
      minThumbSeparation: 0,
    );
    textColor = Theme.of(context).textTheme.bodyText1?.color;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SliderTheme(
          data: _sliderTheme.copyWith(
            thumbShape: SliderComponentShape.noThumb,
            activeTrackColor: textColor?.withAlpha(100),
            inactiveTrackColor: textColor?.withAlpha(300),
          ),
          child: ExcludeSemantics(
            child: Slider(
              value: min(widget.duration.inMilliseconds.toDouble(),
                  widget.bufferedPosition.inMilliseconds.toDouble()),
              max: widget.duration.inMilliseconds.toDouble(),
              onChanged: (double newValue) {
                _sliderController.dragValue = newValue;
                widget.onChanged(newValue);
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderTheme.copyWith(
            activeTrackColor: textColor,
            thumbColor: textColor,
            inactiveTrackColor: Colors.transparent,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 3,
            ),
          ),
          child: Slider(
            value: min(
                _sliderController.dragValue?.value ??
                    widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            max: widget.duration.inMilliseconds.toDouble(),
            onChanged: (double newValue) {
              _sliderController.dragValue = newValue;
              widget.onChanged(newValue);
            },
          ),
        ),
      ],
    );
  }
}

class SliderController extends GetxController {
  final RxDouble? dragValue;

  SliderController({this.dragValue});

  set dragValue(newValue) {
    dragValue?.call(newValue);
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 1;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
