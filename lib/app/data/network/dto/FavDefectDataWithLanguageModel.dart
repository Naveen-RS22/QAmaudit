import 'dart:convert';

class FavDefectDataWithLanguageModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  FavDefectDataWithLanguageModel({this.isSuccess, this.message, this.data});

  FavDefectDataWithLanguageModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? defectLevel;
  String? defectCategory;
  String? defectCode;
  String? defectName;
  String? displayName;
  String? indexNo;
  String? isFav;
  String? translation;
  String? hostName;
  String? defectProfile;
  String? shtKey;
  String? garmentType;
  String? active;
  String? createdDt;
  String? createdBy;
  String? modifyDt;
  String? modifyBy;

  Data(
      {this.id,
      this.defectLevel,
      this.defectCategory,
      this.defectCode,
      this.defectName,
      this.displayName,
      this.indexNo,
      this.isFav,
      this.translation,
      this.hostName,
      this.defectProfile,
      this.shtKey,
      this.garmentType,
      this.active,
      this.createdDt,
      this.createdBy,
      this.modifyDt,
      this.modifyBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    defectLevel = json['defectLevel'];
    defectCategory = json['defectCategory'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    displayName = json['displayName'];
    indexNo = json['indexNo'];
    isFav = json['isFav'];
    translation = json['translation'];
    hostName = json['hostName'];
    defectProfile = json['defectProfile'];
    shtKey = json['shtKey'];
    garmentType = json['garmentType'];
    active = json['active'];
    createdDt = json['createdDt'];
    createdBy = json['createdBy'];
    modifyDt = json['modifyDt'];
    modifyBy = json['modifyBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['defectLevel'] = this.defectLevel;
    data['defectCategory'] = this.defectCategory;
    data['defectCode'] = this.defectCode;
    data['defectName'] = this.defectName;
    data['displayName'] = this.displayName;
    data['indexNo'] = this.indexNo;
    data['isFav'] = this.isFav;
    data['translation'] = this.translation;
    data['hostName'] = this.hostName;
    data['defectProfile'] = this.defectProfile;
    data['shtKey'] = this.shtKey;
    data['garmentType'] = this.garmentType;
    data['active'] = this.active;
    data['createdDt'] = this.createdDt;
    data['createdBy'] = this.createdBy;
    data['modifyDt'] = this.modifyDt;
    data['modifyBy'] = this.modifyBy;
    return data;
  }
}
