import 'dart:convert';

import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/CheckAuditPackIDExistsModel.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarOperationMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarPartDataModel.dart';
import 'package:qapp/app/data/network/dto/GetAqlBaseInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAuditHeadDataByIdModel.dart';
import 'package:qapp/app/data/network/dto/GetAuditHeadDataByIdNewModel.dart';
import 'package:qapp/app/data/network/dto/GetAuditQCFrequentUsedOperationsandPartschecktypeResponseModal.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectsByCategoryModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModels.dart';
import 'package:qapp/app/data/network/dto/GetDsheadByParamModel.dart';
import 'package:qapp/app/data/network/dto/GetEmpData.dart';
import 'package:qapp/app/data/network/dto/GetFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetOperCodeByPartIdModel.dart';
import 'package:qapp/app/data/network/dto/GetUDMasterByTypeModel.dart';
import 'package:qapp/app/data/network/dto/IscheckAuidtExistsModel.dart';
import 'package:qapp/app/data/network/dto/PostSaveAuditModel.dart';
import 'package:qapp/app/data/network/dto/RemoveAuditQcDetlResponse.dart';
import 'package:qapp/app/data/network/dto/SaveAuditModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateInternalAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import '../../dto/GetMesMentDefectsByUomModel.dart';
import '../../dto/GetVisualAllDefectsModel.dart';
import '../../dto/GetVisualFavouriteModal.dart';
import '../../dto/OperatorsChartsModel.dart';
import '../../dto/UserAppModel.dart';
import './internal_audit_repo.dart';

class InternalAuditRepositoryImpl implements InternalAuditRepository {
  ApiService? _apiService;

  InternalAuditRepositoryImpl() {
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
  Future<ApiResult<UpdateAuditStatusModel>> updateAuditStatusAPIdatas(
    auditschhdID,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;

    if (ApiConstants.baseUrlhttp == 'gateway03.ithred.io' ||
        ApiConstants.baseUrlhttp == 'gateway03c.ithred.io') {
      apiData = {
        "appCode": prefs.getString(Constants.qamCode),
        "entityCode": prefs.getString(Constants.entityCode),
        "appEndpoints": "Audit/UpdateAuditStatusputByAuditSchID/$auditschhdID",
        "bodyContent": ""
      };
    } else {
      apiData = {
        "appCode": prefs.getString(Constants.qamCode),
        "entityCode": prefs.getString(Constants.entityCode),
        "appEndpoints": "Audit/UpdateAuditStatusByAuditSchID/$auditschhdID",
        "bodyContent": ""
      };
    }

    if (ApiConstants.baseUrlhttp == 'gateway03.ithred.io' ||
        ApiConstants.baseUrlhttp == 'gateway03c.ithred.io') {
      try {
        final res = await _apiService?.post('', data: apiData);
        return ApiResult.success(data: UpdateAuditStatusModel.fromJson(res));
      } catch (e) {
        return ApiResult.failure(error: NetworkExceptions.getDioException(e));
      }
    } else {
      try {
        final res = await _apiService?.put('', data: apiData);
        return ApiResult.success(data: UpdateAuditStatusModel.fromJson(res));
      } catch (e) {
        return ApiResult.failure(error: NetworkExceptions.getDioException(e));
      }
    }
  }

  @override
  Future<ApiResult<UpdateInternalAuditStatusModel>>
      UpdateInternalAuditStatusData(
    unitCode,
    currentDate,
    audittype,
    auditorname,
    orderno,
    insType,
    sessionname,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.UpdateInternalAuditStatusData}$unitCode/$currentDate/$audittype/$auditorname/$orderno/$insType/$sessionname",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: UpdateInternalAuditStatusModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDsListModels>> getDsListDetailDataas(orderno) async {
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
      return ApiResult.success(data: GetDsListModels.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDsListModel>> getDsListDatas(orderno) async {
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
  Future<ApiResult<GetAllGarPartDataModel>> getAllGarPartDatas(
      ProductType) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.GetGarPartsMasterByProductType}?ProductType=$ProductType",
      "bodyContent": ""
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(data: GetAllGarPartDataModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllGarOperationMasterModel>>
      getAllGarOperationMasterDatas() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getAllGarOperationMaster,
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
  Future<ApiResult<GetVisualFavouriteModal>>
      getVisualFavoriteDefectData() async {
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

      return ApiResult.success(data: GetVisualFavouriteModal.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetVisualAllDefectsModel>> getVisualAllDefectDatas() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getVisualAllDefects,
    };
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetVisualAllDefectsModel.fromJson(res));
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
  Future<ApiResult<GetMesMentDefectsByUomModel>> getMesMentDefectsByUomDatas(
      Uom) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.getMesMentDefectsByUom}$Uom",
    };
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetMesMentDefectsByUomModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAqlBaseInfoModel>> getAqlBaseInfoDatas(
      unitcode, buyercode, aqltype, auditformat, packqty, noofcartons) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    if (noofcartons.toString() == "") {
      apiData = {
        "appCode": prefs.getString(Constants.cnfCode),
        "entityCode": prefs.getString(Constants.entityCode),
        "appEndpoints":
            '${ApiConstants.getAQLHeadByPackQtynoofcartons}?aqltype=$aqltype&auditformat=$auditformat&unitcode=$unitcode&buyercode=$buyercode&packqty=$packqty',
      };
    } else {
      apiData = {
        "appCode": prefs.getString(Constants.cnfCode),
        "entityCode": prefs.getString(Constants.entityCode),
        "appEndpoints":
            '${ApiConstants.getAQLHeadByPackQtynoofcartons}?aqltype=$aqltype&auditformat=$auditformat&unitcode=$unitcode&buyercode=$buyercode&packqty=$packqty&noofcartons=$noofcartons',
      };
    }
    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetAqlBaseInfoModel.fromJson(res));
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
  Future<ApiResult<OperatorsChart>> getOperatorsCntChart(scoreCardData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    DateTime dateToday = DateTime.now();
    String unitcode = scoreCardData.unitCode.toString();
    String auditDate = dateToday.toString().substring(0, 10);
    String roundname = scoreCardData.sessionName.toString();
    String sewline = scoreCardData.sewLine.toString();
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getChartData}$unitcode/$auditDate/$roundname/$sewline",
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
  Future<ApiResult<PostSaveAuditModel>> postAuditDatas(
      SaveAuditModel saveAuditData) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    // var scoreCard = saveAuditData;
    // scoreCard.scoreCardDetlModels.toString();

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.postIAAudit,
      "bodyContent": jsonEncode(saveAuditData)
    };

    try {
      final res = await _apiService?.post('', data: apiData);

      return ApiResult.success(data: PostSaveAuditModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetVisualAllDefectsModel>> getVisualAllDefectData() {
    // TODO: implement getVisualAllDefectData
    throw UnimplementedError();
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
      getFreqUsedDefectsByParamswithChkType(
          unitcode, audittype, username, languagecode, chktype) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetFreqUsedDefectsByParamswithChkType}?unitcode=$unitcode&audittype=$audittype&username=$username&chktype=$chktype',
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
          unitcode, audittype, username, languagecode, chktype) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getAllDefectswithFreqUsedDefectsByParams}?unitcode=$unitcode&audittype=$audittype&username=$username&chktype=$chktype',
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
  Future<
          ApiResult<
              GetAuditQCFrequentUsedOperationsandPartschecktypeResponseModal>>
      getLineQCFrequentUsedOperationsandPartsDatass(
    String unitcode,
    String Rencentdays,
    String audittype,
    String checkername,
    String orderno,
    String checktype,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetAuditQCFrequentUsedOperationsandPartschecktype}?unitcode=$unitcode&Rencentdays=$Rencentdays&audittype=$audittype&checkername=$checkername&orderno=$orderno&checktype=$checktype',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetAuditQCFrequentUsedOperationsandPartschecktypeResponseModal
              .fromJson(res));
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
      "appEndpoints": ApiConstants.UploadImageAuditFileList,
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
  Future<ApiResult<IscheckAuidtExistsModel>> IscheckAuidtExistsAPI(
    String unitcode,
    String auditdate,
    String audittype,
    String instype,
    int orderno,
    int orderqty,
    String auditorname,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetAuditEditInfoByParams}?unitcode=$unitcode&auditdate=$auditdate&audittype=$audittype&instype=$instype&orderno=$orderno&orderqty=$orderqty&auditorname=$auditorname',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: IscheckAuidtExistsModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDefectsByCategoryModel>> GetDefectsByCategoryAPI(
      category) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.GetDefectsByCategory}?category=$category",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetDefectsByCategoryModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CheckAuditPackIDExistsModel>> checkAuditPackIDExistsAPI(
    id,
    packid,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.checkAuditPackIDExists}/$id/$packid",
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: CheckAuditPackIDExistsModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetDsheadByParamModel>> GetDsheadByParamAPI(
      unitcode, audittype, orderno) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.GetDsheadByParam}?unitcode=$unitcode&audittype=$audittype&orderno=$orderno",
      "bodyContent": ""
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetDsheadByParamModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetUDMasterByTypeModel>> GetUDMasterByTypeAPI(
    type,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.GetUDMasterByType}$type",
      "bodyContent": ""
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetUDMasterByTypeModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAuditHeadDataByIdNewModel>> GetAuditHeadDataByIdNewAPI(
    auditheadid,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.GetAuditHeadDataByIdNew}$auditheadid",
      "bodyContent": ""
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetAuditHeadDataByIdNewModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAuditHeadDataByIdModel>> GetAuditHeadDataByIdAPI(
    auditheadid,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.GetAuditHeadDataById}$auditheadid",
      "bodyContent": ""
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAuditHeadDataByIdModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<RemoveAuditQcDetlResponse>> RemoveAuditQcDetlResponseAPI(
      item) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.RemoveAuditQcDetl,
      "bodyContent": jsonEncode(item),
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(data: RemoveAuditQcDetlResponse.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
