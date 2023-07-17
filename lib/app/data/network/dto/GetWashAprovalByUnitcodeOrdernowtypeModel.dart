import 'dart:convert';

class GetWashAprovalByUnitcodeOrdernowtypeModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetWashAprovalByUnitcodeOrdernowtypeModel(
      {this.isSuccess, this.message, this.data});

  GetWashAprovalByUnitcodeOrdernowtypeModel.fromJson(
      Map<String, dynamic> json) {
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
  String? entityID;
  String? buyerCode;
  String? styleNo;
  int? orderNo;
  String? unitCode;
  String? wType;
  String? spec;
  String? construction;
  String? marking;
  String? stickering;
  String? pressStandard;

  String? trims;
  String? grain;
  String? embellishment;
  String? csv;
  String? specRemarks;
  String? constructionRemarks;
  String? markingRemarks;
  String? stickeringRemarks;
  String? pressStandardRemarks;
  String? trimsRemarks;
  String? grainRemarks;
  String? embellishmentRemarks;
  String? csVRemarks;
  String? handfeel;
  String? pilling;
  String? nicking;
  String? color;
  String? handfeelRemarks;
  String? pillingRemarks;
  String? nickingRemarks;
  String? colorRemarks;
  String? active;
  String? hostName;
  List<WashAprlImagesModels>? washAprlImagesModels;
  List<AfterPressImagesModels>? afterPressImagesModels;
  String? createdDate;
  String? createdBy;

  bool? isActive;
  String? samStatus;
  String? aprlRemarks;
  Data({
    this.id,
    this.entityID,
    this.buyerCode,
    this.styleNo,
    this.orderNo,
    this.unitCode,
    this.wType,
    this.spec,
    this.construction,
    this.marking,
    this.stickering,
    this.pressStandard,
    this.trims,
    this.grain,
    this.embellishment,
    this.csv,
    this.specRemarks,
    this.constructionRemarks,
    this.markingRemarks,
    this.stickeringRemarks,
    this.pressStandardRemarks,
    this.trimsRemarks,
    this.grainRemarks,
    this.embellishmentRemarks,
    this.csVRemarks,
    this.handfeel,
    this.pilling,
    this.nicking,
    this.color,
    this.handfeelRemarks,
    this.pillingRemarks,
    this.nickingRemarks,
    this.colorRemarks,
    this.active,
    this.hostName,
    this.washAprlImagesModels,
    this.afterPressImagesModels,
    this.createdDate,
    this.createdBy,
    this.isActive,
    this.samStatus,
    this.aprlRemarks,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityID = json['entityID'];
    buyerCode = json['buyerCode'];
    styleNo = json['styleNo'];
    orderNo = json['orderNo'];
    unitCode = json['unitCode'];
    wType = json['wType'];
    spec = json['spec'];
    construction = json['construction'];

    marking = json['marking'];
    stickering = json['stickering'];
    pressStandard = json['pressStandard'];
    trims = json['trims'];
    grain = json['grain'];
    embellishment = json['embellishment'];
    csv = json['csv'];
    specRemarks = json['spec_Remarks'];
    constructionRemarks = json['construction_Remarks'];
    markingRemarks = json['marking_Remarks'];
    stickeringRemarks = json['stickering_Remarks'];
    pressStandardRemarks = json['pressStandard_Remarks'];
    trimsRemarks = json['trims_Remarks'];
    grainRemarks = json['grain_Remarks'];
    embellishmentRemarks = json['embellishment_Remarks'];
    csVRemarks = json['csV_Remarks'];
    handfeel = json['handfeel'];
    pilling = json['pilling'];
    nicking = json['nicking'];
    color = json['color'];
    handfeelRemarks = json['handfeel_Remarks'];
    pillingRemarks = json['pilling_Remarks'];
    nickingRemarks = json['nicking_Remarks'];
    colorRemarks = json['color_Remarks'];
    active = json['active'];
    hostName = json['hostName'];
    if (json['washAprlImagesModels'] != null) {
      washAprlImagesModels = <WashAprlImagesModels>[];
      json['washAprlImagesModels'].forEach((v) {
        washAprlImagesModels!.add(WashAprlImagesModels.fromJson(v));
      });
    }
    if (json['afterPressImagesModels'] != null) {
      afterPressImagesModels = <AfterPressImagesModels>[];
      json['afterPressImagesModels'].forEach((v) {
        afterPressImagesModels!.add(AfterPressImagesModels.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    isActive = json['isActive'];
    samStatus = json['samStatus'];
    aprlRemarks = json['aprlRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entityID'] = entityID;
    data['buyerCode'] = buyerCode;
    data['styleNo'] = styleNo;
    data['orderNo'] = orderNo;
    data['unitCode'] = unitCode;
    data['wType'] = wType;
    data['spec'] = spec;
    data['construction'] = construction;
    data['marking'] = marking;
    data['stickering'] = stickering;
    data['pressStandard'] = pressStandard;
    data['trims'] = trims;
    data['grain'] = grain;
    data['embellishment'] = embellishment;
    data['csv'] = csv;
    data['spec_Remarks'] = specRemarks;
    data['construction_Remarks'] = constructionRemarks;
    data['marking_Remarks'] = markingRemarks;
    data['stickering_Remarks'] = stickeringRemarks;
    data['pressStandard_Remarks'] = pressStandardRemarks;
    data['trims_Remarks'] = trimsRemarks;
    data['grain_Remarks'] = grainRemarks;
    data['embellishment_Remarks'] = embellishmentRemarks;
    data['csV_Remarks'] = csVRemarks;
    data['handfeel'] = handfeel;
    data['pilling'] = pilling;
    data['nicking'] = nicking;
    data['color'] = color;
    data['handfeel_Remarks'] = handfeelRemarks;
    data['pilling_Remarks'] = pillingRemarks;
    data['nicking_Remarks'] = nickingRemarks;
    data['color_Remarks'] = colorRemarks;
    data['active'] = active;
    data['hostName'] = hostName;
    if (washAprlImagesModels != null) {
      data['washAprlImagesModels'] =
          washAprlImagesModels!.map((v) => v.toJson()).toList();
    }

    if (afterPressImagesModels != null) {
      data['afterPressImagesModels'] =
          afterPressImagesModels!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;

    data['isActive'] = isActive;
    data['samStatus'] = samStatus;
    data['aprlRemarks'] = aprlRemarks;
    return data;
  }
}

class WashAprlImagesModels {
  int? id;
  int? wAprlID;
  String? wType;
  String? descType;
  String? fName;
  String? filePath;
  String? packAttach;
  String? hostName;
  String? createdDate;
  String? createdBy;

  bool? isActive;

  WashAprlImagesModels(
      {this.id,
      this.wAprlID,
      this.wType,
      this.descType,
      this.fName,
      this.filePath,
      this.packAttach,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.isActive});

  WashAprlImagesModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wAprlID = json['wAprl_ID'];
    wType = json['wType'];
    descType = json['descType'];
    fName = json['fName'];
    filePath = json['filePath'];
    packAttach = json['packAttach'];
    hostName = json['hostName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];

    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wAprl_ID'] = wAprlID;
    data['wType'] = wType;
    data['descType'] = descType;
    data['fName'] = fName;
    data['filePath'] = filePath;
    data['packAttach'] = packAttach;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;

    data['isActive'] = isActive;
    return data;
  }
}

class AfterPressImagesModels {
  int? id;
  int? afPID;
  String? wType;
  String? descType;
  String? fName;
  String? filePath;
  String? packAttach;
  String? hostName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  AfterPressImagesModels(
      {this.id,
      this.afPID,
      this.wType,
      this.descType,
      this.fName,
      this.filePath,
      this.packAttach,
      this.hostName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  AfterPressImagesModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    afPID = json['afP_ID'];
    wType = json['wType'];
    descType = json['descType'];
    fName = json['fName'];
    filePath = json['filePath'];
    packAttach = json['packAttach'];
    hostName = json['hostName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['afP_ID'] = afPID;
    data['wType'] = wType;
    data['descType'] = descType;
    data['fName'] = fName;
    data['filePath'] = filePath;
    data['packAttach'] = packAttach;
    data['hostName'] = hostName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}
