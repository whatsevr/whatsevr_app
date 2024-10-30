import 'package:flutter/material.dart';

class WhatsevrStepper extends StatefulWidget {
  final int initNumber;

  final Function(int) counterCallback;

  final Function? increaseCallback;

  final Function? decreaseCallback;

  final int minNumber;

  final int maxNumber;

  final Color? backgroundColor;

  final Color? buttonIconColor;

  final Color? buttonFillColor;
  final String? stickySuffix;

  const WhatsevrStepper(
      {required this.initNumber,
      required this.counterCallback,
      this.decreaseCallback,
      this.increaseCallback,
      required this.minNumber,
      required this.maxNumber,
      this.backgroundColor,
      this.buttonIconColor,
      this.buttonFillColor,
      this.stickySuffix,
      super.key,});

  @override
  _WhatsevrStepperState createState() => _WhatsevrStepperState();
}

class _WhatsevrStepperState extends State<WhatsevrStepper> {
  int _currentCount = 0;
  Function _counterCallback = (int number) {};
  Function? _increaseCallback = () {};
  Function? _decreaseCallback = () {};
  int _minNumber = 0;
  int _maxNumber = 100;
  Color? _backgroundColor = Colors.grey;
  Color? _buttonIconColor = Colors.black;
  Color? _buttonFillColor = Colors.white;
  String? _stickySuffix;
  @override
  void initState() {
    _currentCount = widget.initNumber;
    _counterCallback = widget.counterCallback;
    _increaseCallback = widget.increaseCallback;
    _decreaseCallback = widget.decreaseCallback;
    _maxNumber = widget.maxNumber;
    _minNumber = widget.minNumber;
    _backgroundColor = widget.backgroundColor;
    _buttonIconColor = widget.buttonIconColor;
    _buttonFillColor = widget.buttonFillColor;
    _stickySuffix = widget.stickySuffix;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: _backgroundColor,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Visibility(
              visible: _currentCount > 0,
              child: _createIncrementDecrementButton(
                  Icons.remove, () => _decrease(),),),
          Visibility(
              visible: _currentCount > 0,
              child: const SizedBox(
                width: 6,
              ),),
          Visibility(
            visible: _currentCount > 0,
            child: Text(
              '$_currentCount${_stickySuffix != null ? ' $_stickySuffix' : ""}',
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.w600,),
            ),
          ),
          Visibility(
              visible: _currentCount > 0,
              child: const SizedBox(
                width: 6,
              ),),
          _createIncrementDecrementButton(Icons.add, () => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      if (_currentCount < _maxNumber) {
        _currentCount++;
        _increaseCallback?.call();
      }

      _currentCount = _currentCount;
      _counterCallback(_currentCount);
    });
  }

  void _decrease() {
    setState(() {
      if (_currentCount > _minNumber) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback?.call();
      }
    });
  }

  Widget _createIncrementDecrementButton(
      IconData icon, void Function() onPressed,) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minHeight: 30.0, minWidth: 30.0),
      elevation: 0.0,
      fillColor: _buttonFillColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: _buttonIconColor,
        size: 16.0,
      ),
    );
  }
}
