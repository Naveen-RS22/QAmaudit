import 'dart:convert';

class GetDsheadByParamModel {
  bool? isSuccess;
  String? message;
  List<GetDsheadByParamModelData>? data;

  GetDsheadByParamModel({this.isSuccess, this.message, this.data});

  GetDsheadByParamModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetDsheadByParamModelData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetDsheadByParamModelData.fromJson(v));
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

class GetDsheadByParamModelData {
  String? buyerDCPoNo;
  int? dcpoSlNo;
  int? buyDcPoQty;

  GetDsheadByParamModelData({this.buyerDCPoNo, this.dcpoSlNo, this.buyDcPoQty});

  GetDsheadByParamModelData.fromJson(Map<String, dynamic> json) {
    buyerDCPoNo = json['buyerDCPoNo'];
    dcpoSlNo = json['dcpoSlNo'];
    buyDcPoQty = json['buyDcPoQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['buyerDCPoNo'] = buyerDCPoNo;
    data['dcpoSlNo'] = dcpoSlNo;
    data['buyDcPoQty'] = buyDcPoQty;
    return data;
  }
}
