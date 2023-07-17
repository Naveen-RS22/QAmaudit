import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/network/dto/GetBuyerFromOrderRegModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetWashAprovalByIdModel.dart';
import 'package:qapp/app/data/network/dto/GetWashAprovalByUnitcodeOrdernowtypeModel.dart';
import 'package:qapp/app/data/network/dto/SaveProdSamAprlResponseModel.dart';

import 'package:qapp/app/data/network/dto/SaveWashAprovalModel.dart';
import 'package:qapp/app/data/network/dto/SaveWashAprovalResponseModel.dart';
import 'package:qapp/app/data/network/dto/WashApprovalModel.dart';
import 'package:qapp/app/data/network/dto/saveCQCTaskStatusRequestModal.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_use_case.dart';
import 'package:qapp/app/utils/code_snippet.dart';
import '../../data/local/shared_prefs_helper.dart';
import '../../res/constants.dart';

class BeforewashViewModal extends BaseViewModel {
  final BeforeWashUserCase _useCase = AppManager.instance.beforewashUseCase();
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

  void onGetInit(
    BuildContext context,
  ) async {
    initUpdateWashData();
    getBuyerFromOrderReg(context);
    dismissProgress();
  }

  void getImage(BuildContext context) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 100);
      if (image == null) {
        return;
      }
      final imgPer = await saveFile(image.path, context);
      currentImage = imgPer;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<File> saveFile(String imagePath, BuildContext context) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    File imagefile = File(imagePath);
    Uint8List imagebytes = await imagefile.readAsBytes();
    String base64string = base64.encode(imagebytes);
    currentBase64 = base64string;

    // currentImage64 = base64string;
    // currentImageName = name.substring(name.length - 20);

    // postImageUpload(context, name, base64string);

    photoAttachToSaveWashData(base64string, name.substring(name.length - 20));

    notifyListeners();
    return File(imagePath).copy(image.path);
  }

  Future<File> urlToFile(String imageUrl) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.jpg');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  getBuyerFromOrderReg(
    context,
  ) {
    getBuyerFromOrderRegDetail = GetBuyerFromOrderRegModel();
    saveWashData.buyerCode = null;
    notifyListeners();
    _useCase.getBuyerFromOrderRegData((data) {
      getBuyerFromOrderRegDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getOrderRegWithbuyer(
    String buyerdivcode,
    context,
  ) {
    getOrderRegWithbuyerDetail = GetOrderRegWithbuyerModel();
    saveWashData.buyerCode = buyerdivcode;
    saveWashData.orderNo = null;
    saveWashData.orderNoString = null;
    saveWashData.styleNo = null;
    notifyListeners();
    _useCase.getOrderRegWithbuyerData(buyerdivcode, (data) {
      getOrderRegWithbuyerDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetWashAprovalByIdModel getWashAprovalByIdData = GetWashAprovalByIdModel();
  getWashAprovalById(
    int id,
    String endpoint,
    context,
  ) {
    getWashAprovalByIdData = GetWashAprovalByIdModel();
    notifyListeners();
    _useCase.getWashAprovalByIdData(id, endpoint, (data) {
      getWashAprovalByIdData = data;
      washDataFound();
      notifyListeners();
    }, (errorMessage) {
      initUpdateWashDataWithoutBuyerCode();
      dismissProgress();
    });
  }

  postSaveWash(
    context,
  ) {
    FocusScope.of(context).requestFocus(FocusNode());
    showProgress(context);
    saveWashAprovalResponse = SaveWashAprovalResponseModel();

    notifyListeners();
    dynamic data = saveWashData;
    // if (saveWashData.wType == 'A') {
    //   data = [saveWashData];
    // }
    _useCase.postSaveWashData(
        data,
        saveWashData.wType == 'AP'
            ? 'ProdSamPress/SaveProdSamPress'
            : saveWashData.wType == 'A'
                ? 'ProdSamAprl/SaveProdSamAprl1'
                : 'WashAproval/SaveWashAproval', (data) {
      saveWashAprovalResponse = data;
      getWashAprovalById(
          saveWashAprovalResponse.data?.id ?? 0,
          saveWashData.wType == 'AP'
              ? 'ProdSamPress/GetProdSamPressById/'
              : saveWashData.wType == 'A'
                  ? 'ProdSamAprl/GetProdSamAprlById/'
                  : 'WashAproval/GetWashAprovalById/',
          context);
      dismissProgress();
      notifyListeners();
      showErrorAlert('Saved');
    }, (errorMessage) {
      dismissProgress();
    });
  }

  SaveProdSamAprlResponseModel saveProdSamAprlResponseData =
      SaveProdSamAprlResponseModel();
  postSaveWashApproval(
    context,
  ) {
    FocusScope.of(context).requestFocus(FocusNode());
    showProgress(context);
    saveProdSamAprlResponseData = SaveProdSamAprlResponseModel();

    notifyListeners();
    dynamic data = saveWashData;
    if (saveWashData.wType == 'A') {
      data = [saveWashData];
    }
    _useCase.postSaveWashApproval(
        data,
        saveWashData.wType == 'AP'
            ? 'ProdSamPress/SaveProdSamPress'
            : saveWashData.wType == 'A'
                ? 'ProdSamAprl/SaveProdSamAprl1'
                : 'WashAproval/SaveWashAproval', (data) {
      saveProdSamAprlResponseData = data;
      getWashAprovalById(
          (saveProdSamAprlResponseData.data ?? [])[0].id ?? 0,
          saveWashData.wType == 'AP'
              ? 'ProdSamPress/GetProdSamPressById/'
              : saveWashData.wType == 'A'
                  ? 'ProdSamAprl/GetProdSamAprlById/'
                  : 'WashAproval/GetWashAprovalById/',
          context);
      dismissProgress();
      notifyListeners();
      showErrorAlert('Saved');
    }, (errorMessage) {
      dismissProgress();
    });
  }

  SaveCQCTaskStatusRequestModal saveCQCTaskStatusRequest =
      SaveCQCTaskStatusRequestModal();
  SaveCQCTaskStatusResponseModal saveCQCTaskStatusResponseData =
      SaveCQCTaskStatusResponseModal();
  postSaveCQCTaskStatus(
    context,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());

    saveCQCTaskStatusRequest = SaveCQCTaskStatusRequestModal();
    saveCQCTaskStatusResponseData = SaveCQCTaskStatusResponseModal();
    notifyListeners();
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    _useCase.postSaveCQCTaskStatus(
        SaveCQCTaskStatusRequestModal(
            createdBy: userN,
            createdDate: currentDate,
            hostName: 'NA',
            id: 0,
            isActive: true,
            modifiedBy: userN,
            modifiedDate: currentDate,
            orderNo: saveWashData.orderNo,
            taskName: saveWashData.wType,
            taskStatus: currentPassFailType == 'CA' ? 'C' : currentPassFailType,
            unitCode: unitCode), (data) {
      saveCQCTaskStatusResponseData = data;
      notifyListeners();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
    });
  }

  void showErrorAlert(String message) {
    CodeSnippet.instance.showSuccessMsg(message);
  }

  void showErrorAlert2(String message) {
    CodeSnippet.instance.showSuccessMsg(message);
  }

  void getOrderRegWithbuyerOnchange(
      String styleNo, String orderNo, BuildContext context) async {
    saveWashData.orderNo = int.parse(orderNo);
    saveWashData.styleNo = styleNo.toString();
    saveWashData.orderNoString = orderNo;
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    getWashAprovalByUnitcodeOrdernowtype(
        unitCode,
        (saveWashData.orderNo ?? 0).toString(),
        saveWashData.buyerCode ?? '',
        saveWashData.wType ?? '',
        saveWashData.wType == 'AP'
            ? 'ProdSamPress/GetProdSamPressByUnitcodeOrdernobuyercode'
            : saveWashData.wType == 'A'
                ? 'ProdSamAprl/GetProdSamAprlByUnitcodeOrdernobuyercode'
                : 'WashAproval/GetWashAprovalByUnitcodeOrdernowtype',
        context);

    // getWashAprovalByUnitcodeOrdernowtype(
    //     unitCode, (30341 ?? 0).toString(), saveWashData.wType ?? '', context);
    // notifyListeners();
  }

  void initUpdateWashData() async {
    String entityLocationCode =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);
    String userDisplayName =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    saveWashData.buyerCode = null;
    saveWashData.orderNo = null;
    saveWashData.orderNoString = null;
    saveWashData.id = 0;
    saveWashData.wType = 'BW';
    saveWashData.active = 'Y';
    saveWashData.unitCode = unitCode;
    saveWashData.entityID = entityLocationCode;
    saveWashData.createdBy = userDisplayName;
    saveWashData.createdDate = currentDate;
    saveWashData.buyerCode = null;
    saveWashData.styleNo = null;
    saveWashData.orderNo = null;
    saveWashData.isActive = true;
    saveWashData.color = '';
    saveWashData.samStatus = '';
    saveWashData.aprlRemarks = '';
    saveWashData.colorRemarks = '';
    saveWashData.construction = '';
    saveWashData.marking = '';
    saveWashData.stickering = '';
    saveWashData.pressStandard = '';
    saveWashData.markingRemarks = '';
    saveWashData.stickeringRemarks = '';
    saveWashData.pressStandardRemarks = '';
    saveWashData.constructionRemarks = '';
    saveWashData.csVRemarks = '';
    saveWashData.csv = '';
    saveWashData.embellishment = '';
    saveWashData.embellishmentRemarks = '';
    saveWashData.grain = '';
    saveWashData.grainRemarks = '';
    saveWashData.handfeel = '';
    saveWashData.handfeelRemarks = '';
    saveWashData.hostName = '';
    saveWashData.isActive = true;
    saveWashData.nicking = '';
    saveWashData.nickingRemarks = '';
    saveWashData.pilling = '';
    saveWashData.pillingRemarks = '';
    saveWashData.trims = '';
    saveWashData.trimsRemarks = '';

    saveWashData.spec = '';
    saveWashData.specRemarks = '';
    saveWashData.washAprlImagesModels = [];
    saveWashData.afterPressImagesModels = [];

    currentImage = null;
    currentBase64 = '';
    currentCommentController.text = '';
    currentOptionSelect = '';
    currentPassFailType = '';

    if (saveWashData.wType == 'BW') {
      washApprovalArray = [
        WashApprovalArray(
          wType: 'BW',
          title: 'Specification',
          statusValue: 'spec',
          remarkValue: 'spec_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Construction',
          statusValue: 'construction',
          remarkValue: 'construction_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Trims',
          statusValue: 'trims',
          remarkValue: 'trims_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Embellishment',
          statusValue: 'embellishment',
          remarkValue: 'embellishment_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'CSV',
          statusValue: 'csv',
          remarkValue: 'csV_Remarks',
          isSelected: false,
        )
      ];
    }

    notifyListeners();
  }

  void initUpdateWashDataWithoutBuyerCode() async {
    String entityLocationCode =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);
    String userDisplayName =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    getWashAprovalByIdData = GetWashAprovalByIdModel();
    saveWashData.id = 0;
    // saveWashData.wType = 'BW';
    saveWashData.active = 'Y';
    saveWashData.unitCode = unitCode;
    saveWashData.entityID = entityLocationCode;
    saveWashData.createdBy = userDisplayName;
    saveWashData.createdDate = currentDate;
    saveWashData.isActive = true;
    saveWashData.samStatus = '';
    saveWashData.aprlRemarks = '';
    saveWashData.color = '';
    saveWashData.colorRemarks = '';
    saveWashData.construction = '';
    saveWashData.constructionRemarks = '';
    saveWashData.marking = '';
    saveWashData.stickering = '';
    saveWashData.pressStandard = '';
    saveWashData.markingRemarks = '';
    saveWashData.stickeringRemarks = '';
    saveWashData.pressStandardRemarks = '';
    saveWashData.csVRemarks = '';
    saveWashData.csv = '';
    saveWashData.embellishment = '';
    saveWashData.embellishmentRemarks = '';
    saveWashData.grain = '';
    saveWashData.grainRemarks = '';
    saveWashData.handfeel = '';
    saveWashData.handfeelRemarks = '';
    saveWashData.hostName = '';
    saveWashData.isActive = true;
    saveWashData.nicking = '';
    saveWashData.nickingRemarks = '';
    saveWashData.pilling = '';
    saveWashData.pillingRemarks = '';
    saveWashData.trims = '';
    saveWashData.trimsRemarks = '';

    saveWashData.spec = '';
    saveWashData.specRemarks = '';
    saveWashData.washAprlImagesModels = [];
    saveWashData.afterPressImagesModels = [];

    currentImage = null;
    currentBase64 = '';
    currentCommentController.text = '';
    currentOptionSelect = '';
    currentPassFailType = '';

    if (saveWashData.wType == 'BW') {
      washApprovalArray = [
        WashApprovalArray(
          wType: 'BW',
          title: 'Specification',
          statusValue: 'spec',
          remarkValue: 'spec_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Construction',
          statusValue: 'construction',
          remarkValue: 'construction_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Trims',
          statusValue: 'trims',
          remarkValue: 'trims_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Embellishment',
          statusValue: 'embellishment',
          remarkValue: 'embellishment_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'CSV',
          statusValue: 'csv',
          remarkValue: 'csV_Remarks',
          isSelected: false,
        )
      ];
    } else if (saveWashData.wType == 'AW') {
      washApprovalArray = [
        WashApprovalArray(
          wType: 'AW',
          title: 'Specification',
          statusValue: 'spec',
          remarkValue: 'spec_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Construction',
          statusValue: 'construction',
          remarkValue: 'construction_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Trims',
          statusValue: 'trims',
          remarkValue: 'trims_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Grain',
          statusValue: 'grain',
          remarkValue: 'grain_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Embellishment',
          statusValue: 'embellishment',
          remarkValue: 'embellishment_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Handfeel',
          statusValue: 'handfeel',
          remarkValue: 'handfeel_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Pilling',
          statusValue: 'pilling',
          remarkValue: 'pilling_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Nicking',
          statusValue: 'nicking',
          remarkValue: 'nicking_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Color',
          statusValue: 'color',
          remarkValue: 'color_Remarks',
          isSelected: false,
        ),
      ];
    } else if (saveWashData.wType == 'AP') {
      washApprovalArray = [
        WashApprovalArray(
          wType: 'AP',
          title: 'Specification',
          statusValue: 'spec',
          remarkValue: 'spec_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AP',
          title: 'Construction',
          statusValue: 'construction',
          remarkValue: 'construction_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AP',
          title: 'Marking',
          statusValue: 'marking',
          remarkValue: 'marking_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AP',
          title: 'Stickering',
          statusValue: 'stickering',
          remarkValue: 'stickering_Remarks',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AP',
          title: 'Press Standard',
          statusValue: 'pressStandard',
          remarkValue: 'pressStandard_Remarks',
          isSelected: false,
        ),
      ];
    }

    notifyListeners();
  }

  GetWashAprovalByUnitcodeOrdernowtypeModel
      getWashAprovalByUnitcodeOrdernowtypeData =
      GetWashAprovalByUnitcodeOrdernowtypeModel();
  getWashAprovalByUnitcodeOrdernowtype(
    String unitcode,
    String orderno,
    String buyercode,
    String wType,
    String endpoint,
    context,
  ) {
    showProgress(context);
    notifyListeners();
    getWashAprovalByUnitcodeOrdernowtypeData =
        GetWashAprovalByUnitcodeOrdernowtypeModel();
    _useCase.getWashAprovalByUnitcodeOrdernowtypeData(
        unitcode, orderno, buyercode, wType, endpoint, (data) {
      getWashAprovalByUnitcodeOrdernowtypeData = data;

      if ((getWashAprovalByUnitcodeOrdernowtypeData.data ?? []).isNotEmpty) {
        getWashAprovalById(
            getWashAprovalByUnitcodeOrdernowtypeData.data?[0].id ?? 0,
            saveWashData.wType == 'AP'
                ? 'ProdSamPress/GetProdSamPressById/'
                : saveWashData.wType == 'A'
                    ? 'ProdSamAprl/GetProdSamAprlById/'
                    : 'WashAproval/GetWashAprovalById/',
            context);
      } else {
        initUpdateWashDataWithoutBuyerCode();
      }
      dismissProgress();
      notifyListeners();
    }, (errorMessage) {
      print(errorMessage);
      initUpdateWashDataWithoutBuyerCode();
      dismissProgress();
    });
  }

  void washDataFound() {
    saveWashData.id = getWashAprovalByIdData.data?.id ?? 0;
    saveWashData.entityID = getWashAprovalByIdData.data?.entityID ?? '';
    saveWashData.unitCode = getWashAprovalByIdData.data?.unitCode ?? '';
    // saveWashData.wType = getWashAprovalByIdData.data?.wType ?? '';
    saveWashData.spec = getWashAprovalByIdData.data?.spec ?? '';
    saveWashData.samStatus = getWashAprovalByIdData.data?.samStatus ?? '';
    saveWashData.aprlRemarks = getWashAprovalByIdData.data?.aprlRemarks ?? '';
    saveWashData.construction = getWashAprovalByIdData.data?.construction ?? '';
    saveWashData.trims = getWashAprovalByIdData.data?.trims ?? '';
    saveWashData.grain = getWashAprovalByIdData.data?.grain ?? '';
    saveWashData.embellishment =
        getWashAprovalByIdData.data?.embellishment ?? '';
    saveWashData.csv = getWashAprovalByIdData.data?.csv ?? '';
    saveWashData.specRemarks = getWashAprovalByIdData.data?.specRemarks ?? '';
    saveWashData.constructionRemarks =
        getWashAprovalByIdData.data?.constructionRemarks ?? '';
    saveWashData.marking = getWashAprovalByIdData.data?.marking ?? '';
    saveWashData.stickering = getWashAprovalByIdData.data?.stickering ?? '';
    saveWashData.pressStandard =
        getWashAprovalByIdData.data?.pressStandard ?? '';
    saveWashData.markingRemarks =
        getWashAprovalByIdData.data?.markingRemarks ?? '';
    saveWashData.stickeringRemarks =
        getWashAprovalByIdData.data?.stickeringRemarks ?? '';
    saveWashData.pressStandardRemarks =
        getWashAprovalByIdData.data?.pressStandardRemarks ?? '';
    saveWashData.trimsRemarks = getWashAprovalByIdData.data?.trimsRemarks ?? '';
    saveWashData.grainRemarks = getWashAprovalByIdData.data?.grainRemarks ?? '';
    saveWashData.embellishmentRemarks =
        getWashAprovalByIdData.data?.embellishmentRemarks ?? '';
    saveWashData.csVRemarks = getWashAprovalByIdData.data?.csVRemarks ?? '';
    saveWashData.handfeel = getWashAprovalByIdData.data?.handfeel ?? '';
    saveWashData.pilling = getWashAprovalByIdData.data?.pilling ?? '';
    saveWashData.nicking = getWashAprovalByIdData.data?.nicking ?? '';
    saveWashData.color = getWashAprovalByIdData.data?.color ?? '';
    saveWashData.handfeelRemarks =
        getWashAprovalByIdData.data?.handfeelRemarks ?? '';
    saveWashData.pillingRemarks =
        getWashAprovalByIdData.data?.pillingRemarks ?? '';
    saveWashData.nickingRemarks =
        getWashAprovalByIdData.data?.nickingRemarks ?? '';
    saveWashData.colorRemarks = getWashAprovalByIdData.data?.colorRemarks ?? '';
    saveWashData.active = 'Y';
    saveWashData.hostName = getWashAprovalByIdData.data?.hostName ?? '';
    saveWashData.washAprlImagesModels = [];
    saveWashData.afterPressImagesModels = [];
    List<AfterPressImagesModelss> afterPressImagesModels = [];
    List<WashAprlImagesModelss> washAprlImagesModels = [];

    if (saveWashData.wType != 'AP') {
      for (int i = 0;
          i < (getWashAprovalByIdData.data?.washAprlImagesModels ?? []).length;
          i++) {
        washAprlImagesModels.add(WashAprlImagesModelss(
          createdDate:
              getWashAprovalByIdData.data?.washAprlImagesModels?[i].createdDate,
          createdBy:
              getWashAprovalByIdData.data?.washAprlImagesModels?[i].createdBy,
          isActive:
              getWashAprovalByIdData.data?.washAprlImagesModels?[i].isActive,
          id: getWashAprovalByIdData.data?.washAprlImagesModels?[i].id,
          wAprlID:
              getWashAprovalByIdData.data?.washAprlImagesModels?[i].wAprlID,
          wType: getWashAprovalByIdData.data?.washAprlImagesModels?[i].wType,
          descType:
              getWashAprovalByIdData.data?.washAprlImagesModels?[i].descType,
          fName: getWashAprovalByIdData.data?.washAprlImagesModels?[i].fName,
          filePath:
              getWashAprovalByIdData.data?.washAprlImagesModels?[i].filePath,
          packAttach:
              getWashAprovalByIdData.data?.washAprlImagesModels?[i].packAttach,
          hostName:
              getWashAprovalByIdData.data?.washAprlImagesModels?[i].hostName,
        ));
      }
      saveWashData.washAprlImagesModels = washAprlImagesModels;
    } else if (saveWashData.wType == 'AP') {
      for (int i = 0;
          i <
              (getWashAprovalByIdData.data?.afterPressImagesModels ?? [])
                  .length;
          i++) {
        afterPressImagesModels.add(AfterPressImagesModelss(
          createdDate: getWashAprovalByIdData
              .data?.afterPressImagesModels?[i].createdDate,
          createdBy:
              getWashAprovalByIdData.data?.afterPressImagesModels?[i].createdBy,
          isActive:
              getWashAprovalByIdData.data?.afterPressImagesModels?[i].isActive,
          id: getWashAprovalByIdData.data?.afterPressImagesModels?[i].id,
          afPID: getWashAprovalByIdData.data?.afterPressImagesModels?[i].afPID,
          wType: getWashAprovalByIdData.data?.afterPressImagesModels?[i].wType,
          descType:
              getWashAprovalByIdData.data?.afterPressImagesModels?[i].descType,
          fName: getWashAprovalByIdData.data?.afterPressImagesModels?[i].fName,
          filePath:
              getWashAprovalByIdData.data?.afterPressImagesModels?[i].filePath,
          packAttach: getWashAprovalByIdData
              .data?.afterPressImagesModels?[i].packAttach,
          hostName:
              getWashAprovalByIdData.data?.afterPressImagesModels?[i].hostName,
        ));
      }
      saveWashData.afterPressImagesModels = afterPressImagesModels;
    }

    if (saveWashData.wType == 'BW') {
      washApprovalArray = [
        WashApprovalArray(
          wType: 'BW',
          title: 'Specification',
          statusValue: 'spec',
          remarkValue: 'spec_Remarks',
          remark: getWashAprovalByIdData.data?.specRemarks ?? '',
          status: getWashAprovalByIdData.data?.spec ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Construction',
          statusValue: 'construction',
          remarkValue: 'construction_Remarks',
          remark: getWashAprovalByIdData.data?.constructionRemarks ?? '',
          status: getWashAprovalByIdData.data?.construction ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Trims',
          statusValue: 'trims',
          remarkValue: 'trims_Remarks',
          remark: getWashAprovalByIdData.data?.trimsRemarks ?? '',
          status: getWashAprovalByIdData.data?.trims ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'Embellishment',
          statusValue: 'embellishment',
          remarkValue: 'embellishment_Remarks',
          remark: getWashAprovalByIdData.data?.embellishmentRemarks ?? '',
          status: getWashAprovalByIdData.data?.embellishment ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'BW',
          title: 'CSV',
          statusValue: 'csv',
          remarkValue: 'csV_Remarks',
          remark: getWashAprovalByIdData.data?.csVRemarks ?? '',
          status: getWashAprovalByIdData.data?.csv ?? '',
          isSelected: false,
        )
      ];
    } else if (saveWashData.wType == 'AW') {
      washApprovalArray = [
        WashApprovalArray(
          wType: 'AW',
          title: 'Specification',
          statusValue: 'spec',
          remarkValue: 'spec_Remarks',
          remark: getWashAprovalByIdData.data?.specRemarks ?? '',
          status: getWashAprovalByIdData.data?.spec ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Construction',
          statusValue: 'construction',
          remarkValue: 'construction_Remarks',
          remark: getWashAprovalByIdData.data?.constructionRemarks ?? '',
          status: getWashAprovalByIdData.data?.construction ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Trims',
          statusValue: 'trims',
          remarkValue: 'trims_Remarks',
          remark: getWashAprovalByIdData.data?.trimsRemarks ?? '',
          status: getWashAprovalByIdData.data?.trims ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Grain',
          statusValue: 'grain',
          remarkValue: 'grain_Remarks',
          remark: getWashAprovalByIdData.data?.grainRemarks ?? '',
          status: getWashAprovalByIdData.data?.grain ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Embellishment',
          statusValue: 'embellishment',
          remarkValue: 'embellishment_Remarks',
          remark: getWashAprovalByIdData.data?.embellishmentRemarks ?? '',
          status: getWashAprovalByIdData.data?.embellishment ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Handfeel',
          statusValue: 'handfeel',
          remarkValue: 'handfeel_Remarks',
          remark: getWashAprovalByIdData.data?.handfeelRemarks ?? '',
          status: getWashAprovalByIdData.data?.handfeel ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Pilling',
          statusValue: 'pilling',
          remarkValue: 'pilling_Remarks',
          remark: getWashAprovalByIdData.data?.pillingRemarks ?? '',
          status: getWashAprovalByIdData.data?.pilling ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Nicking',
          statusValue: 'nicking',
          remarkValue: 'nicking_Remarks',
          remark: getWashAprovalByIdData.data?.nickingRemarks ?? '',
          status: getWashAprovalByIdData.data?.nicking ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AW',
          title: 'Color',
          statusValue: 'color',
          remarkValue: 'color_Remarks',
          remark: getWashAprovalByIdData.data?.colorRemarks ?? '',
          status: getWashAprovalByIdData.data?.color ?? '',
          isSelected: false,
        ),
      ];
    } else if (saveWashData.wType == 'AP') {
      washApprovalArray = [
        WashApprovalArray(
          wType: 'AP',
          title: 'Specification',
          statusValue: 'spec',
          remarkValue: 'spec_Remarks',
          remark: getWashAprovalByIdData.data?.specRemarks ?? '',
          status: getWashAprovalByIdData.data?.spec ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AP',
          title: 'Construction',
          statusValue: 'construction',
          remarkValue: 'construction_Remarks',
          remark: getWashAprovalByIdData.data?.constructionRemarks ?? '',
          status: getWashAprovalByIdData.data?.construction ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AP',
          title: 'Marking',
          statusValue: 'marking',
          remarkValue: 'marking_Remarks',
          remark: getWashAprovalByIdData.data?.markingRemarks ?? '',
          status: getWashAprovalByIdData.data?.marking ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AP',
          title: 'Stickering',
          statusValue: 'stickering',
          remarkValue: 'stickering_Remarks',
          remark: getWashAprovalByIdData.data?.stickeringRemarks ?? '',
          status: getWashAprovalByIdData.data?.stickering ?? '',
          isSelected: false,
        ),
        WashApprovalArray(
          wType: 'AP',
          title: 'Press Standard',
          statusValue: 'pressStandard',
          remarkValue: 'pressStandard_Remarks',
          remark: getWashAprovalByIdData.data?.pressStandardRemarks ?? '',
          status: getWashAprovalByIdData.data?.pressStandard ?? '',
          isSelected: false,
        ),
      ];
    } else if (saveWashData.wType == 'A') {
      currentCommentController.text =
          getWashAprovalByIdData.data?.aprlRemarks ?? '';
      currentPassFailType = getWashAprovalByIdData.data?.samStatus ?? '';
    }

    notifyListeners();
  }

  void changeWashType(String wType, BuildContext context) async {
    saveWashData.wType = wType;
    notifyListeners();
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    initUpdateWashDataWithoutBuyerCode();
    getWashAprovalByUnitcodeOrdernowtype(
        unitCode,
        (saveWashData.orderNo ?? 0).toString(),
        saveWashData.buyerCode ?? '',
        saveWashData.wType ?? '',
        saveWashData.wType == 'AP'
            ? 'ProdSamPress/GetProdSamPressByUnitcodeOrdernobuyercode'
            : saveWashData.wType == 'A'
                ? 'ProdSamAprl/GetProdSamAprlByUnitcodeOrdernobuyercode'
                : 'WashAproval/GetWashAprovalByUnitcodeOrdernowtype',
        context);

    // getWashAprovalByUnitcodeOrdernowtype(
    //     unitCode, (30341 ?? 0).toString(), saveWashData.wType ?? '', context);
  }

  void currentOptionSelectOnChange(
      String option, int index, BuildContext context) {
    for (int i = 0; i < washApprovalArray.length; i++) {
      if (i == index) {
        washApprovalArray[i].isSelected = true;
      } else {
        washApprovalArray[i].isSelected = false;
      }
    }

    currentOptionSelect = option;
    clearButton(context);
    assignDataAsOptionChange(index);
    notifyListeners();
  }

  void photoAttachToSaveWashData(String base64, String fileName) async {
    var saveWashDataJson = saveWashData.toJson();
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    String currentDate = dateToday.toString().substring(0, 10);
    for (int i = 0; i < washApprovalArray.length; i++) {
      if (washApprovalArray[i].isSelected ?? false) {
        List<WashAprlImagesModelss> washAprlImagesModels =
            saveWashData.washAprlImagesModels ?? [];
        washAprlImagesModels.add(WashAprlImagesModelss(
            createdDate: currentDate,
            createdBy: userN,
            modifiedDate: currentDate,
            modifiedBy: userN,
            hostName: washApprovalArray[i].statusValue,
            descType: currentPassFailType,
            fName: fileName,
            filePath: '',
            packAttach: base64,
            id: 0,
            wAprlID: saveWashData.id,
            isActive: true,
            wType: saveWashData.wType));

        saveWashData.washAprlImagesModels = washAprlImagesModels;

        List<AfterPressImagesModelss> afterPressImagesModels =
            saveWashData.afterPressImagesModels ?? [];
        afterPressImagesModels.add(AfterPressImagesModelss(
            createdDate: currentDate,
            createdBy: userN,
            modifiedDate: currentDate,
            modifiedBy: userN,
            hostName: washApprovalArray[i].statusValue,
            descType: currentPassFailType,
            fName: fileName,
            filePath: '',
            packAttach: base64,
            id: 0,
            afPID: saveWashData.id,
            isActive: true,
            wType: saveWashData.wType));

        saveWashData.afterPressImagesModels = afterPressImagesModels;
      }
    }
  }

  void curretPassFailOnChange(String status, BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    currentPassFailType = status;

    var saveWashDataJson = saveWashData.toJson();
    for (int i = 0; i < washApprovalArray.length; i++) {
      if (washApprovalArray[i].isSelected ?? false) {
        saveWashDataJson[washApprovalArray[i].statusValue ?? ''] =
            currentPassFailType;
      }
    }

    saveWashData = SaveWashAprovalModel.fromJson(saveWashDataJson);
    saveWashData.samStatus = status;
    print(status);
    notifyListeners();
  }

  void clearButton(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    currentPassFailType = '';
    currentBase64 = '';
    currentImage = null;
    currentCommentController.text = '';

    notifyListeners();
  }

  void customNotifyLisitners() {
    notifyListeners();
  }

  void currentCommentControllerOnChange(String value, BuildContext context) {
    var saveWashDataJson = saveWashData.toJson();
    for (int i = 0; i < washApprovalArray.length; i++) {
      if (washApprovalArray[i].isSelected ?? false) {
        saveWashDataJson[washApprovalArray[i].remarkValue ?? ''] = value;
      }
    }

    saveWashData = SaveWashAprovalModel.fromJson(saveWashDataJson);
    saveWashData.aprlRemarks = value;

    notifyListeners();
  }

  void assignDataAsOptionChange(int index) async {
    var saveWashDataJson = saveWashData.toJson();
    var washArray = washApprovalArray[index].toJson();
    washArray['remark'] =
        saveWashDataJson[washApprovalArray[index].remarkValue];
    washApprovalArray[index] = WashApprovalArray.fromJson(washArray);

    String remark =
        (saveWashDataJson[washApprovalArray[index].remarkValue]) ?? '';
    if (remark.isNotEmpty) {
      currentCommentController.text = remark;
    } else {
      currentCommentController.text = '';
    }

    String passFailType =
        (saveWashDataJson[washApprovalArray[index].statusValue]) ?? '';
    if (passFailType.isNotEmpty) {
      currentPassFailType = passFailType.trim();
    } else {
      currentPassFailType = '';
    }

    if (saveWashData.wType != 'AP') {
      for (int i = 0;
          i < (saveWashData.washAprlImagesModels ?? []).length;
          i++) {
        if (washApprovalArray[index].statusValue ==
            (saveWashData.washAprlImagesModels ?? [])[i].hostName) {
          currentBase64 =
              (saveWashData.washAprlImagesModels ?? [])[i].filePath ?? '';
          currentImage = await urlToFile(
              (saveWashData.washAprlImagesModels ?? [])[i].filePath ?? '');
        }
      }
    } else if (saveWashData.wType == 'AP') {
      for (int i = 0;
          i < (saveWashData.afterPressImagesModels ?? []).length;
          i++) {
        if (washApprovalArray[index].statusValue ==
            (saveWashData.afterPressImagesModels ?? [])[i].hostName) {
          currentBase64 =
              (saveWashData.afterPressImagesModels ?? [])[i].filePath ?? '';
          currentImage = await urlToFile(
              (saveWashData.afterPressImagesModels ?? [])[i].filePath ?? '');
        }
      }
    }

    notifyListeners();
  }
}
