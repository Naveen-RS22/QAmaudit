class SaveProdSamAprl {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  String? entityID;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  String? unitCode;
  String? samStatus;
  String? aprlRemarks;
  String? active;
  String? hostName;

  SaveProdSamAprl(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.entityID,
      this.buyerCode,
      this.styleNo,
      this.orderNo,
      this.unitCode,
      this.samStatus,
      this.aprlRemarks,
      this.active,
      this.hostName});

  SaveProdSamAprl.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    entityID = json['entityID'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    unitCode = json['unitCode'];
    samStatus = json['samStatus'];
    aprlRemarks = json['aprlRemarks'];
    active = json['active'];
    hostName = json['hostName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    data['id'] = id;
    data['entityID'] = entityID;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['unitCode'] = unitCode;
    data['samStatus'] = samStatus;
    data['aprlRemarks'] = aprlRemarks;
    data['active'] = active;
    data['hostName'] = hostName;
    return data;
  }
}
