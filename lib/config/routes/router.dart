import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/media/video_editor.dart';
import 'package:whatsevr_app/dev/routes/routes.dart';
import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/config/widgets/media/thumbnail_selection.dart';
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

class AppNavigationService {
  static CustomTransitionPage<SlideTransition> _navigateWithTransition({
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
        return SlideTransition(
          position: Tween<Offset>(
            begin: slideFromBottom == true
                ? const Offset(0, 1)
                : const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static Future<dynamic> newRoute(
    String routeName, {
    Object? extras,
  }) async {
    return await _router.pushNamed(
      routeName,
      extra: extras,
    );
  }

  static void clearAllAndNewRoute(
    String routeName, {
    Object? extra,
  }) {
    while (_router.canPop()) {
      _router.pop();
    }
    newRoute(
      routeName,
      extras: extra,
    );
  }

  static void goBack<T>({dynamic result}) {
    _router.pop(result);
  }

  static void goBackAndStopAt(String stopRoute) {
    while (_router.canPop()) {
      if (_router.routerDelegate.currentConfiguration.fullPath == stopRoute) {
        break;
      }
      _router.pop();
    }
  }

  static GoRouter allRoutes() => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: RoutesName.splash,
    debugLogDiagnostics: true,
    observers: <NavigatorObserver>[
      FlutterSmartDialog.observer,
      TalkerService.takerRouteObserver(),
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
          GoRoute(
            name: RoutesName.editVideo,
            path: RoutesName.editVideo,
            pageBuilder: (BuildContext context, GoRouterState state) {
              VideoEditorPageArgument pageArgument =
                  state.extra as VideoEditorPageArgument;
              return _navigateWithTransition(
                context: context,
                state: state,
                child: VideoEditorPage(
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
