import 'dart:convert';

class RemoveDefectsByIDModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  RemoveDefectsByIDModel({this.isSuccess, this.message, this.data});

  RemoveDefectsByIDModel.fromJson(Map<String, dynamic> json) {
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
  bool? tagremoved;
  bool? defectremoved;

  Data({this.tagremoved, this.defectremoved});

  Data.fromJson(Map<String, dynamic> json) {
    tagremoved = json['tagremoved'];
    defectremoved = json['defectremoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tagremoved'] = tagremoved;
    data['defectremoved'] = defectremoved;
    return data;
  }
}
