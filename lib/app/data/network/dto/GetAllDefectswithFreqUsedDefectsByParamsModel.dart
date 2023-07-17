import 'dart:convert';

class GetAllDefectswithFreqUsedDefectsByParamsModel {
  bool? isSuccess;
  String? message;
  List<GetAllDefectswithLang>? data;

  GetAllDefectswithFreqUsedDefectsByParamsModel(
      {this.isSuccess, this.message, this.data});

  GetAllDefectswithFreqUsedDefectsByParamsModel.fromJson(
      Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllDefectswithLang>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetAllDefectswithLang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllDefectswithLang {
  int? id;
  int? defectMastId;
  String? defectCode;
  String? defectName;
  String? defectCategory;
  String? defectLevel;
  String? isFav;
  String? translation;
  String? languageCode;
  String? filePath;

  GetAllDefectswithLang(
      {this.id,
      this.defectMastId,
      this.defectCode,
      this.defectName,
      this.defectCategory,
      this.defectLevel,
      this.isFav,
      this.translation,
      this.languageCode,
      this.filePath});

  GetAllDefectswithLang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    defectMastId = json['defectMast_Id'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    defectCategory = json['defectCategory'];
    defectLevel = json['defectLevel'];
    isFav = json['isFav'];
    translation = json['translation'];
    languageCode = json['languageCode'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['defectMast_Id'] = defectMastId;
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['defectCategory'] = defectCategory;
    data['defectLevel'] = defectLevel;
    data['isFav'] = isFav;
    data['translation'] = translation;
    data['languageCode'] = languageCode;
    data['filePath'] = filePath;
    return data;
  }
}
