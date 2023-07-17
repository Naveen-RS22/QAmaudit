import 'dart:convert';

class GetLineQCApprovalByParamsApproverTypeUserCodeModel {
  bool? isSuccess;
  String? message;
  Data? data;

  GetLineQCApprovalByParamsApproverTypeUserCodeModel(
      {this.isSuccess, this.message, this.data});

  GetLineQCApprovalByParamsApproverTypeUserCodeModel.fromJson(
      Map<String, dynamic> json) {
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
  String? unitCode;
  String? auditType;
  String? auditDate;
  String? sewLine;
  String? sessionCode;
  String? styleNo;
  int? orderNo;
  String? approverType;
  String? approver;
  String? userCode;
  String? approveDateTime;
  String? remarks;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.unitCode,
      this.auditType,
      this.auditDate,
      this.sewLine,
      this.sessionCode,
      this.styleNo,
      this.orderNo,
      this.approverType,
      this.approver,
      this.userCode,
      this.approveDateTime,
      this.remarks,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    auditDate = json['auditDate'];
    sewLine = json['sewLine'];
    sessionCode = json['sessionCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    approverType = json['approverType'];
    approver = json['approver'];
    userCode = json['userCode'];
    approveDateTime = json['approveDateTime'];
    remarks = json['remarks'];
    active = json['active'];
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
    data['unitCode'] = unitCode;
    data['auditType'] = auditType;
    data['auditDate'] = auditDate;
    data['sewLine'] = sewLine;
    data['sessionCode'] = sessionCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['approverType'] = approverType;
    data['approver'] = approver;
    data['userCode'] = userCode;
    data['approveDateTime'] = approveDateTime;
    data['remarks'] = remarks;
    data['active'] = active;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
