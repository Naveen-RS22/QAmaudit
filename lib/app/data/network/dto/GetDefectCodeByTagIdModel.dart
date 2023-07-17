import 'dart:convert';

class GetDefectCodeByTagIdModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetDefectCodeByTagIdModel({this.isSuccess, this.message, this.data});

  GetDefectCodeByTagIdModel.fromJson(Map<String, dynamic> json) {
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
  String? defectCode;

  Data({this.defectCode});

  Data.fromJson(Map<String, dynamic> json) {
    defectCode = json['defectCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defectCode'] = this.defectCode;
    return data;
  }
}
