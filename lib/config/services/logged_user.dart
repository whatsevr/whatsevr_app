import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../api/response_model/user.dart';

class LoggedUser {
  LoggedUser._();

  static late Box<dynamic> _authorisedCustomersBox;
  static const String _loggedCustomer = 'logged_user';
  static Future<void> initDB() async {
    String dbBoxName = 'logged-user-hive-box';
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(dbBoxName);
    _authorisedCustomersBox = Hive.box(dbBoxName);
  }

  static Future<void> saveLoggedUser(AuthorisedUserResponse? user) async {
    if (user == null) return;
    log('hiveDb.saveLoggedUser: ${user.toMap()}');
    await _authorisedCustomersBox.put(_loggedCustomer, user.toMap());
  }

  static Future<AuthorisedUserResponse?> getLoggedUser() async {
    var user = _authorisedCustomersBox.get(_loggedCustomer);
    if (user == null) return null;
    return AuthorisedUserResponse.fromMap(user.cast<String, dynamic>());
  }

  static Future<void> clearLoggedUser() async {
    await _authorisedCustomersBox.delete(_loggedCustomer);
  }
}
