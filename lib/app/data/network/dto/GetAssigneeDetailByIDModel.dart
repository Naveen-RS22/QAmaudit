import 'dart:convert';

class GetAssigneeDetailByIDModel {
  bool? isSuccess;
  String? message;
  Data? data;

  GetAssigneeDetailByIDModel({this.isSuccess, this.message, this.data});

  GetAssigneeDetailByIDModel.fromJson(Map<String, dynamic> json) {
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
  String? auditCode;
  String? auditName;
  String? auditMainGroup;
  String? rptGroup;
  int? auditID;
  String? colorCode;
  String? active;
  String? hostName;
  List<AssignmentAuditsModels>? assignmentAuditsModels;
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
      this.assignmentAuditsModels,
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
    if (json['assignmentAuditsModels'] != null) {
      assignmentAuditsModels = <AssignmentAuditsModels>[];
      json['assignmentAuditsModels'].forEach((v) {
        assignmentAuditsModels!.add(AssignmentAuditsModels.fromJson(v));
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
    data['auditCode'] = auditCode;
    data['auditName'] = auditName;
    data['auditMainGroup'] = auditMainGroup;
    data['rptGroup'] = rptGroup;
    data['audit_ID'] = auditID;
    data['colorCode'] = colorCode;
    data['active'] = active;
    data['hostName'] = hostName;
    if (assignmentAuditsModels != null) {
      data['assignmentAuditsModels'] =
          assignmentAuditsModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class AssignmentAuditsModels {
  int? id;
  int? auditId;
  String? usercode;
  String? username;
  String? emaild;
  String? unitCode;
  String? languageCode;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  AssignmentAuditsModels(
      {this.id,
      this.auditId,
      this.usercode,
      this.username,
      this.emaild,
      this.unitCode,
      this.languageCode,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  AssignmentAuditsModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auditId = json['audit_Id'];
    usercode = json['usercode'];
    username = json['username'];
    emaild = json['emaild'];
    unitCode = json['unitCode'];
    languageCode = json['languageCode'];
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
    data['audit_Id'] = auditId;
    data['usercode'] = usercode;
    data['username'] = username;
    data['emaild'] = emaild;
    data['unitCode'] = unitCode;
    data['languageCode'] = languageCode;
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
