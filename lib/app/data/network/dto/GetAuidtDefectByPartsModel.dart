import 'dart:convert';

class GetAuidtDefectByPartsModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetAuidtDefectByPartsModel({this.isSuccess, this.message, this.data});

  GetAuidtDefectByPartsModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defectpcs'] = defectpcs;
    data['partCode'] = partCode;
    data['partName'] = partName;
    return data;
  }
}
