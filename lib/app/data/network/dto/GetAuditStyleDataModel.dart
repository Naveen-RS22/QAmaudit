import 'dart:convert';

class GetAuditStyleDataModel {
  bool? isSuccess;
  String? message;
  List<AuditStyleList>? data;

  GetAuditStyleDataModel({this.isSuccess, this.message, this.data});

  GetAuditStyleDataModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AuditStyleList>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(AuditStyleList.fromJson(v));
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

class AuditStyleList {
  int? schhdId;
  String? schDate;
  String? buycode;
  String? styleno;
  int? orderno;
  String? buyerpono;
  int? poOrderQty;
  int? orderQty;
  String? insType;
  String? aqltype;
  String? productType;
  List<Colorss>? color;

  AuditStyleList(
      {this.schhdId,
      this.schDate,
      this.buycode,
      this.styleno,
      this.orderno,
      this.buyerpono,
      this.poOrderQty,
      this.orderQty,
      this.insType,
      this.aqltype,
      this.productType,
      this.color});

  AuditStyleList.fromJson(Map<String, dynamic> json) {
    schhdId = json['schhdId'];
    schDate = json['schDate'];
    buycode = json['buycode'];
    styleno = json['styleno'];
    orderno = json['orderno'];
    buyerpono = json['buyerpono'];
    poOrderQty = json['poOrderQty'];
    orderQty = json['orderQty'];
    insType = json['insType'];
    aqltype = json['aqltype'];
    productType = json['productType'];

    if (json['color'] != null) {
      color = <Colorss>[];
      json['color'].forEach((v) {
        color!.add(Colorss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['schhdId'] = schhdId;
    data['schDate'] = schDate;
    data['buycode'] = buycode;
    data['styleno'] = styleno;
    data['orderno'] = orderno;
    data['buyerpono'] = buyerpono;
    data['poOrderQty'] = poOrderQty;
    data['orderQty'] = orderQty;
    data['insType'] = insType;
    data['aqltype'] = aqltype;
    data['productType'] = productType;
    if (color != null) {
      data['color'] = color!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colorss {
  String? color;
  String? buyerPoNo;

  Colorss({this.color, this.buyerPoNo});

  Colorss.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    buyerPoNo = json['buyerPoNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['buyerPoNo'] = buyerPoNo;
    return data;
  }
}
