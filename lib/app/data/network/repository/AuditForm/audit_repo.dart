import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/DeleteScoreCardHeadByIdModel.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/FlagInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectsCntModel.dart';
import 'package:qapp/app/data/network/dto/GetEmpData.dart';
import 'package:qapp/app/data/network/dto/GetFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCFrequentUsedOperationsandPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetOperCodeByPartIdModel.dart';
import 'package:qapp/app/data/network/dto/GetScoreCardEntryListModel.dart';
import 'package:qapp/app/data/network/dto/GetScorecardDataByIdModel.dart';
import 'package:qapp/app/data/network/dto/OperatorsChartsModel.dart';
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
import 'package:qapp/app/data/network/exceptions/api_result.dart';

import '../../dto/GetAllGarOperationMasterModel.dart';
import '../../dto/GetAllGarPartDataModel.dart';
import '../../dto/UserAppModel.dart';
import '../../dto/getAllDefectsModel.dart';
import '../../dto/getFavouriteModal.dart';

abstract class AuditRepository {
  Future<ApiResult<UserAppModel>> loginwithUserApp();
  Future<ApiResult<GetFavouriteModel>> getFavoriteDefectData();
  Future<ApiResult<GetAllDefectsModel>> getAllDefectData();
  Future<ApiResult<GetDefectTranslationMasterByLanguageCodeModel>>
      getDefectTranslationMasterByLanguageCodeDatas(languagecode);
  Future<ApiResult<FavDefectDataWithLanguageModel>>
      favDefectDataWithLanguageDatas(languagecode);
  Future<ApiResult<GetAllGarPartDataModel>> getSleevesDatas(
      languagecode, producttype);
  Future<ApiResult<GetAllGarOperationMasterModel>> getSleevesAttachmentsDatas(
      languagecode, partid);
  Future<ApiResult<DefectPartModel>> getdefectByParts(
      auditorId, date, auditorName);
  Future<ApiResult<GetScoreCardEntryListModel>> getScoreCardEntryListDatas(
      unitcode,
      audittype,
      auditDate,
      auditername,
      sewline,
      orderno,
      sessionname);

  Future<ApiResult<GetDefectsCntModel>> getDefectCntData(
      unitCode, currentDate, userN, sewLine, sessionName);

  // Future<ApiResult<FinalAuditModel>> getFinalAuditStatus();
  Future<ApiResult<FinalAuditModel>> getFinalAuditStatus(
      auditorId, date, auditorName);
  Future<ApiResult<OperatorsChart>> getOperatorsCntChart(
      SaveScoreCardModel scoreCardData, String userName);

  Future<ApiResult<GetEmpDataModel>> getEmpCodeData(String empId);
  Future<ApiResult<PostScoreDataModel>> postAuditDatas(
      SaveScoreCardModel empId);

  Future<ApiResult<FlagInfoModel>> getFlagInfoDatas(
    unitCode,
    userN,
    currentData,
    sewLine,
    sessionName,
  );

  Future<ApiResult<UpdateScoreCardAuditStatusModel>>
      UpdateScoreCardAuditStatuss(
    unitCode,
    currentDate,
    auditType,
    auditorName,
    orderNo,
    sewLine,
    sessionName,
  );

  Future<ApiResult<UpdateSessionFlagModel>> UpdateSessionFlagDatas(
      auditscheadid);
  Future<ApiResult<GetOperCodeByPartIdModel>> getOperCodeByPartIdDatas(
      int partid);
  Future<ApiResult<DeleteScoreCardHeadByIdModel>> deleteScoreCardHeadByIds(
      int id);
  Future<ApiResult<GetScorecardDataByIdModel>> getScorecardDataByIdDatas(
      int id);
  Future<ApiResult<UpdateIsFavModel>> postIsFavAPI(
    String defectcode,
    String status,
  );

  Future<ApiResult<GetFreqUsedDefectsByParamsModel>>
      getFreqUsedDefectsByParamsDatas(String unitcode, String audittype,
          String username, String languagecode);
  Future<ApiResult<GetAllDefectswithFreqUsedDefectsByParamsModel>>
      getAllDefectswithFreqUsedDefectsByParamsDatas(String unitcode,
          String audittype, String username, String languagecode);

  Future<ApiResult<ShoworHideIsFavResponseModel>> showorHideIsFavAPIdatas(
    String unitcode,
    String audittype,
    String username,
    String defectcode,
    String status,
  );

  Future<ApiResult<SaveFreqUsedDefectsResponseModel>>
      postSaveFreqUsedDefectsData(SaveFreqUsedDefectsModel scoreCardData);
  Future<ApiResult<GetLineQCFrequentUsedOperationsandPartsModel>>
      getLineQCFrequentUsedOperationsandPartsDatass(
    String unitcode,
    String Rencentdays,
    String audittype,
    String checkername,
    String orderno,
  );
  Future<ApiResult<UploadImageResponseModel>> postImageUploadData(
      UploadImageModel imgData);
}
