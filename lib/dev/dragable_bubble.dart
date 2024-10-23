import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/dev/routes/routes_name.dart';

enum AnchoringPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  center,
}

class DraggableWidget extends StatefulWidget {
  const DraggableWidget({super.key});

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget>
    with SingleTickerProviderStateMixin {
  double top = 0, left = 0;
  double boundary = 0;
  late AnimationController animationController;
  late Animation<double> animation;
  bool offstage = true;
  bool dragging = false;
  bool isStillTouching = false;
  bool? visible;
  AnchoringPosition? currentDocker;
  AnchoringPosition currentlyDocked = AnchoringPosition.topRight;
  double widgetHeight = 18;
  double widgetWidth = 50;
  final GlobalKey key = GlobalKey();

  final double horizontalSpace = 0;
  final double verticalSpace = 0;
  final bool initialVisibility = true;
  final double bottomMargin = 70;
  final double topMargin = 24;
  final double statusBarHeight = 24;
  final double shadowBorderRadius = 10;
  final BoxShadow normalShadow = const BoxShadow(
    color: Colors.black38,
    offset: Offset(0, 4),
    blurRadius: 2,
  );
  final BoxShadow draggingShadow = const BoxShadow(
    color: Colors.black38,
    offset: Offset(0, 10),
    blurRadius: 10,
  );
  final double dragAnimationScale = 0.8;
  final Duration touchDelay = Duration.zero;
  DragController? dragController;

  bool get currentVisibility => visible ?? initialVisibility;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addListener(() {
        if (currentDocker != null) animateWidget(currentDocker!);
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    dragController?._addState(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Size? widgetSize = getWidgetSize(key);
      if (widgetSize != null) {
        setState(() {
          widgetHeight = widgetSize.height;
          widgetWidth = widgetSize.width;
        });
      }
      setInitialPosition();
    });
  }

  void setInitialPosition() {
    setState(() {
      offstage = false;
      boundary = MediaQuery.of(context).size.height - bottomMargin;
      switch (currentlyDocked) {
        case AnchoringPosition.bottomRight:
          top = boundary - widgetHeight + statusBarHeight;
          left = MediaQuery.of(context).size.width - widgetWidth;
          break;
        case AnchoringPosition.bottomLeft:
          top = boundary - widgetHeight + statusBarHeight;
          left = 0;
          break;
        case AnchoringPosition.topRight:
          top = topMargin;
          left = MediaQuery.of(context).size.width - widgetWidth;
          break;
        case AnchoringPosition.topLeft:
          top = topMargin;
          left = 0;
          break;
        case AnchoringPosition.center:
          top = (boundary - widgetHeight) / 2;
          left = (MediaQuery.of(context).size.width - widgetWidth) / 2;
          break;
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: !currentVisibility
            ? Container()
            : Listener(
                onPointerUp: (v) {
                  if (!isStillTouching) return;
                  isStillTouching = false;
                  currentDocker = determineDocker(v.position.dx, v.position.dy);
                  setState(() => dragging = false);
                  animationController.forward(from: 0);
                },
                onPointerDown: (_) async {
                  isStillTouching = false;
                  await Future.delayed(touchDelay);
                  isStillTouching = true;
                },
                onPointerMove: (v) {
                  if (!isStillTouching) return;
                  setState(() {
                    dragging = true;
                    top = max(v.position.dy - widgetHeight / 2, 0);
                    left = max(v.position.dx - widgetWidth / 2, 0);
                  });
                },
                child: Offstage(
                  offstage: offstage,
                  child: Container(
                    key: key,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalSpace,
                      vertical: verticalSpace,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(shadowBorderRadius),
                      ),
                      child: Transform.scale(
                        scale: dragging ? dragAnimationScale : 1,
                        child: SafeArea(
                          child: IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              AppNavigationService.newRoute(
                                DeveloperRoutes.developerPage,
                              );
                            },
                            icon: const Icon(Icons.developer_mode),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  AnchoringPosition determineDocker(double x, double y) {
    final double totalHeight = boundary;
    final double totalWidth = MediaQuery.of(context).size.width;

    if (x <= totalWidth / 2 && y <= totalHeight / 2) {
      return AnchoringPosition.topLeft;
    } else if (x < totalWidth / 2 && y > totalHeight / 2) {
      return AnchoringPosition.bottomLeft;
    } else if (x > totalWidth / 2 && y < totalHeight / 2) {
      return AnchoringPosition.topRight;
    } else {
      return AnchoringPosition.bottomRight;
    }
  }

  void animateWidget(AnchoringPosition docker) {
    final double totalHeight = boundary;
    final double totalWidth = MediaQuery.of(context).size.width;

    setState(() {
      switch (docker) {
        case AnchoringPosition.topLeft:
          left = (1 - animation.value) * left;
          top = (1 - animation.value) * top + topMargin * animation.value;
          break;
        case AnchoringPosition.topRight:
          left = left + (animation.value) * (totalWidth - widgetWidth - left);
          top = (1 - animation.value) * top + topMargin * animation.value;
          break;
        case AnchoringPosition.bottomLeft:
          left = (1 - animation.value) * left;
          top = top + (animation.value) * (totalHeight - widgetHeight - top);
          break;
        case AnchoringPosition.bottomRight:
          left = left + (animation.value) * (totalWidth - widgetWidth - left);
          top = top + (animation.value) * (totalHeight - widgetHeight - top);
          break;
        case AnchoringPosition.center:
          left = left +
              (animation.value) * (totalWidth / 2 - widgetWidth / 2 - left);
          top = top +
              (animation.value) * (totalHeight / 2 - widgetHeight / 2 - top);
          break;
      }
      currentlyDocked = docker;
    });
  }

  Size? getWidgetSize(GlobalKey key) {
    final BuildContext? keyContext = key.currentContext;
    if (keyContext != null) {
      final RenderBox box = keyContext.findRenderObject() as RenderBox;
      return box.size;
    }
    return null;
  }

  void _showWidget() => setState(() => visible = true);
  void _hideWidget() => setState(() => visible = false);
  void _animateTo(AnchoringPosition anchoringPosition) {
    if (animationController.isAnimating) animationController.stop();
    animationController.reset();
    currentDocker = anchoringPosition;
    animationController.forward();
  }

  Offset _getCurrentPosition() => Offset(left, top);
}

class DragController {
  _DraggableWidgetState? _widgetState;
  void _addState(_DraggableWidgetState widgetState) =>
      _widgetState = widgetState;
  void jumpTo(AnchoringPosition anchoringPosition) =>
      _widgetState?._animateTo(anchoringPosition);
  Offset? getCurrentPosition() => _widgetState?._getCurrentPosition();
  void showWidget() => _widgetState?._showWidget();
  void hideWidget() => _widgetState?._hideWidget();
}
