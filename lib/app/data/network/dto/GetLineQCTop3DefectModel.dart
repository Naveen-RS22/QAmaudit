import 'dart:convert';

class GetLineQCTop3DefectModel {
  bool? isSuccess;
  String? message;
  List<LineQCTop3Defects>? data;

  GetLineQCTop3DefectModel({this.isSuccess, this.message, this.data});

  GetLineQCTop3DefectModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LineQCTop3Defects>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(new LineQCTop3Defects.fromJson(v));
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

class LineQCTop3Defects {
  int? totalDefectPcs;
  int? totalPassedPcs;
  int? totalInspectedPcs;
  List<LineQCTop3detailReportModels>? lineQCTop3detailReportModels;

  LineQCTop3Defects(
      {this.totalDefectPcs,
      this.totalPassedPcs,
      this.totalInspectedPcs,
      this.lineQCTop3detailReportModels});

  LineQCTop3Defects.fromJson(Map<String, dynamic> json) {
    totalDefectPcs = json['totalDefectPcs'];
    totalPassedPcs = json['totalPassedPcs'];
    totalInspectedPcs = json['totalInspectedPcs'];
    if (json['lineQCTop3detailReportModels'] != null) {
      lineQCTop3detailReportModels = <LineQCTop3detailReportModels>[];
      json['lineQCTop3detailReportModels'].forEach((v) {
        lineQCTop3detailReportModels!
            .add(new LineQCTop3detailReportModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalDefectPcs'] = this.totalDefectPcs;
    data['totalPassedPcs'] = this.totalPassedPcs;
    data['totalInspectedPcs'] = this.totalInspectedPcs;
    if (this.lineQCTop3detailReportModels != null) {
      data['lineQCTop3detailReportModels'] =
          this.lineQCTop3detailReportModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineQCTop3detailReportModels {
  String? defectCode;
  String? defectName;
  int? defectCount;
  String? defectPercent;

  LineQCTop3detailReportModels(
      {this.defectCode, this.defectName, this.defectCount, this.defectPercent});

  LineQCTop3detailReportModels.fromJson(Map<String, dynamic> json) {
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    defectCount = json['defectCount'];
    defectPercent = json['defectPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defectCode'] = this.defectCode;
    data['defectName'] = this.defectName;
    data['defectCount'] = this.defectCount;
    data['defectPercent'] = this.defectPercent;
    return data;
  }
}
