import 'dart:convert';

class GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel {
  bool? isSuccess;
  String? message;
  List<GetAllLineQCsDefectdetailsByRangeHourlyDefectsModelData>? data;

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel(
      {this.isSuccess, this.message, this.data});

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel.fromJson(
      Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllLineQCsDefectdetailsByRangeHourlyDefectsModelData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(
            GetAllLineQCsDefectdetailsByRangeHourlyDefectsModelData.fromJson(
                v));
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

class GetAllLineQCsDefectdetailsByRangeHourlyDefectsModelData {
  String? defectCode;
  String? defectName;
  int? defectCount;
  int? defectsplitCount;
  int? rejectsplitCount;
  String? defectPercent;
  String? defectDHUPercent;
  int? totalInspectedPcs;
  int? totalRecheckededPcs;

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsModelData(
      {this.defectCode,
      this.defectName,
      this.defectCount,
      this.defectsplitCount,
      this.rejectsplitCount,
      this.defectPercent,
      this.defectDHUPercent,
      this.totalInspectedPcs,
      this.totalRecheckededPcs});

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsModelData.fromJson(
      Map<String, dynamic> json) {
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    defectCount = json['defectCount'];
    defectsplitCount = json['defectsplitCount'];
    rejectsplitCount = json['rejectsplitCount'];
    defectPercent = json['defectPercent'];
    defectDHUPercent = json['defectDHUPercent'];
    totalInspectedPcs = json['totalInspectedPcs'];
    totalRecheckededPcs = json['totalRecheckededPcs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['defectCount'] = defectCount;
    data['defectsplitCount'] = defectsplitCount;
    data['rejectsplitCount'] = rejectsplitCount;
    data['defectPercent'] = defectPercent;
    data['defectDHUPercent'] = defectDHUPercent;
    data['totalInspectedPcs'] = totalInspectedPcs;
    data['totalRecheckededPcs'] = totalRecheckededPcs;
    return data;
  }
}
