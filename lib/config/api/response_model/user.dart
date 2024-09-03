import 'dart:convert';

class AuthorisedUserResponse {
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
  final String? dob;
  final String? profilePicture;
  final bool? isPortfolio;
  final String? portfolioStatus;
  final List<String>? portfolioServices;
  final String? portfolioDescription;
  final bool? isBanned;
  final bool? isSpam;
  final bool? isDiactivated;
  final DateTime? portfolioCreatedAt;

  AuthorisedUserResponse({
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
    this.portfolioServices,
    this.portfolioDescription,
    this.isBanned,
    this.isSpam,
    this.isDiactivated,
    this.portfolioCreatedAt,
  });

  factory AuthorisedUserResponse.fromJson(String str) =>
      AuthorisedUserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthorisedUserResponse.fromMap(Map<String, dynamic> json) =>
      AuthorisedUserResponse(
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
        dob: json["dob"],
        profilePicture: json["profile_picture"],
        isPortfolio: json["is_portfolio"],
        portfolioStatus: json["portfolio_status"],
        portfolioServices: json["portfolio_services"] == null
            ? []
            : List<String>.from(json["portfolio_services"]!.map((x) => x)),
        portfolioDescription: json["portfolio_description"],
        isBanned: json["is_banned"],
        isSpam: json["is_spam"],
        isDiactivated: json["is_diactivated"],
        portfolioCreatedAt: json["portfolio_created_at"] == null
            ? null
            : DateTime.parse(json["portfolio_created_at"]),
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
        "dob": dob,
        "profile_picture": profilePicture,
        "is_portfolio": isPortfolio,
        "portfolio_status": portfolioStatus,
        "portfolio_services": portfolioServices == null
            ? []
            : List<dynamic>.from(portfolioServices!.map((x) => x)),
        "portfolio_description": portfolioDescription,
        "is_banned": isBanned,
        "is_spam": isSpam,
        "is_diactivated": isDiactivated,
        "portfolio_created_at": portfolioCreatedAt?.toIso8601String(),
      };
}
