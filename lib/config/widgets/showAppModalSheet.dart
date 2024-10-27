import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import '../routes/router.dart';

Completer<void>? _currentModalCompleter;

Future<void> showAppModalSheet({
  BuildContext? context,
  required Widget? child,
  bool flexibleSheet = true,
  bool dismissPrevious = false,
  bool transparentMask = false,
  double maxSheetHeight = 0.9,
}) async {
  // Dismiss the previous modal sheet if it exists and dismissPrevious is true
  if (dismissPrevious &&
      _currentModalCompleter != null &&
      !_currentModalCompleter!.isCompleted) {
    Navigator.of(context ?? AppNavigationService.currentContext!).pop();
    await _currentModalCompleter!.future;
  }

  _currentModalCompleter = Completer<void>();

  context ??= AppNavigationService.currentContext!;
  await showModalBottomSheet(
    useRootNavigator: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * maxSheetHeight -
          MediaQuery.of(context).viewInsets.bottom,
      minWidth: MediaQuery.of(context).size.width,
    ),
    barrierColor:
        transparentMask ? Colors.transparent : Colors.white.withOpacity(0.5),
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    isScrollControlled: true, //auto adjust height
    showDragHandle: true,

    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom, // Keyboard adjustment
        ),
        child: Builder(builder: (context) {
          if (!flexibleSheet) {
            return PadHorizontal(child: child ?? const SizedBox.shrink());
          }
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: PadHorizontal(child: child ?? const SizedBox.shrink()),
              );
            },
          );
        }),
      );
    },
  );

  _currentModalCompleter?.complete();
  _currentModalCompleter = null;
}
