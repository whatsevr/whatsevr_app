import 'dart:convert';

class UpdateUserServicesRequest {
  final String? userUid;
  final List<UserService>? userServices;

  UpdateUserServicesRequest({
    this.userUid,
    this.userServices,
  });

  factory UpdateUserServicesRequest.fromJson(String str) =>
      UpdateUserServicesRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateUserServicesRequest.fromMap(Map<String, dynamic> json) =>
      UpdateUserServicesRequest(
        userUid: json['user_uid'],
        userServices: json['user_services'] == null
            ? <UserService>[]
            : List<UserService>.from(
                json['user_services']!.map((x) => UserService.fromMap(x))),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'user_uid': userUid,
        'user_services': userServices == null
            ? <dynamic>[]
            : List<dynamic>.from(
                userServices!.map((UserService x) => x.toMap())),
      };
}

class UserService {
  final String? title;
  final String? userUid;
  final String? description;

  UserService({
    this.title,
    this.userUid,
    this.description,
  });

  factory UserService.fromJson(String str) =>
      UserService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserService.fromMap(Map<String, dynamic> json) => UserService(
        title: json['title'],
        userUid: json['user_uid'],
        description: json['description'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'user_uid': userUid,
        'description': description,
      };
}
