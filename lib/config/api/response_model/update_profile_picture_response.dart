import 'dart:convert';

class ProfilePictureUpdateResponse {
  final String? message;
  final User? user;
  final List<ProfilePicture>? profilePictures;

  ProfilePictureUpdateResponse({
    this.message,
    this.user,
    this.profilePictures,
  });

  factory ProfilePictureUpdateResponse.fromJson(String str) =>
      ProfilePictureUpdateResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfilePictureUpdateResponse.fromMap(Map<String, dynamic> json) =>
      ProfilePictureUpdateResponse(
        message: json["message"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        profilePictures: json["profile_pictures"] == null
            ? []
            : List<ProfilePicture>.from(json["profile_pictures"]!
                .map((x) => ProfilePicture.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "user": user?.toMap(),
        "profile_pictures": profilePictures == null
            ? []
            : List<dynamic>.from(profilePictures!.map((x) => x.toMap())),
      };
}

class ProfilePicture {
  final int? id;
  final DateTime? createdAt;
  final String? url;
  final String? userUid;

  ProfilePicture({
    this.id,
    this.createdAt,
    this.url,
    this.userUid,
  });

  factory ProfilePicture.fromJson(String str) =>
      ProfilePicture.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfilePicture.fromMap(Map<String, dynamic> json) => ProfilePicture(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        url: json["url"],
        userUid: json["user_uid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "url": url,
        "user_uid": userUid,
      };
}

class User {
  final int? id;
  final DateTime? registeredOn;
  final bool? isActive;
  final String? uid;
  final String? userName;
  final String? mobileNumber;
  final String? emailId;
  final String? name;
  final String? bio;
  final String? address;
  final DateTime? dob;
  final String? profilePicture;
  final bool? isPortfolio;
  final String? portfolioStatus;
  final String? portfolioDescription;
  final bool? isBanned;
  final bool? isSpam;
  final bool? isDiactivated;
  final DateTime? portfolioCreatedAt;
  final String? portfolioTitle;
  final int? totalFollowers;
  final int? totalFollowings;
  final int? totalPostLikes;
  final dynamic gender;

  User({
    this.id,
    this.registeredOn,
    this.isActive,
    this.uid,
    this.userName,
    this.mobileNumber,
    this.emailId,
    this.name,
    this.bio,
    this.address,
    this.dob,
    this.profilePicture,
    this.isPortfolio,
    this.portfolioStatus,
    this.portfolioDescription,
    this.isBanned,
    this.isSpam,
    this.isDiactivated,
    this.portfolioCreatedAt,
    this.portfolioTitle,
    this.totalFollowers,
    this.totalFollowings,
    this.totalPostLikes,
    this.gender,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        registeredOn: json["registered_on"] == null
            ? null
            : DateTime.parse(json["registered_on"]),
        isActive: json["is_active"],
        uid: json["uid"],
        userName: json["user_name"],
        mobileNumber: json["mobile_number"],
        emailId: json["email_id"],
        name: json["name"],
        bio: json["bio"],
        address: json["address"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        profilePicture: json["profile_picture"],
        isPortfolio: json["is_portfolio"],
        portfolioStatus: json["portfolio_status"],
        portfolioDescription: json["portfolio_description"],
        isBanned: json["is_banned"],
        isSpam: json["is_spam"],
        isDiactivated: json["is_diactivated"],
        portfolioCreatedAt: json["portfolio_created_at"] == null
            ? null
            : DateTime.parse(json["portfolio_created_at"]),
        portfolioTitle: json["portfolio_title"],
        totalFollowers: json["total_followers"],
        totalFollowings: json["total_followings"],
        totalPostLikes: json["total_post_likes"],
        gender: json["gender"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "registered_on": registeredOn?.toIso8601String(),
        "is_active": isActive,
        "uid": uid,
        "user_name": userName,
        "mobile_number": mobileNumber,
        "email_id": emailId,
        "name": name,
        "bio": bio,
        "address": address,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "profile_picture": profilePicture,
        "is_portfolio": isPortfolio,
        "portfolio_status": portfolioStatus,
        "portfolio_description": portfolioDescription,
        "is_banned": isBanned,
        "is_spam": isSpam,
        "is_diactivated": isDiactivated,
        "portfolio_created_at": portfolioCreatedAt?.toIso8601String(),
        "portfolio_title": portfolioTitle,
        "total_followers": totalFollowers,
        "total_followings": totalFollowings,
        "total_post_likes": totalPostLikes,
        "gender": gender,
      };
}
