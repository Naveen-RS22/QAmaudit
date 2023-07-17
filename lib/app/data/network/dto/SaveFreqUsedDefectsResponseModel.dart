class SaveFreqUsedDefectsResponseModel {
  bool? isSuccess;
  String? message;

  SaveFreqUsedDefectsResponseModel({this.isSuccess, this.message});

  SaveFreqUsedDefectsResponseModel.fromJson(Map<String, dynamic> json) {
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
