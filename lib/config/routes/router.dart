import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/media/camera_surface.dart';
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
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
        routes: <RouteBase>[
          if (kDebugMode) ...getDevRoutes(),
          GoRoute(
            name: RoutesName.takerDebug,
            path: RoutesName.takerDebug,
            builder: (BuildContext context, GoRouterState state) {
              return TalkerScreen(talker: TalkerService.instance);
            },
          ),
          GoRoute(
            name: RoutesName.dashboard,
            path: RoutesName.dashboard,
            builder: (BuildContext context, GoRouterState state) {
              return const DashboardPage();
            },
          ),
          GoRoute(
            name: RoutesName.fullVideoPlayer,
            path: RoutesName.fullVideoPlayer,
            builder: (BuildContext context, GoRouterState state) {
              List<String> videoSrcs = state.extra as List<String>;
              return FullVideoPlayerPage(
                videoSrcs: videoSrcs,
              );
            },
          ),
          GoRoute(
            name: RoutesName.accountSearch,
            path: RoutesName.accountSearch,
            builder: (BuildContext context, GoRouterState state) {
              AccountSearchPage? accountSearchPage =
                  state.extra as AccountSearchPage?;
              return AccountSearchPage(
                hintTexts: accountSearchPage?.hintTexts,
              );
            },
          ),
          GoRoute(
            name: RoutesName.account,
            path: RoutesName.account,
            builder: (BuildContext context, GoRouterState state) {
              AccountPageArgument accountPageArgument =
                  state.extra as AccountPageArgument;
              return AccountPage(
                pageArgument: accountPageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.community,
            path: RoutesName.community,
            builder: (BuildContext context, GoRouterState state) {
              return CommunityPage();
            },
          ),
          GoRoute(
            name: RoutesName.settings,
            path: RoutesName.settings,
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsPage();
            },
          ),
          GoRoute(
            name: RoutesName.wtvDetails,
            path: RoutesName.wtvDetails,
            builder: (BuildContext context, GoRouterState state) {
              return const WtvDetailsPage();
            },
          ),
          GoRoute(
            name: RoutesName.createVideoPost,
            path: RoutesName.createVideoPost,
            builder: (BuildContext context, GoRouterState state) {
              CreateVideoPostPageArgument pageArgument =
                  state.extra as CreateVideoPostPageArgument;
              return CreateVideoPost(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.updateProfile,
            path: RoutesName.updateProfile,
            builder: (BuildContext context, GoRouterState state) {
              ProfileUpdatePageArgument pageArgument =
                  state.extra as ProfileUpdatePageArgument;
              return ProfileUpdatePage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.cameraView,
            path: RoutesName.cameraView,
            builder: (BuildContext context, GoRouterState state) {
              WhatsevrCameraSurfacePageArgument pageArgument =
                  state.extra as WhatsevrCameraSurfacePageArgument;
              return WhatsevrCameraSurfacePage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.editVideo,
            path: RoutesName.editVideo,
            builder: (BuildContext context, GoRouterState state) {
              VideoEditorPageArgument pageArgument =
                  state.extra as VideoEditorPageArgument;
              return VideoEditorPage(
                pageArgument: pageArgument,
              );
            },
          ),
        ],
      ),
    ],
  );
}
