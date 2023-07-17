import 'dart:convert';

class GetDefectsCntModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetDefectsCntModel({this.isSuccess, this.message, this.data});

  GetDefectsCntModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? defectcnt;
  String? defectCode;
  String? defectName;

  Data({this.defectcnt, this.defectCode, this.defectName});

  Data.fromJson(Map<String, dynamic> json) {
    defectcnt = json['defectcnt'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defectcnt'] = defectcnt;
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    return data;
  }
}
