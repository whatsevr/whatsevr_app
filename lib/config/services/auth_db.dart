import 'dart:developer';

import 'package:hive_flutter/adapters.dart';

import '../api/external/models/business_validation_exception.dart';

class AuthUserDb {
  AuthUserDb._();

  static late Box<dynamic> _authorisedCustomersBox;

  static const String _lastLoggedUserUid = 'last_logged_user_uid';
  static const String _allLoggedUserUids = 'all_logged_user_uids';

  static Future<void> initDB() async {
    final dbBoxName = 'auth-user-hive-box-2735';
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(dbBoxName);
    _authorisedCustomersBox = Hive.box(dbBoxName);
  }

  ///[saveAuthorisedUserUid]
  static Future<void> saveAuthorisedUserUid(String? userUid) async {
    if (userUid == null) return;
    log('hiveDb.saveLoggedUser: $userUid');
    List<dynamic> allLoggedUsers =
        await _authorisedCustomersBox.get(_allLoggedUserUids) ?? <dynamic>[];

    allLoggedUsers.add(userUid);
    allLoggedUsers = allLoggedUsers.toSet().toList();
    await _authorisedCustomersBox.put(_allLoggedUserUids, allLoggedUsers);
  }

  static List<String> getAllAuthorisedUserUid() {
    try {
      final List<dynamic>? users =
          _authorisedCustomersBox.get(_allLoggedUserUids, defaultValue: []);
      if (users == null) return [];
      return users.cast<String>();
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return [];
  }

  static Future<void> removeAuthorisedUserUid(String userId) async {
    try {
      final List<dynamic>? users = _authorisedCustomersBox.get(_allLoggedUserUids);
      if (users == null) throw BusinessException('No user found');
      users.remove(userId);
      await _authorisedCustomersBox.put(_allLoggedUserUids, users);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
  }

  ///[saveLastLoggedUserUid]
  static Future<void> saveLastLoggedUserUid(String userUid) async {
    await _authorisedCustomersBox.put(_lastLoggedUserUid, userUid);
  }

  static String? getLastLoggedUserUid() {
    try {
      final String? lastLoggedUserId =
          _authorisedCustomersBox.get(_lastLoggedUserUid);

      return lastLoggedUserId;
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  ///[clearAllAuthorisedUser]

  static Future<void> clearLastLoggedUserUid() async {
    await _authorisedCustomersBox.delete(_lastLoggedUserUid);
  }

  static Future<void> clearAllAuthData() async {
    await _authorisedCustomersBox.clear();
  }
}
