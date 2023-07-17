class ResetPasswordRequest {
  String? currentPassword;
  String? password;
  String? userKey;

  ResetPasswordRequest({this.currentPassword, this.password, this.userKey});

  ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    currentPassword = json['currentPassword'];
    password = json['password'];
    userKey = json['userKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPassword'] = this.currentPassword;
    data['password'] = this.password;
    data['userKey'] = this.userKey;
    return data;
  }
}
