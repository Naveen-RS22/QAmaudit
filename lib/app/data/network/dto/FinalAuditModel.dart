import 'dart:convert';

class FinalAuditModel {
  bool? isSuccess;
  String? message;
  List<AuditData>? data;

  FinalAuditModel({this.isSuccess, this.message, this.data});

  FinalAuditModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AuditData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(AuditData.fromJson(v));
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

class AuditData {
  int? id;
  String? entityID;
  String? auditType;
  String? auditDate;
  String? sessionName;
  String? sesStartDtTime;
  String? sesEndDtTime;
  String? unitCode;
  String? sewLine;
  String? lineName;
  int? totOperators;
  String? auditorName;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  String? operatorCode;
  String? operatorName;
  String? partCode;
  String? operationCode;
  int? defectPcs;
  int? inspectedPcs;
  String? remarks;
  String? flagColor;
  String? createdBy;
  String? createdDt;
  String? modifyBy;
  //String? modifyDt;
  String? hostName;
  //String? scoreCardDetlModels;

  AuditData({
    this.id,
    this.entityID,
    this.auditType,
    this.auditDate,
    this.sessionName,
    this.sesStartDtTime,
    this.sesEndDtTime,
    this.unitCode,
    this.sewLine,
    this.lineName,
    this.totOperators,
    this.auditorName,
    this.buyerCode,
    this.styleNo,
    this.orderNo,
    this.operatorCode,
    this.operatorName,
    this.partCode,
    this.operationCode,
    this.defectPcs,
    this.inspectedPcs,
    this.remarks,
    this.flagColor,
    this.createdBy,
    this.createdDt,
    this.modifyBy,
    //this.modifyDt,
    this.hostName,
    //this.scoreCardDetlModels
  });

  AuditData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityID = json['entityID'];
    auditType = json['auditType'];
    auditDate = json['auditDate'];
    sessionName = json['sessionName'];
    sesStartDtTime = json['sesStartDtTime'];
    sesEndDtTime = json['sesEndDtTime'];
    unitCode = json['unitCode'];
    sewLine = json['sewLine'];
    lineName = json['lineName'];
    totOperators = json['totOperators'];
    auditorName = json['auditorName'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    operatorCode = json['operatorCode'];
    operatorName = json['operatorName'];
    partCode = json['partCode'];
    operationCode = json['operationCode'];
    defectPcs = json['defectPcs'];
    inspectedPcs = json['inspectedPcs'];
    remarks = json['remarks'];
    flagColor = json['flagColor'];
    createdBy = json['createdBy'];
    createdDt = json['createdDt'];
    modifyBy = json['modifyBy'];
    //modifyDt = json['modifyDt'];
    hostName = json['hostName'];
    //scoreCardDetlModels = json['scoreCardDetlModels'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entityID'] = entityID;
    data['auditType'] = auditType;
    data['auditDate'] = auditDate;
    data['sessionName'] = sessionName;
    data['sesStartDtTime'] = sesStartDtTime;
    data['sesEndDtTime'] = sesEndDtTime;
    data['unitCode'] = unitCode;
    data['sewLine'] = sewLine;
    data['lineName'] = lineName;
    data['totOperators'] = totOperators;
    data['auditorName'] = auditorName;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['operatorCode'] = operatorCode;
    data['operatorName'] = operatorName;
    data['partCode'] = partCode;
    data['operationCode'] = operationCode;
    data['defectPcs'] = defectPcs;
    data['inspectedPcs'] = inspectedPcs;
    data['remarks'] = remarks;
    data['flagColor'] = flagColor;
    data['createdBy'] = createdBy;
    data['createdDt'] = createdDt;
    data['modifyBy'] = modifyBy;
    //data['modifyDt'] = this.modifyDt;
    data['hostName'] = hostName;
    //data['scoreCardDetlModels'] = this.scoreCardDetlModels;
    return data;
  }
}
