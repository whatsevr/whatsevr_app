import 'package:flutter/material.dart';

class WhatsevrTwoStateUi extends StatefulWidget {
  final bool? isFirstState;
  final Widget? firstStateUi;
  final Widget? secondStateUi;

  final Function(bool isFirstState, bool isSecondState)? onStateChanged;
  const WhatsevrTwoStateUi({
    super.key,
    this.isFirstState,
    this.firstStateUi,
    this.secondStateUi,
    this.onStateChanged,
  });

  @override
  State<WhatsevrTwoStateUi> createState() => _WhatsevrTwoStateUiState();
}

class _WhatsevrTwoStateUiState extends State<WhatsevrTwoStateUi> {
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
          ? AbsorbPointer(
              child: widget.firstStateUi ?? const Icon(Icons.circle_outlined))
          : AbsorbPointer(
              child: widget.secondStateUi ?? const Icon(Icons.check_circle)),
      onPressed: () {
        setState(() {
          _firstState = !_firstState;
        });
        widget.onStateChanged?.call(_firstState, !_firstState);
      },
    );
  }
}
