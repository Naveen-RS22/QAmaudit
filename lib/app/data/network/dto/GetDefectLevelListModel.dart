import 'dart:convert';

class GetDefectLevelListModel {
  bool? isSuccess;
  String? message;
  List<DefectLevelData>? data;

  GetDefectLevelListModel({this.isSuccess, this.message, this.data});

  GetDefectLevelListModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DefectLevelData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(new DefectLevelData.fromJson(v));
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

class DefectLevelData {
  String? unitCode;
  String? auditDate;
  String? audittype;
  String? checkerName;
  String? defectLevel;
  int? inspec;
  int? defpcs;
  String? sessioncode;
  double? dhu;

  DefectLevelData(
      {this.unitCode,
      this.auditDate,
      this.audittype,
      this.checkerName,
      this.defectLevel,
      this.inspec,
      this.defpcs,
      this.sessioncode,
      this.dhu});

  DefectLevelData.fromJson(Map<String, dynamic> json) {
    unitCode = json['unitCode'];
    auditDate = json['auditDate'];
    audittype = json['audittype'];
    checkerName = json['checkerName'];
    defectLevel = json['defectLevel'];
    inspec = json['inspec'];
    defpcs = json['defpcs'];
    sessioncode = json['sessioncode'];
    dhu = json['dhu'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitCode'] = this.unitCode;
    data['auditDate'] = this.auditDate;
    data['audittype'] = this.audittype;
    data['checkerName'] = this.checkerName;
    data['defectLevel'] = this.defectLevel;
    data['inspec'] = this.inspec;
    data['defpcs'] = this.defpcs;
    data['sessioncode'] = this.sessioncode;
    data['dhu'] = this.dhu;
    return data;
  }
}
