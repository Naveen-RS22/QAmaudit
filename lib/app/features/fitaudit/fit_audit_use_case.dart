import 'package:fimber/fimber.dart';
import 'package:qapp/app/data/network/dto/CopyFitOrderScheduleResponseModel.dart';
import 'package:qapp/app/data/network/dto/DeleteScoreCardHeadByIdModel.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/FlagInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarOperationMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarPartDataModel.dart';
import 'package:qapp/app/data/network/dto/GetAllTop3DefectResponseModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetListGarFitAuditDataByParamsResponseModel.dart';
import 'package:qapp/app/data/network/dto/GetUDMasterByTypeAuditPcsResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveGarFitAudit.dart';
import 'package:qapp/app/data/network/dto/GetDefectsCntModel.dart';
import 'package:qapp/app/data/network/dto/GetEmpData.dart';
import 'package:qapp/app/data/network/dto/GetFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCFrequentUsedOperationsandPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetOperCodeByPartIdModel.dart';
import 'package:qapp/app/data/network/dto/GetScoreCardEntryListModel.dart';
import 'package:qapp/app/data/network/dto/GetScorecardDataByIdModel.dart';
import 'package:qapp/app/data/network/dto/GetUDMasterByTypeResponseModel.dart';
import 'package:qapp/app/data/network/dto/OperatorsChartsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UpdateScoreCardAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateSessionFlagModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageFitAuditFileListRequest.dart';
import 'package:qapp/app/data/network/dto/UploadImageFitAuditFileListResponse.dart';

import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/FitAuditForm/fit_audit_repo_impl.dart';
import 'package:qapp/app/widgets/dialog_utils.dart';
import '../../data/local/shared_prefs_helper.dart';
import '../../data/network/dto/UserAppModel.dart';
import '../../res/constants.dart';

class FitAuditUserCase {
  late FitAuditRepositoryImpl _auditRepositoryImpl;
  FitAuditUserCase(FitAuditRepositoryImpl repository) {
    _auditRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _auditRepositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              onSuccess(data);
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getOperCodeByPartIdData(
    int partid,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getOperCodeByPartIdDatas(partid)
        .then((value) => value.when(success: (GetOperCodeByPartIdModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getFlagInfoData(
    unitCode,
    userN,
    currentData,
    sewLine,
    sessionName,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getFlagInfoDatas(
          unitCode,
          userN,
          currentData,
          sewLine,
          sessionName,
        )
        .then((value) => value.when(success: (FlagInfoModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void deleteScoreCardHeadById(
    id,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .deleteScoreCardHeadByIds(
          id,
        )
        .then(
            (value) => value.when(success: (DeleteScoreCardHeadByIdModel data) {
                  if (data.isSuccess ?? true) {
                    onSuccess(data);
                  } else {
                    onError(data.message);
                  }
                }, failure: (NetworkExceptions failure) {
                  Fimber.d("===>$failure");
                  onError(failure);
                }));
  }

  void getScorecardDataByIdData(
    id,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getScorecardDataByIdDatas(
          id,
        )
        .then((value) => value.when(success: (GetScorecardDataByIdModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getFavoriteDefuctData(
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getFavoriteDefectData()
        .then((value) => value.when(success: (GetFavouriteModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getAllDefuctData(
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getAllDefectData()
        .then((value) => value.when(success: (GetAllDefectsModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getDefectTranslationMasterByLanguageCodeData(
    String languagecode,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getDefectTranslationMasterByLanguageCodeDatas(languagecode)
        .then((value) => value.when(
                success: (GetDefectTranslationMasterByLanguageCodeModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void favDefectDataWithLanguageData(
    String languagecode,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .favDefectDataWithLanguageDatas(languagecode)
        .then((value) =>
            value.when(success: (FavDefectDataWithLanguageModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getSleevesData(
    String languagecode,
    String producttype,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getSleevesDatas(languagecode, producttype)
        .then((value) => value.when(success: (GetAllGarPartDataModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getSleevesAttachmentsData(
    String languagecode,
    String partid,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getSleevesAttachmentsDatas(languagecode, partid)
        .then((value) =>
            value.when(success: (GetAllGarOperationMasterModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getDefectCntData(
    unitCode,
    currentDate,
    userN,
    sewLine,
    sessionName,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getDefectCntData(
          unitCode,
          currentDate,
          userN,
          sewLine,
          sessionName,
        )
        .then((value) => value.when(success: (GetDefectsCntModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getOperatorsCntData(
    SaveGarFitAuditRequestModel scoreCardData,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _auditRepositoryImpl
        .getOperatorsCntChart(scoreCardData, userN)
        .then((value) => value.when(success: (OperatorsChart data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getDefectpart(
    String unitcode,
    String audittype,
    String fromdate,
    String todate,
    String auditername,
    String sewline,
    String sessionname,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _auditRepositoryImpl
        .getdefectByParts(
          unitcode,
          audittype,
          fromdate,
          todate,
          auditername,
          sewline,
          sessionname,
        )
        .then((value) =>
            value.when(success: (GetAllTop3DefectResponseModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getScoreCardEntryListData(
    unitcode,
    audittype,
    auditDate,
    auditername,
    sewline,
    orderno,
    sessionname,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _auditRepositoryImpl
        .getScoreCardEntryListDatas(unitcode, audittype, auditDate, auditername,
            sewline, orderno, sessionname)
        .then((value) => value.when(success: (GetScoreCardEntryListModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getEmpCodeData(
    empCode,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getEmpCodeData(empCode)
        .then((value) => value.when(success: (GetEmpDataModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getFinalAuditReport(
    unitCode,
    currentDate,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _auditRepositoryImpl
        .getFinalAuditStatus(unitCode, currentDate, userN)
        .then((value) => value.when(success: (FinalAuditModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void UpdateScoreCardAuditStatusData(
    unitCode,
    currentDate,
    auditType,
    auditorName,
    orderNo,
    sewLine,
    sessionName,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _auditRepositoryImpl.UpdateScoreCardAuditStatuss(
      unitCode,
      currentDate,
      auditType,
      auditorName,
      orderNo,
      sewLine,
      sessionName,
    ).then(
        (value) => value.when(success: (UpdateScoreCardAuditStatusModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void UpdateSessionFlagData(
    auditscheadid,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _auditRepositoryImpl.UpdateSessionFlagDatas(auditscheadid)
        .then((value) => value.when(success: (UpdateSessionFlagModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void postAuditData(
    SaveGarFitAuditRequestModel scoreCardData,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .postAuditDatas(
          scoreCardData,
        )
        .then(
            (value) => value.when(success: (SaveGarFitAuditResponseModel data) {
                  if (data.isSuccess ?? false) {
                    onSuccess(data);
                  } else {
                    onError(data.message);
                  }
                }, failure: (NetworkExceptions failure) {
                  Fimber.d("===>$failure");
                  DialogUtils.instance.dismissProgressbar();
                }));
  }

  void postIsFav(
    String defectcode,
    String status,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .postIsFavAPI(
          defectcode,
          status,
        )
        .then((value) => value.when(success: (UpdateIsFavModel data) {
              if (data.isSuccess ?? false) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              DialogUtils.instance.dismissProgressbar();
            }));
  }

  void getFreqUsedDefectsByParamsData(
    String unitcode,
    String audittype,
    String username,
    String languagecode,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getFreqUsedDefectsByParamsDatas(
            unitcode, audittype, username, languagecode)
        .then((value) =>
            value.when(success: (GetFreqUsedDefectsByParamsModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getAllDefectswithFreqUsedDefectsByParamsData(
    String unitcode,
    String audittype,
    String username,
    String languagecode,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getAllDefectswithFreqUsedDefectsByParamsDatas(
            unitcode, audittype, username, languagecode)
        .then((value) => value.when(
                success: (GetAllDefectswithFreqUsedDefectsByParamsModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void postSaveFreqUsedDefects(
    SaveFreqUsedDefectsModel scoreCardData,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .postSaveFreqUsedDefectsData(
          scoreCardData,
        )
        .then((value) =>
            value.when(success: (SaveFreqUsedDefectsResponseModel data) {
              if (data.isSuccess ?? false) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              DialogUtils.instance.dismissProgressbar();
            }));
  }

  void showorHideIsFavAPIdata(
    String unitcode,
    String audittype,
    String username,
    String defectcode,
    String status,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .showorHideIsFavAPIdatas(
            unitcode, audittype, username, defectcode, status)
        .then(
            (value) => value.when(success: (ShoworHideIsFavResponseModel data) {
                  if (data.isSuccess ?? false) {
                    onSuccess(data);
                  } else {
                    onError(data.message);
                  }
                }, failure: (NetworkExceptions failure) {
                  Fimber.d("===>$failure");
                  DialogUtils.instance.dismissProgressbar();
                }));
  }

  void getLineQCFrequentUsedOperationsandPartsDatas(
    String unitcode,
    String Rencentdays,
    String audittype,
    String checkername,
    String orderno,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .getLineQCFrequentUsedOperationsandPartsDatass(
          unitcode,
          Rencentdays,
          audittype,
          checkername,
          orderno,
        )
        .then((value) => value.when(
                success: (GetLineQCFrequentUsedOperationsandPartsModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void postImageUploadData(
    UploadImageFitAuditFileListRequest imgData,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .postImageUploadData(
          imgData,
        )
        .then((value) =>
            value.when(success: (UploadImageFitAuditFileListResponse data) {
              if (data.isSuccess ?? false) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              DialogUtils.instance.dismissProgressbar();
            }));
  }

  void getUDMasterByTypeResponseAPI(
    String type,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl.getUDMasterByTypeResponseAPI(type).then(
        (value) => value.when(success: (GetUDMasterByTypeResponseModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void copyFitOrderScheduleResponseAPI(
    String orderschId,
    String round,
    String newaudittype,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl
        .copyFitOrderScheduleResponseAPI(
          orderschId,
          round,
          newaudittype,
        )
        .then((value) =>
            value.when(success: (CopyFitOrderScheduleResponseModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void GetListGarFitAuditDataByParamsResponseAPI(
    unitcode,
    auditDate,
    audittype,
    auditername,
    orderno,
    sewline,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl.GetListGarFitAuditDataByParamsResponseAPI(
            unitcode, auditDate, audittype, auditername, orderno, sewline)
        .then((value) => value.when(
                success: (GetListGarFitAuditDataByParamsResponseModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getUDMasterByTypeResponseAPIauditPcs(
    String type,
    Function onSuccess,
    Function onError,
  ) async {
    await _auditRepositoryImpl.getUDMasterByTypeResponseAPIauditPcs(type).then(
        (value) =>
            value.when(success: (GetUDMasterByTypeAuditPcsResponseModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }
}
