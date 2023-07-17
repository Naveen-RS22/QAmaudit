import 'dart:convert';

class GetAuditHeadDataByIdModel {
  bool? isSuccess;
  String? message;
  Data? data;

  GetAuditHeadDataByIdModel({this.isSuccess, this.message, this.data});

  GetAuditHeadDataByIdModel.fromJson(Map<String, dynamic> json) {
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
  int? auditScheduleHeadID;
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
  String? aqlType;
  String? auditorName;
  String? resubmissionDate;
  String? hostName;
  int? inspectedPcs;
  int? vInspectedPcs;
  int? mInspectedPcs;
  int? pInspectedPcs;
  String? mkType;
  List<AuditQcDetlModelsss>? auditQcDetlModels;
  List<AuditPoDetlModelsss>? auditPoDetlModels;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.auditScheduleHeadID,
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
      this.aqlType,
      this.auditorName,
      this.resubmissionDate,
      this.hostName,
      this.inspectedPcs,
      this.vInspectedPcs,
      this.mInspectedPcs,
      this.pInspectedPcs,
      this.mkType,
      this.auditQcDetlModels,
      this.auditPoDetlModels,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auditScheduleHeadID = json['auditScheduleHeadID'];
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
    aqlType = json['aqlType'];
    auditorName = json['auditorName'];
    resubmissionDate = json['resubmissionDate'];
    hostName = json['hostName'];
    inspectedPcs = json['inspectedPcs'];
    vInspectedPcs = json['vInspectedPcs'];
    mInspectedPcs = json['mInspectedPcs'];
    pInspectedPcs = json['pInspectedPcs'];
    mkType = json['mkType'];
    if (json['auditQcDetlModels'] != null) {
      auditQcDetlModels = <AuditQcDetlModelsss>[];
      json['auditQcDetlModels'].forEach((v) {
        auditQcDetlModels!.add(AuditQcDetlModelsss.fromJson(v));
      });
    }
    if (json['auditPoDetlModels'] != null) {
      auditPoDetlModels = <AuditPoDetlModelsss>[];
      json['auditPoDetlModels'].forEach((v) {
        auditPoDetlModels!.add(AuditPoDetlModelsss.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['auditScheduleHeadID'] = auditScheduleHeadID;
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
    data['aqlType'] = aqlType;
    data['auditorName'] = auditorName;
    data['resubmissionDate'] = resubmissionDate;
    data['hostName'] = hostName;
    data['inspectedPcs'] = inspectedPcs;
    data['vInspectedPcs'] = vInspectedPcs;
    data['mInspectedPcs'] = mInspectedPcs;
    data['pInspectedPcs'] = pInspectedPcs;
    data['mkType'] = mkType;
    if (auditQcDetlModels != null) {
      data['auditQcDetlModels'] =
          auditQcDetlModels!.map((v) => v.toJson()).toList();
    }
    if (auditPoDetlModels != null) {
      data['auditPoDetlModels'] =
          auditPoDetlModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class AuditQcDetlModelsss {
  int? id;
  int? adHeadID;
  String? chkType;
  String? uom;
  String? partCode;
  String? operationCode;
  String? deviation;
  int? defectPcs;
  String? defectCode;
  int? critical;
  int? major;
  int? minor;
  String? comments;
  String? hostName;
  String? garSize;
  String? packID;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  AuditQcDetlModelsss(
      {this.id,
      this.adHeadID,
      this.chkType,
      this.uom,
      this.partCode,
      this.operationCode,
      this.deviation,
      this.defectPcs,
      this.defectCode,
      this.critical,
      this.major,
      this.minor,
      this.comments,
      this.hostName,
      this.garSize,
      this.packID,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  AuditQcDetlModelsss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adHeadID = json['adHead_ID'];
    chkType = json['chkType'];
    uom = json['uom'];
    partCode = json['partCode'];
    operationCode = json['operationCode'];
    deviation = json['deviation'];
    defectPcs = json['defectPcs'];
    defectCode = json['defectCode'];
    critical = json['critical'];
    major = json['major'];
    minor = json['minor'];
    comments = json['comments'];
    hostName = json['hostName'];
    garSize = json['garSize'];
    packID = json['packID'];
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
    data['chkType'] = chkType;
    data['uom'] = uom;
    data['partCode'] = partCode;
    data['operationCode'] = operationCode;
    data['deviation'] = deviation;
    data['defectPcs'] = defectPcs;
    data['defectCode'] = defectCode;
    data['critical'] = critical;
    data['major'] = major;
    data['minor'] = minor;
    data['comments'] = comments;
    data['hostName'] = hostName;
    data['garSize'] = garSize;
    data['packID'] = packID;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class AuditPoDetlModelsss {
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

  AuditPoDetlModelsss(
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

  AuditPoDetlModelsss.fromJson(Map<String, dynamic> json) {
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
