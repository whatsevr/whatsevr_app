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
    String dbBoxName = 'logged-user-hive-boxs-5254325';
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(dbBoxName);
    _authorisedCustomersBox = Hive.box(dbBoxName);
  }

  ///[saveAuthorisedUser]
  static Future<void> saveAuthorisedUser(AuthServiceUserResponse? user) async {
    if (user == null) return;
    log('hiveDb.saveLoggedUser: ${user.toMap()}');
    List<dynamic> allLoggedUsers =
        await _authorisedCustomersBox.get(_allLoggedUsers) ?? <dynamic>[];

    int index = allLoggedUsers.indexWhere(
      (element) => element['data']['userId'] == user.data!.userId,
    );
    if (index != -1) {
      allLoggedUsers[index] = user.toMap();
    } else {
      allLoggedUsers.add(user.toMap());
    }
    await _authorisedCustomersBox.put(_allLoggedUsers, allLoggedUsers);
    await saveLastLoggedUserId(user);
  }

  static Future<AuthServiceUserResponse?> getLastLoggedAuthorisedUser() async {
    List<dynamic>? users = _authorisedCustomersBox.get(_allLoggedUsers);
    if (users == null) return null;
    String? lastLoggedUserId = await getLastLoggedUserUid();
    if (lastLoggedUserId == null) return null;
    var user = users.firstWhereOrNull(
      (element) => element['data']['userId'] == lastLoggedUserId,
    );
    if (user == null) return null;
    return AuthServiceUserResponse.fromMap(jsonDecode(jsonEncode(user)));
  }

  static Future<List<AuthServiceUserResponse>?> getAllAuthorisedUser() async {
    try {
      List<dynamic>? users = _authorisedCustomersBox.get(_allLoggedUsers);
      if (users == null) throw BusinessException('No user found');
      return users
          .map(
              (e) => AuthServiceUserResponse.fromMap(jsonDecode(jsonEncode(e))))
          .toList();
    } catch (e, s) {
      productionSafetyCatch(e, s);
    }
  }

  static Future<void> removeAuthorisedUser(String userId) async {
    try {
      List<dynamic>? users = _authorisedCustomersBox.get(_allLoggedUsers);
      if (users == null) throw BusinessException('No user found');
      users.removeWhere((element) => element['data']['userId'] == userId);
      await _authorisedCustomersBox.put(_allLoggedUsers, users);
    } catch (e, s) {
      productionSafetyCatch(e, s);
    }
  }

  ///[saveLastLoggedUserId]
  static Future<void> saveLastLoggedUserId(AuthServiceUserResponse user) async {
    await _authorisedCustomersBox.put(_lastLoggedUserId, user.data!.userId);
  }

  static Future<String?> getLastLoggedUserUid() async {
    try {
      String? lastLoggedUserId =
          await _authorisedCustomersBox.get(_lastLoggedUserId);
      if (lastLoggedUserId == null) {
        throw BusinessException('No user found');
      }
      return lastLoggedUserId;
    } catch (e, s) {
      productionSafetyCatch(e, s);
    }
  }

  ///[clearAllAuthorisedUser]
  static Future<void> clearAllAuthorisedUser() async {
    await _authorisedCustomersBox.delete(_allLoggedUsers);
  }

  static Future<void> clearLastLoggedUserId() async {
    await _authorisedCustomersBox.delete(_lastLoggedUserId);
  }

  static Future<void> clearAllAuthData() async {
    await _authorisedCustomersBox.clear();
  }
}
