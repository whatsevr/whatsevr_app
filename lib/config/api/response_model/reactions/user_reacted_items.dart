import 'dart:convert';

class UserReactedItemsResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Datum>? data;

  UserReactedItemsResponse({
    this.message,
    this.page,
    this.lastPage,
    this.data,
  });

  UserReactedItemsResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Datum>? data,
  }) =>
      UserReactedItemsResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        data: data ?? this.data,
      );

  factory UserReactedItemsResponse.fromJson(String str) =>
      UserReactedItemsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserReactedItemsResponse.fromMap(Map<String, dynamic> json) =>
      UserReactedItemsResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        data: json['data'] == null
            ? []
            : List<Datum>.from(json['data']!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  final DateTime? createdAt;
  final String? userUid;
  final String? videoPostUid;
  final String? flickPostUid;
  final String? memoryUid;
  final String? offerPostUid;
  final String? photoPostUid;
  final String? pdfUid;
  final String? uid;
  final String? reactionType;

  Datum({
    this.createdAt,
    this.userUid,
    this.videoPostUid,
    this.flickPostUid,
    this.memoryUid,
    this.offerPostUid,
    this.photoPostUid,
    this.pdfUid,
    this.uid,
    this.reactionType,
  });

  Datum copyWith({
    DateTime? createdAt,
    String? userUid,
    String? videoPostUid,
    dynamic flickPostUid,
    dynamic memoryUid,
    dynamic offerPostUid,
    dynamic photoPostUid,
    dynamic pdfUid,
    String? uid,
    String? reactionType,
  }) =>
      Datum(
        createdAt: createdAt ?? this.createdAt,
        userUid: userUid ?? this.userUid,
        videoPostUid: videoPostUid ?? this.videoPostUid,
        flickPostUid: flickPostUid ?? this.flickPostUid,
        memoryUid: memoryUid ?? this.memoryUid,
        offerPostUid: offerPostUid ?? this.offerPostUid,
        photoPostUid: photoPostUid ?? this.photoPostUid,
        pdfUid: pdfUid ?? this.pdfUid,
        uid: uid ?? this.uid,
        reactionType: reactionType ?? this.reactionType,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        userUid: json['user_uid'],
        videoPostUid: json['video_post_uid'],
        flickPostUid: json['flick_post_uid'],
        memoryUid: json['memory_uid'],
        offerPostUid: json['offer_post_uid'],
        photoPostUid: json['photo_post_uid'],
        pdfUid: json['pdf_uid'],
        uid: json['uid'],
        reactionType: json['reaction_type'],
      );

  Map<String, dynamic> toMap() => {
        'created_at': createdAt?.toIso8601String(),
        'user_uid': userUid,
        'video_post_uid': videoPostUid,
        'flick_post_uid': flickPostUid,
        'memory_uid': memoryUid,
        'offer_post_uid': offerPostUid,
        'photo_post_uid': photoPostUid,
        'pdf_uid': pdfUid,
        'uid': uid,
        'reaction_type': reactionType,
      };
}
