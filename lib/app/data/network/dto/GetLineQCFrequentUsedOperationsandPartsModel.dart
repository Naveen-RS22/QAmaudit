import 'dart:convert';

class GetLineQCFrequentUsedOperationsandPartsModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetLineQCFrequentUsedOperationsandPartsModel(
      {this.isSuccess, this.message, this.data});

  GetLineQCFrequentUsedOperationsandPartsModel.fromJson(
      Map<String, dynamic> json) {
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
  String? unitCode;
  String? auditType;
  String? partCode;
  String? partName;
  String? operationCode;
  String? operationName;
  String? checkerName;
  int? defectPcs;
  int? orderNo;
  int? partId;

  Data({
    this.unitCode,
    this.auditType,
    this.partCode,
    this.partName,
    this.operationCode,
    this.operationName,
    this.checkerName,
    this.defectPcs,
    this.orderNo,
    this.partId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    partCode = json['partCode'];
    partName = json['partName'];
    operationCode = json['operationCode'];
    operationName = json['operationName'];
    checkerName = json['checkerName'];
    defectPcs = json['defectPcs'];
    orderNo = json['orderNo'];
    partId = json['partId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitCode'] = unitCode;
    data['auditType'] = auditType;
    data['partCode'] = partCode;
    data['partName'] = partName;
    data['operationCode'] = operationCode;
    data['operationName'] = operationName;
    data['checkerName'] = checkerName;
    data['defectPcs'] = defectPcs;
    data['orderNo'] = orderNo;
    data['partId'] = partId;

    return data;
  }
}
