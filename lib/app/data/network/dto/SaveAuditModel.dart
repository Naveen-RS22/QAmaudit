class SaveAuditModel {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
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
  List<AuditQcDetlModels>? auditQcDetlModels;
  List<AuditPoDetlModels>? auditPoDetlModels;

  SaveAuditModel(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
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
      this.auditPoDetlModels});

  SaveAuditModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
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
      auditQcDetlModels = <AuditQcDetlModels>[];
      json['auditQcDetlModels'].forEach((v) {
        auditQcDetlModels!.add(AuditQcDetlModels.fromJson(v));
      });
    }
    if (json['auditPoDetlModels'] != null) {
      auditPoDetlModels = <AuditPoDetlModels>[];
      json['auditPoDetlModels'].forEach((v) {
        auditPoDetlModels!.add(AuditPoDetlModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
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
    return data;
  }
}

class AuditQcDetlModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
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
  String? cancel;
  List<AuditImagesEntityModels>? auditImagesEntityModels;

  AuditQcDetlModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
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
      this.cancel,
      this.auditImagesEntityModels});

  AuditQcDetlModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
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
    cancel = json['cancel'];
    if (json['auditImagesEntityModels'] != null) {
      auditImagesEntityModels = <AuditImagesEntityModels>[];
      json['auditImagesEntityModels'].forEach((v) {
        auditImagesEntityModels!.add(AuditImagesEntityModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
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
    data['cancel'] = cancel;
    if (auditImagesEntityModels != null) {
      data['auditImagesEntityModels'] =
          auditImagesEntityModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuditImagesEntityModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? adDetlID;
  String? fName;
  String? filePath;
  String? packAttach;
  String? hostName;

  AuditImagesEntityModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.adDetlID,
      this.fName,
      this.filePath,
      this.packAttach,
      this.hostName});

  AuditImagesEntityModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    adDetlID = json['adDetl_ID'];
    fName = json['fName'];
    filePath = json['filePath'];
    packAttach = json['packAttach'];
    hostName = json['hostName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['id'] = id;
    data['adDetl_ID'] = adDetlID;
    data['fName'] = fName;
    data['filePath'] = filePath;
    data['packAttach'] = packAttach;
    data['hostName'] = hostName;
    return data;
  }
}

class AuditPoDetlModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? adHeadID;
  int? orderNo;
  String? buyerPoNo;
  int? buyerPoSlno;
  String? color;
  int? orderQty;
  String? hostName;

  AuditPoDetlModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.adHeadID,
      this.orderNo,
      this.buyerPoNo,
      this.buyerPoSlno,
      this.color,
      this.orderQty,
      this.hostName});

  AuditPoDetlModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    adHeadID = json['adHead_ID'];
    orderNo = json['orderNo'];
    buyerPoNo = json['buyerPoNo'];
    buyerPoSlno = json['buyerPoSlno'];
    color = json['color'];
    orderQty = json['orderQty'];
    hostName = json['hostName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['id'] = id;
    data['adHead_ID'] = adHeadID;
    data['orderNo'] = orderNo;
    data['buyerPoNo'] = buyerPoNo;
    data['buyerPoSlno'] = buyerPoSlno;
    data['color'] = color;
    data['orderQty'] = orderQty;
    data['hostName'] = hostName;
    return data;
  }
}
