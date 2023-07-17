import 'dart:convert';

class LineQCSave {
  bool? isSuccess;
  String? message;
  Data? data;

  LineQCSave({this.isSuccess, this.message, this.data});

  LineQCSave.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data =
        json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
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
  List<String>? lineQcDetlModels;
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
      this.lineQcDetlModels,
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
      lineQcDetlModels = <String>[];
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entityID'] = this.entityID;
    data['auditType'] = this.auditType;
    data['auditDate'] = this.auditDate;
    data['unitCode'] = this.unitCode;
    data['floorName'] = this.floorName;
    data['sewLine'] = this.sewLine;
    data['buyerCode'] = this.buyerCode;
    data['styleNo'] = this.styleNo;
    data['color'] = this.color;
    data['orderNo'] = this.orderNo;
    data['partCode'] = this.partCode;
    data['operationCode'] = this.operationCode;
    data['inspectedPcs'] = this.inspectedPcs;
    data['passedPcs'] = this.passedPcs;
    data['defectPcs'] = this.defectPcs;
    data['rejectedPcs'] = this.rejectedPcs;
    data['recheckedPcs'] = this.recheckedPcs;
    data['checkerName'] = this.checkerName;
    data['hostName'] = this.hostName;
    data['sessionCode'] = this.sessionCode;
    data['currentTime'] = this.currentTime;
    if (this.lineQcDetlModels != null) {
      // data['lineQcDetlModels'] =
      //     this.lineQcDetlModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    return data;
  }
}
