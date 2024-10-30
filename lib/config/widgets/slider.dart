import 'package:flutter/material.dart';

class WhatsevrVideoPlayerSlider extends StatefulWidget {
  final bool isVertical;
  final Color color;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;
  final double length;
  final double thickness;
  const WhatsevrVideoPlayerSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    this.onChanged,
    this.isVertical = true,
    this.color = Colors.white60,
    this.length = 140,
    this.thickness = 1,
  });

  @override
  _WhatsevrVideoPlayerSliderState createState() =>
      _WhatsevrVideoPlayerSliderState();
}

class _WhatsevrVideoPlayerSliderState extends State<WhatsevrVideoPlayerSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final sliderThemeData = SliderTheme.of(context).copyWith(
      activeTrackColor: widget.color,
      inactiveTrackColor: widget.color.withOpacity(0.5),
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: widget.thickness,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 3.0),
      thumbColor: widget.color,
      overlayColor: widget.color.withAlpha(32),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
      tickMarkShape: RoundSliderTickMarkShape(),
      activeTickMarkColor: widget.color,
      inactiveTickMarkColor: widget.color.withOpacity(0.5),
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: widget.color,
      valueIndicatorTextStyle: TextStyle(
        color:
            widget.color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      ),
    );

    Widget slider = SliderTheme(
      data: sliderThemeData,
      child: UnconstrainedBox(
        child: SizedBox(
          width: widget.length,
          child: Slider(
            value: _value,
            min: widget.min,
            max: widget.max,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              });
            },
          ),
        ),
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
