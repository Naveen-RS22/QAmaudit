import 'package:fimber/fimber.dart';
import 'package:qapp/app/data/network/dto/CheckAuditPackIDExistsModel.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarOperationMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarPartDataModel.dart';
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
import 'package:qapp/app/data/network/dto/GetMesMentDefectsByUomModel.dart';
import 'package:qapp/app/data/network/dto/GetOperCodeByPartIdModel.dart';
import 'package:qapp/app/data/network/dto/GetUDMasterByTypeModel.dart';
import 'package:qapp/app/data/network/dto/GetVisualAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/GetVisualFavouriteModal.dart';
import 'package:qapp/app/data/network/dto/IscheckAuidtExistsModel.dart';
import 'package:qapp/app/data/network/dto/OperatorsChartsModel.dart';
import 'package:qapp/app/data/network/dto/PostSaveAuditModel.dart';
import 'package:qapp/app/data/network/dto/RemoveAuditQcDetlResponse.dart';
import 'package:qapp/app/data/network/dto/SaveAuditModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateInternalAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/InternalAudit/internal_audit_imp.dart';
import 'package:qapp/app/widgets/dialog_utils.dart';
import '../../data/local/shared_prefs_helper.dart';
import '../../data/network/dto/UserAppModel.dart';
import '../../res/constants.dart';

class InternalAuditUserCase {
  late InternalAuditRepositoryImpl _internalAuditRepositoryImpl;
  InternalAuditUserCase(InternalAuditRepositoryImpl repository) {
    _internalAuditRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _internalAuditRepositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              onSuccess(data);
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void updateAuditStatusAPIdata(
    auditschhdID,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .updateAuditStatusAPIdatas(auditschhdID)
        .then((value) => value.when(success: (UpdateAuditStatusModel data) {
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

  void UpdateInternalAuditStatusData(
    unitCode,
    currentDate,
    audittype,
    auditorname,
    orderno,
    insType,
    sessionname,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.UpdateInternalAuditStatusData(
      unitCode,
      currentDate,
      audittype,
      auditorname,
      orderno,
      insType,
      sessionname,
    ).then(
        (value) => value.when(success: (UpdateInternalAuditStatusModel data) {
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

  void getDsLists(
    String orderNo,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getDsListDatas(orderNo)
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

  void getDsListDetailDataa(
    orderno,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getDsListDetailDataas(orderno)
        .then((value) => value.when(success: (GetDsListModels data) {
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

  void getAllGarPartData(
    String ProductType,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getAllGarPartDatas(ProductType)
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

  void getAllGarOperationMasterData(
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.getAllGarOperationMasterDatas().then(
        (value) => value.when(success: (GetAllGarOperationMasterModel data) {
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

  void getVisualFavoriteDefuctData(
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getVisualFavoriteDefectData()
        .then((value) => value.when(success: (GetVisualFavouriteModal data) {
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

  void getVisualAllDefectData(
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getVisualAllDefectDatas()
        .then((value) => value.when(success: (GetVisualAllDefectsModel data) {
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
    await _internalAuditRepositoryImpl
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

  void getMesMentDefectsByUomData(
    Uom,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.getMesMentDefectsByUomDatas(Uom).then(
        (value) => value.when(success: (GetMesMentDefectsByUomModel data) {
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

  void getAqlBaseInfoData(
    unitcode,
    buyercode,
    aqltype,
    auditformat,
    packqty,
    noofcartons,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getAqlBaseInfoDatas(
            unitcode, buyercode, aqltype, auditformat, packqty, noofcartons)
        .then((value) => value.when(success: (GetAqlBaseInfoModel data) {
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
    await _internalAuditRepositoryImpl
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
    await _internalAuditRepositoryImpl
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
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
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
    await _internalAuditRepositoryImpl
        .getOperatorsCntChart(scoreCardData)
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

  void getEmpCodeData(
    empCode,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
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
    await _internalAuditRepositoryImpl
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

  void postAuditDatas(
    SaveAuditModel saveAuditData,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .postAuditDatas(
          saveAuditData,
        )
        .then((value) => value.when(success: (PostSaveAuditModel data) {
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
    await _internalAuditRepositoryImpl
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
    await _internalAuditRepositoryImpl
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

  void postIsFav(
    String defectcode,
    String status,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
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

  void getFreqUsedDefectsByParamswithChkType(
    String unitcode,
    String audittype,
    String username,
    String languagecode,
    String chktype,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getFreqUsedDefectsByParamswithChkType(
            unitcode, audittype, username, languagecode, chktype)
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
    String chktype,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getAllDefectswithFreqUsedDefectsByParamsDatas(
            unitcode, audittype, username, languagecode, chktype)
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
    await _internalAuditRepositoryImpl
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
    await _internalAuditRepositoryImpl
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
    String checktype,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .getLineQCFrequentUsedOperationsandPartsDatass(
          unitcode,
          Rencentdays,
          audittype,
          checkername,
          orderno,
          checktype,
        )
        .then((value) => value.when(success:
                (GetAuditQCFrequentUsedOperationsandPartschecktypeResponseModal
                    data) {
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
    await _internalAuditRepositoryImpl
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

  void getOperCodeByPartIdData(
    int partid,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
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

  void IscheckAuidtExistsAPI(
    String unitcode,
    String auditdate,
    String audittype,
    String instype,
    int orderno,
    int orderqty,
    String auditorname,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.IscheckAuidtExistsAPI(
      unitcode,
      auditdate,
      audittype,
      instype,
      orderno,
      orderqty,
      auditorname,
    ).then((value) => value.when(success: (IscheckAuidtExistsModel data) {
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

  void GetDefectsByCategoryAPI(
    String category,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.GetDefectsByCategoryAPI(category)
        .then((value) => value.when(success: (GetDefectsByCategoryModel data) {
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

  void checkAuditPackIDExistsAPI(
    int id,
    String packid,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl
        .checkAuditPackIDExistsAPI(id, packid)
        .then(
            (value) => value.when(success: (CheckAuditPackIDExistsModel data) {
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

  void GetDsheadByParamAPI(
    String unitcode,
    String audittype,
    String orderno,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.GetDsheadByParamAPI(
            unitcode, audittype, orderno)
        .then((value) => value.when(success: (GetDsheadByParamModel data) {
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

  void GetUDMasterByTypeAPI(
    String type,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.GetUDMasterByTypeAPI(type)
        .then((value) => value.when(success: (GetUDMasterByTypeModel data) {
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

  void GetAuditHeadDataByIdNewAPI(
    int auditheadid,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.GetAuditHeadDataByIdNewAPI(auditheadid)
        .then(
            (value) => value.when(success: (GetAuditHeadDataByIdNewModel data) {
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

  void GetAuditHeadDataByIdAPI(
    int auditheadid,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.GetAuditHeadDataByIdAPI(auditheadid)
        .then((value) => value.when(success: (GetAuditHeadDataByIdModel data) {
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

  void RemoveAuditQcDetlResponseAPI(
    item,
    Function onSuccess,
    Function onError,
  ) async {
    await _internalAuditRepositoryImpl.RemoveAuditQcDetlResponseAPI(item)
        .then((value) => value.when(success: (RemoveAuditQcDetlResponse data) {
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
