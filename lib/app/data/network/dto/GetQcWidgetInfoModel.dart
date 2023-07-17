import 'dart:convert';

class GetQcWidgetInfoModel {
  bool? isSuccess;
  String? message;
  Data? data;

  GetQcWidgetInfoModel({this.isSuccess, this.message, this.data});

  GetQcWidgetInfoModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data =
        json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<InspectedInfo>? inspectedInfo;

  Data({this.inspectedInfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['inspectedInfo'] != null) {
      inspectedInfo = <InspectedInfo>[];
      json['inspectedInfo'].forEach((v) {
        inspectedInfo!.add(InspectedInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (inspectedInfo != null) {
      data['inspectedInfo'] = inspectedInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InspectedInfo {
  String? unitCode;
  String? auditDate;
  String? auditType;
  String? checkerName;
  int? inspectedPcs;
  int? currentInspectedPcs;
  int? prevInspectedPcs;
  int? passedPcs;
  int? currentPassedPcs;
  int? prevPassedPcs;
  int? defectedPcs;
  int? currentDefectedPcs;
  int? prevDefectedPcs;

  InspectedInfo(
      {this.unitCode,
      this.auditDate,
      this.auditType,
      this.checkerName,
      this.inspectedPcs,
      this.currentInspectedPcs,
      this.prevInspectedPcs,
      this.passedPcs,
      this.currentPassedPcs,
      this.prevPassedPcs,
      this.defectedPcs,
      this.currentDefectedPcs,
      this.prevDefectedPcs});

  InspectedInfo.fromJson(Map<String, dynamic> json) {
    unitCode = json['unitCode'];
    auditDate = json['auditDate'];
    auditType = json['auditType'];
    checkerName = json['checkerName'];
    inspectedPcs = json['inspectedPcs'];
    currentInspectedPcs = json['currentInspectedPcs'];
    prevInspectedPcs = json['prevInspectedPcs'];
    passedPcs = json['passedPcs'];
    currentPassedPcs = json['currentPassedPcs'];
    prevPassedPcs = json['prevPassedPcs'];
    defectedPcs = json['defectedPcs'];
    currentDefectedPcs = json['currentDefectedPcs'];
    prevDefectedPcs = json['prevDefectedPcs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitCode'] = unitCode;
    data['auditDate'] = auditDate;
    data['auditType'] = auditType;
    data['checkerName'] = checkerName;
    data['inspectedPcs'] = inspectedPcs;
    data['currentInspectedPcs'] = currentInspectedPcs;
    data['prevInspectedPcs'] = prevInspectedPcs;
    data['passedPcs'] = passedPcs;
    data['currentPassedPcs'] = currentPassedPcs;
    data['prevPassedPcs'] = prevPassedPcs;
    data['defectedPcs'] = defectedPcs;
    data['currentDefectedPcs'] = currentDefectedPcs;
    data['prevDefectedPcs'] = prevDefectedPcs;
    return data;
  }
}
