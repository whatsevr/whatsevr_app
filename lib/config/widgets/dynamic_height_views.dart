import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SwipeAbleDynamicHeightViews extends StatefulWidget {
  ///PASS UniqueKey() TO REBUILD THE WIDGET WHENEVER NEEDED
  final List<Widget>? children;
  final Function(int)? onViewIndexChanged;
  final int? selectedViewIndex;
  final bool showDotIndicator;
  const SwipeAbleDynamicHeightViews({
    super.key,
    this.children,
    this.onViewIndexChanged,
    this.selectedViewIndex,
    this.showDotIndicator = true,
  });

  @override
  State<SwipeAbleDynamicHeightViews> createState() =>
      _SwipeAbleDynamicHeightViewsState();
}

bool currentSwipeIsLeft = false;

class _SwipeAbleDynamicHeightViewsState
    extends State<SwipeAbleDynamicHeightViews> {
  List<Widget> _children = <Widget>[
    Container(
      height: 300,
      color: Colors.red,
    ),
    Container(
      height: 100,
      color: Colors.green,
    ),
    Container(
      height: 250,
      color: Colors.blue,
    ),
    Container(
      height: 350,
      color: Colors.black,
    ),
  ];
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    if (widget.children != null && widget.children!.isNotEmpty) {
      setState(() {
        _children = widget.children!;
        if (widget.selectedViewIndex != null) {
          currentIndex = widget.selectedViewIndex!;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_children.isEmpty) {
      return SizedBox();
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        //on left swipe increase index if can be increased vise versa
        if (details.velocity.pixelsPerSecond.dx < 0) {
          if (currentIndex < _children.length - 1) {
            //if last index reached do nothing
            if (currentIndex == _children.length - 1) return;
            setState(() {
              currentSwipeIsLeft = true;
              currentIndex++;
              widget.onViewIndexChanged?.call(currentIndex);
            });
          }
        } else {
          //if first index reached do nothing
          if (currentIndex == 0) return;
          if (currentIndex > 0) {
            setState(() {
              currentSwipeIsLeft = false;
              currentIndex--;
              widget.onViewIndexChanged?.call(currentIndex);
            });
          }
        }
      },
      child: Column(
        children: [
          if (currentSwipeIsLeft)
            SlideInRight(
              key: UniqueKey(),
              duration: const Duration(milliseconds: 200),
              child: _children[currentIndex],
            )
          else
            SlideInLeft(
              key: UniqueKey(),
              duration: const Duration(milliseconds: 200),
              child: _children[currentIndex],
            ),
          //dot indicator
          if (widget.showDotIndicator && _children.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _children.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? Colors.black : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
