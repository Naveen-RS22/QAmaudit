import 'dart:developer';
import 'package:fimber/fimber.dart';
import 'package:qapp/app/data/network/dto/GetBuyerFromOrderRegModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetProdSamCutInspectionByIdNew.dart';
import 'package:qapp/app/data/network/dto/GetProductType.dart';
import 'package:qapp/app/data/network/dto/saveCutInspectionResponseModel.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/cutInspection/cutinspection_imp.dart';
import 'package:qapp/app/widgets/dialog_utils.dart';
import '../../data/network/dto/GetAllActiveFactoryModel.dart';
import '../../data/network/dto/GetAllGarPartDataModel.dart';
import '../../data/network/dto/GetProdSamCutInspectionByparams.dart';
import '../../data/network/dto/UserAppModel.dart';

class CutInspectionUserCase {
  late CutInspectionRepositoryImpl _cutInspectionRepositoryImpl;
  CutInspectionUserCase(CutInspectionRepositoryImpl repository) {
    _cutInspectionRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _cutInspectionRepositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              onSuccess(data);
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getsamCutting(
    String unitcode,
    String date,
    String buyercode,
    String orderno,
    String color,
    String fit,
    Function onSuccess,
    Function onError,
  ) async {
    await _cutInspectionRepositoryImpl
        .getProdSamCutInspectionByparams(
          unitcode,
          date,
          buyercode,
          orderno,
          color,
          fit,
        )
        .then((value) =>
            value.when(success: (GetProdSamCutInspectionByparams data) {
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

  void getsamCuttID(
    int id,
    String endpoint,
    Function onSuccess,
    Function onError,
  ) async {
    await _cutInspectionRepositoryImpl.getProdSamCutt(id, endpoint).then(
        (value) => value.when(success: (GetProdSamCutInspectionByIdNew data) {
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

  void getBuyerFromOrderRegData(
    Function onSuccess,
    Function onError,
  ) async {
    await _cutInspectionRepositoryImpl
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
    await _cutInspectionRepositoryImpl
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

  void GetAllActiveFactoryAPI(
    String locationcode,
    Function onSuccess,
    Function onError,
  ) async {
    await _cutInspectionRepositoryImpl.GetAllActiveFactoryAPI(locationcode)
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

  void getDsLists(
    String orderNo,
    Function onSuccess,
    Function onError,
  ) async {
    await _cutInspectionRepositoryImpl
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

  void getPartData(
    String productType,
    Function onSuccess,
    Function onError,
  ) async {
    await _cutInspectionRepositoryImpl
        .getSleevesDatas(productType)
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

  void getProductType(
    String orderNo,
    Function onSuccess,
    Function onError,
  ) async {
    await _cutInspectionRepositoryImpl
        .getproduct(orderNo)
        .then((value) => value.when(success: (GetProductType data) {
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

  void postSaveCutInspection(
    dynamic savecutInspection,
    String endpoint,
    Function onSuccess,
    Function onError,
  ) async {
    await _cutInspectionRepositoryImpl
        .postSaveCutInspection(
          savecutInspection,
          endpoint,
        )
        .then((value) =>
            value.when(success: (savecutInspectionResponseModel data) {
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
}
