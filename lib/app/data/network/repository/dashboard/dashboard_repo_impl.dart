import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/api_service.dart';
import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/GetEmpData.dart';
import 'package:qapp/app/data/network/dto/TimeSpendModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dto/UserAppModel.dart';
import 'dashboard_repo.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  ApiService? _apiService;

  DashboardRepositoryImpl() {
    _apiService = ApiService.instance;
  }

  @override
  Future<ApiResult<UserAppModel>> loginwithUserApp() async {
    try {
      final res = await _apiService?.normalGet(ApiConstants.userApp);
      return ApiResult.success(data: UserAppModel.fromJson(res));
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
          ApiConstants.auditSummary + "$auditorId/$date/$auditorName/7.0",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ScheduleModel>> getScoreCardAuditInfo(
      auditorId, date, auditorName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          ApiConstants.scheduleAudit + "$auditorId/$date/$auditorName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: ScheduleModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<FinalAuditModel>> getFinalAuditStatus(
      auditorId, date, auditorName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          ApiConstants.finalAuditStatus + "$auditorId/$date/$auditorName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: FinalAuditModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<TimeSpentModel>> getTimeSpentDetail(
      auditorId, date, auditorName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          ApiConstants.getTimeDetail + "$auditorId/$date/$auditorName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: TimeSpentModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DefectPartModel>> getdefectByParts(
      auditorId, date, auditorName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;

    Map<String, dynamic> apiData;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          ApiConstants.defeatParts + "$auditorId/$date/$auditorName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: DefectPartModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<AuditSummaryModel>> getAllDefects() async {
    Map<String, dynamic>? apiData;
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<AuditSummaryModel>> getDefectCount(
      unitCode, auditDate, auditorName, sewLine) async {
    Map<String, dynamic>? apiData;
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetEmpDataModel>> getEmployeeCode() async {
    Map<String, dynamic>? apiData;
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetEmpDataModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<AuditSummaryModel>> getFavorites() async {
    Map<String, dynamic>? apiData;
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<AuditSummaryModel>> getSleeveAttachments() async {
    Map<String, dynamic>? apiData;
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<AuditSummaryModel>> getSleeves() async {
    Map<String, dynamic>? apiData;
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<AuditSummaryModel>> saveAudit() async {
    Map<String, dynamic>? apiData;
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
