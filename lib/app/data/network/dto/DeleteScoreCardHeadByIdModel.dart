class DeleteScoreCardHeadByIdModel {
  bool? isSuccess;
  String? message;

  DeleteScoreCardHeadByIdModel({this.isSuccess, this.message});

  DeleteScoreCardHeadByIdModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    return data;
  }
}
