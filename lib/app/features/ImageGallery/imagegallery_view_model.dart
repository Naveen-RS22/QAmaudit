import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/dto/GetAllAuditTypeModel.dart';
import 'package:qapp/app/data/network/dto/GetAllBuyerDivInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetBuyerFromOrderRegModel.dart';
import 'package:qapp/app/data/network/dto/GetGalleryListModel.dart';
import 'package:qapp/app/data/network/dto/GetGalleryListResponseModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetSewLineInfoModel.dart';

import 'package:qapp/app/data/network/dto/SaveWashAprovalModel.dart';
import 'package:qapp/app/data/network/dto/SaveWashAprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/WashApprovalModel.dart';
import 'package:qapp/app/features/ImageGallery/imagegallery_use_case.dart';
import 'package:qapp/app/utils/code_snippet.dart';
import '../../data/local/shared_prefs_helper.dart';

class ImageGalleryViewModal extends BaseViewModel {
  final ImageGalleryUserCase _useCase =
      AppManager.instance.imageGalleryUseCase();
  SaveWashAprovalModel saveWashData = SaveWashAprovalModel();
  SaveWashAprovalResponseModel saveWashAprovalResponse =
      SaveWashAprovalResponseModel();
  GetBuyerFromOrderRegModel getBuyerFromOrderRegDetail =
      GetBuyerFromOrderRegModel();
  GetOrderRegWithbuyerModel getOrderRegWithbuyerDetail =
      GetOrderRegWithbuyerModel();

  DateTime dateToday = DateTime.now();

  List<WashApprovalArray> washApprovalArray = [];

  File? currentImage;
  String currentBase64 = '';
  TextEditingController currentCommentController = TextEditingController();
  String currentOptionSelect = '';
  String currentPassFailType = '';

  List<InspectionModel> insType = [
    InspectionModel(key: 'F', value: 'Final'),
    InspectionModel(key: 'PF', value: 'Pre Final'),
    InspectionModel(key: 'I', value: 'Interim'),
    InspectionModel(key: 'HP', value: '100 PCS'),
    InspectionModel(key: 'PR', value: 'Pilor Run'),
  ];

  void onGetInit(
    BuildContext context,
  ) async {
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    getGalleryListData = GetGalleryListModel();
    getGalleryListResponseData = GetGalleryListResponseModel();
    notifyListeners();
    getAllAuditType(context);
    getAllBuyerDivInfoDataAPI(context);
    getAllDefectMasterAPI(context);
    getSewLineInfoDataAPI(context, unitCode);

    dismissProgress();
  }

  void showErrorAlert(String message) {
    CodeSnippet.instance.showSuccessMsg(message);
  }

  void showErrorAlert2(String message) {
    CodeSnippet.instance.showSuccessMsg(message);
  }

  void showEndDate(
    BuildContext context,
  ) {
    showDatePicker(
      context: context,
      confirmText: 'confimdsf',
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    ).then((value) => print(value));
  }

  GetGalleryListModel getGalleryListData = GetGalleryListModel();

  showDate(BuildContext context, bool isStart) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xffF06434), // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xffF06434), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (isStart) {
        getGalleryListData.fromDate =
            value.toString().characters.take(10).toString();
      } else {
        getGalleryListData.toDate =
            value.toString().characters.take(10).toString();
      }
      notifyListeners();
      if (value == null) {
        if (isStart) {
          getGalleryListData.fromDate = '';
        } else {
          getGalleryListData.toDate = '';
        }
      }
      return null;
    });
  }

  GetAllAuditTypeModel getAllAuditTypeData = GetAllAuditTypeModel();
  getAllAuditType(
    context,
  ) {
    notifyListeners();
    getAllAuditTypeData = GetAllAuditTypeModel();
    notifyListeners();
    _useCase.getAllAuditType((data) {
      getAllAuditTypeData = data;
      notifyListeners();
    }, (errorMessage) {});
  }

  GetAllDefectMasterModel getAllDefectMasterData = GetAllDefectMasterModel();
  getAllDefectMasterAPI(
    context,
  ) {
    notifyListeners();
    getAllDefectMasterData = GetAllDefectMasterModel();
    notifyListeners();
    _useCase.getAllDefectMasterAPI((data) {
      getAllDefectMasterData = data;
      notifyListeners();
    }, (errorMessage) {});
  }

  GetAllBuyerDivInfoModel getAllBuyerDivInfoData = GetAllBuyerDivInfoModel();
  List<GetAllBuyerDivInfoArray> uniquelist = [];
  getAllBuyerDivInfoDataAPI(context) async {
    getAllBuyerDivInfoData = GetAllBuyerDivInfoModel();
    notifyListeners();
    _useCase.getAllBuyerDivInfoDataAPI((data) {
      getAllBuyerDivInfoData = data;
      notifyListeners();
    }, (errorMessage) {});
  }

  GetOrderRegWithbuyerModel getOrderRegWithbuyerData =
      GetOrderRegWithbuyerModel();
  getOrderRegWithbuyerDataAPI(context, buyerdivcode) async {
    getOrderRegWithbuyerData = GetOrderRegWithbuyerModel();
    notifyListeners();
    _useCase.getOrderRegWithbuyerDataAPI(buyerdivcode, (data) {
      getOrderRegWithbuyerData = data;
      notifyListeners();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
    });
  }

  GetSewLineInfoModel getSewLineInfoData = GetSewLineInfoModel();
  getSewLineInfoDataAPI(context, ucode) async {
    getSewLineInfoData = GetSewLineInfoModel();
    notifyListeners();
    _useCase.getSewLineInfoDataAPI(ucode, (data) {
      getSewLineInfoData = data;
      notifyListeners();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
    });
  }

  void changeAuditType(String auditType) {
    getGalleryListData.audittype = auditType;
    getGalleryListData.instype = '';
    notifyListeners();
  }

  void changeInsType(String instype) {
    getGalleryListData.instype = instype;
    notifyListeners();
  }

  void changeBuyerDiv(BuildContext context, String buyerdivision) {
    getGalleryListData.buyerdivision = buyerdivision;
    getOrderRegWithbuyerDataAPI(context, buyerdivision);
    notifyListeners();
  }

  void changeOrderNo(String orderno) {
    getGalleryListData.orderno = orderno;
    notifyListeners();
  }

  void changeLine(String sewline) {
    getGalleryListData.sewline = sewline;
    notifyListeners();
  }

  void changeDefectCode(String defectCode) {
    getGalleryListData.defectCode = defectCode;
    notifyListeners();
  }

  GetGalleryListAPIConfirm(BuildContext context) {
    if ((getGalleryListData.audittype ?? '').isEmpty ||
        (getGalleryListData.fromDate ?? '').isEmpty ||
        (getGalleryListData.toDate ?? '').isEmpty) {
      showErrorAlert('Mandatory feilds are missing');
    } else {
      GetGalleryListAPI(context);
    }
  }

  GetGalleryListResponseModel getGalleryListResponseData =
      GetGalleryListResponseModel();
  GetGalleryListAPI(
    context,
  ) async {
    notifyListeners();
    showProgress(context);
    getGalleryListResponseData = GetGalleryListResponseModel();
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    notifyListeners();
    _useCase.GetGalleryListAPI(
        unitCode,
        getGalleryListData.audittype ?? '',
        getGalleryListData.instype ?? '',
        getGalleryListData.buyerdivision ?? '',
        getGalleryListData.orderno ?? '',
        getGalleryListData.sewline ?? '',
        getGalleryListData.defectCode ?? '',
        getGalleryListData.fromDate ?? '',
        getGalleryListData.toDate ?? '',
        (getGalleryListData.instype ?? '').isNotEmpty
            ? ApiConstants.GetGalleryList1
            : ApiConstants.GetGalleryList, (data) {
      getGalleryListResponseData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage.toString());
      dismissProgress();
    });
  }
}
