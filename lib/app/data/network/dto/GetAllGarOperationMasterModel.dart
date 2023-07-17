import 'dart:convert';

class GetAllGarOperationMasterModel {
  bool? isSuccess;
  String? message;
  List<OperationData>? data;

  GetAllGarOperationMasterModel({this.isSuccess, this.message, this.data});

  GetAllGarOperationMasterModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OperationData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(OperationData.fromJson(v));
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

class OperationData {
  int? id;
  String? operCode;
  String? operName;
  String? translation;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  OperationData(
      {this.id,
      this.operCode,
      this.operName,
      this.translation,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  OperationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    operCode = json['operCode'];
    operName = json['operName'];
    translation = json['translation'];
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
    data['operCode'] = operCode;
    data['operName'] = operName;
    data['translation'] = translation;
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
