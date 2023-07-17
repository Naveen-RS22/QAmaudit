import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/api_service.dart';
import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/GetAuditStyleDataModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByCountModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtSummarylistModel.dart';
import 'package:qapp/app/data/network/dto/GetIAAuditSummaryModel.dart';
import 'package:qapp/app/data/network/dto/getIAAuditInfo.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dto/UserAppModel.dart';
import 'ia_dashboard_repo.dart';

class IADashboardRepositoryImpl implements IADashboardRepository {
  ApiService? _apiService;

  IADashboardRepositoryImpl() {
    _apiService = ApiService.instance;
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

  @override
  Future<ApiResult<AuditSummaryModel>> getAuditSummary(
      auditorId, date, auditorName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          ApiConstants.auditSummary + "$auditorId/$date/$auditorName",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAuidtDefectByCountModel>> getAuidtDefectByCountDatas(
    unitcode,
    auditDate,
    audittype,
    auditorname,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAuidtDefectByCount +
          "$unitcode/$auditDate/$audittype/$auditorname",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetAuidtDefectByCountModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAuditStyleDataModel>> getAuditStyleDatas(
      unitcode, auditDate, auditername, audittype) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAuditStyleData +
          "$unitcode/$auditDate/$auditername/$audittype",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetAuditStyleDataModel.fromJson(res));
    } catch (e) {
      print(e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAuidtDefectByPartsModel>> getAuidtDefectByPartsDatas(
      unitcode, auditDate, audittype, auditorname) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAuidtDefectByParts +
          "$unitcode/$auditDate/$audittype/$auditorname",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetAuidtDefectByPartsModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAuidtSummarylistModel>> getAuidtSummarylistDatas(
      unitcode, auditDate, audittype, Instype, auditorname) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAuidtSummarylist +
          "$unitcode/$auditDate/$audittype/$Instype?auditorname=$auditorname",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetAuidtSummarylistModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetIAAuditSummaryModel>> getAuditSummarysDatas(
    unitcode,
    auditDate,
    auditername,
    audittype,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAuditSummary +
          "$unitcode/$auditDate/$auditername/$audittype",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetIAAuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetIAAuditInfo>> getIAAuditDatas(
      unitcode, auditDate, auditername, audittype) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAudit +
          "$unitcode/$auditDate/$auditername/$audittype",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetIAAuditInfo.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
