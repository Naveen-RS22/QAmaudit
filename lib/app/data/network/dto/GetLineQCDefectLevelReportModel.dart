import 'dart:convert';

class GetLineQCDefectLevelReportModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetLineQCDefectLevelReportModel({this.isSuccess, this.message, this.data});

  GetLineQCDefectLevelReportModel.fromJson(Map<String, dynamic> json) {
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
  List<LineQCDefectLevel>? lineQCDefectLevel;

  Data({this.lineQCDefectLevel});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['lineQCDefectLevel'] != null) {
      lineQCDefectLevel = <LineQCDefectLevel>[];
      json['lineQCDefectLevel'].forEach((v) {
        lineQCDefectLevel!.add(new LineQCDefectLevel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lineQCDefectLevel != null) {
      data['lineQCDefectLevel'] =
          this.lineQCDefectLevel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineQCDefectLevel {
  String? unitCode;
  String? auditType;
  String? auditDate;
  String? checkerName;
  String? sessionCode;
  int? inspectedPcs;
  int? passedPcs;
  int? defectPcs;
  int? critical;
  int? major;
  int? minor;

  LineQCDefectLevel(
      {this.unitCode,
      this.auditType,
      this.auditDate,
      this.checkerName,
      this.sessionCode,
      this.inspectedPcs,
      this.passedPcs,
      this.defectPcs,
      this.critical,
      this.major,
      this.minor});

  LineQCDefectLevel.fromJson(Map<String, dynamic> json) {
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    auditDate = json['auditDate'];
    checkerName = json['checkerName'];
    sessionCode = json['sessionCode'];
    inspectedPcs = json['inspectedPcs'];
    passedPcs = json['passedPcs'];
    defectPcs = json['defectPcs'];
    critical = json['critical'];
    major = json['major'];
    minor = json['minor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitCode'] = this.unitCode;
    data['auditType'] = this.auditType;
    data['auditDate'] = this.auditDate;
    data['checkerName'] = this.checkerName;
    data['sessionCode'] = this.sessionCode;
    data['inspectedPcs'] = this.inspectedPcs;
    data['passedPcs'] = this.passedPcs;
    data['defectPcs'] = this.defectPcs;
    data['critical'] = this.critical;
    data['major'] = this.major;
    data['minor'] = this.minor;
    return data;
  }
}
