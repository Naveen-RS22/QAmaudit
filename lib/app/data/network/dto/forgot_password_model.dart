class ForgetPasswordModel {
  // int httpCode;
  // String message;
  bool? isSuccess;
  String? message;

  ForgetPasswordModel({
    // this.httpCode,
    // this.message,
    this.isSuccess,
    this.message,
  });

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    // httpCode = json['httpCode'];
    // message = json['Message'];
    isSuccess = json['isSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['httpCode'] = this.httpCode;
    // data['message'] = this.message;
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    return data;
  }
}
