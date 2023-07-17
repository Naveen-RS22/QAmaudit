import 'dart:convert';

class GetAuidtDefectByCountModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetAuidtDefectByCountModel({this.isSuccess, this.message, this.data});

  GetAuidtDefectByCountModel.fromJson(Map<String, dynamic> json) {
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
  int? defectpcs;
  String? defectCode;
  String? defectName;

  Data({this.defectpcs, this.defectCode, this.defectName});

  Data.fromJson(Map<String, dynamic> json) {
    defectpcs = json['defectpcs'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defectpcs'] = defectpcs;
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    return data;
  }
}
