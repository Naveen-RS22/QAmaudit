import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/GetActiveAuditTypeByRptGroupModel.dart';
import 'package:qapp/app/data/network/dto/GetAllActiveFactoryModel.dart';
import 'package:qapp/app/data/network/dto/GetAllBuyerDivInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
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
import 'package:qapp/app/data/network/dto/OperatorsChartsModel.dart';
import 'package:qapp/app/data/network/dto/QCSummaryModel.dart';
import 'package:qapp/app/data/network/dto/RemoveDefectsByIDModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveInlineData.dart';
import 'package:qapp/app/data/network/dto/SaveLineQCApprovalModel.dart';
import 'package:qapp/app/data/network/dto/SaveLineQCApprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveOrderScheduleRequestModel.dart';
import 'package:qapp/app/data/network/dto/SaveScoreCard.dart';
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
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';

import '../../dto/GetAllGarOperationMasterModel.dart';
import '../../dto/GetAllGarPartDataModel.dart';
import '../../dto/GetDefectCodeByTagIdModel.dart';
import '../../dto/GetDefectLevelListModel.dart';
import '../../dto/SaveLineQCModel.dart';
import '../../dto/getAllDefectsModel.dart';
import '../../dto/getFavouriteModal.dart';

abstract class InlineRepository {
  Future<ApiResult<UserAppModel>> loginwithUserApp();
  Future<ApiResult<GetFavouriteModel>> getFavoriteDefectData();
  Future<ApiResult<GetAllDefectsModel>> getAllDefectData();
  Future<ApiResult<GetAllGarPartDataModel>> getSleevesDatas(
      languagecode, producttype);
  Future<ApiResult<GetAllGarOperationMasterModel>> getSleevesAttachmentsDatas(
      languagecode, partid);
  Future<ApiResult<GetOperCodeByPartIdModel>> getOperCodeByPartIdDatas(
      int partid);

  Future<ApiResult<GetFavouriteModel>> getDefectCntData();

  Future<ApiResult<OperatorsChart>> getOperatorsCntChart(
      SaveScoreCardModel scoreCardData, String userName);

  Future<ApiResult<LineQCSave>> postAuditDatas(SaveInlineData empId);
  Future<ApiResult<GetLineQcdefectCountEntrypartModel>>
      getLineQcdefectCountEntryDatas(String unitCode, String currentDate,
          String auditType, String sewLine, String auditorname, int orderno);

  Future<ApiResult<GetLineQCTop3DefectModel>> getLineQCTop3DefectDats(
      String unitCode,
      String currentDate,
      String auditType,
      String sewLine,
      String auditorname,
      int orderno);

  Future<ApiResult<GetDsListModel>> getDsListData(String orderno);
  Future<ApiResult<QCSummaryModel>> getQcSummaryData(
      String orderno,
      String unitcode,
      String auditDate,
      String audittype,
      String checkername,
      String sewline,
      String colorCode);
  Future<ApiResult<GetDefectLevelListModel>> getDefectLevelData(
      String unitcode, String auditDate, String audittype, String checkername);
  Future<ApiResult<GetDefectCodeByTagIdModel>> getDefectCodeByTagIdData(
      String tagId, int orderno, String color, String audittype);

  Future<ApiResult<GetTagInfoModel>> getTagInfoDatas(
      String unitcode,
      String auditdt,
      String AuditType,
      String SewLine,
      int OrderNo,
      String color,
      String CheckerName);

  Future<ApiResult<UpdateIsclosedTagModel>> updateIsclosedTagDatas(id, user);
  Future<ApiResult<GetDefectTranslationMasterByLanguageCodeModel>>
      getDefectTranslationMasterByLanguageCodeDatas(String languagecode);
  Future<ApiResult<FavDefectDataWithLanguageModel>>
      favDefectDataWithLanguageDatas(String languagecode);

  Future<ApiResult<UpdateIsFavModel>> postIsFavAPI(
    String defectcode,
    String status,
  );
  Future<ApiResult<SaveFreqUsedDefectsResponseModel>>
      postSaveFreqUsedDefectsData(SaveFreqUsedDefectsModel scoreCardData);

  Future<ApiResult<GetFreqUsedDefectsByParamsModel>>
      getFreqUsedDefectsByParamsDatas(String unitcode, String audittype,
          String username, String languagecode);
  Future<ApiResult<GetAllDefectswithFreqUsedDefectsByParamsModel>>
      getAllDefectswithFreqUsedDefectsByParamsDatas(String unitcode,
          String audittype, String username, String languagecode);

  Future<ApiResult<GetLineQCDefectsCountandoverallReportModel>>
      getLineQCDefectsCountandoverallReportDatas(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
  );
  Future<ApiResult<GetAllLineQCsDefectdetailsByRangeHourlysummaryModel>>
      getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
          String unitcode,
          String auditDate,
          String audittype,
          String checkername,
          String orderno,
          String sewline,
          String sessioncode);
  Future<ApiResult<GetAllLineQCsDefectdetailsByRangeDaysummaryModel>>
      GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
          String unitcode,
          String auditDate,
          String audittype,
          String checkername,
          String orderno,
          String sewline,
          String sessioncode);
  Future<ApiResult<GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel>>
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
          String unitcode,
          String auditDate,
          String audittype,
          String checkername,
          String orderno,
          String sewline,
          String sessioncode);

  Future<ApiResult<GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel>>
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
          String unitcode,
          String auditDate,
          String audittype,
          String checkername,
          String orderno,
          String sewline,
          String sessioncode);

  Future<ApiResult<GetLineQCFrequentUsedOperationsandPartsModel>>
      getLineQCFrequentUsedOperationsandPartsDatass(
    String unitcode,
    String Rencentdays,
    String audittype,
    String checkername,
    String orderno,
  );
  Future<ApiResult<ShoworHideIsFavResponseModel>> showorHideIsFavAPIdatas(
      String unitcode,
      String audittype,
      String username,
      String defectcode,
      String status);

  Future<ApiResult<GetAppDetlListModel>> getAppDetlListData(
    String unitcode,
    String audittype,
    String ApproverType,
  );
  Future<ApiResult<GetAllSessionMasterbyunitcode>>
      getAllSessionMasterbyunitcode(
    String unitcode,
  );
  Future<ApiResult<RemoveDefectsByIDModel>> RemoveDefectsByIDAPI(
      int id,
      bool isremoveinspectedPcscount,
      bool isremoveAlteredPcscount,
      bool isremoveDefectedPcscount,
      bool isremoveRejectedPcscount);

  Future<ApiResult<GetAllActiveFactoryModel>> GetAllActiveFactoryAPI(
    String locationcode,
  );

  Future<ApiResult<GetLineQCApprovalByParamsListModel>>
      getLineQCApprovalByParamsListData(
    unitCode,
    audittype,
    auditdate,
    sewline,
    sessioncode,
    orderno,
    approver,
  );

  Future<ApiResult<SaveLineQCApprovalResponseModel>> postSaveLineQCApproval(
      SaveLineQCApprovalModel saveLineQCApproval);
  Future<ApiResult<UploadImageResponseModel>> postImageUploadData(
      UploadImageModel imgData);
  Future<ApiResult<GetUserDepartmentListModel>> getUserDepartmentListAPI();
  Future<ApiResult<GetActiveAuditTypeByRptGroupModel>>
      getActiveAuditTypeByRptGroupAPI(String rptgroup);
  Future<ApiResult<GetAllBuyerDivInfoModel>> getAllBuyerDivInfoDataAPI();
  Future<ApiResult<GetOrderRegWithbuyerModel>> getOrderRegWithbuyerDataAPI(
      String buyerdivcode);
  Future<ApiResult<GetSewLineInfoModel>> getSewLineInfoDataAPI(String ucode);
  Future<ApiResult<GetAssigneeDetailByIDModel>> getAssigneeDetailByIDAPI(
      int audittypeid);
  Future<ApiResult<SaveOrderScheduleResponseModel>> postSaveOrderSchedule(
      SaveOrderScheduleRequestModel saveOrderScheduleRequestData);
  Future<ApiResult<GetLineQCApprovalByAuditTypeApproverModel>>
      getLineQCApprovalByAuditTypeApproverAPI(
          String unitcode, String audittype, String auditdate, String approver);
  getLineQCApprovalByAuditTypeUsercodeAPI(
      String unitcode, String audittype, String auditdate, String usercode);

  Future<ApiResult<GetSessionCodeModel>> GetSessionCodeDataAPI(
      String currenttime);

  Future<ApiResult<ScheduleModel>> getScoreCardAuditInfo(
      auditorId, date, auditorName);

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
  );
}
