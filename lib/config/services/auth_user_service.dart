import 'package:whatsevr_app/config/api/interceptors/cache.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/auth_service_user.dart';
import 'package:whatsevr_app/config/api/response_model/user_details.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

import 'package:whatsevr_app/dev/talker.dart';

class CurrentUser {
  final String userUid;
  final String? userName;
  final String? profilePictureUrl;
  final List<String>? allAuthUserUids;
  CurrentUser({
    required this.userUid,
    required this.userName,
    required this.profilePictureUrl,
    required this.allAuthUserUids,
  });

  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'userName': userName,
      'profilePictureUrl': profilePictureUrl,
      'allAuthUserUids': allAuthUserUids,
    };
  }
}

class AuthUserService {
  AuthUserService._privateConstructor();

  static final AuthUserService _instance =
      AuthUserService._privateConstructor();

  static AuthUserService get instance => _instance;
  static CurrentUser? _currentUser;
  static CurrentUser? get currentUser => _currentUser;
  static Future<bool> setCurrentUser(String? newUserUid) async {
    if (newUserUid == null) throw Exception('UserUid is null');
    UserDetailsResponse? userInfo =
        await UsersApi.getUserDetails(userUid: newUserUid);
    if (userInfo != null) {
      _currentUser = CurrentUser(
          userUid: userInfo.data!.uid!,
          userName: userInfo.data?.username,
          profilePictureUrl: userInfo.data?.profilePicture,
          allAuthUserUids: [
            for (AuthServiceUserResponse? authUser
                in (await AuthUserDb.getAllAuthorisedUser()) ?? [])
              if (authUser?.data?.userId != null) authUser!.data!.userId!
          ]);

      TalkerService.instance.info('Current User: ${_currentUser?.toMap()}');
      return true;
    }
    return false;
  }

  static Future<void> checkCurrentUserSanity(String newUserUid) async {}
  static Future<bool?> switchUser(String? newUserUid) async {
    if (newUserUid == null) return false;
    if (await setCurrentUser(newUserUid) == true) {
      await AuthUserDb.saveLastLoggedUserId(newUserUid);
      AppNavigationService.clearAllAndNewRoute(RoutesName.dashboard);
    } else {
      TalkerService.instance.error('Failed to switch user to $newUserUid');
      return false;
    }
    return null;
  }

  static Future<void> logOutCurrentUser({
    bool restartApp = false,
  }) async {
    _currentUser = null;
    await AuthUserDb.clearLastLoggedUserId();

    if (restartApp) {
      AppNavigationService.clearAllAndNewRoute(RoutesName.dashboard);
    }
  }

  static Future<void> logOutAllUser({
    bool restartApp = false,
  }) async {
    _currentUser = null;
    await AuthUserDb.clearAllAuthData();

    if (restartApp) {
      AppNavigationService.clearAllAndNewRoute(RoutesName.dashboard);
    }
  }
}
