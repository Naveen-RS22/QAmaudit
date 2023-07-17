import 'package:fimber/fimber.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/GetActiveAuditTypeByRptGroupModel.dart';
import 'package:qapp/app/data/network/dto/GetAllActiveFactoryModel.dart';
import 'package:qapp/app/data/network/dto/GetAllBuyerDivInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarOperationMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarPartDataModel.dart';
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
import 'package:qapp/app/data/network/dto/RemoveDefectsByIDModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveLineQCApprovalModel.dart';
import 'package:qapp/app/data/network/dto/SaveLineQCApprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveOrderScheduleRequestModel.dart';
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
// import 'package:qapp/app/data/network/dto/ds.dart';
import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/InlineForm/inline_repo_impl.dart';
import 'package:qapp/app/widgets/dialog_utils.dart';
import '../../data/local/shared_prefs_helper.dart';
import '../../data/network/dto/GetDefectCodeByTagIdModel.dart';
import '../../data/network/dto/QCSummaryModel.dart';
import '../../data/network/dto/SaveInlineData.dart';
import '../../data/network/dto/SaveLineQCModel.dart';
import '../../res/constants.dart';

class InlineUserCase {
  late InlineRepositoryImpl _inlineRepositoryImpl;
  InlineUserCase(InlineRepositoryImpl repository) {
    _inlineRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _inlineRepositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              //if (data.isSuccess ?? true) {
              onSuccess(null);
              // } else {
              //   onError(data.message);
              // }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getDsLists(
    String orderNo,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getDsListData(orderNo)
        .then((value) => value.when(success: (GetDsListModel data) {
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

  void updateIsclosedTagData(
    id,
    user,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .updateIsclosedTagDatas(id, user)
        .then((value) => value.when(success: (UpdateIsclosedTagModel data) {
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

  void getLineQcdefectCountEntryData(
    String unitCode,
    String currentDate,
    String auditType,
    String sewLine,
    String auditorname,
    int orderno,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getLineQcdefectCountEntryDatas(
            unitCode, currentDate, auditType, sewLine, auditorname, orderno)
        .then((value) =>
            value.when(success: (GetLineQcdefectCountEntrypartModel data) {
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

  void getLineQCTop3DefectData(
    String unitCode,
    String currentDate,
    String auditType,
    String sewLine,
    String auditorname,
    int orderno,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getLineQCTop3DefectDats(
            unitCode, currentDate, auditType, sewLine, auditorname, orderno)
        .then((value) => value.when(success: (GetLineQCTop3DefectModel data) {
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

  void getQcSummarys(
    String orderNo,
    String unitCode,
    String currentDate,
    String auditType,
    String userN,
    String sawLine,
    String colorCode,
    Function onSuccess,
    Function onError,
  ) async {
    // String userN =
    //     await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _inlineRepositoryImpl
        .getQcSummaryData(orderNo, unitCode, currentDate, auditType, userN,
            sawLine, colorCode)
        .then((value) => value.when(success: (QCSummaryModel data) {
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

  void getDefectCodeByTagIds(
    String tagId,
    int orderno,
    String color,
    String audittype,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getDefectCodeByTagIdData(tagId, orderno, color, audittype)
        .then((value) => value.when(success: (GetDefectCodeByTagIdModel data) {
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
    await _inlineRepositoryImpl
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

  void getTagInfoData(
    unitcode,
    auditdt,
    AuditType,
    SewLine,
    OrderNo,
    color,
    CheckerName,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getTagInfoDatas(
          unitcode,
          auditdt,
          AuditType,
          SewLine,
          OrderNo,
          color,
          CheckerName,
        )
        .then((value) => value.when(success: (GetTagInfoModel data) {
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
    await _inlineRepositoryImpl
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

  void getPartData(
    String language,
    String producttype,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getSleevesDatas(language, producttype)
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

  void getOperationData(
    String language,
    String partid,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getSleevesAttachmentsDatas(language, partid)
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

  void getOperCodeByPartIdData(
    int partid,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
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

  void getDefectCntData(
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getDefectCntData()
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

  void getOperatorsCntData(
    scoreCardData,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _inlineRepositoryImpl
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

  void postAuditData(
    SaveInlineData scoreCardData,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .postAuditDatas(
          scoreCardData,
        )
        .then((value) => value.when(success: (LineQCSave data) {
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

  void getDefectTranslationMasterByLanguageCodeData(
    String languagecode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
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
    await _inlineRepositoryImpl
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

  void getFreqUsedDefectsByParamsData(
    String unitcode,
    String audittype,
    String username,
    String languagecode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
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
    await _inlineRepositoryImpl
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

  void postIsFav(
    String defectcode,
    String status,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
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

  void postSaveFreqUsedDefects(
    SaveFreqUsedDefectsModel scoreCardData,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
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
    await _inlineRepositoryImpl
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

  void getLineQCDefectsCountandoverallReportData(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getLineQCDefectsCountandoverallReportDatas(
          unitcode,
          auditDate,
          audittype,
          checkername,
          orderno,
          sewline,
        )
        .then((value) => value.when(
                success: (GetLineQCDefectsCountandoverallReportModel data) {
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

  void getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    String sessioncode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
          unitcode,
          auditDate,
          audittype,
          checkername,
          orderno,
          sewline,
          sessioncode,
        )
        .then((value) => value.when(success:
                (GetAllLineQCsDefectdetailsByRangeHourlysummaryModel data) {
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

  void GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    String sessioncode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl.GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
      unitcode,
      auditDate,
      audittype,
      checkername,
      orderno,
      sewline,
      sessioncode,
    ).then((value) => value.when(
            success: (GetAllLineQCsDefectdetailsByRangeDaysummaryModel data) {
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

  void GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    String sessioncode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
      unitcode,
      auditDate,
      audittype,
      checkername,
      orderno,
      sewline,
      sessioncode,
    ).then((value) => value.when(success:
            (GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel data) {
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

  void GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
    String unitcode,
    String auditDate,
    String audittype,
    String checkername,
    String orderno,
    String sewline,
    String sessioncode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
      unitcode,
      auditDate,
      audittype,
      checkername,
      orderno,
      sewline,
      sessioncode,
    ).then((value) => value.when(success:
            (GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel data) {
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

  void GetSessionCodeDataAPI(
    String currenttime,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl.GetSessionCodeDataAPI(
      currenttime,
    ).then((value) => value.when(success: (GetSessionCodeModel data) {
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

  void getLineQCFrequentUsedOperationsandPartsDatas(
    String unitcode,
    String Rencentdays,
    String audittype,
    String checkername,
    String orderno,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
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

  void getAppDetlListData(
    String unitcode,
    String audittype,
    String ApproverType,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getAppDetlListData(unitcode, audittype, ApproverType)
        .then((value) => value.when(success: (GetAppDetlListModel data) {
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

  void getAllSessionMasterbyunitcode(
    String unitcode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl.getAllSessionMasterbyunitcode(unitcode).then(
        (value) => value.when(success: (GetAllSessionMasterbyunitcode data) {
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

  void RemoveDefectsByIDAPI(
    int id,
    bool isremoveinspectedPcscount,
    bool isremoveAlteredPcscount,
    bool isremoveDefectedPcscount,
    bool isremoveRejectedPcscount,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl.RemoveDefectsByIDAPI(
            id,
            isremoveinspectedPcscount,
            isremoveAlteredPcscount,
            isremoveDefectedPcscount,
            isremoveRejectedPcscount)
        .then((value) => value.when(success: (RemoveDefectsByIDModel data) {
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

  void getLineQCApprovalByParamsListData(
    unitCode,
    audittype,
    auditdate,
    sewline,
    sessioncode,
    orderno,
    approver,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getLineQCApprovalByParamsListData(unitCode, audittype, auditdate,
            sewline, sessioncode, orderno, approver)
        .then((value) =>
            value.when(success: (GetLineQCApprovalByParamsListModel data) {
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

  void GetLineQCApprovalByParamsApproverTypeUserCodeAPI(
    unitCode,
    audittype,
    auditdate,
    sewline,
    sessioncode,
    styleno,
    orderno,
    approvertype,
    usercode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
            .GetLineQCApprovalByParamsApproverTypeUserCodeAPI(
                unitCode,
                audittype,
                auditdate,
                sewline,
                sessioncode,
                styleno,
                orderno,
                approvertype,
                usercode)
        .then((value) => value.when(success:
                (GetLineQCApprovalByParamsApproverTypeUserCodeModel data) {
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

  void postSaveLineQCApproval(
    SaveLineQCApprovalModel saveLineQCApproval,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl.postSaveLineQCApproval(saveLineQCApproval).then(
        (value) => value.when(success: (SaveLineQCApprovalResponseModel data) {
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
    UploadImageModel imgData,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .postImageUploadData(
          imgData,
        )
        .then((value) => value.when(success: (UploadImageResponseModel data) {
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

  void getUserDepartmentListAPI(
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getUserDepartmentListAPI()
        .then((value) => value.when(success: (GetUserDepartmentListModel data) {
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

  void getActiveAuditTypeByRptGroupAPI(
    String rptgroup,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl.getActiveAuditTypeByRptGroupAPI(rptgroup).then(
        (value) =>
            value.when(success: (GetActiveAuditTypeByRptGroupModel data) {
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

  void getAllBuyerDivInfoDataAPI(
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getAllBuyerDivInfoDataAPI()
        .then((value) => value.when(success: (GetAllBuyerDivInfoModel data) {
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

  void getOrderRegWithbuyerDataAPI(
    String buyerdivcode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getOrderRegWithbuyerDataAPI(buyerdivcode)
        .then((value) => value.when(success: (GetOrderRegWithbuyerModel data) {
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

  void getSewLineInfoDataAPI(
    String ucode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getSewLineInfoDataAPI(ucode)
        .then((value) => value.when(success: (GetSewLineInfoModel data) {
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

  void getAssigneeDetailByIDAPI(
    int audittypeid,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getAssigneeDetailByIDAPI(audittypeid)
        .then((value) => value.when(success: (GetAssigneeDetailByIDModel data) {
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

  void GetAllActiveFactoryAPI(
    String locationcode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl.GetAllActiveFactoryAPI(locationcode)
        .then((value) => value.when(success: (GetAllActiveFactoryModel data) {
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

  void postSaveOrderSchedule(
    SaveOrderScheduleRequestModel saveOrderScheduleRequestData,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .postSaveOrderSchedule(
          saveOrderScheduleRequestData,
        )
        .then((value) =>
            value.when(success: (SaveOrderScheduleResponseModel data) {
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

  void getLineQCApprovalByAuditTypeApproverAPI(
    String unitcode,
    String audittype,
    String auditdate,
    String approver,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getLineQCApprovalByAuditTypeApproverAPI(
          unitcode,
          audittype,
          auditdate,
          approver,
        )
        .then((value) => value.when(
                success: (GetLineQCApprovalByAuditTypeApproverModel data) {
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

  void getLineQCApprovalByAuditTypeUsercodeAPI(
    String unitcode,
    String audittype,
    String auditdate,
    String usercode,
    Function onSuccess,
    Function onError,
  ) async {
    await _inlineRepositoryImpl
        .getLineQCApprovalByAuditTypeUsercodeAPI(
          unitcode,
          audittype,
          auditdate,
          usercode,
        )
        .then((value) => value.when(
                success: (GetLineQCApprovalByAuditTypeApproverModel data) {
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

  void getScheduleList(
    String unitCode,
    String currentDate,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _inlineRepositoryImpl
        .getScoreCardAuditInfo(unitCode, currentDate, userN)
        .then((value) => value.when(success: (ScheduleModel data) {
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
    await _inlineRepositoryImpl
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
    await _inlineRepositoryImpl
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
}
