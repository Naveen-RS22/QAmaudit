// import 'dart:convert';

// class GetTagInfoModel {
//   bool? isSuccess;
//   String? message;
//   List<Data>? data;

//   GetTagInfoModel({this.isSuccess, this.message, this.data});

//   GetTagInfoModel.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       jsonDecode(json['data']).forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isSuccess'] = this.isSuccess;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? tagId;
//   String? garSize;
//   int? lqcDetlID;
//   String? isClosed;
//   String? defectCode;
//   String? garType;

//   Data(
//       {this.id,
//       this.tagId,
//       this.garSize,
//       this.lqcDetlID,
//       this.isClosed,
//       this.defectCode,
//       this.garType});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tagId = json['tagId'];
//     garSize = json['garSize'];
//     lqcDetlID = json['lqcDetl_ID'];
//     isClosed = json['isClosed'];
//     defectCode = json['defectCode'];
//     garType = json['garType'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['tagId'] = this.tagId;
//     data['garSize'] = this.garSize;
//     data['lqcDetl_ID'] = this.lqcDetlID;
//     data['isClosed'] = this.isClosed;
//     data['defectCode'] = this.defectCode;
//     data['garType'] = this.garType;
//     return data;
//   }
// }

import 'dart:convert';

class GetTagInfoModel {
  bool? isSuccess;
  String? message;
  List<String>? data;

  GetTagInfoModel({this.isSuccess, this.message, this.data});

  GetTagInfoModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = jsonDecode(json['data']).cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
