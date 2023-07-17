import 'dart:convert';

class GetLineQcdefectCountModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetLineQcdefectCountModel({this.isSuccess, this.message, this.data});

  GetLineQcdefectCountModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? totalDefectPcs;
  int? totalPassedPcs;
  int? totalInspectedPcs;
  List<LineQCTop3detailReportModels>? lineQCTop3detailReportModels;

  Data(
      {this.totalDefectPcs,
      this.totalPassedPcs,
      this.totalInspectedPcs,
      this.lineQCTop3detailReportModels});

  Data.fromJson(Map<String, dynamic> json) {
    totalDefectPcs = json['totalDefectPcs'];
    totalPassedPcs = json['totalPassedPcs'];
    totalInspectedPcs = json['totalInspectedPcs'];
    if (json['lineQCTop3detailReportModels'] != null) {
      lineQCTop3detailReportModels = <LineQCTop3detailReportModels>[];
      json['lineQCTop3detailReportModels'].forEach((v) {
        lineQCTop3detailReportModels!
            .add(LineQCTop3detailReportModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalDefectPcs'] = totalDefectPcs;
    data['totalPassedPcs'] = totalPassedPcs;
    data['totalInspectedPcs'] = totalInspectedPcs;
    if (lineQCTop3detailReportModels != null) {
      data['lineQCTop3detailReportModels'] =
          lineQCTop3detailReportModels!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['defectCount'] = defectCount;
    data['defectPercent'] = defectPercent;
    return data;
  }
}
