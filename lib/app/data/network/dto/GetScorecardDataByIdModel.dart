import 'dart:convert';

class GetScorecardDataByIdModel {
  bool? isSuccess;
  String? message;
  Data? data;

  GetScorecardDataByIdModel({this.isSuccess, this.message, this.data});

  GetScorecardDataByIdModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data =
        json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? entityID;
  String? auditType;
  String? auditDate;
  String? sessionName;
  String? sesStartDtTime;
  String? sesEndDtTime;
  String? unitCode;
  String? sewLine;
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
  String? active;
  String? hostName;
  List<ScoreCardDetlModelss>? scoreCardDetlModels;
  String? createdDate;
  String? createdBy;
  Null? modifiedDate;
  Null? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.entityID,
      this.auditType,
      this.auditDate,
      this.sessionName,
      this.sesStartDtTime,
      this.sesEndDtTime,
      this.unitCode,
      this.sewLine,
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
      this.active,
      this.hostName,
      this.scoreCardDetlModels,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityID = json['entityID'];
    auditType = json['auditType'];
    auditDate = json['auditDate'];
    sessionName = json['sessionName'];
    sesStartDtTime = json['sesStartDtTime'];
    sesEndDtTime = json['sesEndDtTime'];
    unitCode = json['unitCode'];
    sewLine = json['sewLine'];
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
    active = json['active'];
    hostName = json['hostName'];
    if (json['scoreCardDetlModels'] != null) {
      scoreCardDetlModels = <ScoreCardDetlModelss>[];
      json['scoreCardDetlModels'].forEach((v) {
        scoreCardDetlModels!.add(new ScoreCardDetlModelss.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entityID'] = this.entityID;
    data['auditType'] = this.auditType;
    data['auditDate'] = this.auditDate;
    data['sessionName'] = this.sessionName;
    data['sesStartDtTime'] = this.sesStartDtTime;
    data['sesEndDtTime'] = this.sesEndDtTime;
    data['unitCode'] = this.unitCode;
    data['sewLine'] = this.sewLine;
    data['totOperators'] = this.totOperators;
    data['auditorName'] = this.auditorName;
    data['buyerCode'] = this.buyerCode;
    data['styleNo'] = this.styleNo;
    data['orderNo'] = this.orderNo;
    data['operatorCode'] = this.operatorCode;
    data['operatorName'] = this.operatorName;
    data['partCode'] = this.partCode;
    data['operationCode'] = this.operationCode;
    data['defectPcs'] = this.defectPcs;
    data['inspectedPcs'] = this.inspectedPcs;
    data['remarks'] = this.remarks;
    data['flagColor'] = this.flagColor;
    data['active'] = this.active;
    data['hostName'] = this.hostName;
    if (this.scoreCardDetlModels != null) {
      data['scoreCardDetlModels'] =
          this.scoreCardDetlModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    return data;
  }
}

class ScoreCardDetlModelss {
  int? id;
  int? scHeadID;
  String? defectCode;
  String? garSize;
  String? tagId;
  String? isClosed;
  String? active;
  String? hostName;

  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  ScoreCardDetlModelss(
      {this.id,
      this.scHeadID,
      this.defectCode,
      this.garSize,
      this.tagId,
      this.isClosed,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  ScoreCardDetlModelss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scHeadID = json['scHead_ID'];
    defectCode = json['defectCode'];
    garSize = json['garSize'];
    tagId = json['tagId'];
    isClosed = json['isClosed'];
    active = json['active'];
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
    data['scHead_ID'] = this.scHeadID;
    data['defectCode'] = this.defectCode;
    data['garSize'] = this.garSize;
    data['tagId'] = this.tagId;
    data['isClosed'] = this.isClosed;
    data['active'] = this.active;
    data['hostName'] = this.hostName;

    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    return data;
  }
}
