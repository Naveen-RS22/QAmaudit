import 'dart:convert';

class GetUDMasterByTypeAuditPcsResponseModel {
  bool? isSuccess;
  String? message;
  List<GetUDMasterByTypeAuditPcsData>? data;

  GetUDMasterByTypeAuditPcsResponseModel(
      {this.isSuccess, this.message, this.data});

  GetUDMasterByTypeAuditPcsResponseModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetUDMasterByTypeAuditPcsData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetUDMasterByTypeAuditPcsData.fromJson(v));
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

class GetUDMasterByTypeAuditPcsData {
  String? type;
  String? code;
  String? typeDesc;
  String? codeDesc;
  int? indexkey;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  GetUDMasterByTypeAuditPcsData(
      {this.type,
      this.code,
      this.typeDesc,
      this.codeDesc,
      this.indexkey,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  GetUDMasterByTypeAuditPcsData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    typeDesc = json['typeDesc'];
    codeDesc = json['codeDesc'];
    indexkey = json['indexkey'];
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
    data['type'] = type;
    data['code'] = code;
    data['typeDesc'] = typeDesc;
    data['codeDesc'] = codeDesc;
    data['indexkey'] = indexkey;
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
