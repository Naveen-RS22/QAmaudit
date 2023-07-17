import 'dart:convert';

class GetAllSessionMasterbyunitcode {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetAllSessionMasterbyunitcode({this.isSuccess, this.message, this.data});

  GetAllSessionMasterbyunitcode.fromJson(Map<String, dynamic> json) {
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
  String? sessionCode;
  String? fromTime;
  String? toTime;
  String? preSSCode;
  String? sessionName;
  String? active;
  String? hostname;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.unitcode,
      this.sessionCode,
      this.fromTime,
      this.toTime,
      this.preSSCode,
      this.sessionName,
      this.active,
      this.hostname,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitcode = json['unitcode'];
    sessionCode = json['sessionCode'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    preSSCode = json['preSSCode'];
    sessionName = json['sessionName'];
    active = json['active'];
    hostname = json['hostname'];
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
    data['sessionCode'] = sessionCode;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    data['preSSCode'] = preSSCode;
    data['sessionName'] = sessionName;
    data['active'] = active;
    data['hostname'] = hostname;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
