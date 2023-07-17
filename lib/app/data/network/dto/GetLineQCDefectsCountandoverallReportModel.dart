import 'dart:convert';

class GetLineQCDefectsCountandoverallReportModel {
  bool? isSuccess;
  String? message;
  List<LineQCreport>? data;

  GetLineQCDefectsCountandoverallReportModel(
      {this.isSuccess, this.message, this.data});

  GetLineQCDefectsCountandoverallReportModel.fromJson(
      Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LineQCreport>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(LineQCreport.fromJson(v));
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

class LineQCreport {
  String? auditDate;
  String? unitCode;
  String? auditType;
  String? sessionCode;
  String? sessionName;
  String? fromTime;
  String? toTime;
  String? sewLine;
  String? sewLineName;
  String? partCode;
  String? partName;
  String? operationCode;
  String? operationName;
  String? checkerName;
  int? defectCount;
  int? overAllDefectCount;
  String? defectCode;
  String? defectName;
  int? orderNo;

  LineQCreport(
      {this.auditDate,
      this.unitCode,
      this.auditType,
      this.sessionCode,
      this.sessionName,
      this.fromTime,
      this.toTime,
      this.sewLine,
      this.sewLineName,
      this.partCode,
      this.partName,
      this.operationCode,
      this.operationName,
      this.checkerName,
      this.defectCount,
      this.overAllDefectCount,
      this.defectCode,
      this.defectName,
      this.orderNo});

  LineQCreport.fromJson(Map<String, dynamic> json) {
    auditDate = json['auditDate'];
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    sessionCode = json['sessionCode'];
    sessionName = json['sessionName'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    sewLine = json['sewLine'];
    sewLineName = json['sewLineName'];
    partCode = json['partCode'];
    partName = json['partName'];
    operationCode = json['operationCode'];
    operationName = json['operationName'];
    checkerName = json['checkerName'];
    defectCount = json['defectCount'];
    overAllDefectCount = json['overAllDefectCount'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    orderNo = json['orderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auditDate'] = auditDate;
    data['unitCode'] = unitCode;
    data['auditType'] = auditType;
    data['sessionCode'] = sessionCode;
    data['sessionName'] = sessionName;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    data['sewLine'] = sewLine;
    data['sewLineName'] = sewLineName;
    data['partCode'] = partCode;
    data['partName'] = partName;
    data['operationCode'] = operationCode;
    data['operationName'] = operationName;
    data['checkerName'] = checkerName;
    data['defectCount'] = defectCount;
    data['overAllDefectCount'] = overAllDefectCount;
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['orderNo'] = orderNo;
    return data;
  }
}
