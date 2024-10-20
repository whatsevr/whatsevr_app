import 'package:flutter/material.dart';

class WhatsevrSlider extends StatefulWidget {
  final bool isVertical;
  final bool isLight;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;

  const WhatsevrSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    this.onChanged,
    this.isVertical = true,
    this.isLight = true,
  });

  @override
  _WhatsevrSliderState createState() => _WhatsevrSliderState();
}

class _WhatsevrSliderState extends State<WhatsevrSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final SliderThemeData sliderThemeData = SliderTheme.of(context).copyWith(
      activeTrackColor: widget.isLight ? Colors.white : Colors.black,
      inactiveTrackColor: widget.isLight ? Colors.grey[700] : Colors.grey[300],
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: 6.0,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
      thumbColor: widget.isLight ? Colors.white : Colors.black,
      overlayColor: widget.isLight
          ? Colors.white.withAlpha(32)
          : Colors.black.withAlpha(32),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
      tickMarkShape: RoundSliderTickMarkShape(),
      activeTickMarkColor: widget.isLight ? Colors.white : Colors.black,
      inactiveTickMarkColor:
          widget.isLight ? Colors.grey[700] : Colors.grey[300],
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: widget.isLight ? Colors.white : Colors.black,
      valueIndicatorTextStyle: TextStyle(
        color: widget.isLight ? Colors.black : Colors.white,
      ),
    );

    Widget slider = SliderTheme(
      data: sliderThemeData,
      child: Slider(
        value: _value,
        min: widget.min,
        max: widget.max,
        divisions: 10,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );

    if (widget.isVertical) {
      slider = RotatedBox(
        quarterTurns: -1,
        child: slider,
      );
    }

    return slider;
  }
}
