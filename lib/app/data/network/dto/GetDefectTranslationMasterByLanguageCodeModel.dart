import 'dart:convert';

class GetDefectTranslationMasterByLanguageCodeModel {
  bool? isSuccess;
  String? message;
  List<AllDefectss>? data;

  GetDefectTranslationMasterByLanguageCodeModel(
      {this.isSuccess, this.message, this.data});

  GetDefectTranslationMasterByLanguageCodeModel.fromJson(
      Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllDefectss>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(new AllDefectss.fromJson(v));
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

class AllDefectss {
  int? id;
  int? defectMastId;
  String? defectCode;
  String? defectName;
  String? isFav;
  String? defectLevel;
  String? defectCategory;
  String? translation;
  String? languageCode;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  AllDefectss(
      {this.id,
      this.defectMastId,
      this.defectCode,
      this.defectName,
      this.isFav,
      this.defectLevel,
      this.defectCategory,
      this.translation,
      this.languageCode,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  AllDefectss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    defectMastId = json['defectMast_Id'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    isFav = json['isFav'];
    defectLevel = json['defectLevel'];
    defectCategory = json['defectCategory'];
    translation = json['translation'];
    languageCode = json['languageCode'];
    hostName = json['hostName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['defectMast_Id'] = this.defectMastId;
    data['defectCode'] = this.defectCode;
    data['defectName'] = this.defectName;
    data['isFav'] = this.isFav;
    data['defectLevel'] = this.defectLevel;
    data['defectCategory'] = this.defectCategory;
    data['translation'] = this.translation;
    data['languageCode'] = this.languageCode;
    data['hostName'] = this.hostName;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    return data;
  }
}
