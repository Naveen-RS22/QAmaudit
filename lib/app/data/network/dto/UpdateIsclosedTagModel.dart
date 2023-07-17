import 'dart:convert';

class UpdateIsclosedTagModel {
  bool? isSuccess;
  String? message;
  Data? data;

  UpdateIsclosedTagModel({this.isSuccess, this.message, this.data});

  UpdateIsclosedTagModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null
        ? new Data.fromJson(jsonDecode(json['data']))
        : null;
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
  int? lqcDetlID;
  String? garSize;
  String? tagId;
  String? isClosed;
  String? hostName;
  String? createdDate;
  String? createdBy;
  Null? modifiedDate;
  Null? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.lqcDetlID,
      this.garSize,
      this.tagId,
      this.isClosed,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lqcDetlID = json['lqcDetl_ID'];
    garSize = json['garSize'];
    tagId = json['tagId'];
    isClosed = json['isClosed'];
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
    data['lqcDetl_ID'] = this.lqcDetlID;
    data['garSize'] = this.garSize;
    data['tagId'] = this.tagId;
    data['isClosed'] = this.isClosed;
    data['hostName'] = this.hostName;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    return data;
  }
}
