import 'dart:convert';

class MultipleUserDetailsResponse {
  final String? message;
  final List<User>? users;

  MultipleUserDetailsResponse({
    this.message,
    this.users,
  });

  factory MultipleUserDetailsResponse.fromJson(String str) =>
      MultipleUserDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MultipleUserDetailsResponse.fromMap(Map<String, dynamic> json) =>
      MultipleUserDetailsResponse(
        message: json['message'],
        users: json['users'] == null
            ? <User>[]
            : List<User>.from(json['users']!.map((x) => User.fromMap(x))),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'message': message,
        'users': users == null
            ? <dynamic>[]
            : List<dynamic>.from(users!.map((User x) => x.toMap())),
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
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        registeredOn: json['registered_on'] == null
            ? null
            : DateTime.parse(json['registered_on']),
        isActive: json['is_active'],
        uid: json['uid'],
        userName: json['user_name'],
        mobileNumber: json['mobile_number'],
        emailId: json['email_id'],
        name: json['name'],
        bio: json['bio'],
        address: json['address'],
        dob: json['dob'] == null ? null : DateTime.parse(json['dob']),
        profilePicture: json['profile_picture'],
        isPortfolio: json['is_portfolio'],
        portfolioStatus: json['portfolio_status'],
        portfolioDescription: json['portfolio_description'],
        isBanned: json['is_banned'],
        isSpam: json['is_spam'],
        isDiactivated: json['is_diactivated'],
        portfolioCreatedAt: json['portfolio_created_at'] == null
            ? null
            : DateTime.parse(json['portfolio_created_at']),
        portfolioTitle: json['portfolio_title'],
        totalFollowers: json['total_followers'],
        totalFollowings: json['total_followings'],
        totalPostLikes: json['total_post_likes'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'registered_on': registeredOn?.toIso8601String(),
        'is_active': isActive,
        'uid': uid,
        'user_name': userName,
        'mobile_number': mobileNumber,
        'email_id': emailId,
        'name': name,
        'bio': bio,
        'address': address,
        'dob':
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        'profile_picture': profilePicture,
        'is_portfolio': isPortfolio,
        'portfolio_status': portfolioStatus,
        'portfolio_description': portfolioDescription,
        'is_banned': isBanned,
        'is_spam': isSpam,
        'is_diactivated': isDiactivated,
        'portfolio_created_at': portfolioCreatedAt?.toIso8601String(),
        'portfolio_title': portfolioTitle,
        'total_followers': totalFollowers,
        'total_followings': totalFollowings,
        'total_post_likes': totalPostLikes,
      };
}
