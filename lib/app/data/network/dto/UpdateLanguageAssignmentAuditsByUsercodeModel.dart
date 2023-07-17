class UpdateLanguageAssignmentAuditsByUsercodeModel {
  bool? isSuccess;
  String? message;
  String? data;

  UpdateLanguageAssignmentAuditsByUsercodeModel(
      {this.isSuccess, this.message, this.data});

  UpdateLanguageAssignmentAuditsByUsercodeModel.fromJson(
      Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
