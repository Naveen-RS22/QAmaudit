import 'dart:convert';

class GetSewLineInfoModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetSewLineInfoModel({this.isSuccess, this.message, this.data});

  GetSewLineInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? unitcode;
  String? lineCode;
  String? lineName;
  String? lineIndex;
  String? shiftCode;
  String? floorName;
  String? lineGroup;
  String? chartStatus;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.unitcode,
      this.lineCode,
      this.lineName,
      this.lineIndex,
      this.shiftCode,
      this.floorName,
      this.lineGroup,
      this.chartStatus,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitcode = json['unitcode'];
    lineCode = json['lineCode'];
    lineName = json['lineName'];
    lineIndex = json['lineIndex'];
    shiftCode = json['shiftCode'];
    floorName = json['floorName'];
    lineGroup = json['lineGroup'];
    chartStatus = json['chartStatus'];
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
    data['unitcode'] = unitcode;
    data['lineCode'] = lineCode;
    data['lineName'] = lineName;
    data['lineIndex'] = lineIndex;
    data['shiftCode'] = shiftCode;
    data['floorName'] = floorName;
    data['lineGroup'] = lineGroup;
    data['chartStatus'] = chartStatus;
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
