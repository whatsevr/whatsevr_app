import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/media/camera_surface.dart';
import 'package:whatsevr_app/config/widgets/media/image_cropper.dart';
import 'package:whatsevr_app/config/widgets/media/image_editor.dart';
import 'package:whatsevr_app/config/widgets/media/video_editor.dart';
import 'package:whatsevr_app/constants.dart';
import 'package:whatsevr_app/dev/routes/routes.dart';
import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/src/features/community/views/page.dart';
import 'package:whatsevr_app/src/features/dashboard/views/page.dart';
import 'package:whatsevr_app/src/features/new_community/views/page.dart';

import 'package:whatsevr_app/src/features/search_pages/account/views/page.dart';
import 'package:whatsevr_app/src/features/settings/views/page.dart';
import 'package:whatsevr_app/src/features/splash/views/page.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/views/page.dart';
import 'package:whatsevr_app/src/features/post_details_views/wtv_details/views/page.dart';
import 'package:whatsevr_app/src/features/account/views/page.dart';
import 'package:whatsevr_app/src/features/update_profile/views/page.dart';

import '../../src/features/create_posts/create_flick_post/views/page.dart';
import '../../src/features/create_posts/create_memory/views/page.dart';
import '../../src/features/create_posts/create_offer/views/page.dart';
import '../../src/features/create_posts/create_photo_post/views/page.dart';
import '../../src/features/create_posts/upload_pdf/views/page.dart';

class NavigationObserver extends NavigatorObserver {
  NavigationObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    FirebaseAnalytics.instance.logScreenView(screenName: route.settings.name);
  }
}

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

  static Future<dynamic> clearAllAndNewRoute(
    String routeName, {
    Object? extra,
  }) async {
    while (_router.canPop()) {
      _router.pop();
    }
    return await newRoute(
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

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  static BuildContext? get currentContext => _navigatorKey.currentContext;
  static GoRouter allRoutes() => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: RoutesName.auth,
    debugLogDiagnostics: true,
    observers: <NavigatorObserver>[
      NavigationObserver(),
      // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      FlutterSmartDialog.observer,
      TalkerService.takerRouteObserver(),
    ],
    routes: <RouteBase>[
      GoRoute(
        path: RoutesName.splash,
        routes: <RouteBase>[
          if (kTestingMode) ...getDevRoutes(),
          GoRoute(
            path: RoutesName.auth,
            builder: (BuildContext context, GoRouterState state) {
              return const SplashPage();
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
              SettingsPageArgument settingsPageArgument =
                  state.extra as SettingsPageArgument;
              return SettingsPage(
                pageArgument: settingsPageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.wtvDetails,
            path: RoutesName.wtvDetails,
            builder: (BuildContext context, GoRouterState state) {
              WtvDetailsPageArgument pageArgument =
                  state.extra as WtvDetailsPageArgument;
              return WtvDetailsPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.createVideoPost,
            path: RoutesName.createVideoPost,
            builder: (BuildContext context, GoRouterState state) {
              CreateVideoPostPageArgument pageArgument =
                  state.extra as CreateVideoPostPageArgument;
              return CreateVideoPostPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.createFlick,
            path: RoutesName.createFlick,
            builder: (BuildContext context, GoRouterState state) {
              CreateFlickPostPageArgument pageArgument =
                  state.extra as CreateFlickPostPageArgument;
              return CreateFlickPostPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.createMemory,
            path: RoutesName.createMemory,
            builder: (BuildContext context, GoRouterState state) {
              CreateMemoryPageArgument pageArgument =
                  state.extra as CreateMemoryPageArgument;
              return CreateMemoryPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.createOffer,
            path: RoutesName.createOffer,
            builder: (BuildContext context, GoRouterState state) {
              CreateOfferPageArgument pageArgument =
                  state.extra as CreateOfferPageArgument;
              return CreateOfferPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.createPhotoPost,
            path: RoutesName.createPhotoPost,
            builder: (BuildContext context, GoRouterState state) {
              CreatePhotoPostPageArgument pageArgument =
                  state.extra as CreatePhotoPostPageArgument;
              return CreatePhotoPostPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.uploadPdf,
            path: RoutesName.uploadPdf,
            builder: (BuildContext context, GoRouterState state) {
              UploadPdfPageArgument pageArgument =
                  state.extra as UploadPdfPageArgument;
              return UploadPdfPage(
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
              CameraViewPageArgument pageArgument =
                  state.extra as CameraViewPageArgument;
              return CameraViewPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.videoEditor,
            path: RoutesName.videoEditor,
            builder: (BuildContext context, GoRouterState state) {
              VideoEditorPageArgument pageArgument =
                  state.extra as VideoEditorPageArgument;
              return VideoEditorPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.imageEditor,
            path: RoutesName.imageEditor,
            builder: (BuildContext context, GoRouterState state) {
              ImageEditorPageArgument pageArgument =
                  state.extra as ImageEditorPageArgument;
              return ImageEditorPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.imageCropper,
            path: RoutesName.imageCropper,
            builder: (BuildContext context, GoRouterState state) {
              ImageCropperPageArgument pageArgument =
                  state.extra as ImageCropperPageArgument;
              return ImageCropperPage(
                pageArgument: pageArgument,
              );
            },
          ),
          GoRoute(
            name: RoutesName.newCommunity,
            path: RoutesName.newCommunity,
            builder: (BuildContext context, GoRouterState state) {
              NewCommunityPageArgument pageArgument =
                  state.extra as NewCommunityPageArgument;
              return NewCommunityPage(
                pageArgument: pageArgument,
              );
            },
          ),
        ],
      ),
    ],
  );
}
