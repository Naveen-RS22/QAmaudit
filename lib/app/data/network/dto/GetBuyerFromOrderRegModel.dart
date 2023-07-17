import 'dart:convert';

class GetBuyerFromOrderRegModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetBuyerFromOrderRegModel({this.isSuccess, this.message, this.data});

  GetBuyerFromOrderRegModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? buyDivCode;

  Data({this.buyDivCode});

  Data.fromJson(Map<String, dynamic> json) {
    buyDivCode = json['buyDivCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyDivCode'] = this.buyDivCode;
    return data;
  }
}
