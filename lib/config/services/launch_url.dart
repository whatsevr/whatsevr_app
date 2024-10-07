import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:whatsevr_app/dev/talker.dart';

void launchWebURL(
  BuildContext context, {
  required String url,
  bool openInExternalBrowser = true,
}) async {
  final theme = Theme.of(context);
  try {
    TalkerService.instance.info('Launching URL: $url');

    await launchUrl(
      Uri.parse(url),
      prefersDeepLink: true,
      customTabsOptions: openInExternalBrowser
          ? null
          : CustomTabsOptions(
              colorSchemes: CustomTabsColorSchemes.defaults(
                toolbarColor: theme.colorScheme.surface,
              ),
              shareState: CustomTabsShareState.on,
              urlBarHidingEnabled: true,
              showTitle: true,
              closeButton: CustomTabsCloseButton(
                icon: CustomTabsCloseButtonIcons.back,
              ),
            ),
      safariVCOptions: openInExternalBrowser
          ? null
          : SafariViewControllerOptions(
              preferredBarTintColor: theme.colorScheme.surface,
              preferredControlTintColor: theme.colorScheme.onSurface,
              barCollapsingEnabled: true,
              dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
            ),
    );
  } catch (e) {
    // If the URL launch fails, an exception will be thrown. (For example, if no browser app is installed on the Android device.)
    debugPrint(e.toString());
  }
}
