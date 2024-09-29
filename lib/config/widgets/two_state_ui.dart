import 'package:flutter/material.dart';

class TwoStateWidget extends StatefulWidget {
  final bool? isFirstState;
  final Widget? firstStateUi;
  final Widget? secondStateUi;
  const TwoStateWidget({
    super.key,
    this.isFirstState,
    this.firstStateUi,
    this.secondStateUi,
  });

  @override
  State<TwoStateWidget> createState() => _TwoStateWidgetState();
}

class _TwoStateWidgetState extends State<TwoStateWidget> {
  @override
  void initState() {
    super.initState();
    _firstState = widget.isFirstState ?? true;
  }

  late bool _firstState;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _firstState
          ? widget.firstStateUi ?? const Icon(Icons.circle_outlined)
          : widget.secondStateUi ?? const Icon(Icons.check_circle),
      onPressed: () {
        setState(() {
          _firstState = !_firstState;
        });
      },
    );
  }
}
