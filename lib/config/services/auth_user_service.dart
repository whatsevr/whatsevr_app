import 'package:restart_app/restart_app.dart';
import 'package:whatsevr_app/config/api/interceptors/cache.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/user_details.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

import 'package:whatsevr_app/dev/talker.dart';

class CurrentUser {
  final String userUid;
  final String? userName;
  final String? profilePictureUrl;
  final List<String?>? allAuthUserUids;
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
        allAuthUserUids: (await AuthUserDb.getAllAuthorisedUser())
                ?.map(
                  (e) => e.data?.userId,
                )
                .toList() ??
            <String>[],
      );

      TalkerService.instance.info('Current User: ${_currentUser?.toMap()}');
      return true;
    }
    return false;
  }

  static Future<void> checkCurrentUserSanity(String newUserUid) async {}

  static Future<void> logOutCurrentUser({
    bool restartApp = false,
  }) async {
    _currentUser = null;
    await AuthUserDb.clearLastLoggedUserId();
    await ApiCacheInterceptor.clearCache();
    if (restartApp) {
      Restart.restartApp();
    }
  }

  static Future<void> logOutAllUser({
    bool restartApp = false,
  }) async {
    _currentUser = null;
    await AuthUserDb.clearAllAuthData();
    await ApiCacheInterceptor.clearCache();
    if (restartApp) {
      Restart.restartApp();
    }
  }
}
