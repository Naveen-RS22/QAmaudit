import 'dart:convert';

class SaveGarFitAuditRequestModel {
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
  String? unitCode;
  String? lineCode;
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
  int? inspectedPcs;
  int? passedPcs;
  int? defectPcs;
  String? remarks;
  String? active;
  String? hostName;
  List<GarFitAuditDetlModels>? garFitAuditDetlModels;

  SaveGarFitAuditRequestModel(
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
      this.unitCode,
      this.lineCode,
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
      this.inspectedPcs,
      this.passedPcs,
      this.defectPcs,
      this.remarks,
      this.active,
      this.hostName,
      this.garFitAuditDetlModels});

  SaveGarFitAuditRequestModel.fromJson(Map<String, dynamic> json) {
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
    unitCode = json['unitCode'];
    lineCode = json['lineCode'];
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
    inspectedPcs = json['inspectedPcs'];
    passedPcs = json['passedPcs'];
    defectPcs = json['defectPcs'];
    remarks = json['remarks'];
    active = json['active'];
    hostName = json['hostName'];
    if (json['garFitAuditDetlModels'] != null) {
      garFitAuditDetlModels = <GarFitAuditDetlModels>[];
      json['garFitAuditDetlModels'].forEach((v) {
        garFitAuditDetlModels!.add(GarFitAuditDetlModels.fromJson(v));
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
    data['entityID'] = entityID;
    data['auditType'] = auditType;
    data['auditDate'] = auditDate;
    data['sessionName'] = sessionName;
    data['unitCode'] = unitCode;
    data['lineCode'] = lineCode;
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
    data['inspectedPcs'] = inspectedPcs;
    data['passedPcs'] = passedPcs;
    data['defectPcs'] = defectPcs;
    data['remarks'] = remarks;
    data['active'] = active;
    data['hostName'] = hostName;
    if (garFitAuditDetlModels != null) {
      data['garFitAuditDetlModels'] =
          garFitAuditDetlModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GarFitAuditDetlModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? garFitAuditHeadID;
  String? fitAuditStatus;
  String? defectCode;
  String? garSize;
  String? tagId;
  String? remarks;
  String? isClosed;
  String? active;
  String? hostName;
  List<GarFitAuditImagesModels>? garFitAuditImagesModels;

  GarFitAuditDetlModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.garFitAuditHeadID,
      this.fitAuditStatus,
      this.defectCode,
      this.garSize,
      this.tagId,
      this.remarks,
      this.isClosed,
      this.active,
      this.hostName,
      this.garFitAuditImagesModels});

  GarFitAuditDetlModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    garFitAuditHeadID = json['garFitAuditHead_ID'];
    fitAuditStatus = json['fitAuditStatus'];
    defectCode = json['defectCode'];
    garSize = json['garSize'];
    tagId = json['tagId'];
    remarks = json['remarks'];
    isClosed = json['isClosed'];
    active = json['active'];
    hostName = json['hostName'];
    if (json['garFitAuditImagesModels'] != null) {
      garFitAuditImagesModels = <GarFitAuditImagesModels>[];
      json['garFitAuditImagesModels'].forEach((v) {
        garFitAuditImagesModels!.add(GarFitAuditImagesModels.fromJson(v));
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
    data['garFitAuditHead_ID'] = garFitAuditHeadID;
    data['fitAuditStatus'] = fitAuditStatus;
    data['defectCode'] = defectCode;
    data['garSize'] = garSize;
    data['tagId'] = tagId;
    data['remarks'] = remarks;
    data['isClosed'] = isClosed;
    data['active'] = active;
    data['hostName'] = hostName;
    if (garFitAuditImagesModels != null) {
      data['garFitAuditImagesModels'] =
          garFitAuditImagesModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GarFitAuditImagesModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? garFitAuditHeadID;
  int? garFitAuditDetlID;
  String? fName;
  String? filePath;
  String? hostName;
  String? packAttach;
  String? active;

  GarFitAuditImagesModels({
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.isActive,
    this.id,
    this.garFitAuditHeadID,
    this.garFitAuditDetlID,
    this.fName,
    this.filePath,
    this.hostName,
    this.packAttach,
    this.active,
  });

  GarFitAuditImagesModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    garFitAuditHeadID = json['garFitAuditHead_ID'];
    garFitAuditDetlID = json['garFitAuditDetl_ID'];
    fName = json['fName'];
    filePath = json['filePath'];
    hostName = json['hostName'];
    packAttach = json['packAttach'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['id'] = id;
    data['garFitAuditHead_ID'] = garFitAuditHeadID;
    data['garFitAuditDetl_ID'] = garFitAuditDetlID;
    data['fName'] = fName;
    data['filePath'] = filePath;
    data['hostName'] = hostName;
    data['packAttach'] = packAttach;
    data['active'] = active;
    return data;
  }
}

class SaveGarFitAuditResponseModel {
  bool? isSuccess;
  String? message;
  Data? data;

  SaveGarFitAuditResponseModel({this.isSuccess, this.message, this.data});

  SaveGarFitAuditResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? auditDate;
  String? sessionName;
  String? unitCode;
  String? lineCode;
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
  int? inspectedPcs;
  int? passedPcs;
  int? defectPcs;
  String? remarks;
  String? active;
  String? hostName;
  List<SaveGarFitAuditResponseGarFitAuditDetlModels>? garFitAuditDetlModels;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.entityID,
      this.auditType,
      this.auditDate,
      this.sessionName,
      this.unitCode,
      this.lineCode,
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
      this.inspectedPcs,
      this.passedPcs,
      this.defectPcs,
      this.remarks,
      this.active,
      this.hostName,
      this.garFitAuditDetlModels,
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
    unitCode = json['unitCode'];
    lineCode = json['lineCode'];
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
    inspectedPcs = json['inspectedPcs'];
    passedPcs = json['passedPcs'];
    defectPcs = json['defectPcs'];
    remarks = json['remarks'];
    active = json['active'];
    hostName = json['hostName'];
    if (json['garFitAuditDetlModels'] != null) {
      garFitAuditDetlModels = <SaveGarFitAuditResponseGarFitAuditDetlModels>[];
      json['garFitAuditDetlModels'].forEach((v) {
        garFitAuditDetlModels!
            .add(SaveGarFitAuditResponseGarFitAuditDetlModels.fromJson(v));
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
    data['entityID'] = entityID;
    data['auditType'] = auditType;
    data['auditDate'] = auditDate;
    data['sessionName'] = sessionName;
    data['unitCode'] = unitCode;
    data['lineCode'] = lineCode;
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
    data['inspectedPcs'] = inspectedPcs;
    data['passedPcs'] = passedPcs;
    data['defectPcs'] = defectPcs;
    data['remarks'] = remarks;
    data['active'] = active;
    data['hostName'] = hostName;
    if (garFitAuditDetlModels != null) {
      data['garFitAuditDetlModels'] =
          garFitAuditDetlModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class SaveGarFitAuditResponseGarFitAuditDetlModels {
  int? id;
  int? garFitAuditHeadID;
  String? fitAuditStatus;
  String? defectCode;
  String? garSize;
  String? tagId;
  String? remarks;
  String? isClosed;
  String? active;
  String? hostName;
  List<SaveGarFitAuditResponseGarFitAuditImagesModels>? garFitAuditImagesModels;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  SaveGarFitAuditResponseGarFitAuditDetlModels(
      {this.id,
      this.garFitAuditHeadID,
      this.fitAuditStatus,
      this.defectCode,
      this.garSize,
      this.tagId,
      this.remarks,
      this.isClosed,
      this.active,
      this.hostName,
      this.garFitAuditImagesModels,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  SaveGarFitAuditResponseGarFitAuditDetlModels.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    garFitAuditHeadID = json['garFitAuditHead_ID'];
    fitAuditStatus = json['fitAuditStatus'];
    defectCode = json['defectCode'];
    garSize = json['garSize'];
    tagId = json['tagId'];
    remarks = json['remarks'];
    isClosed = json['isClosed'];
    active = json['active'];
    hostName = json['hostName'];
    if (json['garFitAuditImagesModels'] != null) {
      garFitAuditImagesModels =
          <SaveGarFitAuditResponseGarFitAuditImagesModels>[];
      json['garFitAuditImagesModels'].forEach((v) {
        garFitAuditImagesModels!
            .add(SaveGarFitAuditResponseGarFitAuditImagesModels.fromJson(v));
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
    data['garFitAuditHead_ID'] = garFitAuditHeadID;
    data['fitAuditStatus'] = fitAuditStatus;
    data['defectCode'] = defectCode;
    data['garSize'] = garSize;
    data['tagId'] = tagId;
    data['remarks'] = remarks;
    data['isClosed'] = isClosed;
    data['active'] = active;
    data['hostName'] = hostName;
    if (garFitAuditImagesModels != null) {
      data['garFitAuditImagesModels'] =
          garFitAuditImagesModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class SaveGarFitAuditResponseGarFitAuditImagesModels {
  int? id;
  int? garFitAuditHeadID;
  int? garFitAuditDetlID;
  String? fName;
  String? filePath;
  String? hostName;
  String? packAttach;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  SaveGarFitAuditResponseGarFitAuditImagesModels(
      {this.id,
      this.garFitAuditHeadID,
      this.garFitAuditDetlID,
      this.fName,
      this.filePath,
      this.hostName,
      this.packAttach,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  SaveGarFitAuditResponseGarFitAuditImagesModels.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    garFitAuditHeadID = json['garFitAuditHead_ID'];
    garFitAuditDetlID = json['garFitAuditDetl_ID'];
    fName = json['fName'];
    filePath = json['filePath'];
    hostName = json['hostName'];
    packAttach = json['packAttach'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['garFitAuditHead_ID'] = garFitAuditHeadID;
    data['garFitAuditDetl_ID'] = garFitAuditDetlID;
    data['fName'] = fName;
    data['filePath'] = filePath;
    data['hostName'] = hostName;
    data['packAttach'] = packAttach;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
