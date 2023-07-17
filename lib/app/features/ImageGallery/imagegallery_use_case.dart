import 'dart:developer';

import 'package:fimber/fimber.dart';
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
import 'package:qapp/app/data/network/dto/SaveWashAprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/saveCQCTaskStatusRequestModal.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/ImageGallery/imagegallery_imp.dart';
import 'package:qapp/app/widgets/dialog_utils.dart';
import '../../data/network/dto/UserAppModel.dart';

class ImageGalleryUserCase {
  late ImageGalleryRepositoryImpl _imageGalleryRepositoryImpl;
  ImageGalleryUserCase(ImageGalleryRepositoryImpl repository) {
    _imageGalleryRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _imageGalleryRepositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              onSuccess(data);
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getBuyerFromOrderRegData(
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .getBuyerFromOrderRegDatas()
        .then((value) => value.when(success: (GetBuyerFromOrderRegModel data) {
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

  void getOrderRegWithbuyerData(
    String buyerdivcode,
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .getOrderRegWithbuyerDatas(buyerdivcode)
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

  void getWashAprovalByIdData(
    int id,
    String endpoint,
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .getWashAprovalByIdDatas(id, endpoint)
        .then((value) => value.when(success: (GetWashAprovalByIdModel data) {
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

  void postSaveWashData(
    dynamic saveWashData,
    String endpoint,
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .postSaveWashDatas(
          saveWashData,
          endpoint,
        )
        .then(
            (value) => value.when(success: (SaveWashAprovalResponseModel data) {
                  inspect(data);
                  if (data.isSuccess ?? false) {
                    onSuccess(data);
                  } else {
                    onError(data.message);
                  }
                }, failure: (NetworkExceptions failure) {
                  print(failure);
                  Fimber.d("===>$failure");
                  DialogUtils.instance.dismissProgressbar();
                }));
  }

  void postSaveWashApproval(
    dynamic saveWashData,
    String endpoint,
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .postSaveWashApproval(
          saveWashData,
          endpoint,
        )
        .then(
            (value) => value.when(success: (SaveProdSamAprlResponseModel data) {
                  inspect(data);
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

  void postSaveCQCTaskStatus(
    SaveCQCTaskStatusRequestModal saveCQCTaskStatusRequest,
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .postSaveCQCTaskStatus(
          saveCQCTaskStatusRequest,
        )
        .then((value) =>
            value.when(success: (SaveCQCTaskStatusResponseModal data) {
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

  void postImageUploadData(
    UploadImageModel imgData,
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
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

  void getWashAprovalByUnitcodeOrdernowtypeData(
    String unitcode,
    String orderno,
    String buyercode,
    String wType,
    String endpoint,
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .getWashAprovalByUnitcodeOrdernowtypeData(
          unitcode,
          orderno,
          buyercode,
          wType,
          endpoint,
        )
        .then((value) => value.when(
                success: (GetWashAprovalByUnitcodeOrdernowtypeModel data) {
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

  void getAllAuditType(
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .getAllAuditType()
        .then((value) => value.when(success: (GetAllAuditTypeModel data) {
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

  void getAllDefectMasterAPI(
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl
        .getAllDefectMasterAPI()
        .then((value) => value.when(success: (GetAllDefectMasterModel data) {
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
    await _imageGalleryRepositoryImpl
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
    await _imageGalleryRepositoryImpl
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
    await _imageGalleryRepositoryImpl
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

  void GetGalleryListAPI(
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
    Function onSuccess,
    Function onError,
  ) async {
    await _imageGalleryRepositoryImpl.GetGalleryListAPI(
      unitcode,
      audittype,
      instype,
      buyerdivision,
      orderno,
      sewline,
      defectCode,
      fromDate,
      toDate,
      endpoint,
    ).then((value) => value.when(success: (GetGalleryListResponseModel data) {
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
