import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum TextAlignTitledContainer { Left, Center, Right }

class MaterialLabelContainer extends SingleChildRenderObjectWidget {
  const MaterialLabelContainer({
    super.key,
    required Widget super.child,
    Color? titleColor,
    required this.title,
    this.textAlign = TextAlignTitledContainer.Left,
    this.fontSize = 14.0,
    this.backgroundColor = const Color.fromRGBO(255, 255, 255, 1.0),
  }) : titleColor = titleColor ?? const Color.fromRGBO(0, 0, 0, 1.0);

  final Color titleColor;
  final Color backgroundColor;
  final String title;
  final TextAlignTitledContainer textAlign;
  final double fontSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTitledContainer(
      titleColor: titleColor,
      title: title,
      fontSize: fontSize,
      backgroundColor: backgroundColor,
      textAlign: textAlign,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderTitledContainer renderObject) {
    renderObject
      ..titleColor = titleColor
      ..backgroundColor = backgroundColor
      ..title = title
      ..fontSize = fontSize
      ..textAlign = textAlign;
  }
}

class RenderTitledContainer extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  RenderTitledContainer({
    required Color titleColor,
    required String title,
    required double fontSize,
    required Color backgroundColor,
    required TextAlignTitledContainer textAlign,
  })  : _titleColor = titleColor,
        _title = title,
        _textAlign = textAlign,
        _backgroundColor = backgroundColor,
        _fontSize = fontSize;

  Color _titleColor;
  Color _backgroundColor;
  String _title;
  TextAlignTitledContainer _textAlign;
  double _fontSize;

  Color get titleColor => _titleColor;
  set titleColor(Color value) {
    if (_titleColor != value) {
      _titleColor = value;
      markNeedsPaint();
    }
  }

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      _backgroundColor = value;
      markNeedsPaint();
    }
  }

  String get title => _title;
  set title(String value) {
    if (_title != value) {
      _title = value;
      markNeedsPaint();
    }
  }

  TextAlignTitledContainer get textAlign => _textAlign;
  set textAlign(TextAlignTitledContainer value) {
    if (_textAlign != value) {
      _textAlign = value;
      markNeedsPaint();
    }
  }

  double get fontSize => _fontSize;
  set fontSize(double value) {
    if (_fontSize != value) {
      _fontSize = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(Size(child!.size.width, child!.size.height));
    } else {
      size = constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }

    final canvas = context.canvas;
    final textSpan = TextSpan(
      text: ' $_title ',
      style: TextStyle(
        color: _titleColor,
        fontSize: _fontSize,
        height: 1.0,
        backgroundColor: _backgroundColor,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    double xPos;
    switch (_textAlign) {
      case TextAlignTitledContainer.Center:
        xPos = (size.width - textPainter.width) / 2.0;
        break;
      case TextAlignTitledContainer.Right:
        xPos = size.width - textPainter.width - 10;
        break;
      case TextAlignTitledContainer.Left:
      default:
        xPos = 10.0;
    }

    final titleOffset = Offset(xPos, -_fontSize / 2);
    textPainter.paint(canvas, offset + titleOffset);
  }

  @override
  bool get alwaysNeedsCompositing => true;
}
