import 'dart:io';

class FileUploadModel {
  File? files;

  FileUploadModel({
    this.files,
  });

  FileUploadModel.fromJson(Map<String, dynamic> json) {
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['files'] = files;

    return data;
  }
}
