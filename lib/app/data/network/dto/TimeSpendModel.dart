import 'dart:convert';

class TimeSpentModel {
  bool? isSuccess;
  String? message;
  Data? data;

  TimeSpentModel({this.isSuccess, this.message, this.data});

  TimeSpentModel.fromJson(Map<String, dynamic> json) {
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
  int? totalMins;
  List<Timespentdetail>? timespentdetail;
  List<Defectpscdetail>? defectpscdetail;

  Data({this.totalMins, this.timespentdetail, this.defectpscdetail});

  Data.fromJson(Map<String, dynamic> json) {
    totalMins = json['totalMins'];
    if (json['timespentdetail'] != null) {
      timespentdetail = <Timespentdetail>[];
      json['timespentdetail'].forEach((v) {
        timespentdetail!.add(Timespentdetail.fromJson(v));
      });
    }
    if (json['defectpscdetail'] != null) {
      defectpscdetail = <Defectpscdetail>[];
      json['defectpscdetail'].forEach((v) {
        defectpscdetail!.add(Defectpscdetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMins'] = totalMins;
    if (timespentdetail != null) {
      data['timespentdetail'] =
          timespentdetail!.map((v) => v.toJson()).toList();
    }
    if (defectpscdetail != null) {
      data['defectpscdetail'] =
          defectpscdetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timespentdetail {
  int? totalMins;
  int? orderNo;
  String? styleNo;
  String? sewline;
  String? sewlineName;
  String? sessionName;
  String? unitCode;
  String? auditDate;
  String? auditorName;

  Timespentdetail(
      {this.totalMins,
      this.orderNo,
      this.styleNo,
      this.sewline,
      this.sewlineName,
      this.sessionName,
      this.unitCode,
      this.auditDate,
      this.auditorName});

  Timespentdetail.fromJson(Map<String, dynamic> json) {
    totalMins = json['totalMins'];
    orderNo = json['orderNo'];
    styleNo = json['styleNo'];
    sewline = json['sewline'];
    sewlineName = json['sewlineName'];
    sessionName = json['sessionName'];
    unitCode = json['unitCode'];
    auditDate = json['auditDate'];
    auditorName = json['auditorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMins'] = totalMins;
    data['orderNo'] = orderNo;
    data['styleNo'] = styleNo;
    data['sewline'] = sewline;
    data['sewlineName'] = sewlineName;
    data['sessionName'] = sessionName;
    data['unitCode'] = unitCode;
    data['auditDate'] = auditDate;
    data['auditorName'] = auditorName;
    return data;
  }
}

class Defectpscdetail {
  String? unitCode;
  String? auditDate;
  String? auditorName;
  int? checkps;
  int? defectpsc;
  int? passpcs;

  Defectpscdetail(
      {this.unitCode,
      this.auditDate,
      this.auditorName,
      this.checkps,
      this.defectpsc,
      this.passpcs});

  Defectpscdetail.fromJson(Map<String, dynamic> json) {
    unitCode = json['unitCode'];
    auditDate = json['auditDate'];
    auditorName = json['auditorName'];
    checkps = json['checkps'];
    defectpsc = json['defectpsc'];
    passpcs = json['passpcs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitCode'] = unitCode;
    data['auditDate'] = auditDate;
    data['auditorName'] = auditorName;
    data['checkps'] = checkps;
    data['defectpsc'] = defectpsc;
    data['passpcs'] = passpcs;
    return data;
  }
}

class Timespentdetail2 {
  int? totalMins;
  int? orderNo;
  String? styleNo;
  String? sewline;
  String? sessionName;
  String? unitCode;
  String? auditDate;
  String? auditorName;

  Timespentdetail2(
      {this.totalMins,
      this.orderNo,
      this.styleNo,
      this.sewline,
      this.sessionName,
      this.unitCode,
      this.auditDate,
      this.auditorName});

  Timespentdetail2.fromJson(Map<String, dynamic> json) {
    totalMins = json['totalMins'];
    orderNo = json['orderNo'];
    styleNo = json['styleNo'];
    sewline = json['sewline'];
    sessionName = json['sessionName'];
    unitCode = json['unitCode'];
    auditDate = json['auditDate'];
    auditorName = json['auditorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMins'] = totalMins;
    data['orderNo'] = orderNo;
    data['styleNo'] = styleNo;
    data['sewline'] = sewline;
    data['sessionName'] = sessionName;
    data['unitCode'] = unitCode;
    data['auditDate'] = auditDate;
    data['auditorName'] = auditorName;
    return data;
  }
}
