import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

showAppModalSheet({required BuildContext context, required Widget? child}) {
  showModalBottomSheet(
    useRootNavigator: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      minWidth: MediaQuery.of(context).size.width,
    ),
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom, // Keyboard adjustment
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
                controller: scrollController,
                child: PadHorizontal(child: child ?? const SizedBox.shrink()));
          },
        ),
      );
    },
  );
}
