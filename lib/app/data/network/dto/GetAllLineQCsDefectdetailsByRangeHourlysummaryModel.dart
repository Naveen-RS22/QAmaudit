import 'dart:convert';

class GetAllLineQCsDefectdetailsByRangeHourlysummaryModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetAllLineQCsDefectdetailsByRangeHourlysummaryModel(
      {this.isSuccess, this.message, this.data});

  GetAllLineQCsDefectdetailsByRangeHourlysummaryModel.fromJson(
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
  String? unitCode;
  String? sessionCode;
  String? sessionName;
  String? fromTime;
  String? toTime;
  int? inspectedPcs;
  int? passedPcs;
  int? defectPcs;
  int? rejectedPcs;
  int? recheckedPcs;

  Data(
      {this.unitCode,
      this.sessionCode,
      this.sessionName,
      this.fromTime,
      this.toTime,
      this.inspectedPcs,
      this.passedPcs,
      this.defectPcs,
      this.rejectedPcs,
      this.recheckedPcs});

  Data.fromJson(Map<String, dynamic> json) {
    unitCode = json['unitCode'];
    sessionCode = json['sessionCode'];
    sessionName = json['sessionName'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    inspectedPcs = json['inspectedPcs'];
    passedPcs = json['passedPcs'];
    defectPcs = json['defectPcs'];
    rejectedPcs = json['rejectedPcs'];
    recheckedPcs = json['recheckedPcs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitCode'] = unitCode;
    data['sessionCode'] = sessionCode;
    data['sessionName'] = sessionName;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    data['inspectedPcs'] = inspectedPcs;
    data['passedPcs'] = passedPcs;
    data['defectPcs'] = defectPcs;
    data['rejectedPcs'] = rejectedPcs;
    data['recheckedPcs'] = recheckedPcs;
    return data;
  }
}
