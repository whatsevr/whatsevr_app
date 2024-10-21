import 'package:flutter/cupertino.dart';

void onReachingEndOfTheList(
  ScrollController? scrollController, {
  required Function()? execute,
}) {
  scrollController?.addListener(() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent - 100) {
      execute?.call();
    }
  });
}
