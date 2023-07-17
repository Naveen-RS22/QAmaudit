import 'dart:convert';

class GetAllBuyerDivInfoModel {
  bool? isSuccess;
  String? message;
  List<GetAllBuyerDivInfoArray>? data;

  GetAllBuyerDivInfoModel({this.isSuccess, this.message, this.data});

  GetAllBuyerDivInfoModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllBuyerDivInfoArray>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetAllBuyerDivInfoArray.fromJson(v));
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

class GetAllBuyerDivInfoArray {
  String? buyerCode;
  String? buyDivCode;
  String? buyCode;
  String? divName;
  int? profitPercent;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  GetAllBuyerDivInfoArray(
      {this.buyerCode,
      this.buyDivCode,
      this.buyCode,
      this.divName,
      this.profitPercent,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  GetAllBuyerDivInfoArray.fromJson(Map<String, dynamic> json) {
    buyerCode = json['buyerCode'];
    buyDivCode = json['buyDivCode'];
    buyCode = json['buyCode'];
    divName = json['divName'];
    profitPercent = json['profitPercent'];
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
    data['buyerCode'] = buyerCode;
    data['buyDivCode'] = buyDivCode;
    data['buyCode'] = buyCode;
    data['divName'] = divName;
    data['profitPercent'] = profitPercent;
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
