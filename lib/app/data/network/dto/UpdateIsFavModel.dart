class UpdateIsFavModel {
  bool? isSuccess;
  String? message;

  UpdateIsFavModel({this.isSuccess, this.message});

  UpdateIsFavModel.fromJson(Map<String, dynamic> json) {
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
