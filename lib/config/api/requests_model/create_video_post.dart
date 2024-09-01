import 'dart:convert';

class CreateVideoPostRequest {
  final String? title;
  final String? description;
  final String? userUid;

  CreateVideoPostRequest({
    this.title,
    this.description,
    this.userUid,
  });

  factory CreateVideoPostRequest.fromJson(String str) =>
      CreateVideoPostRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateVideoPostRequest.fromMap(Map<String, dynamic> json) =>
      CreateVideoPostRequest(
        title: json["title"],
        description: json["description"],
        userUid: json["user_uid"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "user_uid": userUid,
      };
}
