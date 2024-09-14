import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/dev/routes/routes.dart';
import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/config/widgets/thumbnail_selection.dart';
import 'package:whatsevr_app/src/features/community/views/page.dart';
import 'package:whatsevr_app/src/features/dashboard/views/page.dart';
import 'package:whatsevr_app/src/features/full_video_player/views/page.dart';

import 'package:whatsevr_app/src/features/search_pages/account/views/page.dart';
import 'package:whatsevr_app/src/features/settings/views/page.dart';
import 'package:whatsevr_app/src/features/splash/views/page.dart';

import 'package:whatsevr_app/src/features/create_posts/create_video_post/views/page.dart';
import 'package:whatsevr_app/src/features/wtv_details/views/page.dart';

import 'package:whatsevr_app/src/features/account/views/page.dart';
import 'package:whatsevr_app/src/features/update_profile/views/page.dart';

// import 'package:talker_flutter/talker_flutter.dart';
CustomTransitionPage<SlideTransition> _navigateWithTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool? slideFromBottom,
}) {
  return CustomTransitionPage<SlideTransition>(
    transitionDuration: const Duration(milliseconds: 300),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      if (slideFromBottom == true) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
            animation,
          ),
          child: child,
        );
      }
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(
          animation,
        ),
        child: child,
      );
    },
  );
}

class AppNavigationService {
  static Future<dynamic> newRoute(
    String routeName, {
    Object? extras,
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, String> pathParameters = const <String, String>{},
  }) async {
    return await navigatorKey.currentContext?.pushNamed(
      routeName,
      extra: extras,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }

  static void clearAllAndNewRoute(
    String routeName, {
    Object? extra,
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, String> pathParameters = const <String, String>{},
  }) {
    while (navigatorKey.currentContext?.canPop() == true) {
      navigatorKey.currentContext?.pop();
    }
    newRoute(
      routeName,
      extras: extra,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }

  static void goBack({dynamic result}) {
    navigatorKey.currentContext?.pop(result);
  }

  static void goBackAndStopAt(String stopRoute) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(stopRoute));
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static GoRouter allRoutesConfig(
    String? initialLocation,
  ) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: RoutesName.splash,
      debugLogDiagnostics: true,
      observers: <NavigatorObserver>[
        FlutterSmartDialog.observer,
        TalkerService.takerRouteObserver(),

        // TalkerRouteObserver(talker),
      ],
      routes: <RouteBase>[
        GoRoute(
          path: RoutesName.splash,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _navigateWithTransition(
              context: context,
              state: state,
              child: const SplashPage(),
            );
          },
          routes: <RouteBase>[
            if (kDebugMode) ...getDevRoutes(),
            GoRoute(
              name: RoutesName.takerDebug,
              path: RoutesName.takerDebug,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: TalkerScreen(talker: TalkerService.instance),
                );
              },
            ),
            GoRoute(
              name: RoutesName.dashboard,
              path: RoutesName.dashboard,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: const DashboardPage(),
                );
              },
            ),
            GoRoute(
              name: RoutesName.fullVideoPlayer,
              path: RoutesName.fullVideoPlayer,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: FullVideoPlayerPage(
                    videoSrcs: state.extra as List<String>,
                  ),
                );
              },
            ),
            GoRoute(
              name: RoutesName.accountSearch,
              path: RoutesName.accountSearch,
              pageBuilder: (BuildContext context, GoRouterState state) {
                AccountSearchPage? accountSearchPage =
                    state.extra as AccountSearchPage?;
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: AccountSearchPage(
                    hintTexts: accountSearchPage?.hintTexts,
                  ),
                );
              },
            ),
            GoRoute(
              name: RoutesName.account,
              path: RoutesName.account,
              pageBuilder: (BuildContext context, GoRouterState state) {
                AccountPageArgument accountPageArgument =
                    state.extra as AccountPageArgument;
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: AccountPage(
                    pageArgument: accountPageArgument,
                  ),
                );
              },
            ),
            GoRoute(
              name: RoutesName.community,
              path: RoutesName.community,
              pageBuilder: (BuildContext context, GoRouterState state) {
                CommunityPage? accountSearchPage =
                    state.extra as CommunityPage?;
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: CommunityPage(),
                );
              },
            ),
            GoRoute(
              name: RoutesName.settings,
              path: RoutesName.settings,
              pageBuilder: (BuildContext context, GoRouterState state) {
                AccountSearchPage? accountSearchPage =
                    state.extra as AccountSearchPage?;
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: const SettingsPage(),
                );
              },
            ),
            GoRoute(
              name: RoutesName.wtvDetails,
              path: RoutesName.wtvDetails,
              pageBuilder: (BuildContext context, GoRouterState state) {
                SettingsPage? accountSearchPage = state.extra as SettingsPage?;
                return _navigateWithTransition(
                  slideFromBottom: true,
                  context: context,
                  state: state,
                  child: const WtvDetailsPage(),
                );
              },
            ),
            GoRoute(
              name: RoutesName.createVideoPost,
              path: RoutesName.createVideoPost,
              pageBuilder: (BuildContext context, GoRouterState state) {
                CreateVideoPostPageArgument pageArgument =
                    state.extra as CreateVideoPostPageArgument;
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: CreateVideoPost(
                    pageArgument: pageArgument,
                  ),
                );
              },
            ),
            GoRoute(
              name: RoutesName.updateProfile,
              path: RoutesName.updateProfile,
              pageBuilder: (BuildContext context, GoRouterState state) {
                ProfileUpdatePageArgument pageArgument =
                    state.extra as ProfileUpdatePageArgument;
                return _navigateWithTransition(
                  context: context,
                  state: state,
                  child: ProfileUpdatePage(
                    pageArgument: pageArgument,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
