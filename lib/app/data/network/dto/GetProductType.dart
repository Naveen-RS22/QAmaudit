class GetProductType {
  bool? isSuccess;
  String? message;
  String? data;

  GetProductType({this.isSuccess, this.message, this.data});

  GetProductType.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
