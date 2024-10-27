import 'package:flutter/cupertino.dart';

void onReachingEndOfTheList(
  ScrollController? scrollController, {
  required Function()? execute,
}) {
  scrollController?.addListener(() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      debugPrint('Reached the end of the list.');
      execute?.call();
    }
  });
}
