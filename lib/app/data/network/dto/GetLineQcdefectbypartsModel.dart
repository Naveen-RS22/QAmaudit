import 'dart:convert';

class GetLineQcdefectbypartsModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetLineQcdefectbypartsModel({this.isSuccess, this.message, this.data});

  GetLineQcdefectbypartsModel.fromJson(Map<String, dynamic> json) {
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
  int? defectpcs;
  String? partCode;
  String? partName;

  Data({this.defectpcs, this.partCode, this.partName});

  Data.fromJson(Map<String, dynamic> json) {
    defectpcs = json['defectpcs'];
    partCode = json['partCode'];
    partName = json['partName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defectpcs'] = this.defectpcs;
    data['partCode'] = this.partCode;
    data['partName'] = this.partName;
    return data;
  }
}
