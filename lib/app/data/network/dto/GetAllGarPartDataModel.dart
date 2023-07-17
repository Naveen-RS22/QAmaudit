import 'dart:convert';

class GetAllGarPartDataModel {
  bool? isSuccess;
  String? message;
  List<GarPartData>? data;

  GetAllGarPartDataModel({this.isSuccess, this.message, this.data});

  GetAllGarPartDataModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GarPartData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GarPartData.fromJson(v));
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

class GarPartData {
  int? id;
  String? productType;
  String? subProductType;
  String? partCode;
  String? partName;
  String? translation;

  String? partIndex;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  GarPartData(
      {this.id,
      this.productType,
      this.subProductType,
      this.partCode,
      this.partName,
      this.translation,
      this.partIndex,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  GarPartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productType = json['productType'];
    subProductType = json['subProductType'];
    partCode = json['partCode'];
    partName = json['partName'];
    translation = json['translation'];
    partIndex = json['partIndex'];
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
    data['productType'] = productType;
    data['subProductType'] = subProductType;
    data['partCode'] = partCode;
    data['partName'] = partName;
    data['translation'] = translation;
    data['partIndex'] = partIndex;
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
