import 'package:qapp/app/data/network/dto/CheckAuditPackIDExistsModel.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
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
import 'package:qapp/app/data/network/dto/OperatorsChartsModel.dart';
import 'package:qapp/app/data/network/dto/PostSaveAuditModel.dart';
import 'package:qapp/app/data/network/dto/RemoveAuditQcDetlResponse.dart';
import 'package:qapp/app/data/network/dto/SaveAuditModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveScoreCard.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateInternalAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';

import '../../dto/GetAllGarOperationMasterModel.dart';
import '../../dto/GetAllGarPartDataModel.dart';
import '../../dto/GetMesMentDefectsByUomModel.dart';
import '../../dto/GetVisualAllDefectsModel.dart';
import '../../dto/UserAppModel.dart';
import '../../dto/getFavouriteModal.dart';

abstract class InternalAuditRepository {
  Future<ApiResult<UserAppModel>> loginwithUserApp();
  Future<ApiResult<GetAllGarPartDataModel>> getAllGarPartDatas(ProductType);
  Future<ApiResult<GetAllGarOperationMasterModel>>
      getAllGarOperationMasterDatas();

  Future<ApiResult<GetVisualAllDefectsModel>> getVisualAllDefectDatas();
  Future<ApiResult<GetVisualAllDefectsModel>> getVisualAllDefectData();
  Future<ApiResult<GetAllDefectsModel>> getAllDefectData();

  Future<ApiResult<GetDsListModels>> getDsListDetailDataas(orderno);
  Future<ApiResult<UpdateInternalAuditStatusModel>>
      UpdateInternalAuditStatusData(unitCode, currentDate, audittype,
          auditorname, orderno, insType, sessionname);
  Future<ApiResult<UpdateAuditStatusModel>> updateAuditStatusAPIdatas(
      auditschhdID);

  Future<ApiResult<GetMesMentDefectsByUomModel>> getMesMentDefectsByUomDatas(
      Uom);

  Future<ApiResult<GetAllGarPartDataModel>> getSleevesDatas(
      languagecode, producttype);
  Future<ApiResult<GetAllGarOperationMasterModel>> getSleevesAttachmentsDatas(
      languagecode, partid);

  Future<ApiResult<GetFavouriteModel>> getDefectCntData();

  // Future<ApiResult<FinalAuditModel>> getFinalAuditStatus();
  Future<ApiResult<FinalAuditModel>> getFinalAuditStatus(
      auditorId, date, auditorName);
  Future<ApiResult<OperatorsChart>> getOperatorsCntChart(
      SaveScoreCardModel scoreCardData);

  Future<ApiResult<GetEmpDataModel>> getEmpCodeData(String empId);
  Future<ApiResult<PostSaveAuditModel>> postAuditDatas(SaveAuditModel empId);

  Future<ApiResult<GetDsListModel>> getDsListDatas(String orderno);
  Future<ApiResult<GetDefectTranslationMasterByLanguageCodeModel>>
      getDefectTranslationMasterByLanguageCodeDatas(String languagecode);

  Future<ApiResult<FavDefectDataWithLanguageModel>>
      favDefectDataWithLanguageDatas(languagecode);
  Future<ApiResult<UpdateIsFavModel>> postIsFavAPI(
    String defectcode,
    String status,
  );
  Future<ApiResult<GetAqlBaseInfoModel>> getAqlBaseInfoDatas(
      String unitcode,
      String buyercode,
      String aqltype,
      String auditformat,
      String packqty,
      String noofcartons);

  Future<ApiResult<GetFreqUsedDefectsByParamsModel>>
      getFreqUsedDefectsByParamswithChkType(String unitcode, String audittype,
          String username, String languagecode, String chktype);
  Future<ApiResult<GetAllDefectswithFreqUsedDefectsByParamsModel>>
      getAllDefectswithFreqUsedDefectsByParamsDatas(
          String unitcode,
          String audittype,
          String username,
          String languagecode,
          String chktype);

  Future<ApiResult<ShoworHideIsFavResponseModel>> showorHideIsFavAPIdatas(
    String unitcode,
    String audittype,
    String username,
    String defectcode,
    String status,
  );
  Future<ApiResult<SaveFreqUsedDefectsResponseModel>>
      postSaveFreqUsedDefectsData(SaveFreqUsedDefectsModel scoreCardData);
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
  );

  Future<ApiResult<UploadImageResponseModel>> postImageUploadData(
      UploadImageModel imgData);

  Future<ApiResult<GetOperCodeByPartIdModel>> getOperCodeByPartIdDatas(
      int partid);

  Future<ApiResult<GetDefectsByCategoryModel>> GetDefectsByCategoryAPI(
      String category);

  Future<ApiResult<IscheckAuidtExistsModel>> IscheckAuidtExistsAPI(
    String unitcode,
    String auditdate,
    String audittype,
    String instype,
    int orderno,
    int orderqty,
    String auditorname,
  );

  Future<ApiResult<CheckAuditPackIDExistsModel>> checkAuditPackIDExistsAPI(
    int id,
    String packid,
  );
  Future<ApiResult<GetDsheadByParamModel>> GetDsheadByParamAPI(
      unitcode, audittype, orderno);
  Future<ApiResult<GetUDMasterByTypeModel>> GetUDMasterByTypeAPI(
    type,
  );
  Future<ApiResult<GetAuditHeadDataByIdNewModel>> GetAuditHeadDataByIdNewAPI(
    auditheadid,
  );
  Future<ApiResult<GetAuditHeadDataByIdModel>> GetAuditHeadDataByIdAPI(
    auditheadid,
  );
  Future<ApiResult<RemoveAuditQcDetlResponse>> RemoveAuditQcDetlResponseAPI(
    item,
  );
}
