import 'dart:convert';

class AuditSummaryModel {
  bool? isSuccess;
  String? message;
  ResponseData? data;

  AuditSummaryModel({this.isSuccess, this.message, this.data});

  AuditSummaryModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null
        ? ResponseData.fromJson(jsonDecode(json['data']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResponseData {
  int? completed;
  int? pending;

  ResponseData({this.completed, this.pending});

  ResponseData.fromJson(Map<String, dynamic> json) {
    completed = json['completed'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed'] = this.completed;
    data['pending'] = this.pending;
    return data;
  }
}
