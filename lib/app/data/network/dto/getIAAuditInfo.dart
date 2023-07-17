import 'dart:convert';

class GetIAAuditInfo {
  bool? isSuccess;
  String? message;
  Data? data;

  GetIAAuditInfo({this.isSuccess, this.message, this.data});

  GetIAAuditInfo.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data =
        json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? passCnt;
  int? failCnt;
  int? totalCnt;
  List<SessionDetl>? sessionDetl;

  Data({this.passCnt, this.failCnt, this.totalCnt, this.sessionDetl});

  Data.fromJson(Map<String, dynamic> json) {
    passCnt = json['passCnt'];
    failCnt = json['failCnt'];
    totalCnt = json['totalCnt'];
    if (json['sessionDetl'] != null) {
      sessionDetl = <SessionDetl>[];
      json['sessionDetl'].forEach((v) {
        sessionDetl!.add(SessionDetl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['passCnt'] = passCnt;
    data['failCnt'] = failCnt;
    data['totalCnt'] = totalCnt;
    if (sessionDetl != null) {
      data['sessionDetl'] = sessionDetl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SessionDetl {
  int? timeMins;
  String? sewline;
  String? unitCode;
  String? auditDate;
  String? auditorName;

  SessionDetl(
      {this.timeMins,
      this.sewline,
      this.unitCode,
      this.auditDate,
      this.auditorName});

  SessionDetl.fromJson(Map<String, dynamic> json) {
    timeMins = json['timeMins'];
    sewline = json['sewline'];
    unitCode = json['unitCode'];
    auditDate = json['auditDate'];
    auditorName = json['auditorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeMins'] = timeMins;
    data['sewline'] = sewline;
    data['unitCode'] = unitCode;
    data['auditDate'] = auditDate;
    data['auditorName'] = auditorName;
    return data;
  }
}
