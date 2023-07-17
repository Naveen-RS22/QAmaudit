import 'dart:convert';

import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/dto/GetAllAuditTypeModel.dart';
import 'package:qapp/app/data/network/dto/GetAllBuyerDivInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetBuyerFromOrderRegModel.dart';
import 'package:qapp/app/data/network/dto/GetGalleryListResponseModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetSewLineInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetWashAprovalByIdModel.dart';
import 'package:qapp/app/data/network/dto/GetWashAprovalByUnitcodeOrdernowtypeModel.dart';
import 'package:qapp/app/data/network/dto/SaveProdSamAprlResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveWashAprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/saveCQCTaskStatusRequestModal.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/ImageGallery/imagegallery_repo.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import '../../dto/GetVisualAllDefectsModel.dart';
import '../../dto/UserAppModel.dart';

class ImageGalleryRepositoryImpl implements ImageGalleryRepository {
  ApiService? _apiService;

  ImageGalleryRepositoryImpl() {
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
  Future<ApiResult<GetBuyerFromOrderRegModel>>
      getBuyerFromOrderRegDatas() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.getBuyerFromOrderReg,
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetBuyerFromOrderRegModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetOrderRegWithbuyerModel>> getOrderRegWithbuyerDatas(
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
  Future<ApiResult<GetWashAprovalByIdModel>> getWashAprovalByIdDatas(
      int id, String endpoint) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "$endpoint$id",
    };

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(data: GetWashAprovalByIdModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SaveWashAprovalResponseModel>> postSaveWashDatas(
      dynamic saveWashData, String endpoint) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": endpoint,
      "bodyContent": jsonEncode(saveWashData)
    };

    try {
      final res = await _apiService?.post('', data: apiData);

      return ApiResult.success(
          data: SaveWashAprovalResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SaveProdSamAprlResponseModel>> postSaveWashApproval(
      dynamic saveWashData, String endpoint) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": endpoint,
      "bodyContent": jsonEncode(saveWashData)
    };

    try {
      final res = await _apiService?.post('', data: apiData);

      return ApiResult.success(
          data: SaveProdSamAprlResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SaveCQCTaskStatusResponseModal>> postSaveCQCTaskStatus(
      SaveCQCTaskStatusRequestModal saveCQCTaskStatusRequest) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.saveCQCTaskStatus,
      "bodyContent": jsonEncode(saveCQCTaskStatusRequest)
    };

    try {
      final res = await _apiService?.post('', data: apiData);

      return ApiResult.success(
          data: SaveCQCTaskStatusResponseModal.fromJson(res));
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
  Future<ApiResult<GetWashAprovalByUnitcodeOrdernowtypeModel>>
      getWashAprovalByUnitcodeOrdernowtypeData(
    String unitcode,
    String orderno,
    String buyercode,
    String wType,
    String endpoint,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    if (endpoint == 'WashAproval/GetWashAprovalByUnitcodeOrdernowtype') {
      apiData = {
        "appCode": prefs.getString(Constants.qamCode),
        "entityCode": prefs.getString(Constants.entityCode),
        "appEndpoints":
            "$endpoint?unitcode=$unitcode&orderno=$orderno&wtype=$wType",
      };
    } else {
      apiData = {
        "appCode": prefs.getString(Constants.qamCode),
        "entityCode": prefs.getString(Constants.entityCode),
        "appEndpoints":
            "$endpoint?unitcode=$unitcode&orderno=$orderno&buyercode=$buyercode",
      };
    }

    try {
      final res = await _apiService?.get('', data: apiData);

      return ApiResult.success(
          data: GetWashAprovalByUnitcodeOrdernowtypeModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllAuditTypeModel>> getAllAuditType() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;

    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.GetAuditTypeByActive,
    };

    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAllAuditTypeModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetAllDefectMasterModel>> getAllDefectMasterAPI() async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;

    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": ApiConstants.GetAllDefectMaster,
    };

    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetAllDefectMasterModel.fromJson(res));
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
  Future<ApiResult<GetGalleryListResponseModel>> GetGalleryListAPI(
    String unitcode,
    String audittype,
    String instype,
    String buyerdivision,
    String orderno,
    String sewline,
    String defectCode,
    String fromDate,
    String toDate,
    String endpoint,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '$endpoint?unitcode=$unitcode&audittype=$audittype&instype=$instype&sewline=$sewline&fromDate=$fromDate&toDate=$toDate&buyerdivision=$buyerdivision&orderno=$orderno&defectCode=$defectCode',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(data: GetGalleryListResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
