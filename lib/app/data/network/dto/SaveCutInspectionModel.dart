class saveCutInspectionModel {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  String? entityID;
  String? unitCode;
  String? transDate;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  String? orderNoString;
  String? color;
  String? size;
  String? fit;
  int? majorParts;
  int? marker;
  int? ncrPer;
  String? partcode;
  int? cutNo;
  int? totalInsPanels;
  int? defectivePanels;
  String? active;
  String? hostName;

  saveCutInspectionModel(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.entityID,
      this.unitCode,
      this.transDate,
      this.buyerCode,
      this.styleNo,
      this.orderNo,
      this.orderNoString,
      this.color,
      this.size,
      this.fit,
      this.majorParts,
      this.marker,
      this.ncrPer,
      this.partcode,
      this.cutNo,
      this.totalInsPanels,
      this.defectivePanels,
      this.active,
      this.hostName});

  saveCutInspectionModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    entityID = json['entityID'];
    unitCode = json['unitCode'];
    transDate = json['transDate'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    orderNoString = json['orderNoString'];
    color = json['color'];
    size = json['size'];
    fit = json['fit'];
    majorParts = json['majorParts'];
    marker = json['marker'];
    ncrPer = json['ncrPer'];
    partcode = json['partcode'];
    cutNo = json['cutNo'];
    totalInsPanels = json['totalInsPanels'];
    defectivePanels = json['defectivePanels'];
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
    data['unitCode'] = unitCode;
    data['transDate'] = transDate;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['orderNoString'] = orderNoString;
    data['color'] = color;
    data['size'] = size;
    data['fit'] = fit;
    data['majorParts'] = majorParts;
    data['marker'] = marker;
    data['ncrPer'] = ncrPer;
    data['partcode'] = partcode;
    data['cutNo'] = cutNo;
    data['totalInsPanels'] = totalInsPanels;
    data['defectivePanels'] = defectivePanels;
    data['active'] = active;
    data['hostName'] = hostName;
    return data;
  }
}
