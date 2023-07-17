class ShoworHideIsFavResponseModel {
  bool? isSuccess;
  String? message;

  ShoworHideIsFavResponseModel({this.isSuccess, this.message});

  ShoworHideIsFavResponseModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    return data;
  }
}
