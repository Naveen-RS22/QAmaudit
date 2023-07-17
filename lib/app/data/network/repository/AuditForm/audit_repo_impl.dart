import 'dart:convert';

import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/DeleteScoreCardHeadByIdModel.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/FlagInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarOperationMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarPartDataModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectsCntModel.dart';
import 'package:qapp/app/data/network/dto/GetEmpData.dart';
import 'package:qapp/app/data/network/dto/GetFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCFrequentUsedOperationsandPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetOperCodeByPartIdModel.dart';
import 'package:qapp/app/data/network/dto/GetScoreCardEntryListModel.dart';
import 'package:qapp/app/data/network/dto/GetScorecardDataByIdModel.dart';
import 'package:qapp/app/data/network/dto/PostScoreDataModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveScoreCard.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UpdateScoreCardAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateSessionFlagModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import '../../dto/OperatorsChartsModel.dart';
import '../../dto/UserAppModel.dart';
import 'audit_repo.dart';

class AuditRepositoryImpl implements AuditRepository {
  ApiService? _apiService;

  AuditRepositoryImpl() {
    _apiService = ApiService.instance;
  }

  @override
  Future<ApiResult<UserAppModel>> loginwithUserApp() async {
    try {
      final res = await _apiService?.normalGet(
        ApiConstants.userApp,
      );
      return ApiResult.success(data: UserAppModel.fromJson(res));
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
  Future<ApiResult<FlagInfoModel>> getFlagInfoDatas(
      unitCode, userN, currentData, sewLine, sessionName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.FlagInfo}$unitCode/$currentData/$userN/$sewLine/$sessionName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: FlagInfoModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DeleteScoreCardHeadByIdModel>> deleteScoreCardHeadByIds(
      id) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.deleteScoreCardHeadById}$id",
    };
    try {
      final res = await _apiService?.delete('', data: apiData);
      return ApiResult.success(
          data: DeleteScoreCardHeadByIdModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetScorecardDataByIdModel>> getScorecardDataByIdDatas(
      id) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.getScorecardDataById}$id",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetScorecardDataByIdModel.fromJson(res));
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
  Future<ApiResult<GetScoreCardEntryListModel>> getScoreCardEntryListDatas(
      unitcode,
      audittype,
      auditDate,
      auditername,
      sewline,
      orderno,
      sessionname) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;

    Map<String, dynamic> apiData;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getScoreCardEntryList}?unitcode=$unitcode&audittype=$audittype&auditDate=$auditDate&auditername=$auditername&sewline=$sewline&orderno=$orderno&sessionname=$sessionname",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetScoreCardEntryListModel.fromJson(res));
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

  @override
  Future<ApiResult<GetDefectsCntModel>> getDefectCntData(
    unitCode,
    currentDate,
    userN,
    sewLine,
    sessionName,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getDefectCnt}$unitCode/$currentDate/$userN/$sewLine/$sessionName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetDefectsCntModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OperatorsChart>> getOperatorsCntChart(
      scoreCardData, userName) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    DateTime dateToday = DateTime.now();
    String unitcode = scoreCardData.unitCode.toString();
    String auditDate = dateToday.toString().substring(0, 10);
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
  Future<ApiResult<GetEmpDataModel>> getEmpCodeData(String empId) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getEmpCode + empId,
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetEmpDataModel.fromJson(res));
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
          "${ApiConstants.finalAuditStatus}$auditorId/$date/$auditorName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: FinalAuditModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UpdateScoreCardAuditStatusModel>>
      UpdateScoreCardAuditStatuss(
    unitCode,
    currentDate,
    auditType,
    auditorName,
    orderNo,
    sewLine,
    sessionName,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.UpdateScoreCardAuditStatus}$unitCode/$currentDate/$auditType/$auditorName/$orderNo/$sewLine/$sessionName",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: UpdateScoreCardAuditStatusModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UpdateSessionFlagModel>> UpdateSessionFlagDatas(
      auditscheadid) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.UpdateSessionFlag}$auditscheadid",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: UpdateSessionFlagModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<AuditSummaryModel>> saveAudit() async {
    try {
      final res = await _apiService?.normalGet(
        ApiConstants.postSaveAudit,
      );
      return ApiResult.success(data: AuditSummaryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<PostScoreDataModel>> postAuditDatass(
      SaveScoreCardModel scoreCardData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.postSaveAudit,
      "bodyContent": scoreCardData.toString()
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(data: PostScoreDataModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<PostScoreDataModel>> postAuditDatas(
      SaveScoreCardModel scoreCardData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    // var scoreCard = scoreCardData;
    // scoreCard.scoreCardDetlModels.toString();

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.postSaveAudit,
      "bodyContent": jsonEncode(scoreCardData)
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(data: PostScoreDataModel.fromJson(res));
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
  Future<ApiResult<UploadImageResponseModel>> postImageUploadData(
      UploadImageModel imgData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.UploadImageScorecardFileList,
      "bodyContent": jsonEncode(imgData)
    };

    try {
      final res = await _apiService?.post('', data: apiData);

      return ApiResult.success(data: UploadImageResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
