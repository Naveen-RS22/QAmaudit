import 'dart:convert';

class GetGalleryListResponseModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetGalleryListResponseModel({this.isSuccess, this.message, this.data});

  GetGalleryListResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? unitCode;
  String? audittype;
  int? orderNo;
  String? sewLine;
  String? sewLineName;
  String? buyerDiveCode;
  String? buyerDivName;
  String? partCode;
  String? partName;
  String? defectCode;
  String? defectName;
  String? filePath;
  String? fName;
  String? operationCode;
  String? operationName;
  String? auditorName;

  Data(
      {this.date,
      this.unitCode,
      this.audittype,
      this.orderNo,
      this.sewLine,
      this.sewLineName,
      this.buyerDiveCode,
      this.buyerDivName,
      this.partCode,
      this.partName,
      this.defectCode,
      this.defectName,
      this.filePath,
      this.fName,
      this.operationCode,
      this.operationName,
      this.auditorName});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    unitCode = json['unitCode'];
    audittype = json['audittype'];
    orderNo = json['orderNo'];
    sewLine = json['sewLine'];
    sewLineName = json['sewLineName'];
    buyerDiveCode = json['buyerDiveCode'];
    buyerDivName = json['buyerDivName'];
    partCode = json['partCode'];
    partName = json['partName'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    filePath = json['filePath'];
    fName = json['fName'];
    operationCode = json['operationCode'];
    operationName = json['operationName'];
    auditorName = json['auditorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['unitCode'] = unitCode;
    data['audittype'] = audittype;
    data['orderNo'] = orderNo;
    data['sewLine'] = sewLine;
    data['sewLineName'] = sewLineName;
    data['buyerDiveCode'] = buyerDiveCode;
    data['buyerDivName'] = buyerDivName;
    data['partCode'] = partCode;
    data['partName'] = partName;
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['filePath'] = filePath;
    data['fName'] = fName;
    data['operationCode'] = operationCode;
    data['operationName'] = operationName;
    data['auditorName'] = auditorName;
    return data;
  }
}
