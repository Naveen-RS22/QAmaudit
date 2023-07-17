import 'dart:convert';

class GetAppDetlListModel {
  bool? isSuccess;
  String? message;
  List<GetAppDetlListDatar>? data;

  GetAppDetlListModel({this.isSuccess, this.message, this.data});

  GetAppDetlListModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAppDetlListDatar>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetAppDetlListDatar.fromJson(v));
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

class GetAppDetlListDatar {
  int? id;
  String? unitCode;
  String? auditType;
  String? approverType;
  String? approver;
  String? passcode;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  GetAppDetlListDatar(
      {this.id,
      this.unitCode,
      this.auditType,
      this.approverType,
      this.approver,
      this.passcode,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  GetAppDetlListDatar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    approverType = json['approverType'];
    approver = json['approver'];
    passcode = json['passcode'];
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
    data['approverType'] = approverType;
    data['approver'] = approver;
    data['passcode'] = passcode;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
