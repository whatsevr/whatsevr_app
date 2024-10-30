import 'package:flutter/material.dart';

class WhatsevrTwoStateUi extends StatefulWidget {
  final bool? isSecondState;
  final Widget? firstStateUi;
  final Widget? secondStateUi;

  final Function(bool isSecondState, bool isFirstState)? onStateChanged;
  const WhatsevrTwoStateUi({
    super.key,
    this.isSecondState,
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
    _isSecondState = widget.isSecondState ?? true;
  }

  late bool _isSecondState;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isSecondState
          ? AbsorbPointer(
              child: widget.secondStateUi ?? const Icon(Icons.check_circle))
          : AbsorbPointer(
              child: widget.firstStateUi ?? const Icon(Icons.circle_outlined)),
      onPressed: () {
        setState(() {
          _isSecondState = !_isSecondState;
        });
        widget.onStateChanged?.call(_isSecondState, !_isSecondState);
      },
    );
  }
}
