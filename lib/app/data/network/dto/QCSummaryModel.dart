import 'dart:convert';

class QCSummaryModel {
  bool? isSuccess;
  String? message;
  List<QCSummaryData>? data;

  QCSummaryModel({this.isSuccess, this.message, this.data});

  QCSummaryModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <QCSummaryData>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(QCSummaryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QCSummaryData {
  String? unitCode;
  String? auditDate;
  String? auditType;
  String? checkerName;
  String? color;
  int? orderNo;
  String? sewLine;
  int? inspectedPcs;
  int? passedPcs;
  int? defectPcs;
  int? rejectedPcs;
  int? recheckedPcs;

  QCSummaryData(
      {this.unitCode,
      this.auditDate,
      this.auditType,
      this.checkerName,
      this.color,
      this.orderNo,
      this.sewLine,
      this.inspectedPcs,
      this.passedPcs,
      this.defectPcs,
      this.rejectedPcs,
      this.recheckedPcs});

  QCSummaryData.fromJson(Map<String, dynamic> json) {
    unitCode = json['unitCode'];
    auditDate = json['auditDate'];
    auditType = json['auditType'];
    checkerName = json['checkerName'];
    color = json['color'];
    orderNo = json['orderNo'];
    sewLine = json['sewLine'];
    inspectedPcs = json['inspectedPcs'];
    passedPcs = json['passedPcs'];
    defectPcs = json['defectPcs'];
    rejectedPcs = json['rejectedPcs'];
    recheckedPcs = json['recheckedPcs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitCode'] = this.unitCode;
    data['auditDate'] = this.auditDate;
    data['auditType'] = this.auditType;
    data['checkerName'] = this.checkerName;
    data['color'] = this.color;
    data['orderNo'] = this.orderNo;
    data['sewLine'] = this.sewLine;
    data['inspectedPcs'] = this.inspectedPcs;
    data['passedPcs'] = this.passedPcs;
    data['defectPcs'] = this.defectPcs;
    data['rejectedPcs'] = this.rejectedPcs;
    data['recheckedPcs'] = this.recheckedPcs;
    return data;
  }
}
