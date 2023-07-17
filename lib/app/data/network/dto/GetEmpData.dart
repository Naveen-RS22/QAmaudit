import 'dart:convert';

class GetEmpDataModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetEmpDataModel({this.isSuccess, this.message, this.data});

  GetEmpDataModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? unitcode;
  String? empcode;
  String? empname;
  String? line;
  String? deptcode;
  String? emptype;
  String? desig;
  String? desigName;

  Data(
      {this.id,
      this.unitcode,
      this.empcode,
      this.empname,
      this.line,
      this.deptcode,
      this.emptype,
      this.desig,
      this.desigName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitcode = json['unitcode'];
    empcode = json['empcode'];
    empname = json['empname'];
    line = json['line'];
    deptcode = json['deptcode'];
    emptype = json['emptype'];
    desig = json['desig'];
    desigName = json['desigName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unitcode'] = this.unitcode;
    data['empcode'] = this.empcode;
    data['empname'] = this.empname;
    data['line'] = this.line;
    data['deptcode'] = this.deptcode;
    data['emptype'] = this.emptype;
    data['desig'] = this.desig;
    data['desigName'] = this.desigName;
    return data;
  }
}
