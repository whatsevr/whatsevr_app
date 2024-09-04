import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../utils/conversion.dart';
import '../api/response_model/user.dart';

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
  static Future<void> saveAuthorisedUser(AuthorisedUserResponse? user) async {
    if (user == null) return;
    log('hiveDb.saveLoggedUser: ${user.toMap()}');
    List<dynamic> allLoggedUsers =
        await _authorisedCustomersBox.get(_allLoggedUsers) ?? [];

    int index = allLoggedUsers.indexWhere(
        (element) => element['data']['userId'] == user.data!.userId);
    if (index != -1) {
      allLoggedUsers[index] = user.toMap();
    } else {
      allLoggedUsers.add(user.toMap());
    }
    await _authorisedCustomersBox.put(_allLoggedUsers, allLoggedUsers);
    await saveLastLoggedUserId(user);
  }

  static Future<AuthorisedUserResponse?> getLastLoggedAuthorisedUser() async {
    List<dynamic>? users = _authorisedCustomersBox.get(_allLoggedUsers);
    if (users == null) return null;
    var lastLoggedUserId = await getLastLoggedUserId();
    if (lastLoggedUserId == null) return null;
    var user = users.firstWhereOrNull(
        (element) => element['data']['userId'] == lastLoggedUserId);
    if (user == null) return null;
    return AuthorisedUserResponse.fromMap(jsonDecode(jsonEncode(user)));
  }

  static Future<void> clearAllAuthorisedUser() async {
    await _authorisedCustomersBox.clear();
  }

  ///[saveLastLoggedUserId]
  static Future<void> saveLastLoggedUserId(AuthorisedUserResponse user) async {
    await _authorisedCustomersBox.put(_lastLoggedUserId, user.data!.userId);
  }

  static Future<String?> getLastLoggedUserId() async {
    return _authorisedCustomersBox.get(_lastLoggedUserId);
  }
}
