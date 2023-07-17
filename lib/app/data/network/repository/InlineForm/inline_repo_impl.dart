import 'dart:convert';

import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/GetActiveAuditTypeByRptGroupModel.dart';
import 'package:qapp/app/data/network/dto/GetAllActiveFactoryModel.dart';
import 'package:qapp/app/data/network/dto/GetAllBuyerDivInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarOperationMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarPartDataModel.dart';
import 'package:qapp/app/data/network/dto/GetAllLineQCsDefectdetailsByRangeDaysummaryModel.dart';
import 'package:qapp/app/data/network/dto/GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel.dart';
import 'package:qapp/app/data/network/dto/GetAllLineQCsDefectdetailsByRangeHourlysummaryModel.dart';
import 'package:qapp/app/data/network/dto/GetAllSessionMasterbyunitcode.dart';
import 'package:qapp/app/data/network/dto/GetAppDetlListModel.dart';
import 'package:qapp/app/data/network/dto/GetAssigneeDetailByIDModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCApprovalByAuditTypeApproverModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCDefectsCountandoverallReportModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCFrequentUsedOperationsandPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCTop3DefectModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectCountEntrypartModel.dart';

import 'package:qapp/app/data/network/dto/GetOperCodeByPartIdModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetSessionCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetSewLineInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetTagInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetUserDepartmentListModel.dart';
import 'package:qapp/app/data/network/dto/RemoveDefectsByIDModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveLineQCApprovalModel.dart';
import 'package:qapp/app/data/network/dto/SaveLineQCApprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveOrderScheduleRequestModel.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsclosedTagModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/UserAppModel.dart';
import 'package:qapp/app/data/network/dto/class%20SaveOrderScheduleResponseModel%20%7B.dart';
import 'package:qapp/app/data/network/dto/GetLineQCApprovalByParamsListModel.dart';
import 'package:qapp/app/data/network/dto/GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel.dart';
import 'package:qapp/app/data/network/dto/dsa.dart';
// import 'package:qapp/app/data/network/dto/ds.dart';

import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import '../../dto/GetDefectCodeByTagIdModel.dart';
import '../../dto/GetDefectLevelListModel.dart';
import '../../dto/OperatorsChartsModel.dart';

import '../../dto/QCSummaryModel.dart';
import '../../dto/SaveInlineData.dart';
import '../../dto/SaveLineQCModel.dart';
import 'inline_repo.dart';

class InlineRepositoryImpl implements InlineRepository {
  ApiService? _apiService;

  InlineRepositoryImpl() {
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
  Future<ApiResult<GetFavouriteModel>> getFavoriteDefectData() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getFavourite,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetFavouriteModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetTagInfoModel>> getTagInfoDatas(
      String unitcode,
      String auditdt,
      String AuditType,
      String SewLine,
      int OrderNo,
      String color,
      String CheckerName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getTagInfo}?unitcode=$unitcode&auditdt=$auditdt&AuditType=$AuditType&SewLine=$SewLine&OrderNo=$OrderNo&Color=$color&CheckerName=$CheckerName',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetTagInfoModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllDefectsModel>> getAllDefectData() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAllDefects,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAllDefectsModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetOperCodeByPartIdModel>> getOperCodeByPartIdDatas(
      int partid) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": '${ApiConstants.getOperCodeByPartId}/$partid',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetOperCodeByPartIdModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetFavouriteModel>> getDefectCntData() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getDefectCnt,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetFavouriteModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OperatorsChart>> getOperatorsCntChart(
      scoreCardData, String userName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    String unitcode = scoreCardData.unitCode.toString();
    String auditDate = scoreCardData.auditDate.toString();
    String roundname = scoreCardData.sessionName.toString();
    String sewline = scoreCardData.sewLine.toString();
    String orderNo = scoreCardData.orderNo.toString();
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getChartData}$unitcode/$auditDate/$roundname/$sewline/$orderNo/$userName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: OperatorsChart.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<LineQCSave>> postAuditDatas(
      SaveInlineData scoreCardData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    // var scoreCard = scoreCardData;
    // scoreCard.scoreCardDetlModels.toString();

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.postSaveLineQC,
      "bodyContent": jsonEncode(scoreCardData)
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(data: LineQCSave.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQcdefectCountEntrypartModel>>
      getLineQcdefectCountEntryDatas(unitCode, currentDate, auditType, sewLine,
          auditorname, orderno) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    String queryString =
        "?unitCode=$unitCode&auditDate=$currentDate&audittype=$auditType&sewline=$sewLine&auditorname=$auditorname&orderno=$orderno";
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getLineQcdefectCountEntrypart + queryString,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetLineQcdefectCountEntrypartModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQCTop3DefectModel>> getLineQCTop3DefectDats(
      unitCode, currentDate, auditType, sewLine, auditorname, orderno) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    String queryString =
        "?unitCode=$unitCode&auditDate=$currentDate&audittype=$auditType&sewline=$sewLine&auditorname=$auditorname&orderno=$orderno";
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getLineQCTop3Defect + queryString,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetLineQCTop3DefectModel.fromJson(res));
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
  Future<ApiResult<UpdateIsclosedTagModel>> updateIsclosedTagDatas(
      id, user) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.updateIsclosedTag}/$id/$user",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: UpdateIsclosedTagModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<QCSummaryModel>> getQcSummaryData(orderno, unitcode,
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
      return ApiResult.success(data: QCSummaryModel.fromJson(res));
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
      String tagId, int orderno, String color, String audittype) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'applicm ation/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getDefectCodeByTagId}$tagId/$orderno/$color/$audittype",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetDefectCodeByTagIdModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDefectTranslationMasterByLanguageCodeModel>>
      getDefectTranslationMasterByLanguageCodeDatas(languagecode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getDefectTranslationMasterByLanguageCode}?languagecode=$languagecode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(
          data: GetDefectTranslationMasterByLanguageCodeModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<FavDefectDataWithLanguageModel>>
      favDefectDataWithLanguageDatas(languagecode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.favDefectDataWithLanguage}?languagecode=$languagecode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(
          data: FavDefectDataWithLanguageModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetFreqUsedDefectsByParamsModel>>
      getFreqUsedDefectsByParamsDatas(
          unitcode, audittype, username, languagecode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getFreqUsedDefectsByParams}?unitcode=$unitcode&audittype=$audittype&username=$username',
    };
    // String unitcode, String audittype,
    //       String username, String languagecode
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(
          data: GetFreqUsedDefectsByParamsModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllDefectswithFreqUsedDefectsByParamsModel>>
      getAllDefectswithFreqUsedDefectsByParamsDatas(
          unitcode, audittype, username, languagecode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getAllDefectswithFreqUsedDefectsByParams}?unitcode=$unitcode&audittype=$audittype&username=$username',
    };
    // String unitcode, String audittype,
    //       String username, String languagecode
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(
          data: GetAllDefectswithFreqUsedDefectsByParamsModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UpdateIsFavModel>> postIsFavAPI(
    String defectcode,
    String status,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "bodyContent": "",
      "appEndpoints":
          '${ApiConstants.UpdateIsFav}?defectcode=$defectcode&status=$status',
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(data: UpdateIsFavModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQCDefectsCountandoverallReportModel>>
      getLineQCDefectsCountandoverallReportDatas(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetLineQCDefectsCountandoverallReport}?unitcode=$unitcode&auditDate=$auditDate&audittype=$audittype&checkername=$checkername&orderno=$orderno&sewline=$sewline',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetLineQCDefectsCountandoverallReportModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllLineQCsDefectdetailsByRangeHourlysummaryModel>>
      getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    String sessioncode,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetAllLineQCsDefectdetailsByRangeHourlysummary}?unitcode=$unitcode&audittype=$audittype&auditDate=$auditDate&checkername=$checkername&sewline=$sewline&orderno=$orderno&sessioncode=$sessioncode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetAllLineQCsDefectdetailsByRangeHourlysummaryModel.fromJson(
              res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllLineQCsDefectdetailsByRangeDaysummaryModel>>
      GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    String sessioncode,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetAllLineQCsDefectdetailsByRangeDaysummary}?unitcode=$unitcode&audittype=$audittype&auditDate=$auditDate&checkername=$checkername&sewline=$sewline&orderno=$orderno',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetAllLineQCsDefectdetailsByRangeDaysummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel>>
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    String sessioncode,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetAllLineQCsDefectdetailsByRangeHourlyDefects}?unitcode=$unitcode&audittype=$audittype&auditDate=$auditDate&checkername=$checkername&sewline=$sewline&orderno=$orderno&sessioncode=$sessioncode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel.fromJson(
              res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel>>
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    String sessioncode,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetAllLineQCsDefectdetailsByRangeHourlyDefectsList}?unitcode=$unitcode&audittype=$audittype&auditDate=$auditDate&checkername=$checkername&sewline=$sewline&orderno=$orderno&sessioncode=$sessioncode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data:
              GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel.fromJson(
                  res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetSessionCodeModel>> GetSessionCodeDataAPI(
    String currenttime,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": '${ApiConstants.GetSessionCode}$currenttime',
      "bodyContent": "",
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(data: GetSessionCodeModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQCFrequentUsedOperationsandPartsModel>>
      getLineQCFrequentUsedOperationsandPartsDatass(
    String unitcode,
    String Rencentdays,
    String audittype,
    String checkername,
    String orderno,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetLineQCFrequentUsedOperationsandParts}?unitcode=$unitcode&Rencentdays=$Rencentdays&audittype=$audittype&checkername=$checkername&orderno=$orderno',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetLineQCFrequentUsedOperationsandPartsModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SaveFreqUsedDefectsResponseModel>>
      postSaveFreqUsedDefectsData(
          SaveFreqUsedDefectsModel scoreCardData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    // var scoreCard = scoreCardData;
    // scoreCard.scoreCardDetlModels.toString();

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.SaveFreqUsedDefects,
      "bodyContent": jsonEncode(scoreCardData)
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(
          data: SaveFreqUsedDefectsResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ShoworHideIsFavResponseModel>> showorHideIsFavAPIdatas(
    String unitcode,
    String audittype,
    String username,
    String defectcode,
    String status,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.ShoworHideIsFav}?unitcode=$unitcode&audittype=$audittype&username=$username&defectcode=$defectcode&status=$status",
      "bodyContent": ""
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(
          data: ShoworHideIsFavResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAppDetlListModel>> getAppDetlListData(
      unitcode, audittype, ApproverType) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getAppDetlList}?unitcode=$unitcode&audittype=$audittype&approverType=$ApproverType',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAppDetlListModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllSessionMasterbyunitcode>>
      getAllSessionMasterbyunitcode(unitcode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetSessionCodeCurrentandpreviousallByUnitcode}/$unitcode',
      "bodyContent": "",
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(
          data: GetAllSessionMasterbyunitcode.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<RemoveDefectsByIDModel>> RemoveDefectsByIDAPI(
      id,
      bool isremoveinspectedPcscount,
      bool isremoveAlteredPcscount,
      bool isremoveDefectedPcscount,
      bool isremoveRejectedPcscount) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.RemoveDefectsByID}/$id?isremoveinspectedPcscount=$isremoveinspectedPcscount&isremoveAlteredPcscount=$isremoveAlteredPcscount&isremoveDefectedPcscount=$isremoveDefectedPcscount&isremoveRejectedPcscount=$isremoveRejectedPcscount',
      "bodyContent": "",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: RemoveDefectsByIDModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQCApprovalByParamsListModel>>
      getLineQCApprovalByParamsListData(
    unitCode,
    audittype,
    auditdate,
    sewline,
    sessioncode,
    orderno,
    approver,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getLineQCApprovalByParamsList}?unitcode=$unitCode&audittype=$audittype&auditdate=$auditdate&sewline=$sewline&sessioncode=$sessioncode&orderno=$orderno&approver=$approver',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetLineQCApprovalByParamsListModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQCApprovalByParamsApproverTypeUserCodeModel>>
      GetLineQCApprovalByParamsApproverTypeUserCodeAPI(
    unitCode,
    audittype,
    auditdate,
    sewline,
    sessioncode,
    styleno,
    orderno,
    approvertype,
    usercode,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetLineQCApprovalByParamsApproverTypeUserCode}?unitcode=$unitCode&audittype=$audittype&auditdate=$auditdate&sewline=$sewline&sessioncode=$sessioncode&styleno=$styleno&orderno=$orderno&approvertype=$approvertype&usercode=$usercode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data:
              GetLineQCApprovalByParamsApproverTypeUserCodeModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SaveLineQCApprovalResponseModel>> postSaveLineQCApproval(
      SaveLineQCApprovalModel saveLineQCApproval) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.saveLineQCApproval,
      "bodyContent": jsonEncode(saveLineQCApproval)
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(
          data: SaveLineQCApprovalResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UploadImageResponseModel>> postImageUploadData(
      UploadImageModel imgData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.UploadImageLineQCFileList,
      "bodyContent": jsonEncode(imgData)
    };

    try {
      final res = await _apiService?.post('', data: apiData);

      return ApiResult.success(data: UploadImageResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetUserDepartmentListModel>>
      getUserDepartmentListAPI() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": "Catalog",
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getUserDepartmentList,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetUserDepartmentListModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetActiveAuditTypeByRptGroupModel>>
      getActiveAuditTypeByRptGroupAPI(String rptgroup) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getActiveAuditTypeByRptGroup}?rptgroup=$rptgroup',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetActiveAuditTypeByRptGroupModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllBuyerDivInfoModel>> getAllBuyerDivInfoDataAPI() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.GetAllBuyerCode,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAllBuyerDivInfoModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetOrderRegWithbuyerModel>> getOrderRegWithbuyerDataAPI(
      String buyerdivcode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getOrderRegWithbuyer + buyerdivcode,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetOrderRegWithbuyerModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetSewLineInfoModel>> getSewLineInfoDataAPI(
      String ucode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getSewLineInfo + ucode,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetSewLineInfoModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAssigneeDetailByIDModel>> getAssigneeDetailByIDAPI(
      int audittypeid) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          ApiConstants.getAssigneeDetailByID + audittypeid.toString(),
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAssigneeDetailByIDModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllActiveFactoryModel>> GetAllActiveFactoryAPI(
      String locationcode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetAllActiveFactory}?locationcode=$locationcode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAllActiveFactoryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SaveOrderScheduleResponseModel>> postSaveOrderSchedule(
      SaveOrderScheduleRequestModel saveOrderScheduleRequestData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    // var scoreCard = scoreCardData;
    // scoreCard.scoreCardDetlModels.toString();

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.saveOrderSchedule,
      "bodyContent": jsonEncode(saveOrderScheduleRequestData)
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(
          data: SaveOrderScheduleResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQCApprovalByAuditTypeApproverModel>>
      getLineQCApprovalByAuditTypeApproverAPI(String unitcode, String audittype,
          String auditdate, String approver) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetLineQCApprovalByAuditTypeApprover}?unitcode=$unitcode&audittype=$audittype&auditdate=$auditdate&approver=$approver',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetLineQCApprovalByAuditTypeApproverModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetLineQCApprovalByAuditTypeApproverModel>>
      getLineQCApprovalByAuditTypeUsercodeAPI(String unitcode, String audittype,
          String auditdate, String usercode) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetLineQCApprovalByAuditTypeUserCode}?unitcode=$unitcode&audittype=$audittype&auditdate=$auditdate&usercode=$usercode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetLineQCApprovalByAuditTypeApproverModel.fromJson(res));
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
          "${ApiConstants.scheduleAudit}$auditorId/$date/$auditorName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: ScheduleModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllGarPartDataModel>> getSleevesDatas(
      languagecode, producttype) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetPartTranslationMasterByLanguageCode}?languagecode=$languagecode&producttype=$producttype',
      "bodyContent": "",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAllGarPartDataModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllGarOperationMasterModel>> getSleevesAttachmentsDatas(
      languagecode, partid) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetOperTranslationMasterByLanguageCode}?languagecode=$languagecode&partid=$partid',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetAllGarOperationMasterModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
