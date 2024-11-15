import 'dart:convert';

class OtpLessSuccessResponse {
  final Info? firebaseInfo;
  final String? token;
  final String? status;
  final String? userId;
  final DateTime? timestamp;
  final List<Identity>? identities;
  final String? idToken;
  final Network? network;
  final DeviceInfo? deviceInfo;
  final Info? sessionInfo;

  OtpLessSuccessResponse({
    this.firebaseInfo,
    this.token,
    this.status,
    this.userId,
    this.timestamp,
    this.identities,
    this.idToken,
    this.network,
    this.deviceInfo,
    this.sessionInfo,
  });

  OtpLessSuccessResponse copyWith({
    Info? firebaseInfo,
    String? token,
    String? status,
    String? userId,
    DateTime? timestamp,
    List<Identity>? identities,
    String? idToken,
    Network? network,
    DeviceInfo? deviceInfo,
    Info? sessionInfo,
  }) =>
      OtpLessSuccessResponse(
        firebaseInfo: firebaseInfo ?? this.firebaseInfo,
        token: token ?? this.token,
        status: status ?? this.status,
        userId: userId ?? this.userId,
        timestamp: timestamp ?? this.timestamp,
        identities: identities ?? this.identities,
        idToken: idToken ?? this.idToken,
        network: network ?? this.network,
        deviceInfo: deviceInfo ?? this.deviceInfo,
        sessionInfo: sessionInfo ?? this.sessionInfo,
      );

  factory OtpLessSuccessResponse.fromJson(String str) =>
      OtpLessSuccessResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtpLessSuccessResponse.fromMap(Map<String, dynamic> json) =>
      OtpLessSuccessResponse(
        firebaseInfo: json['firebaseInfo'] == null
            ? null
            : Info.fromMap(json["firebaseInfo"]),
        token: json['token'],
        status: json['status'],
        userId: json['userId'],
        timestamp: json['timestamp'] == null
            ? null
            : DateTime.parse(json['timestamp']),
        identities: json['identities'] == null
            ? []
            : List<Identity>.from(
                json['identities']!.map((x) => Identity.fromMap(x)),),
        idToken: json['idToken'],
        network:
            json['network'] == null ? null : Network.fromMap(json['network']),
        deviceInfo: json['deviceInfo'] == null
            ? null
            : DeviceInfo.fromMap(json['deviceInfo']),
        sessionInfo: json['sessionInfo'] == null
            ? null
            : Info.fromMap(json['sessionInfo']),
      );

  Map<String, dynamic> toMap() => {
        'firebaseInfo': firebaseInfo?.toMap(),
        'token': token,
        'status': status,
        'userId': userId,
        'timestamp': timestamp?.toIso8601String(),
        'identities': identities == null
            ? []
            : List<dynamic>.from(identities!.map((x) => x.toMap())),
        'idToken': idToken,
        'network': network?.toMap(),
        'deviceInfo': deviceInfo?.toMap(),
        'sessionInfo': sessionInfo?.toMap(),
      };
}

class DeviceInfo {
  final String? userAgent;
  final String? platform;
  final String? vendor;
  final String? browser;
  final String? connection;
  final String? language;
  final bool? cookieEnabled;
  final int? screenWidth;
  final int? screenHeight;
  final int? screenColorDepth;
  final double? devicePixelRatio;
  final int? timezoneOffset;
  final String? cpuArchitecture;
  final String? fontFamily;

  DeviceInfo({
    this.userAgent,
    this.platform,
    this.vendor,
    this.browser,
    this.connection,
    this.language,
    this.cookieEnabled,
    this.screenWidth,
    this.screenHeight,
    this.screenColorDepth,
    this.devicePixelRatio,
    this.timezoneOffset,
    this.cpuArchitecture,
    this.fontFamily,
  });

  DeviceInfo copyWith({
    String? userAgent,
    String? platform,
    String? vendor,
    String? browser,
    String? connection,
    String? language,
    bool? cookieEnabled,
    int? screenWidth,
    int? screenHeight,
    int? screenColorDepth,
    double? devicePixelRatio,
    int? timezoneOffset,
    String? cpuArchitecture,
    String? fontFamily,
  }) =>
      DeviceInfo(
        userAgent: userAgent ?? this.userAgent,
        platform: platform ?? this.platform,
        vendor: vendor ?? this.vendor,
        browser: browser ?? this.browser,
        connection: connection ?? this.connection,
        language: language ?? this.language,
        cookieEnabled: cookieEnabled ?? this.cookieEnabled,
        screenWidth: screenWidth ?? this.screenWidth,
        screenHeight: screenHeight ?? this.screenHeight,
        screenColorDepth: screenColorDepth ?? this.screenColorDepth,
        devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
        timezoneOffset: timezoneOffset ?? this.timezoneOffset,
        cpuArchitecture: cpuArchitecture ?? this.cpuArchitecture,
        fontFamily: fontFamily ?? this.fontFamily,
      );

  factory DeviceInfo.fromJson(String str) =>
      DeviceInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeviceInfo.fromMap(Map<String, dynamic> json) => DeviceInfo(
        userAgent: json['userAgent'],
        platform: json['platform'],
        vendor: json['vendor'],
        browser: json['browser'],
        connection: json['connection'],
        language: json['language'],
        cookieEnabled: json['cookieEnabled'],
        screenWidth: json['screenWidth'],
        screenHeight: json['screenHeight'],
        screenColorDepth: json['screenColorDepth'],
        devicePixelRatio: json['devicePixelRatio']?.toDouble(),
        timezoneOffset: json['timezoneOffset'],
        cpuArchitecture: json['cpuArchitecture'],
        fontFamily: json['fontFamily'],
      );

  Map<String, dynamic> toMap() => {
        'userAgent': userAgent,
        'platform': platform,
        'vendor': vendor,
        'browser': browser,
        'connection': connection,
        'language': language,
        'cookieEnabled': cookieEnabled,
        'screenWidth': screenWidth,
        'screenHeight': screenHeight,
        'screenColorDepth': screenColorDepth,
        'devicePixelRatio': devicePixelRatio,
        'timezoneOffset': timezoneOffset,
        'cpuArchitecture': cpuArchitecture,
        'fontFamily': fontFamily,
      };
}

class Info {
  Info();

  Info copyWith() => Info();

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info();

  Map<String, dynamic> toMap() => {};
}

class Identity {
  final String? identityType;
  final String? identityValue;
  final String? channel;
  final List<String>? methods;
  final bool? verified;
  final DateTime? verifiedAt;

  Identity({
    this.identityType,
    this.identityValue,
    this.channel,
    this.methods,
    this.verified,
    this.verifiedAt,
  });

  Identity copyWith({
    String? identityType,
    String? identityValue,
    String? channel,
    List<String>? methods,
    bool? verified,
    DateTime? verifiedAt,
  }) =>
      Identity(
        identityType: identityType ?? this.identityType,
        identityValue: identityValue ?? this.identityValue,
        channel: channel ?? this.channel,
        methods: methods ?? this.methods,
        verified: verified ?? this.verified,
        verifiedAt: verifiedAt ?? this.verifiedAt,
      );

  factory Identity.fromJson(String str) => Identity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Identity.fromMap(Map<String, dynamic> json) => Identity(
        identityType: json['identityType'],
        identityValue: json['identityValue'],
        channel: json['channel'],
        methods: json['methods'] == null
            ? []
            : List<String>.from(json['methods']!.map((x) => x)),
        verified: json['verified'],
        verifiedAt: json['verifiedAt'] == null
            ? null
            : DateTime.parse(json['verifiedAt']),
      );

  Map<String, dynamic> toMap() => {
        'identityType': identityType,
        'identityValue': identityValue,
        'channel': channel,
        'methods':
            methods == null ? [] : List<dynamic>.from(methods!.map((x) => x)),
        'verified': verified,
        'verifiedAt': verifiedAt?.toIso8601String(),
      };
}

class Network {
  final String? ip;
  final String? timezone;
  final IpLocation? ipLocation;

  Network({
    this.ip,
    this.timezone,
    this.ipLocation,
  });

  Network copyWith({
    String? ip,
    String? timezone,
    IpLocation? ipLocation,
  }) =>
      Network(
        ip: ip ?? this.ip,
        timezone: timezone ?? this.timezone,
        ipLocation: ipLocation ?? this.ipLocation,
      );

  factory Network.fromJson(String str) => Network.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        ip: json['ip'],
        timezone: json['timezone'],
        ipLocation: json['ipLocation'] == null
            ? null
            : IpLocation.fromMap(json['ipLocation']),
      );

  Map<String, dynamic> toMap() => {
        'ip': ip,
        'timezone': timezone,
        'ipLocation': ipLocation?.toMap(),
      };
}

class IpLocation {
  final City? city;
  final Country? subdivisions;
  final Country? country;
  final Continent? continent;
  final double? latitude;
  final double? longitude;
  final String? postalCode;

  IpLocation({
    this.city,
    this.subdivisions,
    this.country,
    this.continent,
    this.latitude,
    this.longitude,
    this.postalCode,
  });

  IpLocation copyWith({
    City? city,
    Country? subdivisions,
    Country? country,
    Continent? continent,
    double? latitude,
    double? longitude,
    String? postalCode,
  }) =>
      IpLocation(
        city: city ?? this.city,
        subdivisions: subdivisions ?? this.subdivisions,
        country: country ?? this.country,
        continent: continent ?? this.continent,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        postalCode: postalCode ?? this.postalCode,
      );

  factory IpLocation.fromJson(String str) =>
      IpLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IpLocation.fromMap(Map<String, dynamic> json) => IpLocation(
        city: json['city'] == null ? null : City.fromMap(json['city']),
        subdivisions: json['subdivisions'] == null
            ? null
            : Country.fromMap(json['subdivisions']),
        country:
            json['country'] == null ? null : Country.fromMap(json['country']),
        continent: json['continent'] == null
            ? null
            : Continent.fromMap(json['continent']),
        latitude: json['latitude']?.toDouble(),
        longitude: json['longitude']?.toDouble(),
        postalCode: json['postalCode'],
      );

  Map<String, dynamic> toMap() => {
        'city': city?.toMap(),
        'subdivisions': subdivisions?.toMap(),
        'country': country?.toMap(),
        'continent': continent?.toMap(),
        'latitude': latitude,
        'longitude': longitude,
        'postalCode': postalCode,
      };
}

class City {
  final String? name;

  City({
    this.name,
  });

  City copyWith({
    String? name,
  }) =>
      City(
        name: name ?? this.name,
      );

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
      };
}

class Continent {
  final String? code;

  Continent({
    this.code,
  });

  Continent copyWith({
    String? code,
  }) =>
      Continent(
        code: code ?? this.code,
      );

  factory Continent.fromJson(String str) => Continent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Continent.fromMap(Map<String, dynamic> json) => Continent(
        code: json['code'],
      );

  Map<String, dynamic> toMap() => {
        'code': code,
      };
}

class Country {
  final String? code;
  final String? name;

  Country({
    this.code,
    this.name,
  });

  Country copyWith({
    String? code,
    String? name,
  }) =>
      Country(
        code: code ?? this.code,
        name: name ?? this.name,
      );

  factory Country.fromJson(String str) => Country.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        code: json['code'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'code': code,
        'name': name,
      };
}

// {
// "firebaseInfo": {},
// "token": "c2837e6c62ef449b9e5f33d27acd4f41",
// "status": "SUCCESS",
// "userId": "MO-ee730066d3464444991ef9610a322d01",
// "timestamp": "2024-10-30T15:26:28Z",
// "identities": [
// {
// "identityType": "MOBILE",
// "identityValue": "917002689673",
// "channel": "OTP",
// "methods": ["SMS"],
// "verified": true,
// "verifiedAt": "2024-10-30T15:26:28Z"
// }
// ],
// "idToken": "eyJraWQiOiJwazAxODMiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJNTy1lZTczMDA2NmQzNDY0NDQ0OTkxZWY5NjEwYTMyMmQwMSIsImF1ZCI6ImFjNzEwMmU4MjVlMmVhNWNmNzM3NWFmYzY5ZmQxMWVmLVlBQThFWVZST0haMDAxMjVBQUFWIiwiY291bnRyeV9jb2RlIjoiKzkxIiwiYXV0aF90aW1lIjoiMTczMDMyMTc4OCIsImlzcyI6Imh0dHBzOi8vb3RwbGVzcy5jb20iLCJuYXRpb25hbF9waG9uZV9udW1iZXIiOiI3MDAyNjg5NjczIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjp0cnVlLCJwaG9uZV9udW1iZXIiOiI5MTcwMDI2ODk2NzMiLCJleHAiOjE3MzAzMDIyODgsImlhdCI6MTczMDMwMTk4OCwidG9rZW4iOiJjMjgzN2U2YzYyZWY0NDliOWU1ZjMzZDI3YWNkNGY0MSJ9.Uw1v-SXVwPyf-7Iv5JztzW6gl-J_dwOqiccQ8ARGmqc1KqemiMPNoCsxeJSqwJ5th2DhC1b76qawIlJ8PcURPsgND0FNl12yxf-98MmrLA-4ZAo9J1mTLFZdoLq6FHrT5ZUotNsMxq_LgmzcGUcKUzDl3uANoWpDqF6x1PkLpC1g7841ckEAwhoMY5xisR9WOuxAwaFAPg7bJ8zFl_2JiSeXvTPko3WacGj-tp4SEU261g874FD0kr6H8Ovu7oqt0FsByfhRn5_b4uTyoumthfKfwD3tzpXk2BjXa81s3T_mF_3ElLJw_cYBioG-Qh5BkQ2iXJ8HG1iPZuXqvHz6WA",
// "network": {
// "ip": "49.43.154.44",
// "timezone": "Asia/Kolkata",
// "ipLocation": {
// "city": {
// "name": "Roorkee"
// },
// "subdivisions": {
// "code": "UK",
// "name": "Uttarakhand"
// },
// "country": {
// "code": "IN",
// "name": "India"
// },
// "continent": {
// "code": "AS"
// },
// "latitude": 29.794,
// "longitude": 77.8653,
// "postalCode": "247667"
// }
// },
// "deviceInfo": {
// "userAgent": "Mozilla/5.0 (Linux; Android 8.1.0; Android SDK built for x86 Build/OSM1.180201.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/61.0.3163.98 Mobile Safari/537.36 otplesssdk",
// "platform": "Linux i686",
// "vendor": "Google Inc.",
// "browser": "Chrome",
// "connection": "4g",
// "language": "en-US",
// "cookieEnabled": true,
// "screenWidth": 412,
// "screenHeight": 915,
// "screenColorDepth": 32,
// "devicePixelRatio": 2.625,
// "timezoneOffset": -330,
// "cpuArchitecture": "4-core",
// "fontFamily": "sans-serif"
// },
// "sessionInfo": {}
// }
