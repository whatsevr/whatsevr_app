import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:whatsevr_app/config/api/response_model/auth_service_user.dart';

import '../api/external/models/business_validation_exception.dart';

class AuthUserDb {
  AuthUserDb._();

  static late Box<dynamic> _authorisedCustomersBox;

  static const String _lastLoggedUserId = 'last_logged_user_id';
  static const String _allLoggedUsers = 'all_logged_users';

  static Future<void> initDB() async {
    String dbBoxName = 'auth-user-hive-box-2546';
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(dbBoxName);
    _authorisedCustomersBox = Hive.box(dbBoxName);
  }

  ///[saveAuthorisedUser]
  static Future<void> saveAuthorisedUser(
      AuthServiceUserResponse? authServiceUserResponse) async {
    if (authServiceUserResponse == null) return;
    log('hiveDb.saveLoggedUser: ${authServiceUserResponse.toMap()}');
    List<dynamic> allLoggedUsers =
        await _authorisedCustomersBox.get(_allLoggedUsers) ?? <dynamic>[];

    int index = allLoggedUsers.indexWhere(
      (element) =>
          element['data']['userId'] == authServiceUserResponse.data!.userId,
    );
    if (index != -1) {
      allLoggedUsers[index] = authServiceUserResponse.toMap();
    } else {
      allLoggedUsers.add(authServiceUserResponse.toMap());
    }
    await _authorisedCustomersBox.put(_allLoggedUsers, allLoggedUsers);
  }

  // static Future<AuthServiceUserResponse?> getLastLoggedAuthorisedUser() async {
  //   List<dynamic>? users = _authorisedCustomersBox.get(_allLoggedUsers);
  //   if (users == null) return null;
  //   String? lastLoggedUserId = await getLastLoggedUserUid();
  //   if (lastLoggedUserId == null) return null;
  //   var user = users.firstWhereOrNull(
  //     (element) => element['data']['userId'] == lastLoggedUserId,
  //   );
  //   if (user == null) return null;
  //   return AuthServiceUserResponse.fromMap(jsonDecode(jsonEncode(user)));
  // }

  static Future<List<AuthServiceUserResponse>?> getAllAuthorisedUser() async {
    try {
      List<dynamic>? users = _authorisedCustomersBox.get(_allLoggedUsers);
      if (users == null) return null;
      return users
          .map(
              (e) => AuthServiceUserResponse.fromMap(jsonDecode(jsonEncode(e))))
          .toList();
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<void> removeAuthorisedUser(String userId) async {
    try {
      List<dynamic>? users = _authorisedCustomersBox.get(_allLoggedUsers);
      if (users == null) throw BusinessException('No user found');
      users.removeWhere((element) => element['data']['userId'] == userId);
      await _authorisedCustomersBox.put(_allLoggedUsers, users);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
  }

  ///[saveLastLoggedUserId]
  static Future<void> saveLastLoggedUserId(String userUid) async {
    await _authorisedCustomersBox.put(_lastLoggedUserId, userUid);
  }

  static Future<String?> getLastLoggedUserUid() async {
    try {
      String? lastLoggedUserId =
          await _authorisedCustomersBox.get(_lastLoggedUserId);

      return lastLoggedUserId;
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  ///[clearAllAuthorisedUser]

  static Future<void> clearLastLoggedUserId() async {
    await _authorisedCustomersBox.delete(_lastLoggedUserId);
  }

  static Future<void> clearAllAuthData() async {
    await _authorisedCustomersBox.clear();
  }
}
