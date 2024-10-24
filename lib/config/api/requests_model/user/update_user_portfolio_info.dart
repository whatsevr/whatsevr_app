import 'dart:convert';

class UpdateUserPortfolioInfoRequest {
  final String? userUid;
  final PortfolioInfo? portfolioInfo;

  UpdateUserPortfolioInfoRequest({
    this.userUid,
    this.portfolioInfo,
  });

  factory UpdateUserPortfolioInfoRequest.fromJson(String str) =>
      UpdateUserPortfolioInfoRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateUserPortfolioInfoRequest.fromMap(Map<String, dynamic> json) =>
      UpdateUserPortfolioInfoRequest(
        userUid: json['user_uid'],
        portfolioInfo: json['portfolio_info'] == null
            ? null
            : PortfolioInfo.fromMap(json['portfolio_info']),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'user_uid': userUid,
        'portfolio_info': portfolioInfo?.toMap(),
      };
}

class PortfolioInfo {
  final String? portfolioStatus;
  final String? portfolioDescription;
  final String? portfolioTitle;

  PortfolioInfo({
    this.portfolioStatus,
    this.portfolioDescription,
    this.portfolioTitle,
  });

  factory PortfolioInfo.fromJson(String str) =>
      PortfolioInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PortfolioInfo.fromMap(Map<String, dynamic> json) => PortfolioInfo(
        portfolioStatus: json['portfolio_status'],
        portfolioDescription: json['portfolio_description'],
        portfolioTitle: json['portfolio_title'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'portfolio_status': portfolioStatus,
        'portfolio_description': portfolioDescription,
        'portfolio_title': portfolioTitle,
      };
}
