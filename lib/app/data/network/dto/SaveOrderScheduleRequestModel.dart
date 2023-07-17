class SaveOrderScheduleRequestModel {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  String? entityID;
  String? auditType;
  String? insType;
  String? fromDate;
  String? toDate;
  String? schFmTime;
  String? schToTime;
  String? sessionCnt;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  String? unitCode;
  String? sewLine;
  int? orderQty;
  String? auditorName;
  String? comments;
  int? targetPerHour;
  String? aqlStd;
  String? hostName;
  List<OrderScheduleDetlModels>? orderScheduleDetlModels;
  List<AuditScheduleHeadEntityModels>? auditScheduleHeadEntityModels;

  SaveOrderScheduleRequestModel(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.entityID,
      this.auditType,
      this.insType,
      this.fromDate,
      this.toDate,
      this.schFmTime,
      this.schToTime,
      this.sessionCnt,
      this.buyerCode,
      this.styleNo,
      this.orderNo,
      this.unitCode,
      this.sewLine,
      this.orderQty,
      this.auditorName,
      this.comments,
      this.targetPerHour,
      this.aqlStd,
      this.hostName,
      this.orderScheduleDetlModels,
      this.auditScheduleHeadEntityModels});

  SaveOrderScheduleRequestModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    entityID = json['entityID'];
    auditType = json['auditType'];
    insType = json['insType'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    schFmTime = json['schFmTime'];
    schToTime = json['schToTime'];
    sessionCnt = json['sessionCnt'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    unitCode = json['unitCode'];
    sewLine = json['sewLine'];
    orderQty = json['orderQty'];
    auditorName = json['auditorName'];
    comments = json['comments'];
    targetPerHour = json['targetPerHour'];
    aqlStd = json['aqlStd'];
    hostName = json['hostName'];
    if (json['orderScheduleDetlModels'] != null) {
      orderScheduleDetlModels = <OrderScheduleDetlModels>[];
      json['orderScheduleDetlModels'].forEach((v) {
        orderScheduleDetlModels!.add(OrderScheduleDetlModels.fromJson(v));
      });
    }
    if (json['auditScheduleHeadEntityModels'] != null) {
      auditScheduleHeadEntityModels = <AuditScheduleHeadEntityModels>[];
      json['auditScheduleHeadEntityModels'].forEach((v) {
        auditScheduleHeadEntityModels!
            .add(AuditScheduleHeadEntityModels.fromJson(v));
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
    data['insType'] = insType;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['schFmTime'] = schFmTime;
    data['schToTime'] = schToTime;
    data['sessionCnt'] = sessionCnt;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['unitCode'] = unitCode;
    data['sewLine'] = sewLine;
    data['orderQty'] = orderQty;
    data['auditorName'] = auditorName;
    data['comments'] = comments;
    data['targetPerHour'] = targetPerHour;
    data['aqlStd'] = aqlStd;
    data['hostName'] = hostName;
    if (orderScheduleDetlModels != null) {
      data['orderScheduleDetlModels'] =
          orderScheduleDetlModels!.map((v) => v.toJson()).toList();
    }
    if (auditScheduleHeadEntityModels != null) {
      data['auditScheduleHeadEntityModels'] =
          auditScheduleHeadEntityModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderScheduleDetlModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? orderSchID;
  int? orderNo;
  String? buyerPoNo;
  int? buyerPoSlno;
  int? orderQty;
  String? hostname;
  String? cancel;

  OrderScheduleDetlModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.orderSchID,
      this.orderNo,
      this.buyerPoNo,
      this.buyerPoSlno,
      this.orderQty,
      this.hostname,
      this.cancel});

  OrderScheduleDetlModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    orderSchID = json['orderSch_ID'];
    orderNo = json['orderNo'];
    buyerPoNo = json['buyerPoNo'];
    buyerPoSlno = json['buyerPoSlno'];
    orderQty = json['orderQty'];
    hostname = json['hostname'];
    cancel = json['cancel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['id'] = id;
    data['orderSch_ID'] = orderSchID;
    data['orderNo'] = orderNo;
    data['buyerPoNo'] = buyerPoNo;
    data['buyerPoSlno'] = buyerPoSlno;
    data['orderQty'] = orderQty;
    data['hostname'] = hostname;
    data['cancel'] = cancel;
    return data;
  }
}

class AuditScheduleHeadEntityModels {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? orderSchID;
  String? entityID;
  String? schDate;
  String? schTime;
  String? auditType;
  String? insType;
  String? sessionName;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  String? unitCode;
  String? sewLine;
  int? orderQty;
  String? auditorName;
  String? auditorName1;
  String? auditorName2;
  String? auditorName3;
  String? auditorName4;
  String? auditStatus;
  String? comments;
  String? completedDate;
  String? hostName;
  String? isScheduled;
  int? totOperators;
  String? ssFlag;
  String? aqlType;
  List<AuditScheduleDetlModel>? auditScheduleDetlModel;

  AuditScheduleHeadEntityModels(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.orderSchID,
      this.entityID,
      this.schDate,
      this.schTime,
      this.auditType,
      this.insType,
      this.sessionName,
      this.buyerCode,
      this.styleNo,
      this.orderNo,
      this.unitCode,
      this.sewLine,
      this.orderQty,
      this.auditorName,
      this.auditorName1,
      this.auditorName2,
      this.auditorName3,
      this.auditorName4,
      this.auditStatus,
      this.comments,
      this.completedDate,
      this.hostName,
      this.isScheduled,
      this.totOperators,
      this.ssFlag,
      this.aqlType,
      this.auditScheduleDetlModel});

  AuditScheduleHeadEntityModels.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    orderSchID = json['orderSch_ID'];
    entityID = json['entityID'];
    schDate = json['schDate'];
    schTime = json['schTime'];
    auditType = json['auditType'];
    insType = json['insType'];
    sessionName = json['sessionName'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    unitCode = json['unitCode'];
    sewLine = json['sewLine'];
    orderQty = json['orderQty'];
    auditorName = json['auditorName'];
    auditorName1 = json['auditorName1'];
    auditorName2 = json['auditorName2'];
    auditorName3 = json['auditorName3'];
    auditorName4 = json['auditorName4'];
    auditStatus = json['auditStatus'];
    comments = json['comments'];
    completedDate = json['completedDate'];
    hostName = json['hostName'];
    isScheduled = json['isScheduled'];
    totOperators = json['totOperators'];
    ssFlag = json['ssFlag'];
    aqlType = json['aqlType'];
    if (json['auditScheduleDetlModel'] != null) {
      auditScheduleDetlModel = <AuditScheduleDetlModel>[];
      json['auditScheduleDetlModel'].forEach((v) {
        auditScheduleDetlModel!.add(AuditScheduleDetlModel.fromJson(v));
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
    data['orderSch_ID'] = orderSchID;
    data['entityID'] = entityID;
    data['schDate'] = schDate;
    data['schTime'] = schTime;
    data['auditType'] = auditType;
    data['insType'] = insType;
    data['sessionName'] = sessionName;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['unitCode'] = unitCode;
    data['sewLine'] = sewLine;
    data['orderQty'] = orderQty;
    data['auditorName'] = auditorName;
    data['auditorName1'] = auditorName1;
    data['auditorName2'] = auditorName2;
    data['auditorName3'] = auditorName3;
    data['auditorName4'] = auditorName4;
    data['auditStatus'] = auditStatus;
    data['comments'] = comments;
    data['completedDate'] = completedDate;
    data['hostName'] = hostName;
    data['isScheduled'] = isScheduled;
    data['totOperators'] = totOperators;
    data['ssFlag'] = ssFlag;
    data['aqlType'] = aqlType;
    if (auditScheduleDetlModel != null) {
      data['auditScheduleDetlModel'] =
          auditScheduleDetlModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuditScheduleDetlModel {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  int? scHeadID;
  int? orderNo;
  String? buyerPoNo;
  int? buyerPoSlno;
  String? color;
  int? orderQty;
  String? hostName;

  AuditScheduleDetlModel(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.scHeadID,
      this.orderNo,
      this.buyerPoNo,
      this.buyerPoSlno,
      this.color,
      this.orderQty,
      this.hostName});

  AuditScheduleDetlModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    scHeadID = json['scHead_ID'];
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
    data['scHead_ID'] = scHeadID;
    data['orderNo'] = orderNo;
    data['buyerPoNo'] = buyerPoNo;
    data['buyerPoSlno'] = buyerPoSlno;
    data['color'] = color;
    data['orderQty'] = orderQty;
    data['hostName'] = hostName;
    return data;
  }
}
