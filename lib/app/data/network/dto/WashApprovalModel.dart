import 'dart:io';

class WashApprovalArray {
  String? wType;
  String? title;
  String? statusValue;
  String? remarkValue;
  String? status;
  String? image;
  String? remark;
  File? file;
  bool? isSelected;

  WashApprovalArray({
    this.wType,
    this.title,
    this.statusValue,
    this.remarkValue,
    this.status,
    this.image,
    this.remark,
    this.file,
    this.isSelected,
  });

  WashApprovalArray.fromJson(Map<String, dynamic> json) {
    wType = json['wType'];
    title = json['title'];
    statusValue = json['statusValue'];
    remarkValue = json['remarkValue'];
    status = json['status'];
    image = json['image'];
    remark = json['remark'];
    file = json['file'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wType'] = wType;
    data['title'] = title;
    data['statusValue'] = statusValue;
    data['remarkValue'] = remarkValue;
    data['status'] = status;
    data['image '] = image;
    data['remark'] = remark;
    data['file'] = file;
    data['isSelected'] = isSelected;

    return data;
  }
}
