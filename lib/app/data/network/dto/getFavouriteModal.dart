import 'dart:convert';

class GetFavouriteModel {
  bool? isSuccess;
  String? message;
  List<FavDefect>? data;

  GetFavouriteModel({this.isSuccess, this.message, this.data});

  GetFavouriteModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavDefect>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(FavDefect.fromJson(v));
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

class FavDefect {
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
  String? active;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  FavDefect(
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
      this.active,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  FavDefect.fromJson(Map<String, dynamic> json) {
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
    data['active'] = active;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
