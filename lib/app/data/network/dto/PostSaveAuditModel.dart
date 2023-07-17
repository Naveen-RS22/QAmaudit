import 'dart:convert';

class PostSaveAuditModel {
  bool? isSuccess;
  String? message;
  Data? data;

  PostSaveAuditModel({this.isSuccess, this.message, this.data});

  PostSaveAuditModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data =
        json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
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
  String? insType;
  String? auditDate;
  String? unitCode;
  String? floorName;
  String? sewLine;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  int? orderQty;
  int? packQty;
  String? partCode;
  String? operationCode;
  int? sampleSize;
  int? measurementPcs;
  int? packCtns;
  int? visualPassPcs;
  int? measurementPassPcs;
  int? packPassed;
  String? visualResult;
  String? measurementResult;
  String? caaResult;
  String? finalResult;
  String? auditCount;
  String? aqlBase;
  String? auditorName;
  String? resubmissionDate;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  List<AuditPoDetlModelsPost>? auditPoDetlModels;

  Data(
      {this.id,
      this.entityID,
      this.auditType,
      this.insType,
      this.auditDate,
      this.unitCode,
      this.floorName,
      this.sewLine,
      this.buyerCode,
      this.styleNo,
      this.orderNo,
      this.orderQty,
      this.packQty,
      this.partCode,
      this.operationCode,
      this.sampleSize,
      this.measurementPcs,
      this.packCtns,
      this.visualPassPcs,
      this.measurementPassPcs,
      this.packPassed,
      this.visualResult,
      this.measurementResult,
      this.caaResult,
      this.finalResult,
      this.auditCount,
      this.aqlBase,
      this.auditorName,
      this.resubmissionDate,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.auditPoDetlModels});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityID = json['entityID'];
    auditType = json['auditType'];
    insType = json['insType'];
    auditDate = json['auditDate'];
    unitCode = json['unitCode'];
    floorName = json['floorName'];
    sewLine = json['sewLine'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    orderQty = json['orderQty'];
    packQty = json['packQty'];
    partCode = json['partCode'];
    operationCode = json['operationCode'];
    sampleSize = json['sampleSize'];
    measurementPcs = json['measurementPcs'];
    packCtns = json['packCtns'];
    visualPassPcs = json['visualPassPcs'];
    measurementPassPcs = json['measurementPassPcs'];
    packPassed = json['packPassed'];
    visualResult = json['visualResult'];
    measurementResult = json['measurementResult'];
    caaResult = json['caaResult'];
    finalResult = json['finalResult'];
    auditCount = json['auditCount'];
    aqlBase = json['aqlBase'];
    auditorName = json['auditorName'];
    resubmissionDate = json['resubmissionDate'];
    hostName = json['hostName'];

    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    if (json['auditPoDetlModels'] != null) {
      auditPoDetlModels = <AuditPoDetlModelsPost>[];
      json['auditPoDetlModels'].forEach((v) {
        auditPoDetlModels!.add(AuditPoDetlModelsPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entityID'] = entityID;
    data['auditType'] = auditType;
    data['insType'] = insType;
    data['auditDate'] = auditDate;
    data['unitCode'] = unitCode;
    data['floorName'] = floorName;
    data['sewLine'] = sewLine;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['orderQty'] = orderQty;
    data['packQty'] = packQty;
    data['partCode'] = partCode;
    data['operationCode'] = operationCode;
    data['sampleSize'] = sampleSize;
    data['measurementPcs'] = measurementPcs;
    data['packCtns'] = packCtns;
    data['visualPassPcs'] = visualPassPcs;
    data['measurementPassPcs'] = measurementPassPcs;
    data['packPassed'] = packPassed;
    data['visualResult'] = visualResult;
    data['measurementResult'] = measurementResult;
    data['caaResult'] = caaResult;
    data['finalResult'] = finalResult;
    data['auditCount'] = auditCount;
    data['aqlBase'] = aqlBase;
    data['auditorName'] = auditorName;
    data['resubmissionDate'] = resubmissionDate;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    if (auditPoDetlModels != null) {
      data['auditPoDetlModels'] =
          auditPoDetlModels!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class AuditPoDetlModelsPost {
  int? id;
  int? adHeadID;
  int? orderNo;
  String? buyerPoNo;
  int? buyerPoSlno;
  String? color;
  int? orderQty;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  AuditPoDetlModelsPost(
      {this.id,
      this.adHeadID,
      this.orderNo,
      this.buyerPoNo,
      this.buyerPoSlno,
      this.color,
      this.orderQty,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  AuditPoDetlModelsPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adHeadID = json['adHead_ID'];
    orderNo = json['orderNo'];
    buyerPoNo = json['buyerPoNo'];
    buyerPoSlno = json['buyerPoSlno'];
    color = json['color'];
    orderQty = json['orderQty'];
    hostName = json['hostName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['adHead_ID'] = adHeadID;
    data['orderNo'] = orderNo;
    data['buyerPoNo'] = buyerPoNo;
    data['buyerPoSlno'] = buyerPoSlno;
    data['color'] = color;
    data['orderQty'] = orderQty;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
