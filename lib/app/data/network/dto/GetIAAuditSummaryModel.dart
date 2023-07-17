import 'dart:convert';

class GetIAAuditSummaryModel {
  bool? isSuccess;
  String? message;
  Data? data;

  GetIAAuditSummaryModel({this.isSuccess, this.message, this.data});

  GetIAAuditSummaryModel.fromJson(Map<String, dynamic> json) {
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
  int? completed;
  int? pending;

  Data({this.completed, this.pending});

  Data.fromJson(Map<String, dynamic> json) {
    completed = json['completed'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed'] = completed;
    data['pending'] = pending;
    return data;
  }
}
