import 'dart:convert';

class GetLineQcdefectCountEntrypartModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetLineQcdefectCountEntrypartModel({this.isSuccess, this.message, this.data});

  GetLineQcdefectCountEntrypartModel.fromJson(Map<String, dynamic> json) {
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
  int? defectPcs;
  int? inspectPcs;
  String? defectPercent;
  String? defectCode;
  String? defectName;

  Data(
      {this.defectPcs,
      this.inspectPcs,
      this.defectPercent,
      this.defectCode,
      this.defectName});

  Data.fromJson(Map<String, dynamic> json) {
    defectPcs = json['defectPcs'];
    inspectPcs = json['inspectPcs'];
    defectPercent = json['defectPercent'].toString();
    defectCode = json['defectCode'];
    defectName = json['defectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defectPcs'] = this.defectPcs;
    data['inspectPcs'] = this.inspectPcs;
    data['defectPercent'] = this.defectPercent;
    data['defectCode'] = this.defectCode;
    data['defectName'] = this.defectName;
    return data;
  }
}
