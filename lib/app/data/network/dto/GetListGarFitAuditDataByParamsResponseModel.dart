import 'dart:convert';

class GetListGarFitAuditDataByParamsResponseModel {
  bool? isSuccess;
  String? message;
  List<GetListGarFitAuditDataByParamsResponseModelData>? data;

  GetListGarFitAuditDataByParamsResponseModel(
      {this.isSuccess, this.message, this.data});

  GetListGarFitAuditDataByParamsResponseModel.fromJson(
      Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetListGarFitAuditDataByParamsResponseModelData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetListGarFitAuditDataByParamsResponseModelData.fromJson(v));
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

class GetListGarFitAuditDataByParamsResponseModelData {
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
  String? operationName;

  int? inspectedPcs;
  int? passedPcs;
  int? defectPcs;
  String? remarks;
  String? active;
  String? hostName;
  List<GetListGarFitAuditDataByParamsResponseGarFitAuditDetlModels>?
      garFitAuditDetlModels;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  bool? delete;
  bool? edit;

  GetListGarFitAuditDataByParamsResponseModelData({
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
    this.operationName,
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
    this.isActive,
    this.delete,
    this.edit,
  });

  GetListGarFitAuditDataByParamsResponseModelData.fromJson(
      Map<String, dynamic> json) {
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
    operationName = json['operationName'];
    inspectedPcs = json['inspectedPcs'];
    passedPcs = json['passedPcs'];
    defectPcs = json['defectPcs'];
    remarks = json['remarks'];
    active = json['active'];
    hostName = json['hostName'];
    if (json['garFitAuditDetlModels'] != null) {
      garFitAuditDetlModels =
          <GetListGarFitAuditDataByParamsResponseGarFitAuditDetlModels>[];
      json['garFitAuditDetlModels'].forEach((v) {
        garFitAuditDetlModels!.add(
            GetListGarFitAuditDataByParamsResponseGarFitAuditDetlModels
                .fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    delete = json['delete'];
    edit = json['edit'];
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
    data['operationName'] = operationName;
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
    data['delete'] = delete;
    data['edit'] = edit;
    return data;
  }
}

class GetListGarFitAuditDataByParamsResponseGarFitAuditDetlModels {
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
  List<GetListGarFitAuditDataByParamsResponseModelAuditImagesModels>?
      garFitAuditImagesModels;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  bool? delete;
  bool? edit;

  GetListGarFitAuditDataByParamsResponseGarFitAuditDetlModels({
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
    this.garFitAuditImagesModels,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.isActive,
    this.delete,
    this.edit,
  });

  GetListGarFitAuditDataByParamsResponseGarFitAuditDetlModels.fromJson(
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
          <GetListGarFitAuditDataByParamsResponseModelAuditImagesModels>[];
      json['garFitAuditImagesModels'].forEach((v) {
        garFitAuditImagesModels!.add(
            GetListGarFitAuditDataByParamsResponseModelAuditImagesModels
                .fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    delete = json['delete'];
    edit = json['edit'];
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
    data['delete'] = delete;
    data['edit'] = edit;
    return data;
  }
}

class GetListGarFitAuditDataByParamsResponseModelAuditImagesModels {
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

  GetListGarFitAuditDataByParamsResponseModelAuditImagesModels(
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

  GetListGarFitAuditDataByParamsResponseModelAuditImagesModels.fromJson(
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
