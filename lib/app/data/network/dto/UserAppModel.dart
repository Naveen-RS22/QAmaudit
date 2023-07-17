import 'dart:convert';

class UserAppModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  UserAppModel({this.isSuccess, this.message, this.data});

  UserAppModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      // jsonDecode(json['data']).forEach((v) {
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? serviceCode;
  String? serviceName;
  String? serviceType;
  String? iconFileName;
  String? iconFileContent;
  String? description;
  bool? isPublish;
  String? expiryDate;
  bool? isAccess;
  bool? isActive;
  String? roleCode;
  String? roleName;
  String? hostURL;
  String? hostUIURL;
  String? serviceKey;

  Data(
      {this.serviceCode,
      this.serviceName,
      this.serviceType,
      this.iconFileName,
      this.iconFileContent,
      this.description,
      this.isPublish,
      this.expiryDate,
      this.isAccess,
      this.isActive,
      this.roleCode,
      this.roleName,
      this.hostURL,
      this.hostUIURL,
      this.serviceKey});

  Data.fromJson(Map<String, dynamic> json) {
    serviceCode = json['serviceCode'];
    serviceName = json['serviceName'];
    serviceType = json['serviceType'];
    iconFileName = json['iconFileName'];
    iconFileContent = json['iconFileContent'];
    description = json['description'];
    isPublish = json['isPublish'];
    expiryDate = json['expiryDate'];
    isAccess = json['isAccess'];
    isActive = json['isActive'];
    roleCode = json['roleCode'];
    roleName = json['roleName'];
    hostURL = json['hostURL'];
    hostUIURL = json['hostUIURL'];
    serviceKey = json['serviceKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceCode'] = this.serviceCode;
    data['serviceName'] = this.serviceName;
    data['serviceType'] = this.serviceType;
    data['iconFileName'] = this.iconFileName;
    data['iconFileContent'] = this.iconFileContent;
    data['description'] = this.description;
    data['isPublish'] = this.isPublish;
    data['expiryDate'] = this.expiryDate;
    data['isAccess'] = this.isAccess;
    data['isActive'] = this.isActive;
    data['roleCode'] = this.roleCode;
    data['roleName'] = this.roleName;
    data['hostURL'] = this.hostURL;
    data['hostUIURL'] = this.hostUIURL;
    data['serviceKey'] = this.serviceKey;
    return data;
  }
}
