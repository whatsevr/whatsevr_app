import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/user_details.dart';
import 'package:whatsevr_app/dev/talker.dart';



class CurrentUser {
  final String? userUid;
  final String? userName;
  final String? profilePictureUrl;

  CurrentUser({
    required this.userUid,
    required this.userName,
    required this.profilePictureUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'userName': userName,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}

class CurrentUserService {
  CurrentUserService._privateConstructor();

  static final CurrentUserService _instance =
      CurrentUserService._privateConstructor();

  static CurrentUserService get instance => _instance;
static CurrentUser? _currentUser;
  static CurrentUser? get currentUser => _currentUser;
  static Future<void> setCurrentUser(String newUserUid) async {
    UserDetailsResponse? userInfo =
        await UsersApi.getUserDetails(userUid: newUserUid);
    if (userInfo != null) {
      _currentUser = CurrentUser(
        userUid: newUserUid,
        userName: userInfo.username,
        profilePictureUrl: userInfo.profilePicture,
      );
      TalkerService.instance.info('Current User: ${_currentUser?.toMap()}');
    }
  }
}
