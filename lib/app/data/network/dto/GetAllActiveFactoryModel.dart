import 'dart:convert';

class GetAllActiveFactoryModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetAllActiveFactoryModel({this.isSuccess, this.message, this.data});

  GetAllActiveFactoryModel.fromJson(Map<String, dynamic> json) {
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
  String? uCode;
  String? uName;

  Data({this.uCode, this.uName});

  Data.fromJson(Map<String, dynamic> json) {
    uCode = json['uCode'];
    uName = json['uName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uCode'] = uCode;
    data['uName'] = uName;
    return data;
  }
}
