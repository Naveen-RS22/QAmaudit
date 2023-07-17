import 'dart:convert';

class DefectPartModel {
  bool? isSuccess;
  String? message;
  List<defectData>? data;

  DefectPartModel({this.isSuccess, this.message, this.data});
  DefectPartModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];

    if (json['data'] != null) {
      data = <defectData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(defectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}

class defectData {
  int? cnt;
  String? partName;
  String? partIndex;

  defectData({this.cnt, this.partName, this.partIndex});

  defectData.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    partName = json['partName'];
    partIndex = json['partIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cnt'] = this.cnt;
    data['partName'] = this.partName;
    data['partIndex'] = this.partIndex;
    return data;
  }
}
