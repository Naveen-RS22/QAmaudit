class LoginModel {
  bool? isSuccess;
  String? message;
  Data? data;

  LoginModel({this.isSuccess, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  AuthUser? authUser;
  String? appUrl;

  Data({this.authUser, this.appUrl});

  Data.fromJson(Map<String, dynamic> json) {
    authUser =
        json['authUser'] != null ? AuthUser.fromJson(json['authUser']) : null;
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (authUser != null) {
      data['authUser'] = authUser!.toJson();
    }
    data['appUrl'] = appUrl;
    return data;
  }
}

class AuthUser {
  String? userName;
  String? userCode;
  String? displayName;
  String? accessToken;
  String? refreshToken;
  String? entityCode;
  bool? isFirstLogin;
  bool? isEnable2FA;
  String? portalAccessToken;
  String? userIdentityKey;
  String? entityLocationCode;
  bool? isRequiredEnable2FA;
  List<String>? locationCodes;
  List<String>? unitCodes;

  AuthUser(
      {this.userName,
      this.userCode,
      this.displayName,
      this.accessToken,
      this.refreshToken,
      this.entityCode,
      this.isFirstLogin,
      this.isEnable2FA,
      this.portalAccessToken,
      this.userIdentityKey,
      this.entityLocationCode,
      this.isRequiredEnable2FA,
      this.locationCodes,
      this.unitCodes});

  AuthUser.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userCode = json['userCode'];
    displayName = json['displayName'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    entityCode = json['entityCode'];
    isFirstLogin = json['isFirstLogin'];
    isEnable2FA = json['isEnable2FA'];
    portalAccessToken = json['portalAccessToken'];
    userIdentityKey = json['userIdentityKey'];
    entityLocationCode = json['entityLocationCode'];
    isRequiredEnable2FA = json['isRequiredEnable2FA'];
    locationCodes = json['locationCodes'].cast<String>();
    unitCodes = json['unitCodes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['userCode'] = userCode;
    data['displayName'] = displayName;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['entityCode'] = entityCode;
    data['isFirstLogin'] = isFirstLogin;
    data['isEnable2FA'] = isEnable2FA;
    data['portalAccessToken'] = portalAccessToken;
    data['userIdentityKey'] = userIdentityKey;
    data['entityLocationCode'] = entityLocationCode;
    data['isRequiredEnable2FA'] = isRequiredEnable2FA;
    data['locationCodes'] = locationCodes;
    data['unitCodes'] = unitCodes;
    return data;
  }
}
