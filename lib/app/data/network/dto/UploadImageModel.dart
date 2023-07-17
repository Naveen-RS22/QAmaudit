class UploadImageModel {
  List<UploadBase64Datacollection>? uploadBase64Datacollection;

  UploadImageModel({this.uploadBase64Datacollection});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    if (json['uploadBase64Datacollection'] != null) {
      uploadBase64Datacollection = <UploadBase64Datacollection>[];
      json['uploadBase64Datacollection'].forEach((v) {
        uploadBase64Datacollection!.add(UploadBase64Datacollection.fromJson(v));
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

class UploadBase64Datacollection {
  String? packAttach;
  String? fName;
  String? factoryCode;
  String? auditType;
  String? insType;
  String? defectName;

  UploadBase64Datacollection(
      {this.packAttach,
      this.fName,
      this.factoryCode,
      this.auditType,
      this.insType,
      this.defectName});

  UploadBase64Datacollection.fromJson(Map<String, dynamic> json) {
    packAttach = json['packAttach'];
    fName = json['fName'];
    factoryCode = json['factoryCode'];
    auditType = json['auditType'];
    insType = json['insType'];
    defectName = json['defectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packAttach'] = packAttach;
    data['fName'] = fName;
    data['factoryCode'] = factoryCode;
    data['auditType'] = auditType;
    data['insType'] = insType;
    data['defectName'] = defectName;
    return data;
  }
}
