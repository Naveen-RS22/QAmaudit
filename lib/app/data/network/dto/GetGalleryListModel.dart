class GetGalleryListModel {
  String? unitcode;
  String? audittype;
  String? instype;
  String? sewline;
  String? fromDate;
  String? toDate;
  String? buyerdivision;
  String? orderno;
  String? defectCode;

  GetGalleryListModel(
      {this.unitcode,
      this.audittype,
      this.sewline,
      this.fromDate,
      this.toDate,
      this.buyerdivision,
      this.orderno,
      this.defectCode});

  GetGalleryListModel.fromJson(Map<String, dynamic> json) {
    unitcode = json['unitcode'];
    audittype = json['audittype'];
    instype = json['instype'];
    sewline = json['sewline'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    buyerdivision = json['buyerdivision'];
    orderno = json['orderno'];
    defectCode = json['defectCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitcode'] = unitcode;
    data['audittype'] = audittype;
    data['instype'] = instype;
    data['sewline'] = sewline;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['buyerdivision'] = buyerdivision;
    data['orderno'] = orderno;
    data['defectCode'] = defectCode;
    return data;
  }
}

class InspectionModel {
  String? key;
  String? value;

  InspectionModel({
    this.key,
    this.value,
  });

  InspectionModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;

    return data;
  }
}
