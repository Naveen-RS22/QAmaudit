import 'dart:convert';

class GetVisualAllDefectsModel {
  bool? isSuccess;
  String? message;
  List<GetVisualAllDefectsArray>? data;

  GetVisualAllDefectsModel({this.isSuccess, this.message, this.data});

  GetVisualAllDefectsModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetVisualAllDefectsArray>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetVisualAllDefectsArray.fromJson(v));
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

class GetVisualAllDefectsArray {
  int? id;
  String? defectLevel;
  String? defectCategory;
  String? defectCode;
  String? defectName;
  String? translation;
  String? displayName;
  String? indexNo;
  String? isFav;
  String? hostName;
  String? defectProfile;
  String? shtKey;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  GetVisualAllDefectsArray(
      {this.id,
      this.defectLevel,
      this.defectCategory,
      this.defectCode,
      this.defectName,
      this.translation,
      this.displayName,
      this.indexNo,
      this.isFav,
      this.hostName,
      this.defectProfile,
      this.shtKey,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  GetVisualAllDefectsArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    defectLevel = json['defectLevel'];
    defectCategory = json['defectCategory'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    translation = json['translation'];
    displayName = json['displayName'];
    indexNo = json['indexNo'];
    isFav = json['isFav'];
    hostName = json['hostName'];
    defectProfile = json['defectProfile'];
    shtKey = json['shtKey'];
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
    data['translation'] = translation;
    data['displayName'] = displayName;
    data['indexNo'] = indexNo;
    data['isFav'] = isFav;
    data['hostName'] = hostName;
    data['defectProfile'] = defectProfile;
    data['shtKey'] = shtKey;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
