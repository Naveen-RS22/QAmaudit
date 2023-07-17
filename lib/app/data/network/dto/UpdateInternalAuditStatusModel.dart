import 'dart:convert';

class UpdateInternalAuditStatusModel {
  bool? isSuccess;
  String? message;

  UpdateInternalAuditStatusModel({
    this.isSuccess,
    this.message,
  });

  UpdateInternalAuditStatusModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;

    return data;
  }
}
