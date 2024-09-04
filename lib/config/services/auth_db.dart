import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../api/response_model/user.dart';

class AuthUserDb {
  AuthUserDb._();

  static late Box<dynamic> _authorisedCustomersBox;
  static const String _lastLoggedUserId = 'last_logged_user_id';
  static Future<void> initDB() async {
    String dbBoxName = 'logged-user-hive-boxs4252';
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(dbBoxName);
    _authorisedCustomersBox = Hive.box(dbBoxName);
  }

  ///[saveAuthorisedUser]
  static Future<void> saveAuthorisedUser(AuthorisedUserResponse? user) async {
    if (user == null) return;
    log('hiveDb.saveLoggedUser: ${user.toMap()}');
    await _authorisedCustomersBox.add(user.toMap());
  }

  static Future<AuthorisedUserResponse?> getLastLoggedAuthorisedUser() async {
    List users = _authorisedCustomersBox.values.toList();
    if (users.isEmpty) return null;
    List<AuthorisedUserResponse> usersList = users
        .map((e) => AuthorisedUserResponse.fromMap(jsonDecode(jsonEncode(e))))
        .toList();
    String? lastLoggedUserId = await getLastLoggedUserId();
    if (lastLoggedUserId == null) return usersList.first;
    return usersList.firstWhereOrNull(
      (AuthorisedUserResponse element) =>
          element.data!.userId == lastLoggedUserId,
    );
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
