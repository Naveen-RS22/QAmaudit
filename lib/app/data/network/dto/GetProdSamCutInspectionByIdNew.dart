import 'dart:convert';

class GetProdSamCutInspectionByIdNew {
  bool? isSuccess;
  String? message;
  Data? data;

  GetProdSamCutInspectionByIdNew({this.isSuccess, this.message, this.data});

  GetProdSamCutInspectionByIdNew.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data =
    json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? entityID;
  String? unitCode;
  String? transDate;
  String? buyerName;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  String? color;
  String? size;
  String? fit;
  int? majorParts;
  int? marker;
  int? ncrPer;
  String? partName;
  String? partcode;
  int? cutNo;
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
        this.buyerName,
        this.buyerCode,
        this.styleNo,
        this.orderNo,
        this.color,
        this.size,
        this.fit,
        this.majorParts,
        this.marker,
        this.ncrPer,
        this.partName,
        this.partcode,
        this.cutNo,
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
    buyerName = json['buyerName'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    color = json['color'];
    size = json['size'];
    fit = json['fit'];
    majorParts = json['majorParts'];
    marker = json['marker'];
    ncrPer = json['ncrPer'];
    partName = json['partName'];
    partcode = json['partcode'];
    cutNo = json['cutNo'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entityID'] = this.entityID;
    data['unitCode'] = this.unitCode;
    data['transDate'] = this.transDate;
    data['buyerName'] = this.buyerName;
    data['buyerCode'] = this.buyerCode;
    data['styleNo'] = this.styleNo;
    data['orderNo'] = this.orderNo;
    data['color'] = this.color;
    data['size'] = this.size;
    data['fit'] = this.fit;
    data['majorParts'] = this.majorParts;
    data['marker'] = this.marker;
    data['ncrPer'] = this.ncrPer;
    data['partName'] = this.partName;
    data['partcode'] = this.partcode;
    data['cutNo'] = this.cutNo;
    data['totalInsPanels'] = this.totalInsPanels;
    data['defectivePanels'] = this.defectivePanels;
    data['active'] = this.active;
    data['hostName'] = this.hostName;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    return data;
  }
}
