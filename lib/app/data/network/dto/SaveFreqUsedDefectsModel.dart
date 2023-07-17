class SaveFreqUsedDefectsModel {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  String? unitCode;
  String? auditType;
  String? userName;
  String? defectCode;
  String? ChkType;
  String? active;
  String? hostName;

  SaveFreqUsedDefectsModel(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.unitCode,
      this.auditType,
      this.userName,
      this.defectCode,
      this.ChkType,
      this.active,
      this.hostName});

  SaveFreqUsedDefectsModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    userName = json['userName'];
    defectCode = json['defectCode'];
    ChkType = json['ChkType'];
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
    data['unitCode'] = unitCode;
    data['auditType'] = auditType;
    data['userName'] = userName;
    data['defectCode'] = defectCode;
    data['ChkType'] = ChkType;
    data['active'] = active;
    data['hostName'] = hostName;
    return data;
  }
}
