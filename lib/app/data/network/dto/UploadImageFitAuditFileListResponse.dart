import 'dart:convert';

class UploadImageFitAuditFileListResponse {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  UploadImageFitAuditFileListResponse(
      {this.isSuccess, this.message, this.data});

  UploadImageFitAuditFileListResponse.fromJson(Map<String, dynamic> json) {
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
  String? filepath;
  String? filename;

  Data({this.filepath, this.filename});

  Data.fromJson(Map<String, dynamic> json) {
    filepath = json['filepath'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filepath'] = filepath;
    data['filename'] = filename;
    return data;
  }
}
