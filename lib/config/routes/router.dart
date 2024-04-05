import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/src/features/dashboard/views/page.dart';
import 'package:whatsevr_app/src/features/full_video_player/views/page.dart';

import '../../src/features/search_pages/account/views/page.dart';
import '../../src/features/splash/views/page.dart';

// import 'package:talker_flutter/talker_flutter.dart';
CustomTransitionPage<SlideTransition> navigateWithTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
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
  static void newRoute(
    String routeName, {
    Object? extras,
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, String> pathParameters = const <String, String>{},
  }) {
    navigatorKey.currentContext?.goNamed(
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

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter allRoutesConfig(
    String? initialLocation,
  ) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: RoutesName.splash,
      debugLogDiagnostics: true,
      observers: <NavigatorObserver>[
        FlutterSmartDialog.observer,
        // TalkerRouteObserver(talker),
      ],
      routes: <RouteBase>[
        GoRoute(
            path: RoutesName.splash,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return navigateWithTransition(
                context: context,
                state: state,
                child: const SplashPage(),
              );
            },
            routes: [
              GoRoute(
                name: RoutesName.dashboard,
                path: RoutesName.dashboard,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return navigateWithTransition(
                    context: context,
                    state: state,
                    child: const DashboardPage(),
                  );
                },
                routes: [
                  GoRoute(
                    name: RoutesName.fullVideoPlayer,
                    path: RoutesName.fullVideoPlayer,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return navigateWithTransition(
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
                      AccountSearchPage? accountSearchPage = state.extra as AccountSearchPage?;
                      return navigateWithTransition(
                        context: context,
                        state: state,
                        child: AccountSearchPage(
                          hintTexts: accountSearchPage?.hintTexts,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ]),
      ],
    );
  }
}
