import 'dart:convert';

class GetLanguageAssignmentByUsercodeModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetLanguageAssignmentByUsercodeModel(
      {this.isSuccess, this.message, this.data});

  GetLanguageAssignmentByUsercodeModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      jsonDecode(json['data']).forEach((v) {
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
  List<LanguageAssigned>? languageAssigned;
  List<LanguageList>? languageList;

  Data({this.languageAssigned, this.languageList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['languageAssigned'] != null) {
      languageAssigned = <LanguageAssigned>[];
      json['languageAssigned'].forEach((v) {
        languageAssigned!.add(new LanguageAssigned.fromJson(v));
      });
    }
    if (json['languageList'] != null) {
      languageList = <LanguageList>[];
      json['languageList'].forEach((v) {
        languageList!.add(new LanguageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.languageAssigned != null) {
      data['languageAssigned'] =
          this.languageAssigned!.map((v) => v.toJson()).toList();
    }
    if (this.languageList != null) {
      data['languageList'] = this.languageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageAssigned {
  String? language;
  String? usercode;
  String? username;

  LanguageAssigned({this.language, this.usercode, this.username});

  LanguageAssigned.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    usercode = json['usercode'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['usercode'] = this.usercode;
    data['username'] = this.username;
    return data;
  }
}

class LanguageList {
  int? id;
  String? languageCode;
  String? languageName;
  String? translationName;
  String? createdBy;
  String? createdDt;
  String? modifyBy;
  String? modifyDt;
  String? hostName;

  LanguageList(
      {this.id,
      this.languageCode,
      this.languageName,
      this.translationName,
      this.createdBy,
      this.createdDt,
      this.modifyBy,
      this.modifyDt,
      this.hostName});

  LanguageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageCode = json['languageCode'];
    languageName = json['languageName'];
    translationName = json['translationName'];
    createdBy = json['createdBy'];
    createdDt = json['createdDt'];
    modifyBy = json['modifyBy'];
    modifyDt = json['modifyDt'];
    hostName = json['hostName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['languageCode'] = this.languageCode;
    data['languageName'] = this.languageName;
    data['translationName'] = this.translationName;
    data['createdBy'] = this.createdBy;
    data['createdDt'] = this.createdDt;
    data['modifyBy'] = this.modifyBy;
    data['modifyDt'] = this.modifyDt;
    data['hostName'] = this.hostName;
    return data;
  }
}
