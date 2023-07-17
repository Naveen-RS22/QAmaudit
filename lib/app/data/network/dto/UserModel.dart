class UserModel {
  String? userCode;
  String? username;
  String? password;

  UserModel({this.userCode, this.username, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    userCode = json['userCode'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userCode'] = userCode;
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'userCode': userCode,
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'UserModel{userCode: $userCode, username: $username, password: $password}';
  }
}
