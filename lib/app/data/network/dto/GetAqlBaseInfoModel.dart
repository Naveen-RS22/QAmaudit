import 'dart:convert';

class GetAqlBaseInfoModel {
  bool? isSuccess;
  String? message;
  Data? data;

  GetAqlBaseInfoModel({this.isSuccess, this.message, this.data});

  GetAqlBaseInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? aqlType;
  String? auditFormat;
  String? unitCode;
  String? buyerCode;
  String? active;
  String? hostName;
  List<AqlpkDetlModels>? aqlpkDetlModels;
  List<AqlvmDetlModels>? aqlvmDetlModels;
  String? createdDate;
  String? createdBy;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.aqlType,
      this.auditFormat,
      this.unitCode,
      this.buyerCode,
      this.active,
      this.hostName,
      this.aqlpkDetlModels,
      this.aqlvmDetlModels,
      this.createdDate,
      this.createdBy,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aqlType = json['aqlType'];
    auditFormat = json['auditFormat'];
    unitCode = json['unitCode'];
    buyerCode = json['buyerCode'];
    active = json['active'];
    hostName = json['hostName'];
    if (json['aqlpkDetlModels'] != null) {
      aqlpkDetlModels = <AqlpkDetlModels>[];
      json['aqlpkDetlModels'].forEach((v) {
        aqlpkDetlModels!.add(AqlpkDetlModels.fromJson(v));
      });
    }
    if (json['aqlvmDetlModels'] != null) {
      aqlvmDetlModels = <AqlvmDetlModels>[];
      json['aqlvmDetlModels'].forEach((v) {
        aqlvmDetlModels!.add(AqlvmDetlModels.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aqlType'] = aqlType;
    data['auditFormat'] = auditFormat;
    data['unitCode'] = unitCode;
    data['buyerCode'] = buyerCode;
    data['active'] = active;
    data['hostName'] = hostName;
    if (aqlpkDetlModels != null) {
      data['aqlpkDetlModels'] =
          aqlpkDetlModels!.map((v) => v.toJson()).toList();
    }
    if (aqlvmDetlModels != null) {
      data['aqlvmDetlModels'] =
          aqlvmDetlModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class AqlpkDetlModels {
  int? id;
  int? aqlHeadID;
  int? noofCtnsFrom;
  int? noofCtnsTo;
  int? packSamples;
  int? maxAllowPackDefects;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;

  String? modifiedBy;
  bool? isActive;

  AqlpkDetlModels(
      {this.id,
      this.aqlHeadID,
      this.noofCtnsFrom,
      this.noofCtnsTo,
      this.packSamples,
      this.maxAllowPackDefects,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedBy,
      this.isActive});

  AqlpkDetlModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aqlHeadID = json['aqlHead_ID'];
    noofCtnsFrom = json['noofCtnsFrom'];
    noofCtnsTo = json['noofCtnsTo'];
    packSamples = json['packSamples'];
    maxAllowPackDefects = json['maxAllowPackDefects'];
    active = json['active'];
    hostName = json['hostName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aqlHead_ID'] = aqlHeadID;
    data['noofCtnsFrom'] = noofCtnsFrom;
    data['noofCtnsTo'] = noofCtnsTo;
    data['packSamples'] = packSamples;
    data['maxAllowPackDefects'] = maxAllowPackDefects;
    data['active'] = active;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class AqlvmDetlModels {
  int? id;
  int? aqlHeadID;
  int? packQtyFrom;
  int? packQtyTo;
  int? sampleSize;
  int? mesurementPcs;
  int? maxAllowVisualDefects;
  int? maxAllowCriticalDefects;
  int? maxAllowSewDefects;
  int? maxAllowOthDefects;
  int? maxAllowMesurementDefects;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedBy;
  bool? isActive;

  AqlvmDetlModels(
      {this.id,
      this.aqlHeadID,
      this.packQtyFrom,
      this.packQtyTo,
      this.sampleSize,
      this.mesurementPcs,
      this.maxAllowVisualDefects,
      this.maxAllowCriticalDefects,
      this.maxAllowSewDefects,
      this.maxAllowOthDefects,
      this.maxAllowMesurementDefects,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedBy,
      this.isActive});

  AqlvmDetlModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aqlHeadID = json['aqlHead_ID'];
    packQtyFrom = json['packQtyFrom'];
    packQtyTo = json['packQtyTo'];
    sampleSize = json['sampleSize'];
    mesurementPcs = json['mesurementPcs'];
    maxAllowVisualDefects = json['maxAllowVisualDefects'];
    maxAllowCriticalDefects = json['maxAllowCriticalDefects'];
    maxAllowSewDefects = json['maxAllowSewDefects'];
    maxAllowOthDefects = json['maxAllowOthDefects'];
    maxAllowMesurementDefects = json['maxAllowMesurementDefects'];
    active = json['active'];
    hostName = json['hostName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aqlHead_ID'] = aqlHeadID;
    data['packQtyFrom'] = packQtyFrom;
    data['packQtyTo'] = packQtyTo;
    data['sampleSize'] = sampleSize;
    data['mesurementPcs'] = mesurementPcs;
    data['maxAllowVisualDefects'] = maxAllowVisualDefects;
    data['maxAllowCriticalDefects'] = maxAllowCriticalDefects;
    data['maxAllowSewDefects'] = maxAllowSewDefects;
    data['maxAllowOthDefects'] = maxAllowOthDefects;
    data['maxAllowMesurementDefects'] = maxAllowMesurementDefects;
    data['active'] = active;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
