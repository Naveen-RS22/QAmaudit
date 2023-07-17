import 'dart:convert';

class savecutInspectionResponseModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  savecutInspectionResponseModel({this.isSuccess, this.message, this.data});
  savecutInspectionResponseModel.fromJson(Map<String, dynamic> json) {
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
      data['data'] = data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? entityID;
  String? unitCode;
  String? transDate;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  String? color;
  String? fit;
  int? majorParts;
  int? marker;
  int? ncrPer;
  String? partcode;
  int? totalInsPanels;
  int? defectivePanels;
  String? active;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.entityID,
      this.unitCode,
      this.transDate,
      this.buyerCode,
      this.styleNo,
      this.orderNo,
      this.color,
      this.fit,
      this.majorParts,
      this.marker,
      this.ncrPer,
      this.partcode,
      this.totalInsPanels,
      this.defectivePanels,
      this.active,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityID = json['entityID'];
    unitCode = json['unitCode'];
    transDate = json['transDate'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    color = json['color'];
    fit = json['fit'];
    majorParts = json['majorParts'];
    marker = json['marker'];
    ncrPer = json['ncrPer'];
    partcode = json['partcode'];
    totalInsPanels = json['totalInsPanels'];
    defectivePanels = json['defectivePanels'];
    active = json['active'];
    hostName = json['hostName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entityID'] = entityID;
    data['unitCode'] = unitCode;
    data['transDate'] = transDate;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['color'] = color;
    data['fit'] = fit;
    data['majorParts'] = majorParts;
    data['marker'] = marker;
    data['ncrPer'] = ncrPer;
    data['partcode'] = partcode;
    data['totalInsPanels'] = totalInsPanels;
    data['defectivePanels'] = defectivePanels;
    data['active'] = active;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
