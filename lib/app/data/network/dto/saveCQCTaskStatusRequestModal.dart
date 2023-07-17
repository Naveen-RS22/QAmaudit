import 'dart:convert';

class SaveCQCTaskStatusRequestModal {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  String? unitCode;
  int? orderNo;
  String? taskName;
  String? taskStatus;
  String? hostName;

  SaveCQCTaskStatusRequestModal(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.unitCode,
      this.orderNo,
      this.taskName,
      this.taskStatus,
      this.hostName});

  SaveCQCTaskStatusRequestModal.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    unitCode = json['unitCode'];
    orderNo = json['orderNo'];
    taskName = json['taskName'];
    taskStatus = json['taskStatus'];
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
    data['unitCode'] = unitCode;
    data['orderNo'] = orderNo;
    data['taskName'] = taskName;
    data['taskStatus'] = taskStatus;
    data['hostName'] = hostName;
    return data;
  }
}

class SaveCQCTaskStatusResponseModal {
  bool? isSuccess;
  String? message;
  Data? data;

  SaveCQCTaskStatusResponseModal({this.isSuccess, this.message, this.data});

  SaveCQCTaskStatusResponseModal.fromJson(Map<String, dynamic> json) {
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
  int? orderNo;
  String? taskName;
  String? taskStatus;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.unitCode,
      this.orderNo,
      this.taskName,
      this.taskStatus,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitCode = json['unitCode'];
    orderNo = json['orderNo'];
    taskName = json['taskName'];
    taskStatus = json['taskStatus'];
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
    data['orderNo'] = orderNo;
    data['taskName'] = taskName;
    data['taskStatus'] = taskStatus;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
