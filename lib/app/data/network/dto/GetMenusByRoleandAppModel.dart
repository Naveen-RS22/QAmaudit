import 'dart:convert';

class GetMenusByRoleandAppModel {
  bool? isSuccess;
  String? message;
  List<Data>? data;

  GetMenusByRoleandAppModel({this.isSuccess, this.message, this.data});

  GetMenusByRoleandAppModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? roleId;
  String? appName;
  String? locCode;
  String? unitCode;
  int? menuId;
  int? parantMenuId;
  String? menuName;
  String? menuType;
  String? menuUrl;
  String? menuVisible;
  int? index;

  Data(
      {this.roleId,
      this.appName,
      this.locCode,
      this.unitCode,
      this.menuId,
      this.parantMenuId,
      this.menuName,
      this.menuType,
      this.menuUrl,
      this.menuVisible,
      this.index});

  Data.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    appName = json['appName'];
    locCode = json['locCode'];
    unitCode = json['unitCode'];
    menuId = json['menuId'];
    parantMenuId = json['parantMenuId'];
    menuName = json['menuName'];
    menuType = json['menuType'];
    menuUrl = json['menuUrl'];
    menuVisible = json['menuVisible'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['appName'] = this.appName;
    data['locCode'] = this.locCode;
    data['unitCode'] = this.unitCode;
    data['menuId'] = this.menuId;
    data['parantMenuId'] = this.parantMenuId;
    data['menuName'] = this.menuName;
    data['menuType'] = this.menuType;
    data['menuUrl'] = this.menuUrl;
    data['menuVisible'] = this.menuVisible;
    data['index'] = this.index;
    return data;
  }
}
