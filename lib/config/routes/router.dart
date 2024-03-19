import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';

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

  static void newAnonRoute(
    String routeName, {
    Object? extras,
  }) {
    navigatorKey.currentContext?.pushNamed(
      routeName,
      extra: extras,
    );
  }

  static void clearAllAndNewRoute(
    String routeName, {
    Object? extra,
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Map<String, String> pathParameters = const <String, String>{},
  }) {
    while (navigatorKey.currentState?.canPop() == true) {
      navigatorKey.currentState?.pop();
    }
    newRoute(
      routeName,
      extras: extra,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }

  static void goBack({Object? result}) {
    navigatorKey.currentState?.pop(result);
  }

  static void goBackAndStopAt(String stopRoute) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(stopRoute));
  }

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter allRoutesConfig(
    BuildContext context,
    String? initialLocation,
  ) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: RoutesName.home,
      debugLogDiagnostics: true,
      observers: <NavigatorObserver>[
        FlutterSmartDialog.observer,
        // TalkerRouteObserver(talker),
      ],
      routes: <RouteBase>[],
    );
  }
}
