import 'dart:io';

import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/dto/GetAllLanguageInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetLanguageAssignmentByUsercodeModel.dart';
import 'package:qapp/app/data/network/dto/GetMenusByRoleandAppModel.dart';
import 'package:qapp/app/data/network/dto/ResetPasswordBody.dart';
import 'package:qapp/app/data/network/dto/ResetPasswordResponse.dart';
import 'package:qapp/app/data/network/dto/UpdateLanguageAssignmentAuditsByUsercodeModel.dart';
import 'package:qapp/app/data/network/dto/UserAppModel.dart';
import 'package:qapp/app/data/network/dto/forgot_password_model.dart';
import 'package:qapp/app/data/network/dto/login_model.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import 'on_boarding_repo.dart';

class OnBoardingRepositoryImpl extends OnBoardingRepository {
  ApiService? _apiService;

  OnBoardingRepositoryImpl() {
    _apiService = ApiService.instance;
  }

  @override
  Future<ApiResult<ForgetPasswordModel>> forgotPassword(username) async {
    try {
      final res = await _apiService?.normalGet(
        ApiConstants.forgotPassword + "/$username",
      );
      return ApiResult.success(data: ForgetPasswordModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<LoginModel>> loginWithCredentials(username, password) async {
    Map<String, dynamic> loginData;
    loginData = {
      "userName": username,
      "password": password,
      "deviceName": Platform.operatingSystem,
      "deviceType": Platform.isAndroid ? "Android" : "iOS",
      "macid": "",
      "operatingSys": "",
      "browser": "",
    };

    try {
      final res =
          await _apiService?.normalPost(ApiConstants.login, data: loginData);
      return ApiResult.success(data: LoginModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest data) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      Map<String, dynamic> loginData;
      loginData = {
        "userKey": data.userKey,
        "password": data.password,
        "currentPassword": data.currentPassword,
      };

      final rest = await _apiService?.normalPost(ApiConstants.changePassword,
          data: loginData);

      return ApiResult.success(data: ResetPasswordResponse.fromJson(rest));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLanguageAssignmentByUsercodeModel>>
      getLanguageAssignmentByUsercodeDatas(usercode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getLanguageAssignmentByUsercode + usercode,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetLanguageAssignmentByUsercodeModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllLanguageInfoModel>> getAllLanguageInfoDatas() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAllLanguageInfo,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAllLanguageInfoModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetMenusByRoleandAppModel>> GetMenusByRoleandAppDatas(
      currentRole) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getMenusByRoleandApp + '/$currentRole/QAM',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetMenusByRoleandAppModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UpdateLanguageAssignmentAuditsByUsercodeModel>>
      updateLanguageAssignmentAuditsByUsercodeDatas(usercode, language) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.updateLanguageAssignmentAuditsByUsercode +
          "?usercode=$usercode&languagecode=$language",
      "bodyContent": ""
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(
          data: UpdateLanguageAssignmentAuditsByUsercodeModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UserAppModel>> loginwithUserApp() async {
    try {
      final result = await _apiService?.normalGet(ApiConstants.userApp);
      return ApiResult.success(data: UserAppModel.fromJson(result));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
