import 'dart:convert';

class GetAllTop3DefectResponseModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetAllTop3DefectResponseModel({this.isSuccess, this.message, this.data});

  GetAllTop3DefectResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? defectCode;
  String? defectName;
  int? defectCount;

  Data({this.defectCode, this.defectName, this.defectCount});

  Data.fromJson(Map<String, dynamic> json) {
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    defectCount = json['defectCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['defectCount'] = defectCount;
    return data;
  }
}
