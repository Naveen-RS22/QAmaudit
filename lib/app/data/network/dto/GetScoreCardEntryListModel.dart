import 'dart:convert';

class GetScoreCardEntryListModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetScoreCardEntryListModel({this.isSuccess, this.message, this.data});

  GetScoreCardEntryListModel.fromJson(Map<String, dynamic> json) {
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
  String? unitCode;
  String? auditType;
  String? auditDate;
  String? auditorName;
  String? sewLine;
  String? operatorCode;
  String? operatorName;
  String? sessionName;
  String? buyerCode;
  String? operationCode;
  String? operationName;
  String? styleNo;
  int? orderNo;
  String? partCode;
  String? partName;
  int? inspectedPcs;
  int? defectPcs;
  String? defectCodes;
  String? defectNames;
  int? defectCount;
  bool? edit;
  bool? delete;

  Data({
    this.id,
    this.unitCode,
    this.auditType,
    this.auditDate,
    this.auditorName,
    this.sewLine,
    this.operatorCode,
    this.operatorName,
    this.sessionName,
    this.buyerCode,
    this.operationCode,
    this.operationName,
    this.styleNo,
    this.orderNo,
    this.partCode,
    this.partName,
    this.inspectedPcs,
    this.defectPcs,
    this.defectCodes,
    this.defectNames,
    this.defectCount,
    this.edit,
    this.delete,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    auditDate = json['auditDate'];
    auditorName = json['auditorName'];
    sewLine = json['sewLine'];
    operatorCode = json['operatorCode'];
    operatorName = json['operatorName'];
    sessionName = json['sessionName'];
    buyerCode = json['buyerCode'];
    operationCode = json['operationCode'];
    operationName = json['operationName'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    partCode = json['partCode'];
    partName = json['partName'];
    inspectedPcs = json['inspectedPcs'];
    defectPcs = json['defectPcs'];
    defectCodes = json['defectCodes'];
    defectNames = json['defectNames'];
    defectCount = json['defectCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unitCode'] = this.unitCode;
    data['auditType'] = this.auditType;
    data['auditDate'] = this.auditDate;
    data['auditorName'] = this.auditorName;
    data['sewLine'] = this.sewLine;
    data['operatorCode'] = this.operatorCode;
    data['operatorName'] = this.operatorName;
    data['sessionName'] = this.sessionName;
    data['buyerCode'] = this.buyerCode;
    data['operationCode'] = this.operationCode;
    data['operationName'] = this.operationName;
    data['styleNo'] = this.styleNo;
    data['orderNo'] = this.orderNo;
    data['partCode'] = this.partCode;
    data['partName'] = this.partName;
    data['inspectedPcs'] = this.inspectedPcs;
    data['defectPcs'] = this.defectPcs;
    data['defectCodes'] = this.defectCodes;
    data['defectNames'] = this.defectNames;
    data['defectCount'] = this.defectCount;
    return data;
  }
}
