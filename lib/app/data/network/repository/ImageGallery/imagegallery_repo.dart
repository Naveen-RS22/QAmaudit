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
import 'package:qapp/app/data/network/dto/SaveWashAprovalModel.dart';
import 'package:qapp/app/data/network/dto/SaveWashAprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/saveCQCTaskStatusRequestModal.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';

import '../../dto/UserAppModel.dart';

abstract class ImageGalleryRepository {
  Future<ApiResult<UserAppModel>> loginwithUserApp();
  Future<ApiResult<SaveWashAprovalResponseModel>> postSaveWashDatas(
      SaveWashAprovalModel saveWashData, String endpoint);
  Future<ApiResult<SaveProdSamAprlResponseModel>> postSaveWashApproval(
      SaveWashAprovalModel saveWashData, String endpoint);

  Future<ApiResult<SaveCQCTaskStatusResponseModal>> postSaveCQCTaskStatus(
      SaveCQCTaskStatusRequestModal saveCQCTaskStatusRequest);

  Future<ApiResult<GetBuyerFromOrderRegModel>> getBuyerFromOrderRegDatas();
  Future<ApiResult<GetOrderRegWithbuyerModel>> getOrderRegWithbuyerDatas(
      String buyerdivcode);
  Future<ApiResult<GetWashAprovalByIdModel>> getWashAprovalByIdDatas(
      int id, String endpoint);
  Future<ApiResult<UploadImageResponseModel>> postImageUploadData(
      UploadImageModel imgData);
  Future<ApiResult<GetWashAprovalByUnitcodeOrdernowtypeModel>>
      getWashAprovalByUnitcodeOrdernowtypeData(
    String unitcode,
    String orderno,
    String buyercode,
    String wType,
    String endpoint,
  );
  Future<ApiResult<GetAllAuditTypeModel>> getAllAuditType();
  Future<ApiResult<GetAllBuyerDivInfoModel>> getAllBuyerDivInfoDataAPI();
  Future<ApiResult<GetOrderRegWithbuyerModel>> getOrderRegWithbuyerDataAPI(
      String buyerdivcode);
  Future<ApiResult<GetSewLineInfoModel>> getSewLineInfoDataAPI(String ucode);
  Future<ApiResult<GetAllDefectMasterModel>> getAllDefectMasterAPI();
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
  );
}
