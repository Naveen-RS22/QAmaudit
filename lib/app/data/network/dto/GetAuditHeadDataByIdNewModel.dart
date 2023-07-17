import 'dart:convert';

class GetAuditHeadDataByIdNewModel {
  bool? isSuccess;
  String? message;
  GetAuditHeadDataByIdNewData? data;

  GetAuditHeadDataByIdNewModel({this.isSuccess, this.message, this.data});

  GetAuditHeadDataByIdNewModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null
        ? GetAuditHeadDataByIdNewData.fromJson(jsonDecode(json['data']))
        : null;
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

class GetAuditHeadDataByIdNewData {
  int? id;
  int? auditScheduleHeadID;
  String? entityID;
  String? auditType;
  String? insType;
  String? auditDate;
  String? unitCode;
  String? floorName;
  String? sewLine;
  String? sewlineName;
  String? buyerCode;
  String? buyerName;
  String? styleNo;
  int? orderNo;
  int? orderQty;
  int? packQty;
  String? partCode;
  String? partName;
  String? operationCode;
  String? operationName;
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
  List<AuditQcDetlModelsNew>? auditQcDetlModels;
  List<AuditPoDetlModelsNew>? auditPoDetlModels;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  GetAuditHeadDataByIdNewData(
      {this.id,
      this.auditScheduleHeadID,
      this.entityID,
      this.auditType,
      this.insType,
      this.auditDate,
      this.unitCode,
      this.floorName,
      this.sewLine,
      this.sewlineName,
      this.buyerCode,
      this.buyerName,
      this.styleNo,
      this.orderNo,
      this.orderQty,
      this.packQty,
      this.partCode,
      this.partName,
      this.operationCode,
      this.operationName,
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

  GetAuditHeadDataByIdNewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auditScheduleHeadID = json['auditScheduleHeadID'];
    entityID = json['entityID'];
    auditType = json['auditType'];
    insType = json['insType'];
    auditDate = json['auditDate'];
    unitCode = json['unitCode'];
    floorName = json['floorName'];
    sewLine = json['sewLine'];
    sewlineName = json['sewlineName'];
    buyerCode = json['buyerCode'];
    buyerName = json['buyerName'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    orderQty = json['orderQty'];
    packQty = json['packQty'];
    partCode = json['partCode'];
    partName = json['partName'];
    operationCode = json['operationCode'];
    operationName = json['operationName'];
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
      auditQcDetlModels = <AuditQcDetlModelsNew>[];
      json['auditQcDetlModels'].forEach((v) {
        auditQcDetlModels!.add(AuditQcDetlModelsNew.fromJson(v));
      });
    }
    if (json['auditPoDetlModels'] != null) {
      auditPoDetlModels = <AuditPoDetlModelsNew>[];
      json['auditPoDetlModels'].forEach((v) {
        auditPoDetlModels!.add(AuditPoDetlModelsNew.fromJson(v));
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
    data['sewlineName'] = sewlineName;
    data['buyerCode'] = buyerCode;
    data['buyerName'] = buyerName;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['orderQty'] = orderQty;
    data['packQty'] = packQty;
    data['partCode'] = partCode;
    data['partName'] = partName;
    data['operationCode'] = operationCode;
    data['operationName'] = operationName;
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

class AuditQcDetlModelsNew {
  int? id;
  int? adHeadID;
  String? chkType;
  String? uom;
  String? partCode;
  String? partName;
  String? operationCode;
  String? operationName;
  String? deviation;
  int? defectPcs;
  String? defectCode;
  String? defectName;
  int? critical;
  int? major;
  int? minor;
  String? comments;
  String? hostName;
  String? garSize;
  String? packID;
  List<AuditImagesEntityModelsNew>? auditImagesEntityModels;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  bool? isSelected;

  AuditQcDetlModelsNew({
    this.id,
    this.adHeadID,
    this.chkType,
    this.uom,
    this.partCode,
    this.partName,
    this.operationCode,
    this.operationName,
    this.deviation,
    this.defectPcs,
    this.defectCode,
    this.defectName,
    this.critical,
    this.major,
    this.minor,
    this.comments,
    this.hostName,
    this.garSize,
    this.packID,
    this.auditImagesEntityModels,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.isActive,
    this.isSelected,
  });

  AuditQcDetlModelsNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adHeadID = json['adHead_ID'];
    chkType = json['chkType'];
    uom = json['uom'];
    partCode = json['partCode'];
    partName = json['partName'];
    operationCode = json['operationCode'];
    operationName = json['operationName'];
    deviation = json['deviation'];
    defectPcs = json['defectPcs'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    critical = json['critical'];
    major = json['major'];
    minor = json['minor'];
    comments = json['comments'];
    hostName = json['hostName'];
    garSize = json['garSize'];
    packID = json['packID'];
    if (json['auditImagesEntityModels'] != null) {
      auditImagesEntityModels = <AuditImagesEntityModelsNew>[];
      json['auditImagesEntityModels'].forEach((v) {
        auditImagesEntityModels!.add(AuditImagesEntityModelsNew.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['adHead_ID'] = adHeadID;
    data['chkType'] = chkType;
    data['uom'] = uom;
    data['partCode'] = partCode;
    data['partName'] = partName;
    data['operationCode'] = operationCode;
    data['operationName'] = operationName;
    data['deviation'] = deviation;
    data['defectPcs'] = defectPcs;
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['critical'] = critical;
    data['major'] = major;
    data['minor'] = minor;
    data['comments'] = comments;
    data['hostName'] = hostName;
    data['garSize'] = garSize;
    data['packID'] = packID;
    if (auditImagesEntityModels != null) {
      data['auditImagesEntityModels'] =
          auditImagesEntityModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['isSelected'] = isSelected;
    return data;
  }
}

class AuditImagesEntityModelsNew {
  int? id;
  int? adDetlID;
  String? fName;
  String? filePath;
  String? packAttach;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  AuditImagesEntityModelsNew(
      {this.id,
      this.adDetlID,
      this.fName,
      this.filePath,
      this.packAttach,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  AuditImagesEntityModelsNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adDetlID = json['adDetl_ID'];
    fName = json['fName'];
    filePath = json['filePath'];
    packAttach = json['packAttach'];
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
    data['adDetl_ID'] = adDetlID;
    data['fName'] = fName;
    data['filePath'] = filePath;
    data['packAttach'] = packAttach;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class AuditPoDetlModelsNew {
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

  AuditPoDetlModelsNew(
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

  AuditPoDetlModelsNew.fromJson(Map<String, dynamic> json) {
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
