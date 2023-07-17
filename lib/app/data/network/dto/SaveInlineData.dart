class SaveInlineData {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  String? entityID;
  String? auditType;
  String? auditDate;
  String? unitCode;
  String? floorName;
  String? sewLine;
  String? buyerCode;
  String? styleNo;
  String? color;
  int? orderNo;
  String? partCode;
  String? operationCode;
  int? inspectedPcs;
  int? passedPcs;
  int? defectPcs;
  int? rejectedPcs;
  int? recheckedPcs;
  String? checkerName;
  String? hostName;
  String? sessionCode;
  String? currentTime;
  List<LineQcDetlModels>? lineQcDetlModels;

  SaveInlineData(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.entityID,
      this.auditType,
      this.auditDate,
      this.unitCode,
      this.floorName,
      this.sewLine,
      this.buyerCode,
      this.styleNo,
      this.color,
      this.orderNo,
      this.partCode,
      this.operationCode,
      this.inspectedPcs,
      this.passedPcs,
      this.defectPcs,
      this.rejectedPcs,
      this.recheckedPcs,
      this.checkerName,
      this.hostName,
      this.sessionCode,
      this.currentTime,
      this.lineQcDetlModels});

  SaveInlineData.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    entityID = json['entityID'];
    auditType = json['auditType'];
    auditDate = json['auditDate'];
    unitCode = json['unitCode'];
    floorName = json['floorName'];
    sewLine = json['sewLine'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    color = json['color'];
    orderNo = json['orderNo'];
    partCode = json['partCode'];
    operationCode = json['operationCode'];
    inspectedPcs = json['inspectedPcs'];
    passedPcs = json['passedPcs'];
    defectPcs = json['defectPcs'];
    rejectedPcs = json['rejectedPcs'];
    recheckedPcs = json['recheckedPcs'];
    checkerName = json['checkerName'];
    hostName = json['hostName'];
    sessionCode = json['sessionCode'];
    currentTime = json['currentTime'];
    if (json['lineQcDetlModels'] != null) {
      lineQcDetlModels = <LineQcDetlModels>[];
      json['lineQcDetlModels'].forEach((v) {
        lineQcDetlModels!.add(LineQcDetlModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['id'] = id;
    data['entityID'] = entityID;
    data['auditType'] = auditType;
    data['auditDate'] = auditDate;
    data['unitCode'] = unitCode;
    data['floorName'] = floorName;
    data['sewLine'] = sewLine;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['color'] = color;
    data['orderNo'] = orderNo;
    data['partCode'] = partCode;
    data['operationCode'] = operationCode;
    data['inspectedPcs'] = inspectedPcs;
    data['passedPcs'] = passedPcs;
    data['defectPcs'] = defectPcs;
    data['rejectedPcs'] = rejectedPcs;
    data['recheckedPcs'] = recheckedPcs;
    data['checkerName'] = checkerName;
    data['hostName'] = hostName;
    data['sessionCode'] = sessionCode;
    data['currentTime'] = currentTime;
    if (lineQcDetlModels != null) {
      data['lineQcDetlModels'] =
          lineQcDetlModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineQcDetlModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? lqcHeadID;
  String? defectCode;
  String? garType;
  int? defectPcs;
  String? hostName;
  List<LineQcTagDetlEntityModels>? lineQcTagDetlEntityModels;
  List<LineQcImagesEntityModels>? lineQcImagesEntityModels;

  LineQcDetlModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.lqcHeadID,
      this.defectCode,
      this.garType,
      this.defectPcs,
      this.hostName,
      this.lineQcTagDetlEntityModels,
      this.lineQcImagesEntityModels});

  LineQcDetlModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    lqcHeadID = json['lqcHead_ID'];
    defectCode = json['defectCode'];
    garType = json['garType'];
    defectPcs = json['defectPcs'];
    hostName = json['hostName'];
    if (json['lineQcTagDetlEntityModels'] != null) {
      lineQcTagDetlEntityModels = <LineQcTagDetlEntityModels>[];
      json['lineQcTagDetlEntityModels'].forEach((v) {
        lineQcTagDetlEntityModels!.add(LineQcTagDetlEntityModels.fromJson(v));
      });
    }
    if (json['lineQcImagesEntityModels'] != null) {
      lineQcImagesEntityModels = <LineQcImagesEntityModels>[];
      json['lineQcImagesEntityModels'].forEach((v) {
        lineQcImagesEntityModels!.add(LineQcImagesEntityModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['id'] = id;
    data['lqcHead_ID'] = lqcHeadID;
    data['defectCode'] = defectCode;
    data['garType'] = garType;
    data['defectPcs'] = defectPcs;
    data['hostName'] = hostName;
    if (lineQcTagDetlEntityModels != null) {
      data['lineQcTagDetlEntityModels'] =
          lineQcTagDetlEntityModels!.map((v) => v.toJson()).toList();
    }
    if (lineQcImagesEntityModels != null) {
      data['lineQcImagesEntityModels'] =
          lineQcImagesEntityModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineQcTagDetlEntityModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? lqcDetlID;
  String? garSize;
  String? tagId;
  String? isClosed;
  String? hostName;

  LineQcTagDetlEntityModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.lqcDetlID,
      this.garSize,
      this.tagId,
      this.isClosed,
      this.hostName});

  LineQcTagDetlEntityModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    lqcDetlID = json['lqcDetl_ID'];
    garSize = json['garSize'];
    tagId = json['tagId'];
    isClosed = json['isClosed'];
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
    data['lqcDetl_ID'] = lqcDetlID;
    data['garSize'] = garSize;
    data['tagId'] = tagId;
    data['isClosed'] = isClosed;
    data['hostName'] = hostName;
    return data;
  }
}

class LineQcImagesEntityModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? lqcDetlID;
  String? fName;
  String? filePath;
  String? hostName;
  String? packAttach;

  LineQcImagesEntityModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.lqcDetlID,
      this.fName,
      this.filePath,
      this.hostName,
      this.packAttach});

  LineQcImagesEntityModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    lqcDetlID = json['lqcDetl_ID'];
    fName = json['fName'];
    filePath = json['filePath'];
    hostName = json['hostName'];
    packAttach = json['packAttach'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['id'] = id;
    data['lqcDetl_ID'] = lqcDetlID;
    data['fName'] = fName;
    data['filePath'] = filePath;
    data['hostName'] = hostName;
    data['packAttach'] = packAttach;
    return data;
  }
}
