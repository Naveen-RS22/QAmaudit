import 'dart:convert';

class GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel {
  bool? isSuccess;
  String? message;
  List<GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModelData>? data;

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel(
      {this.isSuccess, this.message, this.data});

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel.fromJson(
      Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModelData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModelData
            .fromJson(v));
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

class GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModelData {
  int? lineQCHeadID;
  int? lineQCDetailID;
  int? tagDetailID;
  int? orderNo;
  String? auditDate;
  String? unitCode;
  String? auditType;
  String? defectCode;
  String? defectName;
  String? partCode;
  String? partName;
  String? operationCode;
  String? operationName;
  String? sessionCode;
  String? sessionName;
  String? sewLine;
  String? sewLineName;
  String? fromTime;
  String? toTime;
  int? inspectedPcs;
  String? garType;
  String? tagId;
  String? garSize;
  String? isClosed;

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModelData(
      {this.lineQCHeadID,
      this.lineQCDetailID,
      this.tagDetailID,
      this.orderNo,
      this.auditDate,
      this.unitCode,
      this.auditType,
      this.defectCode,
      this.defectName,
      this.partCode,
      this.partName,
      this.operationCode,
      this.operationName,
      this.sessionCode,
      this.sessionName,
      this.sewLine,
      this.sewLineName,
      this.fromTime,
      this.toTime,
      this.inspectedPcs,
      this.garType,
      this.tagId,
      this.garSize,
      this.isClosed});

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModelData.fromJson(
      Map<String, dynamic> json) {
    lineQCHeadID = json['lineQCHeadID'];
    lineQCDetailID = json['lineQCDetailID'];
    tagDetailID = json['tagDetailID'];
    orderNo = json['orderNo'];
    auditDate = json['auditDate'];
    unitCode = json['unitCode'];
    auditType = json['auditType'];
    defectCode = json['defectCode'];
    defectName = json['defectName'];
    partCode = json['partCode'];
    partName = json['partName'];
    operationCode = json['operationCode'];
    operationName = json['operationName'];
    sessionCode = json['sessionCode'];
    sessionName = json['sessionName'];
    sewLine = json['sewLine'];
    sewLineName = json['sewLineName'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    inspectedPcs = json['inspectedPcs'];
    garType = json['garType'];
    tagId = json['tagId'];
    garSize = json['garSize'];
    isClosed = json['isClosed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lineQCHeadID'] = lineQCHeadID;
    data['lineQCDetailID'] = lineQCDetailID;
    data['tagDetailID'] = tagDetailID;
    data['orderNo'] = orderNo;
    data['auditDate'] = auditDate;
    data['unitCode'] = unitCode;
    data['auditType'] = auditType;
    data['defectCode'] = defectCode;
    data['defectName'] = defectName;
    data['partCode'] = partCode;
    data['partName'] = partName;
    data['operationCode'] = operationCode;
    data['operationName'] = operationName;
    data['sessionCode'] = sessionCode;
    data['sessionName'] = sessionName;
    data['sewLine'] = sewLine;
    data['sewLineName'] = sewLineName;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    data['inspectedPcs'] = inspectedPcs;
    data['garType'] = garType;
    data['tagId'] = tagId;
    data['garSize'] = garSize;
    data['isClosed'] = isClosed;
    return data;
  }
}
