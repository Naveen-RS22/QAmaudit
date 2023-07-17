import 'package:flutter/material.dart';

class SaveScoreCardModel {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
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
  String? hostName;
  String? active;
  List<ScoreCardDetlModels>? scoreCardDetlModels;

  SaveScoreCardModel(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
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
      this.hostName,
      this.active,
      this.scoreCardDetlModels});

  SaveScoreCardModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
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
    hostName = json['hostName'];
    active = json['active'];
    if (json['scoreCardDetlModels'] != null) {
      scoreCardDetlModels = <ScoreCardDetlModels>[];
      json['scoreCardDetlModels'].forEach((v) {
        scoreCardDetlModels!.add(new ScoreCardDetlModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
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
    data['hostName'] = this.hostName;
    data['active'] = this.active;
    if (this.scoreCardDetlModels != null) {
      data['scoreCardDetlModels'] =
          this.scoreCardDetlModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScoreCardDetlModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? scHeadID;
  String? defectCode;
  String? garSize;
  String? tagId;
  String? isClosed;
  String? hostName;
  String? active;
  List<ScoreCardImagesModels>? scoreCardImagesModels;

  ScoreCardDetlModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.scHeadID,
      this.defectCode,
      this.garSize,
      this.tagId,
      this.isClosed,
      this.hostName,
      this.active,
      this.scoreCardImagesModels});

  ScoreCardDetlModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    scHeadID = json['scHead_ID'];
    defectCode = json['defectCode'];
    garSize = json['garSize'];
    tagId = json['tagId'];
    isClosed = json['isClosed'];
    hostName = json['hostName'];
    active = json['active'];
    if (json['scoreCardImagesModels'] != null) {
      scoreCardImagesModels = <ScoreCardImagesModels>[];
      json['scoreCardImagesModels'].forEach((v) {
        scoreCardImagesModels!.add(new ScoreCardImagesModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    data['scHead_ID'] = this.scHeadID;
    data['defectCode'] = this.defectCode;
    data['garSize'] = this.garSize;
    data['tagId'] = this.tagId;
    data['isClosed'] = this.isClosed;
    data['hostName'] = this.hostName;
    data['active'] = this.active;
    if (this.scoreCardImagesModels != null) {
      data['scoreCardImagesModels'] =
          this.scoreCardImagesModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScoreCardImagesModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? scDetlID;
  String? fName;
  String? filePath;
  String? hostName;
  String? packAttach;

  ScoreCardImagesModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.scDetlID,
      this.fName,
      this.filePath,
      this.hostName,
      this.packAttach});

  ScoreCardImagesModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    scDetlID = json['scDetl_ID'];
    fName = json['fName'];
    filePath = json['filePath'];
    hostName = json['hostName'];
    packAttach = json['packAttach'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    data['scDetl_ID'] = this.scDetlID;
    data['fName'] = this.fName;
    data['filePath'] = this.filePath;
    data['hostName'] = this.hostName;
    data['packAttach'] = this.packAttach;
    return data;
  }
}
