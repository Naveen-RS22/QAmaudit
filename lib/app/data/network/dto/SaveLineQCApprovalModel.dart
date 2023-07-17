class SaveLineQCApprovalModel {
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;
  int? id;
  String? unitCode;
  String? auditType;
  String? auditDate;
  String? sewLine;
  String? sessionCode;
  String? styleNo;
  int? orderNo;
  String? approverType;
  String? approver;
  String? userCode;
  String? approveDateTime;
  String? remarks;
  String? active;
  String? hostName;

  SaveLineQCApprovalModel(
      {this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive,
      this.id,
      this.unitCode,
      this.auditType,
      this.auditDate,
      this.sewLine,
      this.sessionCode,
      this.styleNo,
      this.orderNo,
      this.approverType,
      this.approver,
      this.userCode,
      this.approveDateTime,
      this.remarks,
      this.active,
      this.hostName});

  SaveLineQCApprovalModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    id = json['id'];
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    auditDate = json['auditDate'];
    sewLine = json['sewLine'];
    sessionCode = json['sessionCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    approverType = json['approverType'];
    approver = json['approver'];
    userCode = json['userCode'];
    approveDateTime = json['approveDateTime'];
    remarks = json['remarks'];
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
    data['auditDate'] = auditDate;
    data['sewLine'] = sewLine;
    data['sessionCode'] = sessionCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['approverType'] = approverType;
    data['approver'] = approver;
    data['userCode'] = userCode;
    data['approveDateTime'] = approveDateTime;
    data['remarks'] = remarks;
    data['active'] = active;
    data['hostName'] = hostName;
    return data;
  }
}
