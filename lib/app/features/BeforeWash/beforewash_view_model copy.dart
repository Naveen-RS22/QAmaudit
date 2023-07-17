// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:qapp/app/base/base_view_model.dart';
// import 'package:qapp/app/base/di.dart';
// import 'package:qapp/app/data/network/dto/GetBuyerFromOrderRegModel.dart';
// import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';

// import 'package:qapp/app/data/network/dto/SaveWashAprovalModel.dart';
// import 'package:qapp/app/data/network/dto/SaveWashAprovalResponseModel.dart';
// import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
// import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
// import 'package:qapp/app/data/network/dto/saveCQCTaskStatusRequestModal.dart';
// import 'package:qapp/app/features/BeforeWash/beforewash_use_case.dart';
// import 'package:qapp/app/utils/code_snippet.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../data/local/shared_prefs_helper.dart';
// import '../../res/constants.dart';
// import 'package:http/http.dart' as http;

// class BeforewashViewModal extends BaseViewModel {
//   final BeforeWashUserCase _useCase = AppManager.instance.beforewashUseCase();
//   SaveWashAprovalModel saveWashData = SaveWashAprovalModel();
//   SaveWashAprovalResponseModel saveWashAprovalResponse =
//       SaveWashAprovalResponseModel();
//   GetBuyerFromOrderRegModel getBuyerFromOrderRegDetail =
//       GetBuyerFromOrderRegModel();
//   GetOrderRegWithbuyerModel getOrderRegWithbuyerDetail =
//       GetOrderRegWithbuyerModel();
//   TextEditingController currentCommentController = TextEditingController();

//   bool beforeWashCompleted = false;
//   bool afterWashCompleted = false;
//   bool afterPressCompleted = false;

//   File? currentImage;

//   int currentMenu = 0;

//   int currentCheck = 1;
//   String selectMenu = 'Specification';
//   String currentImage64 = "";
//   String currentImageName = "";
//   String currentComment = "";
//   String currentPassFail = "";

//   List<String> beforeItems = [
//     'Specification',
//     'Construction',
//     'Trims',
//     'Embellishment',
//     'CSV',
//   ];

//   List<String> afterItems = [
//     'Specification',
//     'Construction',
//     'Trims',
//     'Grain',
//     'Embellishment',
//     'Handfeel',
//     'Pilling',
//     'Nicking',
//     'Color',
//   ];

//   List<String> afterPressItems = [
//     'Specification',
//     'Construction',
//     'Marking',
//     'Stickering',
//     'Press Standard',
//   ];
//   List<String> currentMenuItem = [];

//   DateTime dateToday = DateTime.now();

//   void menuSetter() {
//     if (currentCheck == 1) {
//       currentMenuItem = beforeItems;
//     } else if (currentCheck == 2) {
//       currentMenuItem = afterItems;
//     } else if (currentCheck == 3) {
//       currentMenuItem = afterPressItems;
//     }

//     notifyListeners();
//   }

//   void currentComentOnchange(val) {
//     currentComment = val;
//     notifyListeners();
//   }

//   void onGetInit(
//     BuildContext context,
//   ) async {
//     updateSaveData();
//     menuSetter();

//     notifyListeners();
//     notifyListeners();
//     // _useCase.loginUserApp((data) {
//     getBuyerFromOrderReg(context);
//     dismissProgress();
//     // }, (errorMessage) {
//     //   dismissProgress();
//     //   logoutUser(context);
//     //   showErrorAlert("Your session timeout. Kindly login again");
//     // });
//   }

//   void logoutUser(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferenceHelper.prefs;
//     prefs.clear();
//     Navigator.pushNamedAndRemoveUntil(
//         context, Constants.onBoardingRoute, (Route<dynamic> route) => false);
//   }

//   void getImage(BuildContext context) async {
//     try {
//       final image = await ImagePicker()
//           .pickImage(source: ImageSource.camera, imageQuality: 100);
//       if (image == null) {
//         return;
//       }
//       final imgPer = await saveFile(image.path, context);

//       currentImage = imgPer;
//     } on PlatformException catch (e) {
//       print(e);
//     }
//   }

//   Future<File> saveFile(String imagePath, BuildContext context) async {
//     String userN =
//         await SharedPreferenceHelper.getString(Constants.userDisplayName);
//     final directory = await getApplicationDocumentsDirectory();
//     final name = basename(imagePath);
//     final image = File('${directory.path}/$name');

//     File imagefile = File(imagePath);
//     Uint8List imagebytes = await imagefile.readAsBytes();
//     String base64string = base64.encode(imagebytes);

//     currentImage64 = base64string;
//     currentImageName = name.substring(name.length - 20);

//     postImageUpload(context, name, base64string);

//     notifyListeners();
//     return File(imagePath).copy(image.path);
//   }

//   void clearCurrentImage() {
//     currentImage = null;
//     currentImage64 = "";
//     currentImageName = "";
//     notifyListeners();
//   }

//   void currentMenuUpdate(val, currentItem) {
//     currentMenu = val;
//     selectMenu = currentItem.toString();
//     clearWhileChange();
//     changeCheckMenu(currentItem);
//     setCurrentData();
//     notifyListeners();
//   }

//   void clearWhileChange() {
//     currentComment = '';
//     currentImage64 = '';
//     currentImageName = '';
//     currentImage = null;
//     saveWashData.washAprlImagesModels = [];
//     currentPassFail = '';
//     currentCommentController.text = '';
//   }

//   void currentCheckUpdate(val) {
//     currentCheck = val;
//     currentMenu = 0;

//     if (currentCheck == 1) {
//       saveWashData.wType = 'BW';
//     }
//     if (currentCheck == 2) {
//       saveWashData.wType = 'AW';
//     }
//     if (currentCheck == 3) {
//       saveWashData.wType = 'AP';
//     }
//     notifyListeners();

//     menuSetter();
//   }

//   void clearSaveWash() {
//     updateSaveData();
//     clearWhileChange();
//     notifyListeners();
//   }

//   void closeButton() {
//     currentPassFail = "";
//     currentComment = "";
//     currentImage64 = "";
//     currentImageName = '';
//     currentImage = null;
//     currentCommentController.text = '';
//     notifyListeners();
//   }

//   void getBuyerFromOrderRegOnchange(String val) {
//     saveWashData.orderNo = null;
//     saveWashData.styleNo = null;
//     getOrderRegWithbuyerDetail.data = [];
//     saveWashData.buyerCode = val;
//     beforeWashCompleted = false;
//     afterWashCompleted = false;
//     afterPressCompleted = false;
//     currentCheck = 1;
//     notifyListeners();

//     getOrderRegWithbuyer(val, context);
//   }

//   void getOrderRegWithbuyerOnchange(String styleNo, String orderNo) {
//     saveWashData.orderNo = int.parse(orderNo);
//     saveWashData.styleNo = styleNo;
//     beforeWashCompleted = false;
//     afterWashCompleted = false;
//     afterPressCompleted = false;
//     currentCheck = 1;
//     notifyListeners();
//   }

//   void updateSaveData() async {
//     String currentDate = dateToday.toString().substring(0, 10);
//     String userN =
//         await SharedPreferenceHelper.getString(Constants.userDisplayName);
//     List<WashAprlImagesModelss> data = saveWashData.washAprlImagesModels ?? [];
//     String unitCode = await SharedPreferenceHelper.getString('unitCode');

//     data.add(WashAprlImagesModelss(
//         createdDate: currentDate,
//         createdBy: userN,
//         modifiedDate: currentDate,
//         modifiedBy: userN,
//         hostName: '',
//         descType: '',
//         fName: currentImageName,
//         filePath: 'path',
//         packAttach: currentImage64,
//         id: 0,
//         wAprlID: 0,
//         isActive: true,
//         wType: currentCheck == 1
//             ? 'BW'
//             : currentCheck == 2
//                 ? 'AW'
//                 : 'AP'));

//     SaveWashAprovalModel save = SaveWashAprovalModel(
//         createdDate: currentDate,
//         createdBy: userN,
//         modifiedDate: currentDate,
//         modifiedBy: userN,
//         isActive: true,
//         id: 0,
//         entityID: 'IND',
//         buyerCode: null,
//         styleNo: null,
//         orderNo: null,
//         unitCode: unitCode,
//         wType: currentCheck == 1
//             ? 'BW'
//             : currentCheck == 2
//                 ? 'AW'
//                 : 'AP',
//         spec: '',
//         construction: '',
//         trims: '',
//         grain: '',
//         embellishment: '',
//         csv: '',
//         specRemarks: '',
//         constructionRemarks: '',
//         trimsRemarks: '',
//         grainRemarks: '',
//         embellishmentRemarks: '',
//         csVRemarks: '',
//         handfeel: '',
//         pilling: '',
//         nicking: '',
//         color: '',
//         handfeelRemarks: '',
//         pillingRemarks: '',
//         nickingRemarks: '',
//         colorRemarks: '',
//         hostName: '',
//         washAprlImagesModels: data);

//     saveWashData = save;

//     notifyListeners();
//   }

//   getBuyerFromOrderReg(
//     context,
//   ) {
//     getBuyerFromOrderRegDetail = GetBuyerFromOrderRegModel();
//     notifyListeners();
//     _useCase.getBuyerFromOrderRegData((data) {
//       getBuyerFromOrderRegDetail = data;
//       notifyListeners();
//       dismissProgress();
//     }, (errorMessage) {
//       dismissProgress();
//     });
//   }

//   getOrderRegWithbuyer(
//     String buyerdivcode,
//     context,
//   ) {
//     getOrderRegWithbuyerDetail = GetOrderRegWithbuyerModel();
//     notifyListeners();
//     _useCase.getOrderRegWithbuyerData(buyerdivcode, (data) {
//       getOrderRegWithbuyerDetail = data;
//       notifyListeners();
//       dismissProgress();
//     }, (errorMessage) {
//       dismissProgress();
//     });
//   }

//   getWashAprovalById(
//     int id,
//     context,
//   ) {
//     showProgress(context);
//     notifyListeners();
//     _useCase.getWashAprovalByIdData(id, (data) {
//       dismissProgress();
//       setCurrentData();
//       notifyListeners();
//     }, (errorMessage) {
//       dismissProgress();
//     });
//   }

//   void postSuccess(context) {
//     saveWashData.id = saveWashAprovalResponse.data?.id;
//     clearWhileChange();
//     getWashAprovalById(saveWashAprovalResponse.data?.id ?? 0, context);
//     notifyListeners();
//     saveDataAssign();
//     completedChecker();
//   }

//   postSaveWash(
//     context,
//   ) {
//     FocusScope.of(context).requestFocus(FocusNode());
//     showProgress(context);
//     saveWashAprovalResponse = SaveWashAprovalResponseModel();
//     notifyListeners();
//     _useCase.postSaveWashData(saveWashData, (data) {
//       saveWashAprovalResponse = data;
//       dismissProgress();
//       notifyListeners();
//       showErrorAlert('Saved');
//       postSuccess(context);
//     }, (errorMessage) {
//       dismissProgress();
//     });
//   }

//   SaveCQCTaskStatusRequestModal saveCQCTaskStatusRequest =
//       SaveCQCTaskStatusRequestModal();
//   SaveCQCTaskStatusResponseModal saveCQCTaskStatusResponseData =
//       SaveCQCTaskStatusResponseModal();
//   postSaveCQCTaskStatus(
//     context,
//   ) async {
//     FocusScope.of(context).requestFocus(FocusNode());

//     saveCQCTaskStatusRequest = SaveCQCTaskStatusRequestModal();
//     saveCQCTaskStatusResponseData = SaveCQCTaskStatusResponseModal();
//     notifyListeners();
//     String userN =
//         await SharedPreferenceHelper.getString(Constants.userDisplayName);
//     String currentDate = dateToday.toString().substring(0, 10);
//     String unitCode = await SharedPreferenceHelper.getString('unitCode');
//     _useCase.postSaveCQCTaskStatus(
//         SaveCQCTaskStatusRequestModal(
//             createdBy: userN,
//             createdDate: currentDate,
//             hostName: 'NA',
//             id: 0,
//             isActive: true,
//             modifiedBy: userN,
//             modifiedDate: currentDate,
//             orderNo: saveWashData.orderNo,
//             taskName: currentCheck == 1
//                 ? 'BW'
//                 : currentCheck == 2
//                     ? 'AW'
//                     : currentCheck == 2
//                         ? 'AP'
//                         : 'NA',
//             taskStatus: currentPassFail,
//             unitCode: unitCode), (data) {
//       saveCQCTaskStatusResponseData = data;
//       notifyListeners();
//     }, (errorMessage) {
//       showErrorAlert(errorMessage);
//     });
//   }

//   void showErrorAlert(String message) {
//     CodeSnippet.instance.showSuccessMsg(message);
//   }

//   void showErrorAlert2(String message) {
//     CodeSnippet.instance.showSuccessMsg(message);
//   }

//   void completedChecker() {
//     // showErrorAlert('spec ' + saveWashData.spec.toString());
//     // showErrorAlert('construction ' + saveWashData.construction.toString());
//     // showErrorAlert('trims ' + saveWashData.trims.toString());
//     // showErrorAlert('embellishment ' + saveWashData.embellishment.toString());
//     // showErrorAlert('csv ' + saveWashData.csv.toString());
//     if (saveWashData.wType.toString() == "BW") {
//       if (saveWashData.spec.toString().isNotEmpty &&
//           saveWashData.construction.toString().isNotEmpty &&
//           saveWashData.trims.toString().isNotEmpty &&
//           saveWashData.embellishment.toString().isNotEmpty &&
//           saveWashData.csv.toString().isNotEmpty) {
//         beforeWashCompleted = true;
//       }
//     }
//     if (saveWashData.wType.toString() == "AW") {
//       if (saveWashData.spec.toString().isNotEmpty &&
//           saveWashData.construction.toString().isNotEmpty &&
//           saveWashData.trims.toString().isNotEmpty &&
//           saveWashData.grain.toString().isNotEmpty &&
//           saveWashData.embellishment.toString().isNotEmpty &&
//           saveWashData.handfeel.toString().isNotEmpty &&
//           saveWashData.pilling.toString().isNotEmpty &&
//           saveWashData.nicking.toString().isNotEmpty &&
//           saveWashData.color.toString().isNotEmpty) {
//         afterWashCompleted = true;
//       }
//     }

//     if (saveWashData.wType.toString() == "AP") {
//       if (saveWashData.spec.toString().isNotEmpty &&
//           saveWashData.construction.toString().isNotEmpty &&
//           saveWashData.trims.toString().isNotEmpty &&
//           saveWashData.embellishment.toString().isNotEmpty &&
//           saveWashData.csv.toString().isNotEmpty) {
//         afterPressCompleted = true;
//       }
//     }
//   }

//   void changeCheckMenu(currentMenuItem) {}

//   void imageModelFunction() async {
//     String currentDate = dateToday.toString().substring(0, 10);
//     String userN =
//         await SharedPreferenceHelper.getString(Constants.userDisplayName);

//     List<WashAprlImagesModelss> data = [];

//     data.add(WashAprlImagesModelss(
//         createdDate: currentDate,
//         createdBy: userN,
//         modifiedDate: currentDate,
//         modifiedBy: userN,
//         hostName: currentHostnameSetter(),
//         descType: currentPassFail,
//         fName: currentImageName,
//         filePath: 'path',
//         packAttach: currentImage64,
//         id: 0,
//         wAprlID: 0,
//         isActive: true,
//         wType: currentCheck == 1
//             ? 'BW'
//             : currentCheck == 2
//                 ? 'AW'
//                 : 'AP'));

//     saveWashData.washAprlImagesModels = data;
//     notifyListeners();
//   }

//   void curretPassFailOnChange(val) {
//     currentPassFail = val;
//     notifyListeners();
//   }

//   void saveFunction(context) {
//     imageModelFunction();
//     if (currentCheck == 1) {
//       if (selectMenu == 'Specification') {
//         saveWashData.spec = currentPassFail;
//         saveWashData.specRemarks = currentComment;
//       }
//       if (selectMenu == 'Construction') {
//         saveWashData.construction = currentPassFail;
//         saveWashData.constructionRemarks = currentComment;
//       }
//       if (selectMenu == 'Trims') {
//         saveWashData.trims = currentPassFail;
//         saveWashData.trimsRemarks = currentComment;
//       }
//       if (selectMenu == 'Grain') {
//         saveWashData.grain = currentPassFail;
//         saveWashData.grainRemarks = currentComment;
//       }
//       if (selectMenu == 'Embellishment') {
//         saveWashData.embellishment = currentPassFail;
//         saveWashData.embellishmentRemarks = currentComment;
//       }
//       if (selectMenu == 'CSV') {
//         saveWashData.csv = currentPassFail;
//         saveWashData.csVRemarks = currentComment;
//       }
//     }
//     if (currentCheck == 2) {
//       if (selectMenu == 'Specification') {
//         saveWashData.spec = currentPassFail;
//         saveWashData.specRemarks = currentComment;
//       }
//       if (selectMenu == 'Construction') {
//         saveWashData.construction = currentPassFail;
//         saveWashData.constructionRemarks = currentComment;
//       }
//       if (selectMenu == 'Trims') {
//         saveWashData.trims = currentPassFail;
//         saveWashData.trimsRemarks = currentComment;
//       }
//       if (selectMenu == 'Grain') {
//         saveWashData.grain = currentPassFail;
//         saveWashData.grainRemarks = currentComment;
//       }
//       if (selectMenu == 'Embellishment') {
//         saveWashData.embellishment = currentPassFail;
//         saveWashData.embellishmentRemarks = currentComment;
//       }
//       if (selectMenu == 'CSV') {
//         saveWashData.csv = currentPassFail;
//         saveWashData.csVRemarks = currentComment;
//       }
//       if (selectMenu == 'Handfeel') {
//         saveWashData.handfeel = currentPassFail;
//         saveWashData.handfeelRemarks = currentComment;
//       }
//       if (selectMenu == 'Pilling') {
//         saveWashData.pilling = currentPassFail;
//         saveWashData.pillingRemarks = currentComment;
//       }
//       if (selectMenu == 'Nicking') {
//         saveWashData.nicking = currentPassFail;
//         saveWashData.nickingRemarks = currentComment;
//       }
//       if (selectMenu == 'Color') {
//         saveWashData.color = currentPassFail;
//         saveWashData.colorRemarks = currentComment;
//       }
//     }

//     if (currentCheck == 3) {
//       if (selectMenu == 'Specification') {
//         saveWashData.spec = currentPassFail;
//         saveWashData.specRemarks = currentComment;
//       }
//       if (selectMenu == 'Construction') {
//         saveWashData.construction = currentPassFail;
//         saveWashData.constructionRemarks = currentComment;
//       }
//       if (selectMenu == 'Marking') {
//         saveWashData.trims = currentPassFail;
//         saveWashData.trimsRemarks = currentComment;
//       }
//       if (selectMenu == 'Stickering') {
//         saveWashData.grain = currentPassFail;
//         saveWashData.grainRemarks = currentComment;
//       }
//       if (selectMenu == 'Press Standard') {
//         saveWashData.embellishment = currentPassFail;
//         saveWashData.embellishmentRemarks = currentComment;
//       }
//     }
//     notifyListeners();
//     postSaveCQCTaskStatus(context);
//     postSaveWash(context);
//   }

//   void saveDataAssign() {
//     saveWashData.id = saveWashAprovalResponse.data?.id;
//     saveWashData.wType = saveWashAprovalResponse.data?.wType;
//     saveWashData.spec = saveWashAprovalResponse.data?.spec;
//     saveWashData.construction = saveWashAprovalResponse.data?.construction;
//     saveWashData.trims = saveWashAprovalResponse.data?.trims;
//     saveWashData.grain = saveWashAprovalResponse.data?.grain;
//     saveWashData.embellishment = saveWashAprovalResponse.data?.embellishment;
//     saveWashData.csv = saveWashAprovalResponse.data?.csv;
//     saveWashData.specRemarks = saveWashAprovalResponse.data?.specRemarks;
//     saveWashData.constructionRemarks =
//         saveWashAprovalResponse.data?.constructionRemarks;
//     saveWashData.trimsRemarks = saveWashAprovalResponse.data?.trimsRemarks;
//     saveWashData.grainRemarks = saveWashAprovalResponse.data?.grainRemarks;
//     saveWashData.embellishmentRemarks =
//         saveWashAprovalResponse.data?.embellishmentRemarks;
//     saveWashData.csVRemarks = saveWashAprovalResponse.data?.csVRemarks;
//     saveWashData.handfeel = saveWashAprovalResponse.data?.handfeel;
//     saveWashData.pilling = saveWashAprovalResponse.data?.pilling;
//     saveWashData.nicking = saveWashAprovalResponse.data?.nicking;
//     saveWashData.color = saveWashAprovalResponse.data?.color;
//     saveWashData.handfeelRemarks =
//         saveWashAprovalResponse.data?.handfeelRemarks;
//     saveWashData.pillingRemarks = saveWashAprovalResponse.data?.pillingRemarks;
//     saveWashData.nickingRemarks = saveWashAprovalResponse.data?.nicking;
//     saveWashData.colorRemarks = saveWashAprovalResponse.data?.colorRemarks;

//     var dataArray = saveWashAprovalResponse.data?.washAprlImagesModels ?? [];

//     for (int i = 0; i < dataArray.length; i++) {
//       // before wash

//       if (dataArray[i].wType == "BW" &&
//           dataArray[i].hostName == "Specification") {
//         saveWashData.specificationImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" &&
//           dataArray[i].hostName == "Construction") {
//         saveWashData.constructionImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" && dataArray[i].hostName == "Trims") {
//         saveWashData.trimsImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" && dataArray[i].hostName == "Grain") {
//         saveWashData.grainImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" &&
//           dataArray[i].hostName == "Embellishment") {
//         saveWashData.embellishmentImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" && dataArray[i].hostName == "CSV") {
//         saveWashData.csvImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

// // after wash
//       if (dataArray[i].wType == "AW" &&
//           dataArray[i].hostName == "Specification") {
//         saveWashData.specificationImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" &&
//           dataArray[i].hostName == "Construction") {
//         saveWashData.constructionImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Trims") {
//         saveWashData.trimsImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Grain") {
//         saveWashData.grainImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" &&
//           dataArray[i].hostName == "Embellishment") {
//         saveWashData.embellishmentImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "CSV") {
//         saveWashData.csvImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }
//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Handfeel") {
//         saveWashData.handfeelImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Pilling") {
//         saveWashData.pillingImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Nicking") {
//         saveWashData.nickingImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Color") {
//         saveWashData.colorImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }
//     }
//   }

//   String currentHostnameSetter() {
//     String setted = '';
//     if (currentCheck == 1) {
//       setted = beforeItems[currentMenu];
//     }
//     if (currentCheck == 2) {
//       setted = afterItems[currentMenu];
//     }
//     if (currentCheck == 3) {
//       setted = afterPressItems[currentMenu];
//     }

//     return setted;
//   }

//   void setCurrentData() async {
//     if (currentCheck == 1 && currentHostnameSetter() == "Specification") {
//       currentImage =
//           await urlToFile(saveWashData.specificationImagePathBW.toString());
//       currentCommentController.text = saveWashData.specRemarks.toString();
//     }
//     if (currentCheck == 1 && currentHostnameSetter() == "Construction") {
//       currentImage =
//           await urlToFile(saveWashData.constructionImagePathBW.toString());
//       currentCommentController.text =
//           saveWashData.constructionRemarks.toString();
//     }
//     if (currentCheck == 1 && currentHostnameSetter() == "Trims") {
//       currentImage = await urlToFile(saveWashData.trimsImagePathBW.toString());
//       currentCommentController.text = saveWashData.trimsRemarks.toString();
//     }
//     if (currentCheck == 1 && currentHostnameSetter() == "Grain") {
//       currentImage = await urlToFile(saveWashData.grainImagePathBW.toString());
//       currentCommentController.text = saveWashData.grainRemarks.toString();
//     }
//     if (currentCheck == 1 && currentHostnameSetter() == "Embellishment") {
//       currentImage =
//           await urlToFile(saveWashData.embellishmentImagePathBW.toString());
//       currentCommentController.text =
//           saveWashData.embellishmentRemarks.toString();
//     }
//     if (currentCheck == 1 && currentHostnameSetter() == "CSV") {
//       currentImage = await urlToFile(saveWashData.csvImagePathBW.toString());
//       currentCommentController.text = saveWashData.csVRemarks.toString();
//     }
//     notifyListeners();
//   }

//   Future<File> urlToFile(String imageUrl) async {
//     var rng = Random();
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;
//     File file = File('$tempPath${rng.nextInt(100)}.jpg');
//     http.Response response = await http.get(Uri.parse(imageUrl));
//     await file.writeAsBytes(response.bodyBytes);
//     return file;
//   }

//   void setImageOnMenuChange() {
//     var dataArray = saveWashAprovalResponse.data?.washAprlImagesModels ?? [];

//     for (int i = 0; i < dataArray.length; i++) {
//       // before wash

//       if (dataArray[i].wType == "BW" &&
//           dataArray[i].hostName == "Specification") {
//         dataArray[i].filePath = '';
//         saveWashData.specificationImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" &&
//           dataArray[i].hostName == "Construction") {
//         saveWashData.constructionImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" && dataArray[i].hostName == "Trims") {
//         saveWashData.trimsImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" && dataArray[i].hostName == "Grain") {
//         saveWashData.grainImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" &&
//           dataArray[i].hostName == "Embellishment") {
//         saveWashData.embellishmentImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "BW" && dataArray[i].hostName == "CSV") {
//         saveWashData.csvImagePathBW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

// // after wash
//       if (dataArray[i].wType == "AW" &&
//           dataArray[i].hostName == "Specification") {
//         saveWashData.specificationImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" &&
//           dataArray[i].hostName == "Construction") {
//         saveWashData.constructionImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Trims") {
//         saveWashData.trimsImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Grain") {
//         saveWashData.grainImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" &&
//           dataArray[i].hostName == "Embellishment") {
//         saveWashData.embellishmentImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "CSV") {
//         saveWashData.csvImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }
//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Handfeel") {
//         saveWashData.handfeelImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Pilling") {
//         saveWashData.pillingImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Nicking") {
//         saveWashData.nickingImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }

//       if (dataArray[i].wType == "AW" && dataArray[i].hostName == "Color") {
//         saveWashData.colorImagePathAW =
//             dataArray[i].filePath.toString() + dataArray[i].fName.toString();
//       }
//     }
//   }

//   UploadImageResponseModel uploadImageResponse = UploadImageResponseModel();

//   postImageUpload(BuildContext context, String fName, String packAttach) async {
//     showProgress(context);
//     uploadImageResponse = UploadImageResponseModel();
//     String userN =
//         await SharedPreferenceHelper.getString(Constants.userDisplayName);
//     String unitCode = await SharedPreferenceHelper.getString('unitCode');
//     notifyListeners();
//     _useCase.postImageUploadData(
//         UploadImageModel(uploadBase64Datacollection: [
//           UploadBase64Datacollection(
//               fName: fName,
//               packAttach: packAttach,
//               auditType: 'NA',
//               insType: 'NA',
//               factoryCode: unitCode,
//               defectName: 'NA')
//         ]), (data) {
//       uploadImageResponse = data;

//       notifyListeners();

//       String currentDate = dateToday.toString().substring(0, 10);
//       List<WashAprlImagesModelss> data2 =
//           saveWashData.washAprlImagesModels ?? [];
//       data2.add(WashAprlImagesModelss(
//           createdDate: currentDate,
//           createdBy: userN,
//           modifiedDate: currentDate,
//           modifiedBy: userN,
//           hostName: '',
//           descType: '',
//           fName: uploadImageResponse.data?[0].filename,
//           filePath: uploadImageResponse.data?[0].filepath,
//           packAttach: currentImage64,
//           id: 0,
//           wAprlID: 0,
//           isActive: true,
//           wType: currentCheck == 1
//               ? 'BW'
//               : currentCheck == 2
//                   ? 'AW'
//                   : 'AP'));

//       saveWashData.washAprlImagesModels = data2;

//       dismissProgress();
//     }, (errorMessage) {
//       dismissProgress();
//     });
//   }
// }
