import 'dart:convert';

class GetAllDefectMasterModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetAllDefectMasterModel({this.isSuccess, this.message, this.data});

  GetAllDefectMasterModel.fromJson(Map<String, dynamic> json) {
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? defectLevel;
  String? defectCategory;
  String? defectCode;
  String? defectName;
  String? displayName;
  String? indexNo;
  String? isFav;
  String? hostName;
  String? defectProfile;
  String? shtKey;
  String? garmentType;
  String? fName;
  String? filePath;
  String? packAttach;
  String? active;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Data(
      {this.id,
      this.defectLevel,
      this.defectCategory,
      this.defectCode,
      this.defectName,
      this.displayName,
      this.indexNo,
      this.isFav,
      this.hostName,
      this.defectProfile,
      this.shtKey,
      this.garmentType,
      this.fName,
      this.filePath,
      this.packAttach,
      this.active,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    defectLevel = json['defectLevel'];
    defectCategory = json['defectCategory'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    displayName = json['displayName'];
    indexNo = json['indexNo'];
    isFav = json['isFav'];
    hostName = json['hostName'];
    defectProfile = json['defectProfile'];
    shtKey = json['shtKey'];
    garmentType = json['garmentType'];
    fName = json['fName'];
    filePath = json['filePath'];
    packAttach = json['packAttach'];
    active = json['active'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['defectLevel'] = defectLevel;
    data['defectCategory'] = defectCategory;
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['displayName'] = displayName;
    data['indexNo'] = indexNo;
    data['isFav'] = isFav;
    data['hostName'] = hostName;
    data['defectProfile'] = defectProfile;
    data['shtKey'] = shtKey;
    data['garmentType'] = garmentType;
    data['fName'] = fName;
    data['filePath'] = filePath;
    data['packAttach'] = packAttach;
    data['active'] = active;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
