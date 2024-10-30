import 'dart:convert';

class OtpLessSuccessResponse {
  final Data? data;

  OtpLessSuccessResponse({
    this.data,
  });

  factory OtpLessSuccessResponse.fromJson(String str) =>
      OtpLessSuccessResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtpLessSuccessResponse.fromMap(Map<String, dynamic> json) =>
      OtpLessSuccessResponse(
        data: json['data'] == null ? null : Data.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'data': data?.toMap(),
      };
}

class Data {
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

  Data({
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

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        firebaseInfo: json['firebaseInfo'] == null
            ? null
            : Info.fromMap(json['firebaseInfo']),
        token: json['token'],
        status: json['status'],
        userId: json['userId'],
        timestamp: json['timestamp'] == null
            ? null
            : DateTime.parse(json['timestamp']),
        identities: json['identities'] == null
            ? <Identity>[]
            : List<Identity>.from(
                json['identities']!.map((x) => Identity.fromMap(x)),
              ),
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

  Map<String, dynamic> toMap() => <String, dynamic>{
        'firebaseInfo': firebaseInfo?.toMap(),
        'token': token,
        'status': status,
        'userId': userId,
        'timestamp': timestamp?.toIso8601String(),
        'identities': identities == null
            ? <dynamic>[]
            : List<dynamic>.from(identities!.map((Identity x) => x.toMap())),
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

  Map<String, dynamic> toMap() => <String, dynamic>{
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

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap() => Info();

  Map<String, dynamic> toMap() => <String, dynamic>{};
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

  factory Identity.fromJson(String str) => Identity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Identity.fromMap(Map<String, dynamic> json) => Identity(
        identityType: json['identityType'],
        identityValue: json['identityValue'],
        channel: json['channel'],
        methods: json['methods'] == null
            ? <String>[]
            : List<String>.from(json['methods']!.map((x) => x)),
        verified: json['verified'],
        verifiedAt: json['verifiedAt'] == null
            ? null
            : DateTime.parse(json['verifiedAt']),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'identityType': identityType,
        'identityValue': identityValue,
        'channel': channel,
        'methods': methods == null
            ? <dynamic>[]
            : List<dynamic>.from(methods!.map((String x) => x)),
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

  factory Network.fromJson(String str) => Network.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        ip: json['ip'],
        timezone: json['timezone'],
        ipLocation: json['ipLocation'] == null
            ? null
            : IpLocation.fromMap(json['ipLocation']),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
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

  Map<String, dynamic> toMap() => <String, dynamic>{
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

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
        name: json['name'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
      };
}

class Continent {
  final String? code;

  Continent({
    this.code,
  });

  factory Continent.fromJson(String str) => Continent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Continent.fromMap(Map<String, dynamic> json) => Continent(
        code: json['code'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
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

  factory Country.fromJson(String str) => Country.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        code: json['code'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'code': code,
        'name': name,
      };
}
