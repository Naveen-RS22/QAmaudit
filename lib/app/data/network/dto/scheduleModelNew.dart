import 'dart:convert';

class ScheduleModelNew {
  bool? isSuccess;
  String? message;
  List<StyleAuditDataNew>? data;

  ScheduleModelNew({this.isSuccess, this.message, this.data});

  ScheduleModelNew.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StyleAuditDataNew>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(StyleAuditDataNew.fromJson(v));
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

class StyleAuditDataNew {
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
  String? lineName;
  String? sewLine;
  int? orderQty;
  int? totalInspectedPcs;
  int? totalDefectPcs;
  num? dhu;
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
  List<String>? auditScheduleDetlModel;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? ssFlag;
  int? preID;
  bool? isActive;
  String? productType;

  StyleAuditDataNew(
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
      this.lineName,
      this.sewLine,
      this.orderQty,
      this.totalInspectedPcs,
      this.totalDefectPcs,
      this.dhu,
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
      this.auditScheduleDetlModel,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.ssFlag,
      this.isActive,
      this.preID,
      this.productType});

  StyleAuditDataNew.fromJson(Map<String, dynamic> json) {
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
    lineName = json['lineName'];
    sewLine = json['sewLine'];
    orderQty = json['orderQty'];
    totalInspectedPcs = json['totalInspectedPcs'];
    totalDefectPcs = json['totalDefectPcs'];
    dhu = json['dhu'];
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
    if (json['auditScheduleDetlModel'] != null) {
      auditScheduleDetlModel = <String>[];
      // json['auditScheduleDetlModel'].forEach((v) {
      //   auditScheduleDetlModel!.add(String.fromJson(v));
      // });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    ssFlag = json['ssFlag'];
    isActive = json['isActive'];
    preID = json['preID'];
    productType = json['productType'];
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
    data['lineName'] = lineName;
    data['sewLine'] = sewLine;
    data['orderQty'] = orderQty;
    data['totalInspectedPcs'] = totalInspectedPcs;
    data['totalDefectPcs'] = totalDefectPcs;
    data['dhu'] = dhu;
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
    if (auditScheduleDetlModel != null) {
      data['auditScheduleDetlModel'] = [];
    }
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['ssFlag'] = ssFlag;
    data['preID'] = preID;
    data['productType'] = productType;

    return data;
  }
}

class SchTime {
  int? ticks;
  int? days;
  int? hours;
  int? milliseconds;
  int? minutes;
  int? seconds;
  double? totalDays;
  int? totalHours;
  int? totalMilliseconds;
  int? totalMinutes;
  int? totalSeconds;

  SchTime(
      {this.ticks,
      this.days,
      this.hours,
      this.milliseconds,
      this.minutes,
      this.seconds,
      this.totalDays,
      this.totalHours,
      this.totalMilliseconds,
      this.totalMinutes,
      this.totalSeconds});

  SchTime.fromJson(Map<String, dynamic> json) {
    ticks = json['ticks'];
    days = json['days'];
    hours = json['hours'];
    milliseconds = json['milliseconds'];
    minutes = json['minutes'];
    seconds = json['seconds'];
    totalDays = json['totalDays'];
    totalHours = json['totalHours'];
    totalMilliseconds = json['totalMilliseconds'];
    totalMinutes = json['totalMinutes'];
    totalSeconds = json['totalSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticks'] = ticks;
    data['days'] = days;
    data['hours'] = hours;
    data['milliseconds'] = milliseconds;
    data['minutes'] = minutes;
    data['seconds'] = seconds;
    data['totalDays'] = totalDays;
    data['totalHours'] = totalHours;
    data['totalMilliseconds'] = totalMilliseconds;
    data['totalMinutes'] = totalMinutes;
    data['totalSeconds'] = totalSeconds;
    return data;
  }
}
