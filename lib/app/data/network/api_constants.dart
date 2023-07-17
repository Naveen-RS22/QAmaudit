class ApiConstants {
  static const String baseUrlDEV = "http://gateway01.ithred.info/api/";
  static const String baseUrlDEV03 = "4ethttp://gateway03.ithred.info/api/";
  static const String baseUrlUAT = "http://gateway01.ithred.in/api/";
  static const String baseUrlUAT03 = "http://gateway03.ithred.in/api/";
  static const String baseUrlPROD = "http://gateway03c.ithred.io/api/";
  static const String baseUrlPROD03 = "http://gateway03.ithred.io/api/";
  static const String baseUrlPROD03C = "https://gateway03c.ithred.io/api/";
  static const String baseUrlQA = "http://gateway01.ithred.net/api/";

  static const String baseUrlhttpDEV = "gateway01.ithred.info";
  static const String baseUrlhttpDEV03 = "gateway03.ithred.info";
  static const String baseUrlhttpUAT = "gateway01.ithred.in";
  static const String baseUrlhttpUAT03 = "gateway03.ithred.in";
  static const String baseUrlhttpPROD = "gateway03c.ithred.io";
  static const String baseUrlhttpPROD03 = "gateway03.ithred.io";
  static const String baseUrlhttpPROD03C = "gateway03c.ithred.io";
  static const String baseUrlhttpQA = "gateway01.ithred.net";

  static const String baseUrl = baseUrlDEV;
  static const String baseUrlhttp = baseUrlhttpDEV;

  //Login
  static const String login = 'Platform/Login';
  static const String forgotPassword = 'Platform/ForgotPassword';
  static const String changePassword = 'Platform/ChangePassword';
  static const String userApp = 'Platform/UserApps';

  //Dashboard
  static const String scheduleAudit = 'Scorecard/GetScoreCardAuditInfo/';
  static const String GetScoreCardAuditInfonew =
      'Scorecard/GetScoreCardAuditInfonew/';
  // static const String scheduleAudit = 'AuditSchedule/GetAuditStyleData/';
  static const String finalAuditStatus = 'Scorecard/FinalAuditStatus/';
  static const String getTimeDetail = 'Scorecard/GetTimeSpentDetailnew/';
  static const String defeatParts = 'Scorecard/GetdefectByParts/';
  static const String auditSummary = 'AuditSchedule/GetAuditSummary/';

  //Inline
  static const String getLineQcdefectCount = 'LineQc/GetLineQcdefectCount';
  static const String getLineQcdefectCountEntrypart =
      'LineQc/GetLineQcdefectCountEntrypart';
  static const String getLineQcdefectbyparts = 'LineQc/GetLineQcdefectbyparts/';
  static const String getLineQCTop3Defect = 'LineQc/getLineQCTop3Defect';

  static const String getDsList = 'LineQc/GetDsList';
  static const String getQcSummary = 'LineQc/GetQcSummary';
  static const String getDefectLevelList = 'LineQc/GetDefectLevelList';
  static const String GetDefectsByCategory =
      'DefectMaster/GetDefectsByCategory';
  static const String getDefectCodeByTagId = 'LineQc/GetDefectCodeByTagId/';
  static const String getQcWidgetInfo = 'LineQc/GetQcWidgetInfo';
  static const String postSaveLineQC = 'LineQc/SaveLineQC';
  static const String getTagInfo = 'LineQc/GetTagInfo';
  static const String updateIsclosedTag = 'LineQc/UpdateIsclosedTagbyuser';
  static const String getLineQCDefectLevelReport =
      'Report/GetLineQCDefectLevelReport';
  static const String getAppDetlList = 'AppDetl/GetAppDetlList';
  static const String saveLineQCApproval = 'LineQCApproval/SaveLineQCApproval';

  static const String GetSessionCodeCurrentandpreviousallByUnitcode =
      'SessionMaster/GetSessionCodeCurrentandpreviousallByUnitcode';
  static const String RemoveDefectsByID =
      'LineQc/RemoveDefectsandHeadercountByID';

  static const String getLineQCApprovalByParamsList =
      'LineQCApproval/GetLineQCApprovalByParamsList';

  static const String GetLineQCApprovalByParamsApproverTypeUserCode =
      'LineQCApproval/GetLineQCApprovalByParamsApproverTypeUserCode';

  //7.0 Audit form
  static const String getDefectCnt = 'Scorecard/GetDefectsCnt/';
  static const String getEmpCode = 'Scorecard/GetEmpData/';
  static const String postSaveAudit = 'Scorecard/SaveScoreCard';
  static const String UpdateIsFav = 'DefectMaster/UpdateIsFav';

  static const String getSleeves = 'GarPartsMaster/GetAllGarPartData';
  static const String getSleevesAttachments =
      'GarOperMaster/GetAllGarOperationMaster';
  static const String getOperCodeByPartId = 'GarOperMaster/GetOperCodeByPartId';

  static const String getFavourite = 'DefectMaster/IsFavDefectData';
  static const String GetLineQCFrequentUsedOperationsandParts =
      'Report/GetLineQCFrequentUsedOperationsandParts';
  static const String GetAuditQCFrequentUsedOperationsandPartschecktype =
      'Report/GetAuditQCFrequentUsedOperationsandPartschecktype';
  static const String getAllDefects =
      'DefectMaster/GetAllDefectMasterWithCategory';

  static const String getDefectTranslationMasterByLanguageCode =
      'DefectTranslationMaster/GetDefectTranslationMasterByLanguageCode';
  static const String favDefectDataWithLanguage =
      'DefectMaster/FavDefectDataWithLanguage';
  static const String getFreqUsedDefectsByParams =
      'FreqUsedDefects/getFreqUsedDefectsByParams';

  static const String GetFreqUsedDefectsByParamswithChkType =
      'FreqUsedDefects/GetFreqUsedDefectsByParamswithChkType';

  static const String getAllDefectswithFreqUsedDefectsByParams =
      'FreqUsedDefects/GetAllDefectswithFreqUsedDefectsByParams';
  static const String GetAllDefectswithFreqUsedDefectsByParamswithChkType =
      'FreqUsedDefects/GetAllDefectswithFreqUsedDefectsByParamswithChkType';

  static const String SaveFreqUsedDefects =
      'FreqUsedDefects/SaveFreqUsedDefects';
  static const String ShoworHideIsFav = 'FreqUsedDefects/ShoworHideIsFav';

  static const String getChartData = 'Scorecard/GetOperatorCnt/';

  static const String FlagInfo = 'Scorecard/FlagInfo/';
  static const String UpdateScoreCardAuditStatus =
      'Scorecard/UpdateScoreCardAuditStatus/';
  static const String UpdateSessionFlag = 'Scorecard/UpdateSessionFlag/';
  static const String UpdateInternalAuditStatusData =
      'Scorecard/UpdateScoreCardAuditStatus/';
  static const String UpdateAuditStatus = 'Scorecard/UpdateAuditStatus';

  static const String getScoreCardEntryList = 'Report/GetScoreCardEntryList';
  static const String GetLineQCDefectsCountandoverallReport =
      'Report/GetLineQCDefectsCountandoverallReport';
  static const String GetAllLineQCsDefectdetailsByRangeHourlysummary =
      'DashBoard/GetAllLineQCsDefectdetailsByRangeHourlysummary';
  static const String GetAllLineQCsDefectdetailsByRangeDaysummary =
      'DashBoard/GetAllLineQCsDefectdetailsByRangeDaysummary';

  static const String GetAllLineQCsDefectdetailsByRangeHourlyDefects =
      'DashBoard/GetAllLineQCsDefectdetailsByRangeHourlyDefects';
  static const String GetAllLineQCsDefectdetailsByRangeHourlyDefectsList =
      'DashBoard/GetAllLineQCsDefectdetailsByRangeHourlyDefectsList';
  static const String GetSessionCode = 'SessionMaster/GetSessionCode/';

  static const String deleteScoreCardHeadById =
      'Scorecard/DeleteScoreCardHeadById/';
  static const String getScorecardDataById = 'Scorecard/GetScorecardDataById/';

  //Internal Audit Form

  static const String getAudit = 'Audit/GetAuditInfo/';
  static const String getAuidtDefectByCount =
      'Audit/GetAuidtTop3defectbyAuditor/';
  static const String getAuidtDefectByParts =
      'Audit/GetAuidtdefectbypartsbyauditor/';
  static const String getAuditSummary = 'AuditSchedule/GetAuditSummary/';
  static const String getAuidtSummarylist = 'Audit/GetAuidtSummarylist/';
  static const String getAuditStyleData = 'AuditSchedule/GetAuditStyleData/';
  static const String postIAAudit = 'Audit/SaveAudit';
  static const String getAllGarOperationMaster =
      'GarOperMaster/GetAllGarOperationMaster/';
  static const String GetAuditEditInfoByParams =
      'Audit/GetAuditEditInfoByParams';

  static const String getAllGarPartData = 'GarPartsMaster/GetAllGarPartData/';
  static const String GetDsheadByParam = 'AuditSchedule/GetDsheadByParam';
  static const String GetUDMasterByType = 'UDMaster/GetUDMasterByType/';

  static const String GetAuditHeadDataByIdNew =
      'Audit/GetAuditHeadDataByIdNew/';
  static const String GetAuditHeadDataById = 'Audit/GetAuditHeadDataById/';
  static const String GetGarPartsMasterByProductType =
      'GarPartsMaster/GetGarPartsMasterByProductType';
  static const String GetPartTranslationMasterByLanguageCode =
      'PartTranslationMaster/GetPartTranslationMasterByLanguageCodeProductType';
  static const String GetOperTranslationMasterByLanguageCode =
      'OperTranslationMaster/GetOperTranslationMasterByLanguageCodePartID';

  static const String getAllDefectMaster = 'GarPartsMaster/GetAllDefectMaster/';
  static const String getVisualAllDefects = 'DefectMaster/GetAllDefectMaster/';
  static const String getMesMentDefectsByUom =
      'MesmentDefect/GetMesMentDefectsByUom/';
  static const String getAqlBaseInfo = 'AQLBaseTable/GetAqlBaseInfo/';
  static const String getAQLHeadByPackQtynoofcartons =
      'AQLHead/GetAQLHeadByPackQtynoofcartons';
  static const String success = 'true';
  static const String failure = 'false';
  static const String checkAuditPackIDExists = 'Audit/CheckAuditPackIDExists';

  //Beforewash

  static const String getBuyerFromOrderReg = 'NCR/GetBuyerFromOrderReg';
  static const String getOrderRegWithbuyer = 'NCR/GetOrderRegWithbuyer/';
  static const String getWashAprovalById = 'WashAproval/GetWashAprovalById/';
  static const String saveWashAproval = 'WashAproval/SaveWashAproval';
  static const String saveCQCTaskStatus = 'CQCTaskStatus/SaveCQCTaskStatus';
  static const String getWashAprovalByUnitcodeOrdernowtype =
      'WashAproval/GetWashAprovalByUnitcodeOrdernowtype';

  //Preferance

  static const String getAllLanguageInfo = 'Lang/GetAllLanguageInfo';
  static const String getLanguageAssignmentByUsercode =
      'AssignmentAudits/GetLanguageAssignmentByUsercode/';

  static const String updateLanguageAssignmentAuditsByUsercode =
      'AssignmentAudits/UpdateLanguageAssignmentAuditsByUsercode';

  static const String getMenusByRoleandApp =
      'RoleMenuRights/GetMenusByRoleandApp';

  static const String UploadImageAuditFileList =
      'UploadImage/UploadImageAuditFileList';
  static const String UploadImageLineQCFileList =
      'UploadImage/UploadImageLineQCFileList';
  static const String UploadImageScorecardFileList =
      'UploadImage/UploadImageScorecardFileList';
  static const String UploadImageFitAuditFileList =
      'UploadImage/UploadImageFitAuditFileList';

  static const String getUserDepartmentList = 'User/GetUserDepartmentList';
  static const String getActiveAuditTypeByRptGroup =
      'AuditTypeMaster/GetActiveAuditTypeByRptGroup';
  static const String getAllBuyerDivInfo = 'BuyerDivMaster/GetAllBuyerDivInfo';
  static const String GetAllBuyerCode = 'AuditSchedule/GetAllBuyerCode';
  static const String getSewLineInfo = 'SewLineMaster/GetSewLineInfo/';
  static const String getAssigneeDetailByID =
      'AuditTypeMaster/GetAssigneeDetailByID/';
  static const String GetAllActiveFactory = 'UnitMaster/GetAllActiveFactory';
  static const String saveOrderSchedule = 'AuditSchedule/SaveOrderSchedule';
  static const String GetLineQCApprovalByAuditTypeApprover =
      'LineQCApproval/GetLineQCApprovalByAuditTypeApprover';
  static const String GetLineQCApprovalByAuditTypeUserCode =
      'LineQCApproval/GetLineQCApprovalByAuditTypeUserCode';
  static const String GetAuditTypeByActive =
      'AuditTypeMaster/GetAuditTypeByActive';
  static const String GetAllDefectMaster = 'DefectMaster/GetAllDefectMaster';
  static const String GetGalleryList = 'Report/GetGalleryList';
  static const String GetGalleryList1 = 'Report/GetGalleryList1';
  static const String GetProductType = 'Audit/GetProductTypeByOrderNo';
  static const String getProdSamCutInspectionByparams =
      'ProdSamCutInspection/GetProdSamCutInspectionByparams';
  static const String RemoveAuditQcDetl = 'Audit/RemoveAuditQcDetl';
  static const String GetUDMasterByTypes = 'UDMaster/GetUDMasterByType/';
  static const String SaveGarFitAudit = 'GarFitAudit/SaveGarFitAudit';

  static const String CopyFitOrderSchedule =
      'AuditSchedule/CopyFitOrderSchedule';
  static const String GetFitAudiOperatorCnt =
      'GarFitAudit/GetFitAudiOperatorCnt';

  static const String GarFitAuditGetAllTop3Defect =
      'GarFitAudit/GetAllTop3Defect/';
  static const String GetListGarFitAuditDataByParams =
      'GarFitAudit/GetListGarFitAuditDataByParams';
  static const String DeleteGarFitAuditDataById =
      'GarFitAudit/DeleteGarFitAuditDataById/';
  static const String FinalFitAuditStatus = 'GarFitAudit/FinalFitAuditStatus/';
  static const String GetFitAuditTimeSpentDetailnew =
      'GarFitAudit/GetFitAuditTimeSpentDetailnew/';
  static const String GetFitAuditdefectByParts =
      'GarFitAudit/GetFitAuditdefectByParts/';
  static const String GetAllFitAuditDefectswithFreqUsedDefectsByParams =
      'FreqUsedDefects/GetAllFitAuditDefectswithFreqUsedDefectsByParams';
  static const String GetFreqUsedFitAuditDefectsByParams =
      'FreqUsedDefects/GetFreqUsedFitAuditDefectsByParams';
}
