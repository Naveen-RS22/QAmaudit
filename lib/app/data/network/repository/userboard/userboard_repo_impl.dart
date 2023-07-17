import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/api_service.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByCountModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectCodeByTagIdModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectLevelListModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCDefectLevelReportModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectCountModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectbypartsModel.dart';
import 'package:qapp/app/data/network/dto/GetQcWidgetInfoModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dto/UserAppModel.dart';
import 'userboard_repo.dart';

class UserboardRepositoryImpl implements UserboardRepository {
  ApiService? _apiService;

  UserboardRepositoryImpl() {
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
  Future<ApiResult<GetLineQcdefectbypartsModel>> getLineQcdefectbypartsDatas(
      unitcode, auditDate, audittype, checkername) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getLineQcdefectbyparts}$unitcode/$auditDate/$audittype/$checkername",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetLineQcdefectbypartsModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAuidtDefectByCountModel>> getAuidtDefectByCountDatas(
      unitcode, auditDate, audittype) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getAuidtDefectByCount}$unitcode/$auditDate/$audittype",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetAuidtDefectByCountModel.fromJson(res));
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
          "${ApiConstants.GetScoreCardAuditInfonew}$auditorId/$date/$auditorName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: ScheduleModel.fromJson(res));
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
          "${ApiConstants.defeatParts}$auditorId/$date/$auditorName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: DefectPartModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetQcWidgetInfoModel>> getQcWidgetInfoData(
      unitCode, auditDate, audittype, checkername, currentime) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    String encode = Uri.encodeComponent(currentime);
    Map<String, dynamic> apiData;
    String queryString =
        "?unitcode=$unitCode&auditDate=$auditDate&audittype=$audittype&checkername=$checkername&currentime=$encode";

    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getQcWidgetInfo + queryString,
      // "/$unitCode/$auditDate/$audittype/$checkername/$currentime",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetQcWidgetInfoModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQcdefectCountModel>> getLineQcdefectCountData(
    String unitCode,
    String auditDate,
    String audittype,
    String checkername,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    String queryString =
        "?unitCode=$unitCode&auditDate=$auditDate&audittype=$audittype&checkername=$checkername";
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getLineQcdefectCount + queryString,
      // "/$unitCode/$auditDate/$audittype/$checkername/$currentime",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetLineQcdefectCountModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQCDefectLevelReportModel>>
      getLineQCDefectLevelReportAPIdatas(
          unitCode, audittype, auditDate, checkername) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getLineQCDefectLevelReport}/$unitCode/$audittype/$auditDate/$checkername",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetLineQCDefectLevelReportModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDsListModel>> getDsListData(orderno) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.getDsList}?orderno=$orderno",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetDsListModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDsListModel>> getQcSummaryData(orderno, unitcode,
      auditDate, audittype, checkername, sewline, color) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getQcSummary}?orderno=$orderno&unitcode=$unitcode&auditDate=$auditDate&audittype=$audittype&checkername=$checkername&sewline=$sewline&color=$color",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetDsListModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDefectLevelListModel>> getDefectLevelData(
      unitcode, auditDate, audittype, checkername) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getDefectLevelList}?unitcode=$unitcode&auditDate=$auditDate&audittype=$audittype&checkername=$checkername",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetDefectLevelListModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDefectCodeByTagIdModel>> getDefectCodeByTagIdData(
      String tagId) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getDefectCodeByTagId + tagId,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetDefectCodeByTagIdModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
