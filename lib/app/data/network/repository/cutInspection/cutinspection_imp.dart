import 'dart:convert';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/dto/GetBuyerFromOrderRegModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetProductType.dart';
import 'package:qapp/app/data/network/dto/saveCutInspectionResponseModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/cutInspection/cutinspection_repo.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_service.dart';
import '../../dto/GetAllActiveFactoryModel.dart';
import '../../dto/GetAllGarPartDataModel.dart';
import '../../dto/GetDsListModel.dart';
import '../../dto/GetProdSamCutInspectionByIdNew.dart';
import '../../dto/GetProdSamCutInspectionByparams.dart';
import '../../dto/UserAppModel.dart';

class CutInspectionRepositoryImpl implements CutInspectionRepository {
  ApiService? _apiService;

  CutInspectionRepositoryImpl() {
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
  Future<ApiResult<GetProdSamCutInspectionByparams>>
      getProdSamCutInspectionByparams(
    String unitcode,
    String date,
    String buyercode,
    String orderno,
    String color,
    String fit,
  ) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.getProdSamCutInspectionByparams}?unitcode=$unitcode&date=$date&buyercode=$buyercode&orderno=$orderno&color=$color&fit=$fit',
    };
    try {
      final res = await _apiService?.get('', data: apiData);
      return ApiResult.success(
          data: GetProdSamCutInspectionByparams.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GetProdSamCutInspectionByIdNew>> getProdSamCutt(
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

      return ApiResult.success(
          data: GetProdSamCutInspectionByIdNew.fromJson(res));
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
  Future<ApiResult<GetAllGarPartDataModel>> getSleevesDatas(productType) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          '${ApiConstants.GetGarPartsMasterByProductType}?ProductType=$productType',
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
  Future<ApiResult<GetProductType>> getproduct(orderNo) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": '${ApiConstants.GetProductType}/$orderNo',
    };
    try {
      final res = await _apiService?.post('', data: apiData);
      return ApiResult.success(data: GetProductType.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<savecutInspectionResponseModel>> postSaveCutInspection(
      dynamic savecutInspection, String endpoint) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    Map<String, dynamic> contentData;
    contentData = {'Content-Type': 'application/json; charset=UTF-8'};

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.qamCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": endpoint,
      "bodyContent": jsonEncode(savecutInspection)
    };

    try {
      final res = await _apiService?.post('', data: apiData);

      return ApiResult.success(
          data: savecutInspectionResponseModel.fromJson(res));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
