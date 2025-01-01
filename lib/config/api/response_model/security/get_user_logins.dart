import 'dart:convert';

class GetUserLoginSessionsResponse {
  String? message;
  List<ActiveLoginSession>? activeLoginSessions;

  GetUserLoginSessionsResponse({
    this.message,
    this.activeLoginSessions,
  });

  GetUserLoginSessionsResponse copyWith({
    String? message,
    List<ActiveLoginSession>? activeLoginSessions,
  }) =>
      GetUserLoginSessionsResponse(
        message: message ?? this.message,
        activeLoginSessions: activeLoginSessions ?? this.activeLoginSessions,
      );

  factory GetUserLoginSessionsResponse.fromJson(String str) =>
      GetUserLoginSessionsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetUserLoginSessionsResponse.fromMap(Map<String, dynamic> json) =>
      GetUserLoginSessionsResponse(
        message: json['message'],
        activeLoginSessions: json['active_login_sessions'] == null
            ? []
            : List<ActiveLoginSession>.from(
                json['active_login_sessions']!
                    .map((x) => ActiveLoginSession.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'active_login_sessions': activeLoginSessions == null
            ? []
            : List<dynamic>.from(activeLoginSessions!.map((x) => x.toMap())),
      };
}

class ActiveLoginSession {
  DateTime? createdAt;
  dynamic fcmToken;
  String? agentType;
  String? userUid;
  String? ipAddress;
  String? uid;
  bool? isActive;
  String? agentId;
  String? agentName;
  int? appVersionCode;

  ActiveLoginSession({
    this.createdAt,
    this.fcmToken,
    this.agentType,
    this.userUid,
    this.ipAddress,
    this.uid,
    this.isActive,
    this.agentId,
    this.agentName,
    this.appVersionCode,
  });

  ActiveLoginSession copyWith({
    DateTime? createdAt,
    dynamic fcmToken,
    String? agentType,
    String? userUid,
    String? ipAddress,
    String? uid,
    bool? isActive,
    String? agentId,
    String? agentName,
    int? appVersionCode,
  }) =>
      ActiveLoginSession(
        createdAt: createdAt ?? this.createdAt,
        fcmToken: fcmToken ?? this.fcmToken,
        agentType: agentType ?? this.agentType,
        userUid: userUid ?? this.userUid,
        ipAddress: ipAddress ?? this.ipAddress,
        uid: uid ?? this.uid,
        isActive: isActive ?? this.isActive,
        agentId: agentId ?? this.agentId,
        agentName: agentName ?? this.agentName,
        appVersionCode: appVersionCode ?? this.appVersionCode,
      );

  factory ActiveLoginSession.fromJson(String str) =>
      ActiveLoginSession.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActiveLoginSession.fromMap(Map<String, dynamic> json) =>
      ActiveLoginSession(
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        fcmToken: json['fcm_token'],
        agentType: json['agent_type'],
        userUid: json['user_uid'],
        ipAddress: json['ip_address'],
        uid: json['uid'],
        isActive: json['is_active'],
        agentId: json['agent_id'],
        agentName: json['agent_name'],
        appVersionCode: json['app_version_code'],
      );

  Map<String, dynamic> toMap() => {
        'created_at': createdAt?.toIso8601String(),
        'fcm_token': fcmToken,
        'agent_type': agentType,
        'user_uid': userUid,
        'ip_address': ipAddress,
        'uid': uid,
        'is_active': isActive,
        'agent_id': agentId,
        'agent_name': agentName,
        'app_version_code': appVersionCode,
      };
}
