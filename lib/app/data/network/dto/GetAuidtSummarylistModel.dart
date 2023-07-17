import 'dart:convert';

class GetAuidtSummarylistModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetAuidtSummarylistModel({this.isSuccess, this.message, this.data});

  GetAuidtSummarylistModel.fromJson(Map<String, dynamic> json) {
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
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  int? poQty;
  int? defectpcs;
  String? finalResult;

  Data(
      {this.buyerCode,
      this.styleNo,
      this.orderNo,
      this.poQty,
      this.defectpcs,
      this.finalResult});

  Data.fromJson(Map<String, dynamic> json) {
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    poQty = json['poQty'];
    defectpcs = json['defectpcs'];
    finalResult = json['finalResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['poQty'] = poQty;
    data['defectpcs'] = defectpcs;
    data['finalResult'] = finalResult;
    return data;
  }
}
