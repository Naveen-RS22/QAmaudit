import 'dart:convert';

class GetOrderRegWithbuyerModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetOrderRegWithbuyerModel({this.isSuccess, this.message, this.data});

  GetOrderRegWithbuyerModel.fromJson(Map<String, dynamic> json) {
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
  String? styleNo;
  int? orderno;

  Data({this.styleNo, this.orderno});

  Data.fromJson(Map<String, dynamic> json) {
    styleNo = json['styleNo'];
    orderno = json['orderno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['styleNo'] = this.styleNo;
    data['orderno'] = this.orderno;
    return data;
  }
}
