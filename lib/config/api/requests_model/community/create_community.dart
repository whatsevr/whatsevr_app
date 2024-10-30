import 'dart:convert';

class CreateCommunityRequest {
  final String? adminUserUid;
  final String? status;
  final String? title;

  final bool? requireJoiningApproval;

  CreateCommunityRequest({
    this.adminUserUid,
    this.status,
    this.title,
    this.requireJoiningApproval,
  });

  CreateCommunityRequest copyWith({
    String? adminUserUid,
    String? status,
    String? title,
    String? username,
    bool? requireJoiningApproval,
  }) =>
      CreateCommunityRequest(
        adminUserUid: adminUserUid ?? this.adminUserUid,
        status: status ?? this.status,
        title: title ?? this.title,
        requireJoiningApproval:
            requireJoiningApproval ?? this.requireJoiningApproval,
      );

  factory CreateCommunityRequest.fromJson(String str) =>
      CreateCommunityRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateCommunityRequest.fromMap(Map<String, dynamic> json) =>
      CreateCommunityRequest(
        adminUserUid: json['admin_user_uid'],
        status: json['status'],
        title: json['title'],
        requireJoiningApproval: json['require_joining_approval'],
      );

  Map<String, dynamic> toMap() => {
        'admin_user_uid': adminUserUid,
        'status': status,
        'title': title,
        'require_joining_approval': requireJoiningApproval,
      };
}
