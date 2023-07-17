class UpdateAuditStatusModel {
  bool? isSuccess;
  String? message;
  // Data? data;

  UpdateAuditStatusModel({
    this.isSuccess,
    this.message,
    // this.data
  });

  UpdateAuditStatusModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    // data =
    //     json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    return data;
  }
}

class Data {
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
  String? hostName;
  String? isScheduled;
  int? totOperators;
  String? ssFlag;
  String? createdDate;
  String? createdBy;
  bool? isActive;

  Data(
      {this.id,
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
      this.hostName,
      this.isScheduled,
      this.totOperators,
      this.ssFlag,
      this.createdDate,
      this.createdBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
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
    hostName = json['hostName'];
    isScheduled = json['isScheduled'];
    totOperators = json['totOperators'];
    ssFlag = json['ssFlag'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['hostName'] = hostName;
    data['isScheduled'] = isScheduled;
    data['totOperators'] = totOperators;
    data['ssFlag'] = ssFlag;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['isActive'] = isActive;
    return data;
  }
}
