import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../api/response_model/user.dart';

class AuthUserDb {
  AuthUserDb._();

  static late Box<dynamic> _authorisedCustomersBox;
  static const String _loggedCustomer = 'logged_user';
  static Future<void> initDB() async {
    String dbBoxName = 'logged-user-hive-boxsdd';
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(dbBoxName);
    _authorisedCustomersBox = Hive.box(dbBoxName);
  }

  static Future<void> saveAuthorisedUser(AuthorisedUserResponse? user) async {
    if (user == null) return;
    log('hiveDb.saveLoggedUser: ${user.toMap()}');
    await _authorisedCustomersBox.add(user.toMap());
  }

  static Future<AuthorisedUserResponse?> getAuthorisedUser() async {
    var users = _authorisedCustomersBox.values;
    if (users.isEmpty) return null;
    return AuthorisedUserResponse.fromMap(jsonDecode(jsonEncode(users.last)));
  }

  static Future<void> clearAuthorisedUser() async {
    await _authorisedCustomersBox.delete(_loggedCustomer);
  }
}
