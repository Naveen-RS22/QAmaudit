import 'dart:convert';

class OperatorsChart {
  bool? isSuccess;
  String? message;
  Data? data;

  OperatorsChart({this.isSuccess, this.message, this.data});

  OperatorsChart.fromJson(Map<String, dynamic> json) {
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
  List<Operatorcnt>? operatorcnt;
  int? totalcount;
  int? totoperators;
  List<Defectper>? defectper;
  int? checkedpsc;

  Data(
      {this.operatorcnt,
      this.totalcount,
      this.totoperators,
      this.defectper,
      this.checkedpsc});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['operatorcnt'] != null) {
      operatorcnt = <Operatorcnt>[];
      json['operatorcnt'].forEach((v) {
        operatorcnt!.add(Operatorcnt.fromJson(v));
      });
    }
    totalcount = json['totalcount'];
    totoperators = json['totoperators'];

    if (json['defectper'] != null) {
      defectper = <Defectper>[];
      json['defectper'].forEach((v) {
        defectper!.add(Defectper.fromJson(v));
      });
    }
    checkedpsc = json['checkedpsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (operatorcnt != null) {
      data['operatorcnt'] = operatorcnt!.map((v) => v.toJson()).toList();
    }
    data['totalcount'] = totalcount;
    data['totoperators'] = totoperators;

    if (defectper != null) {
      data['defectper'] = defectper!.map((v) => v.toJson()).toList();
    }
    data['checkedpsc'] = checkedpsc;
    return data;
  }
}

class Operatorcnt {
  String? flgcolor;
  int? operCnt;

  Operatorcnt({this.flgcolor, this.operCnt});

  Operatorcnt.fromJson(Map<String, dynamic> json) {
    flgcolor = json['flgcolor'];
    operCnt = json['operCnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flgcolor'] = flgcolor;
    data['operCnt'] = operCnt;
    return data;
  }
}

class Defectper {
  String? unitcode;
  int? orderno;
  String? sewline;
  int? tagidcnt;

  Defectper({this.unitcode, this.orderno, this.sewline, this.tagidcnt});

  Defectper.fromJson(Map<String, dynamic> json) {
    unitcode = json['unitcode'];
    orderno = json['orderno'];
    sewline = json['sewline'];
    tagidcnt = json['tagidcnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitcode'] = unitcode;
    data['orderno'] = orderno;
    data['sewline'] = sewline;
    data['tagidcnt'] = tagidcnt;
    return data;
  }
}
