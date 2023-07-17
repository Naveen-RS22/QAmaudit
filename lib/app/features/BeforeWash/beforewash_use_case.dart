import 'dart:developer';

import 'package:fimber/fimber.dart';
import 'package:qapp/app/data/network/dto/GetBuyerFromOrderRegModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetWashAprovalByIdModel.dart';
import 'package:qapp/app/data/network/dto/GetWashAprovalByUnitcodeOrdernowtypeModel.dart';
import 'package:qapp/app/data/network/dto/SaveProdSamAprlResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveWashAprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/saveCQCTaskStatusRequestModal.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/BeforeWash/beforewash_imp.dart';
import 'package:qapp/app/widgets/dialog_utils.dart';
import '../../data/network/dto/UserAppModel.dart';

class BeforeWashUserCase {
  late BeforewashRepositoryImpl _beforewashRepositoryImpl;
  BeforeWashUserCase(BeforewashRepositoryImpl repository) {
    _beforewashRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _beforewashRepositoryImpl
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
    await _beforewashRepositoryImpl
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
    await _beforewashRepositoryImpl
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
    await _beforewashRepositoryImpl
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
    await _beforewashRepositoryImpl
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
    await _beforewashRepositoryImpl
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
    await _beforewashRepositoryImpl
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
    await _beforewashRepositoryImpl
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
    await _beforewashRepositoryImpl
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
}
