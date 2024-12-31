import 'package:flutter/cupertino.dart';

void onReachingEndOfTheList(
  BuildContext? context, {
  ScrollController? scrollController,
  required Function()? execute,
}) {
  if (scrollController == null) return;
  if (context == null || !scrollController.hasClients || !context.mounted) {
    return;
  }

  scrollController.addListener(() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      debugPrint('Reached the end of the list.');
      execute?.call();
    }
  });
}
