import 'package:qapp/app/data/network/dto/GetBuyerFromOrderRegModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetProdSamCutInspectionByparams.dart';
import 'package:qapp/app/data/network/dto/SaveCutInspectionModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';

import '../../dto/GetDsListModel.dart';
import '../../dto/UserAppModel.dart';
import '../../dto/saveCutInspectionResponseModel.dart';

abstract class CutInspectionRepository {
  Future<ApiResult<UserAppModel>> loginwithUserApp();
  Future<ApiResult<savecutInspectionResponseModel>> postSaveCutInspection(
      saveCutInspectionModel savecutInspection, String endpoint);

  Future<ApiResult<GetBuyerFromOrderRegModel>> getBuyerFromOrderRegDatas();
  Future<ApiResult<GetOrderRegWithbuyerModel>> getOrderRegWithbuyerDatas(
      String buyerdivcode);

  Future<ApiResult<GetDsListModel>> getDsListData(String orderno);
  Future<ApiResult<GetProdSamCutInspectionByparams>>
      getProdSamCutInspectionByparams(
    String unitcode,
    String date,
    String buyercode,
    String orderno,
    String color,
    String fit,
  );
}
