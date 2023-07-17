import 'dart:convert';

class GetDsListModels {
  bool? isSuccess;
  String? message;
  Data? data;

  GetDsListModels({this.isSuccess, this.message, this.data});

  GetDsListModels.fromJson(Map<String, dynamic> json) {
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
  List<String>? sizelist;
  List<String>? colorlist;
  List<String>? fitlist;

  Data({this.sizelist, this.colorlist, this.fitlist});

  Data.fromJson(Map<String, dynamic> json) {
    sizelist = json['sizelist'].cast<String>();
    colorlist = json['colorlist'].cast<String>();
    fitlist = json['fitlist'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizelist'] = sizelist;
    data['colorlist'] = colorlist;
    data['fitlist'] = fitlist;
    return data;
  }
}
