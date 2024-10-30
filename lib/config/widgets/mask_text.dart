import 'package:flutter/material.dart';

class MaskText extends StatefulWidget {
  final String text;
  final int maskLength;
  final bool maskFirstDigits;
  final TextStyle? style;
  const MaskText({
    required super.key,
    required this.text,
    required this.maskLength,
    required this.maskFirstDigits,
    this.style,
  });

  @override
  _MaskTextState createState() => _MaskTextState();
}

class _MaskTextState extends State<MaskText> {
  late String _maskedText;

  @override
  void initState() {
    super.initState();
    _maskedText =
        maskString(widget.text, widget.maskLength, widget.maskFirstDigits);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _maskedText = _maskedText == widget.text
              ? maskString(
                  widget.text,
                  widget.maskLength,
                  widget.maskFirstDigits,
                )
              : widget.text;
        });
      },
      child: Text(
        _maskedText,
        style: widget.style,
      ),
    );
  }

  String maskString(String input, int maskLength, bool maskFirstDigits) {
    if (input.length <= maskLength) {
      return input;
    }

    var maskedString = '';
    if (maskFirstDigits) {
      maskedString = '*' * maskLength;
      maskedString += input.substring(maskLength);
    } else {
      maskedString = input.substring(0, input.length - maskLength);
      maskedString += '*' * maskLength;
    }

    return maskedString;
  }
}
