class UploadImageFitAuditFileListRequest {
  List<UploadBase64DatacollectionFitAudit>? uploadBase64Datacollection;

  UploadImageFitAuditFileListRequest({this.uploadBase64Datacollection});

  UploadImageFitAuditFileListRequest.fromJson(Map<String, dynamic> json) {
    if (json['uploadBase64Datacollection'] != null) {
      uploadBase64Datacollection = <UploadBase64DatacollectionFitAudit>[];
      json['uploadBase64Datacollection'].forEach((v) {
        uploadBase64Datacollection!
            .add(UploadBase64DatacollectionFitAudit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uploadBase64Datacollection != null) {
      data['uploadBase64Datacollection'] =
          uploadBase64Datacollection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UploadBase64DatacollectionFitAudit {
  String? packAttach;
  String? fName;
  String? factoryCode;
  String? auditType;
  String? insType;
  String? defectName;
  String? sewLine;
  String? round;

  UploadBase64DatacollectionFitAudit(
      {this.packAttach,
      this.fName,
      this.factoryCode,
      this.auditType,
      this.insType,
      this.defectName,
      this.sewLine,
      this.round});

  UploadBase64DatacollectionFitAudit.fromJson(Map<String, dynamic> json) {
    packAttach = json['packAttach'];
    fName = json['fName'];
    factoryCode = json['factoryCode'];
    auditType = json['auditType'];
    insType = json['insType'];
    defectName = json['defectName'];
    sewLine = json['sewLine'];
    round = json['round'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packAttach'] = packAttach;
    data['fName'] = fName;
    data['factoryCode'] = factoryCode;
    data['auditType'] = auditType;
    data['insType'] = insType;
    data['defectName'] = defectName;
    data['sewLine'] = sewLine;
    data['round'] = round;
    return data;
  }
}
