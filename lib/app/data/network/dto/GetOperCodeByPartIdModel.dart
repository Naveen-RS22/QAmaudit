import 'dart:convert';

class GetOperCodeByPartIdModel {
  bool? isSuccess;
  String? message;
  List<GetOperCodeByPartIdArr>? data;

  GetOperCodeByPartIdModel({this.isSuccess, this.message, this.data});

  GetOperCodeByPartIdModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetOperCodeByPartIdArr>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(new GetOperCodeByPartIdArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetOperCodeByPartIdArr {
  int? id;
  int? partID;
  String? operCode;
  String? operName;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  GetOperCodeByPartIdArr(
      {this.id,
      this.partID,
      this.operCode,
      this.operName,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  GetOperCodeByPartIdArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partID = json['part_ID'];
    operCode = json['operCode'];
    operName = json['operName'];
    active = json['active'];
    hostName = json['hostName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['part_ID'] = this.partID;
    data['operCode'] = this.operCode;
    data['operName'] = this.operName;
    data['active'] = this.active;
    data['hostName'] = this.hostName;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    return data;
  }
}
