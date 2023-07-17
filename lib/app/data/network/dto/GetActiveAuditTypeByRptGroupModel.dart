import 'dart:convert';

class GetActiveAuditTypeByRptGroupModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetActiveAuditTypeByRptGroupModel({this.isSuccess, this.message, this.data});

  GetActiveAuditTypeByRptGroupModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? auditCode;
  String? auditName;
  String? auditMainGroup;
  String? rptGroup;
  int? auditID;
  String? colorCode;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.auditCode,
      this.auditName,
      this.auditMainGroup,
      this.rptGroup,
      this.auditID,
      this.colorCode,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auditCode = json['auditCode'];
    auditName = json['auditName'];
    auditMainGroup = json['auditMainGroup'];
    rptGroup = json['rptGroup'];
    auditID = json['audit_ID'];
    colorCode = json['colorCode'];
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
    data['auditCode'] = auditCode;
    data['auditName'] = auditName;
    data['auditMainGroup'] = auditMainGroup;
    data['rptGroup'] = rptGroup;
    data['audit_ID'] = auditID;
    data['colorCode'] = colorCode;
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
