import 'dart:convert';

class GetFreqUsedDefectsByParamsModel {
  bool? isSuccess;
  String? message;
  List<GetFreqUsedDefectsByParamsData>? data;

  GetFreqUsedDefectsByParamsModel({this.isSuccess, this.message, this.data});

  GetFreqUsedDefectsByParamsModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetFreqUsedDefectsByParamsData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetFreqUsedDefectsByParamsData.fromJson(v));
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

class GetFreqUsedDefectsByParamsData {
  int? id;
  String? unitCode;
  String? auditType;
  String? userName;
  String? defectCode;
  String? defectLevel;
  String? defectCategory;
  String? defectName;
  String? translation;
  String? filePath;

  GetFreqUsedDefectsByParamsData(
      {this.id,
      this.unitCode,
      this.auditType,
      this.userName,
      this.defectCode,
      this.defectLevel,
      this.defectCategory,
      this.defectName,
      this.translation,
      this.filePath});

  GetFreqUsedDefectsByParamsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    userName = json['userName'];
    defectCode = json['defectCode'];
    defectLevel = json['defectLevel'];
    defectCategory = json['defectCategory'];

    defectName = json['defectName'];
    translation = json['translation'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unitCode'] = unitCode;
    data['auditType'] = auditType;
    data['userName'] = userName;
    data['defectCode'] = defectCode;
    data['defectLevel'] = defectLevel;
    data['defectCategory'] = defectCategory;
    data['defectName'] = defectName;
    data['translation'] = translation;
    data['filePath'] = filePath;

    return data;
  }
}
