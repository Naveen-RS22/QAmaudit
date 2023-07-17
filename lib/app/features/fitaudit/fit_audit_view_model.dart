import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/network/dto/DeleteScoreCardHeadByIdModel.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/FlagInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetAllDefectswithFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetUDMasterByTypeAuditPcsResponseModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarOperationMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarPartDataModel.dart';
import 'package:qapp/app/data/network/dto/GetAllTop3DefectResponseModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectsCntModel.dart';
import 'package:qapp/app/data/network/dto/CopyFitOrderScheduleResponseModel.dart';
import 'package:qapp/app/data/network/dto/GetListGarFitAuditDataByParamsResponseModel.dart';

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
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_use_case.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/data/network/dto/SaveGarFitAudit.dart';

import 'package:qapp/app/utils/code_snippet.dart';

import '../../data/local/shared_prefs_helper.dart';
import '../../res/constants.dart';

class FitAuditViewModal extends BaseViewModel {
  final FitAuditUserCase _useCase = AppManager.instance.fitAuditUseCase();
  final pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);

  String? sleeveValue;
  String? sleeveAttachmentValue;
  List selectFavorite = [];

  bool enableRound = false;
  int? remainingCnt;
  int? passCnt;
  int? FailCnt;
  int? yellowCnt;
  Duration duration = const Duration();
  Timer? timer;
  int auditStep = 1;
  int auditCount = 0;
  int failCount = 0;
  int passCount = 0;
  String auditCurrentCheck = "";
  String empCodeString = "";
  String defectSearch = "";
  String? defaultCategory;
  bool operatorFound = false;
  bool auditStarted = false;
  bool operatorEditable = true;
  bool empEditable = true;
  bool isCount = true;
  bool nextOperatorAction = true;
  bool isPass = false;
  bool sessionCompleted = false;

  int completedOperators = 1;
  int completedPcs = 0;
  int defectPcs = 0;
  double DHU = 0;
  List<AllDefects> searchDefect = [];

  bool endSession = false;
  int remaning = 0;
  int green = 0;
  int yellow = 0;
  int red = 0;

  bool isDefectList = false;

  List<String> completedOperatorsArray = [];
  Map<String, int> completedOperatorsDetails = {};
  List completedOperatorsFinal = [];

  bool reOperator = false;
  String savedAudit = "";

  List<Map<String, String>> allDef = [];
  List allDefectFinal = [];
  Map<String, int> countDetails = {};

  int totalDefectCount = 0;

  var top3DefectArray = [];

  List<GarFitAuditDetlModels> top3TotalData = [];

  var top3Final = [];
  List top3Data = [];
  List<Map<String, dynamic>> allDefectDetails = [];

  final tagName = TextEditingController();
  final operatorSearch = TextEditingController();
  final defectSearchController = TextEditingController();
  final remarkController = TextEditingController();
  final operatorsCntController = TextEditingController();
  final auditPcsCntController = TextEditingController();

  static const countDown = Duration(minutes: 10);

  FinalAuditModel finalAudit = FinalAuditModel();
  GetAllGarPartDataModel sleevesData = GetAllGarPartDataModel();
  GetAllGarOperationMasterModel sleevesAttachmentData =
      GetAllGarOperationMasterModel();
  GetFavouriteModel favoriteData = GetFavouriteModel();
  GetAllDefectsModel allDefectData = GetAllDefectsModel();
  GetDefectTranslationMasterByLanguageCodeModel getDefectTranslation =
      GetDefectTranslationMasterByLanguageCodeModel();

  SaveGarFitAuditResponseModel postScoreData = SaveGarFitAuditResponseModel();
  GetEmpDataModel empData = GetEmpDataModel();
  OperatorsChart optData = OperatorsChart();
  GetAllTop3DefectResponseModel defectPart = GetAllTop3DefectResponseModel();
  // SaveScoreCardModel scoreCardData = SaveScoreCardModel();
  SaveGarFitAuditRequestModel scoreCardData = SaveGarFitAuditRequestModel();
  FlagInfoModel flagInfoData = FlagInfoModel();

  GetDefectsCntModel defectsCntData = GetDefectsCntModel();

  UpdateScoreCardAuditStatusModel UpdateScoreCardAuitDetail =
      UpdateScoreCardAuditStatusModel();

  UpdateSessionFlagModel UpdateSessionFlagDetail = UpdateSessionFlagModel();

  GetOperCodeByPartIdModel getOperCodeByPartIdDetail =
      GetOperCodeByPartIdModel();
  StyleAuditData styleAuditData = StyleAuditData();

  GetScoreCardEntryListModel getScoreCardEntryListDetail =
      GetScoreCardEntryListModel();

  DeleteScoreCardHeadByIdModel deleteResponse = DeleteScoreCardHeadByIdModel();
  GetScorecardDataByIdModel editList = GetScorecardDataByIdModel();

  FavDefectDataWithLanguageModel favDefectDataWithLanguageDetail =
      FavDefectDataWithLanguageModel();

  File? defectImage;
  String? defectbase;

  String lang = "";

  int auditPcs = 0;

  String remark = '';

  List<GarFitAuditDetlModels> selectFavoriteBackup = [];

  void getLang() async {
    lang = await SharedPreferenceHelper.getString(Constants.currentLang);
    notifyListeners();
  }

  void getImage(context) async {
    if (selectFavorite.isNotEmpty) {
      try {
        final image = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 100);
        if (image == null) {
          return;
        }

        final imgPer = await saveFile(image.path, context);
        defectImage = imgPer;
        notifyListeners();
      } on PlatformException catch (e) {
        debugPrint(e.toString());
      }
    } else {
      showErrorAlert('Please select a defect to add image');
    }
  }

  Future<File> saveFile(String imagePath, context) async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    File imagefile = File(imagePath);
    Uint8List imagebytes = await imagefile.readAsBytes();
    String base64string = base64.encode(imagebytes);
    defectbase = base64string;

    // postImageUpload(context, name, base64string);

    notifyListeners();
    return File(imagePath).copy(image.path);
  }

  void setDefectList(val) async {
    isDefectList = val;

    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    if (val == true) {
      //   getScoreCardEntryList(
      //       context,
      //       unitCode,
      //       styleAuditData.auditType,
      //       styleAuditData.schDate!.substring(0, 10),
      //       styleAuditData.auditorName,
      //       styleAuditData.sewLine,
      //       styleAuditData.orderNo,
      //       styleAuditData.sessionName);

      GetListGarFitAuditDataByParamsResponseAPI(
          context,
          unitCode,
          styleAuditData.schDate!.substring(0, 10),
          styleAuditData.auditType,
          styleAuditData.auditorName,
          styleAuditData.orderNo,
          styleAuditData.sewLine);
    }
    notifyListeners();
  }

  getDefectPart(
    context,
    String unitcode,
    String audittype,
    String fromdate,
    String todate,
    String auditername,
    String sewline,
    String sessionname,
  ) {
    defectPart = GetAllTop3DefectResponseModel();
    notifyListeners();
    _useCase.getDefectpart(unitcode, audittype, fromdate, todate, auditername,
        sewline, sessionname, (data) {
      defectPart = data;
      inspect(defectPart);
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      debugPrint(errorMessage.toString());
      dismissProgress();
    });
  }

  void clearDefectImage() {
    defectImage = null;
    defectbase = null;
    notifyListeners();
  }

  void remarksOnChange(String value) {
    scoreCardData.remarks = value;
    remark = value;

    for (int i = 0;
        i < (scoreCardData.garFitAuditDetlModels ?? []).length;
        i++) {
      (scoreCardData.garFitAuditDetlModels ?? [])[i].remarks = remark;
    }
    notifyListeners();
  }

  void operatorsCntOnChange(
    String value,
  ) {
    if (value.isNotEmpty) {
      scoreCardData.totOperators = int.parse(value);
      remaning = int.parse(value);
      // operatorsCntController.text = value;
      // getOpCnt(context, styleInfo);
      notifyListeners();
    } else {
      scoreCardData.totOperators = 0;
      remaning = 0;
      operatorsCntController.text = '';
    }
  }

  void nextOperatorFunction() {}
  void failFunction() {
    // if (tagName.text.isNotEmpty) {

    if (auditCount < auditPcs) {
      auditStep = 2;
      auditStepUpdate(3);
      auditCurrentCheck = 'fail';
      auditStarted = true;
      // getLineQCFrequentUsedOperationsandPartsData(
      //     context,
      //     scoreCardData.unitCode.toString(),
      //     '7',
      //     scoreCardData.auditType.toString(),
      //     scoreCardData.auditorName.toString(),
      //     scoreCardData.orderNo.toString());
      notifyListeners();
    }

    // } else {
    //   showErrorAlert("Enter Tag ID");
    // }
  }

  void passFunction() {
    if (auditCount < auditPcs) {
      isPass = true;
      auditStep = 1;
      auditCount = auditCount + 1;
      auditCurrentCheck = 'pass';
      passCount = passCount + 1;
      scoreCardData.passedPcs = passCount;
      // completedPcs = completedPcs + 1;
      // DHU = (defectPcs * 100) / completedPcs;

      if (auditCount == auditPcs) {
        isPass = false;
      }
      notifyListeners();
    }
  }

  void passFunctionFA() {
    // if (tagName.text.isNotEmpty) {
    if (auditCount < auditPcs) {
      auditStep = 2;
      auditStepUpdate(6);
      auditCurrentCheck = 'pass';
      auditStarted = true;
      // getLineQCFrequentUsedOperationsandPartsData(
      //     context,
      //     scoreCardData.unitCode.toString(),
      //     '7',
      //     scoreCardData.auditType.toString(),
      //     scoreCardData.auditorName.toString(),
      //     scoreCardData.orderNo.toString());
      notifyListeners();
    }
    // } else {
    //   showErrorAlert("Enter Tag ID");
    // }
  }

  void defectListGenerator() {
    allDefectFinal.addAll(selectFavorite);

    top3TotalData = [...scoreCardData.garFitAuditDetlModels ?? []];
    // var arr = scoreCardData.scoreCardDetlModels ?? [];
    // top3Data.addAll(scoreCardData.scoreCardDetlModels ?? []);
    Map<String, int> count = {};
    for (var i in allDefectFinal) {
      count[i] = (count[i] ?? 0) + 1;
    }
    countDetails = count;
    var newList = [];
    var newLis2 = [];
    count.forEach((k, v) => newList.add({"defectCode": k, "count": v}));
    var def = searchDefect;
    for (int i = 0; i < newList.length; i++) {
      var val = def.firstWhereOrNull(
        (defArr) => defArr.defectCode == newList[i]['defectCode'],
      );

      newLis2.add({
        "name": val?.defectName,
        "code": val?.defectCode,
        "count": newList[i]['count']
      });
    }

    var data = scoreCardData.garFitAuditDetlModels ?? [];

    var newMap =
        groupBy(top3TotalData, (GarFitAuditDetlModels obj) => obj.defectCode);
    top3Final = [];
    newMap.forEach((key, value) => top3Final.add({
          "defectCode": key,
          "defectName": value[0].hostName,
          "count": value.length,
          "tag": value
        }));

    top3DefectArray = [];
    top3DefectArray.addAll(newLis2);
    notifyListeners();
  }

  void defectCategoryOnChange(String value) {
    defaultCategory = value;
    defectSearchController.text = "";
    defectSearchFunction("");

    List<AllDefects> search(String input) {
      return (searchDefect)
          .where((e) => e.defectCategory!.contains(value))
          .toList();
    }

    var newList = search(value);
    allDefectData.data?.allDefects = newList;
    notifyListeners();
  }

  void defectSearchFunction(String value) {
    if (value.isNotEmpty) {
      List<AllDefects> search(String input) {
        defaultCategory = null;
        return (searchDefect)
            .where((e) =>
                e.defectName!.toLowerCase().contains(input.toLowerCase()))
            .toList();
      }

      var newList = search(value);
      allDefectData.data?.allDefects = newList;
    } else {
      allDefectData.data?.allDefects = searchDefect;
    }
    notifyListeners();

    // Future.delayed(Duration(seconds: 2), () {
    // Do something
    notifyListeners();
  }

  void resetData() {
    top3DefectArray = [];
    defectsCntData = GetDefectsCntModel();
    flagInfoData = FlagInfoModel();
    nextOperatorAction = true;
    enableRound = false;
    operatorsCntController.text = "";
    auditPcsCntController.text = '0';

    allDefectFinal = [];
    countDetails = {};
    finalAudit = FinalAuditModel();
    // sleevesData = GetAllGarPartDataModel();
    // sleevesAttachmentData = GetAllGarOperationMasterModel();
    favoriteData = GetFavouriteModel();
    allDefectData = GetAllDefectsModel();

    postScoreData = SaveGarFitAuditResponseModel();
    empData = GetEmpDataModel();
    optData = OperatorsChart();

    duration = const Duration(microseconds: 0, minutes: 0);
    auditStep = 1;
    failCount = 0;
    passCount = 0;
    auditCurrentCheck = "";
    empCodeString = "";
    operatorSearch.clear();
    tagName.clear();
    remarkController.clear();
    operatorFound = false;

    auditCount = 0;
    isPass = false;
    sleeveAttachmentValue = null;
    sleeveValue = null;
    scoreCardData.partCode = null;
    scoreCardData.operationCode = null;
    passCnt = null;
    yellowCnt = null;
    FailCnt = null;
    remainingCnt = null;
    // operatorsCntController.text = "";
    defectSearchController.text = '';
    auditPcs = 0;
    notifyListeners();
  }

  void clearData() {
    auditStep = 1;
    failCount = 0;
    passCount = 0;
    auditCurrentCheck = "";
    empCodeString = "";
    operatorSearch.clear();
    tagName.clear();
    remarkController.clear();
    operatorFound = false;
    auditCount = 0;
    isPass = false;
    scoreCardData.partCode = null;
    scoreCardData.operationCode = null;
    sleeveAttachmentValue = null;
    sleeveValue = null;
    defectSearchController.text = '';
    notifyListeners();
  }

  void nextOperator(BuildContext context, styleAudit) {
    exceptionDialog() {
      return Get.defaultDialog(
          title: "Fit Audit",
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text('Are You Sure'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey.shade200,
                      child: Text(passCount.toString()),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Pass'),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey.shade200,
                      child: Text(failCount.toString()),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Fail')
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        reAuditFunction(context, styleAudit);
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Re Audit',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);

                        // updatePassedWithInspected();
                        postAudit(context, styleAudit);
                      },
                      child: Center(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffF7931C),
                                Color(0xffF57234),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          confirmTextColor: const Color(0xffffffff),
          cancelTextColor: const Color(0xffF7931C),
          buttonColor: const Color(0xffF7931C));
    }

    // if (operatorFound) {
    //   if (failCount == 0) {
    //     scoreCardData.flagColor = "G";
    //   } else if (failCount == 1) {
    //     scoreCardData.flagColor = "O";
    // } else {
    // scoreCardData.flagColor = "R";
    // }

    // passCount = (failCount - 7).abs();
    // auditCount = 7;
    // scoreCardData.sesEndDtTime =
    //     "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z";

    //   notifyListeners();
    // }

    exceptionDialog();
  }

  getScoreCardEntryList(context, unitcode, audittype, auditDate, auditername,
      sewline, orderno, sessionname) {
    getScoreCardEntryListDetail = GetScoreCardEntryListModel();
    notifyListeners();
    _useCase.getScoreCardEntryListData(unitcode, audittype, auditDate,
        auditername, sewline, orderno, sessionname, (data) {
      getScoreCardEntryListDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void onEmpCodeChange(String email) {
    empCodeString = email;
    notifyListeners();
  }

  void resetAuditStep() {
    auditStep = 1;
    auditCurrentCheck = "";
    selectFavorite = [];
    defectImage = null;
    notifyListeners();
  }

  void auditStepUpdate(int step) {
    auditStep = step;
    notifyListeners();
  }

  void addTimer() {
    const seconds = 1;

    final second = duration.inSeconds + seconds;
    duration = Duration(seconds: second);
    notifyListeners();
  }

  void timerFunction() {
    timer = Timer.periodic(const Duration(seconds: 0), (_) {
      addTimer();
    });
  }

  void resetTImer() {
    if (isCount) {
      duration = countDown;
    } else {
      duration = const Duration();
    }
  }

  void roundChange(bool value) {
    if (value) {
      timerFunction();
      // scoreCardData.sesStartDtTime =
      //     "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z";
    } else {}

    enableRound = !enableRound;

    notifyListeners();
  }

  String getSystemTime() {
    DateTime dateToday = DateTime.now();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(dateToday.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('dd-MM-yyyy h:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  void tagNumberOnChange(String value) {
    // var newList = scoreCardData.scoreCardDetlModels ?? [];
    // var scoreDel = ScoreCardDetlModels(tagId: value);
    // newList.insert(auditCount, scoreDel);
    // scoreCardData.scoreCardDetlModels = newList;
    notifyListeners();
  }

  void selectFavoriteFunction(
      String selectedFavorite, String defectName) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    int findItem =
        selectFavorite.indexWhere((element) => element == selectedFavorite);

    notifyListeners();

    if (findItem < 0) {
      selectFavorite.add(selectedFavorite);
      var newList = scoreCardData.garFitAuditDetlModels ?? [];
      newList.add(GarFitAuditDetlModels(
          createdDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          createdBy: userN,
          modifiedDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          modifiedBy: userN,
          isActive: true,
          id: 0,
          garFitAuditHeadID: 0,
          fitAuditStatus: auditCurrentCheck == 'pass'
              ? 'P'
              : auditCurrentCheck == 'fail'
                  ? 'D'
                  : 'NA',
          remarks: remarkController.text.isEmpty ? 'NA' : remarkController.text,
          // scHeadID: 0,
          defectCode: selectedFavorite,
          garSize: "L",
          tagId: 'NA',
          isClosed: "Y",
          hostName: defectName,
          active: "Y",
          garFitAuditImagesModels: []));

      scoreCardData.garFitAuditDetlModels = newList;
      selectFavoriteBackup = newList;
      notifyListeners();
    } else {
      selectFavorite.removeAt(findItem);
      scoreCardData.garFitAuditDetlModels?.removeAt(findItem);
      selectFavoriteBackup.removeAt(findItem);
      notifyListeners();
    }

    notifyListeners();
  }

  void sleeveValueOnchange(BuildContext context, String sleeve, int? id) async {
    sleeveValue = sleeve;
    scoreCardData.partCode = sleeve.toString();
    currentoperationName = '';
    getOperCodeByPartIdDetail.data = [];
    scoreCardData.operationCode = null;
    notifyListeners();
    if (id != 0) {
      // getOperCodeByPartId(context, id);
      String lan =
          await SharedPreferenceHelper.getString(Constants.currentLang);
      getSleevesAttachments(context, lan.isEmpty ? 'EN' : lan, id.toString());
    }
  }

  void clearDefectsList() {
    failCount = 0;
    scoreCardData.garFitAuditDetlModels = [];
    selectFavoriteBackup = [];
    top3DefectArray = [];

    notifyListeners();
  }

  String currentoperationName = '';

  void sleeveAttachmentValueOnchange(
      String sleeveAttachment, String sleeveName) {
    sleeveAttachmentValue = sleeveAttachment;
    currentoperationName = sleeveName;
    scoreCardData.operationCode = sleeveAttachment.toString();

    notifyListeners();
  }

  void onGetInit(
    BuildContext context,
    StyleAuditData styleAudit,
    InlineViewModal inlineviews,
  ) async {
    showProgress(context);
    notifyListeners();
    // _useCase.loginUserApp((data) async {
    dismissProgress();
    styleAuditData = styleAudit;

    String nowAudit =
        styleAudit.orderNo.toString() + styleAudit.sessionName.toString();

    bool reset = savedAudit == nowAudit ? false : true;
    // operatorsCntController.text = remaning.toString();
    if (reset) {
      resetData();
      updateChartValues();
    }
    getLang();

    opertorReset();
    updateScoreCard(context, styleAudit);

    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    getUDMasterByTypeResponseAPI('FITAUDIT');
    getUDMasterByTypeResponseAPIauditPcs('FRPCS');
    getOpCnt(context, styleAudit);
    getDefectPart(
      context,
      styleAudit.unitCode ?? '',
      styleAudit.auditType ?? '',
      styleAudit.schDate ?? '',
      styleAudit.schDate ?? '',
      styleAudit.auditorName1 ?? '',
      styleAudit.sewLine ?? '',
      styleAudit.sessionName ?? '',
    );

    String lan = await SharedPreferenceHelper.getString(Constants.currentLang);
    getSleeves(context, lan.isEmpty ? 'EN' : lan, styleAudit.productType);

    // getFinalAudit(context);
    getDefectCntData(context, unitCode, currentDate, userN, styleAudit);
    getFlagInfo(context, unitCode, userN, currentDate, styleAudit);

    // getAllDefect(context);
    // getDefectTranslationMasterByLanguageCode(context);
    // favDefectDataWithLanguage(context);
    // getFavoriteDefect(context);
    // getDefectCnt(context);
    dismissProgress();
    // }, (errorMessage) {
    //   dismissProgress();
    // });
    typeOnchange(styleAudit.auditType ?? '');
    print('---------------');
    print(operatorFound);
    print('---------------');
  }

  opertorReset() {
    scoreCardData.totOperators = 0;
    remaning = 0;
    operatorsCntController.text = '';
    scoreCardData.auditType = null;
    scoreCardData = SaveGarFitAuditRequestModel();
    auditStarted = false;
    auditPcs = 0;
    selectFavoriteBackup = [];
    typeOnchange(styleAuditData.auditType ?? '');
    notifyListeners();
  }

  totopertorReset() {
    scoreCardData.totOperators = 0;
    notifyListeners();
  }

  getOperCodeByPartId(context, partid) {
    getOperCodeByPartIdDetail = GetOperCodeByPartIdModel();
    notifyListeners();
    _useCase.getOperCodeByPartIdData(partid, (data) {
      getOperCodeByPartIdDetail = data;
      List<GetOperCodeByPartIdArr> listOf = [];
      var newList = getOperCodeByPartIdDetail.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      getOperCodeByPartIdDetail.data = listOf;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getFlagInfo(
    context,
    unitCode,
    userN,
    currentDate,
    StyleAuditData styleAudit,
  ) {
    flagInfoData = FlagInfoModel();
    notifyListeners();
    _useCase.getFlagInfoData(unitCode, userN, currentDate, styleAudit.sewLine,
        styleAudit.sessionName, (data) {
      flagInfoData = data;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getFavoriteDefect(context) {
    isFavLoading = true;
    notifyListeners();
    favoriteData = GetFavouriteModel();
    notifyListeners();
    _useCase.getFavoriteDefuctData((data) {
      favoriteData = data;

      List<FavDefect> listOf = [];
      var newList = favoriteData.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      favoriteData.data = listOf;

      // ChangeNotifier().notifyListeners();
      isFavLoading = false;
      notifyListeners();
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    });
  }

  getAllDefect(context) {
    isFavLoading = true;
    notifyListeners();
    allDefectData = GetAllDefectsModel();
    notifyListeners();
    _useCase.getAllDefuctData((data) {
      isFavLoading = false;
      notifyListeners();
      allDefectData = data;
      List<AllDefects> listOf = [];
      var newList = allDefectData.data?.allDefects ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      allDefectData.data?.allDefects = listOf;
      searchDefect = listOf;

      notifyListeners();
      isFavLoading = false;
      notifyListeners();

      dismissProgress();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    });
  }

  getDefectTranslationMasterByLanguageCode(context) async {
    String languagecode =
        await SharedPreferenceHelper.getString(Constants.currentLang);
    isFavLoading = true;
    notifyListeners();

    getDefectTranslation = GetDefectTranslationMasterByLanguageCodeModel();
    notifyListeners();
    _useCase.getDefectTranslationMasterByLanguageCodeData(
        languagecode == "" ? "EN" : languagecode, (data) {
      getDefectTranslation = data;
      isFavLoading = false;
      notifyListeners();
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    });
  }

  getSleeves(context, languagecode, producttype) {
    sleevesData = GetAllGarPartDataModel();
    sleevesAttachmentData = GetAllGarOperationMasterModel();
    notifyListeners();
    _useCase.getSleevesData(languagecode, producttype, (data) {
      sleevesData = data;
      List<GarPartData> listOf = [];
      var newList = sleevesData.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      sleevesData.data = listOf;
      notifyListeners();

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      // showErrorAlert('Invalid ProductType');
      dismissProgress();
    });
  }

  getDefectCntData(
      context, unitCode, currentDate, userN, StyleAuditData styleAudit) {
    defectsCntData = GetDefectsCntModel();
    notifyListeners();
    _useCase.getDefectCntData(unitCode, currentDate, userN, styleAudit.sewLine,
        styleAudit.sessionName, (data) {
      // ChangeNotifier().notifyListeners();

      defectsCntData = data;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getSleevesAttachments(context, String lan, String partid) {
    sleevesAttachmentData = GetAllGarOperationMasterModel();
    notifyListeners();
    _useCase.getSleevesAttachmentsData(lan, partid, (data) {
      // ChangeNotifier().notifyListeners();
      sleevesAttachmentData = data;

      List<OperationData> listOf = [];
      var newList = sleevesAttachmentData.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      sleevesAttachmentData.data = listOf;
      notifyListeners();

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getDefectCnt(context) {
    notifyListeners();
    _useCase.getFavoriteDefuctData((data) {
      // ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  // operatorFoundChange() {
  //   operatorFound = true;
  //   notifyListeners();
  // }

  void reOperatorChecker() {
    Map<String, int> count = {};
    for (var i in completedOperatorsArray) {
      count[i] = (count[i] ?? 0) + 1;
    }
    completedOperatorsDetails = count;
    var newList = [];

    count.forEach((k, v) => newList.add({"id": k, "count": v}));

    completedOperatorsFinal = [];
    completedOperatorsFinal.addAll(newList);

    int index = completedOperatorsFinal
        .indexWhere(((element) => element['id'] == operatorSearch.text));

    if (completedOperatorsFinal[index]['count'] > 1) {
      reOperator = true;
    } else {
      reOperator = false;
    }
    notifyListeners();
  }

  getEmpCode(context, StyleAuditData styleAuditdata) {
    if (empCodeString.isNotEmpty) {
      FocusScope.of(context).requestFocus(FocusNode());
      empData = GetEmpDataModel();
      notifyListeners();
      _useCase.getEmpCodeData(empCodeString, (
        data,
      ) {
        empData = data;

        if (empData.isSuccess ?? false) {
          var empdetails = empData.data ?? [];
          if (empdetails.isNotEmpty) {
            completedOperatorsArray.add(operatorSearch.text);
            reOperatorChecker();
            scoreCardData.totOperators = int.parse(operatorsCntController.text);
            operatorSearch.text = empdetails[0].empname.toString();
            scoreCardData.operatorCode = empdetails[0].empcode;
            scoreCardData.operatorName = empdetails[0].empname;
            operatorFound = true;
            auditStarted = true;
            operatorEditable = false;
            empEditable = false;
          } else {
            operatorFound = false;
            operatorEditable = true;
            empEditable = true;
            operatorSearch.clear();
            showErrorAlert("No Data Found");
          }
        } else {
          showErrorAlert("Something went wrong");
        }

        notifyListeners();
        dismissProgress();
      }, (errorMessage) {
        empCodeString = '';
        showErrorAlert('Not found');
        dismissProgress();
      });
    }
  }

  getOpCnt(
    context,
    StyleAuditData styleAudit,
  ) async {
    optData = OperatorsChart();

    notifyListeners();

    _useCase.getOperatorsCntData(scoreCardData, (data) {
      optData = data;

      green = 0;
      yellow = 0;
      red = 0;

      if (optData.data != null) {
        var operData = optData.data!.operatorcnt ?? [];
        for (int i = 0; i < operData.length; i++) {
          if (operData[i].flgcolor == "G") {
            green = operData[i].operCnt ?? 0;
          } else if (operData[i].flgcolor == "R") {
            red = operData[i].operCnt ?? 0;
          } else {
            yellow = operData[i].operCnt ?? 0;
          }
        }
      }

      if (optData.isSuccess ?? false) {
        if ((optData.data?.totalcount ?? 0) > 0) {
          int completedCount = optData.data?.totalcount ?? 0;
          int totOperators = optData.data?.totoperators ?? 0;
          // for (int i = 1; i < completedCount; i++) {
          //   totOperators = totOperators / 2;
          // }
          scoreCardData.totOperators = totOperators;

          operatorsCntController.text = totOperators.toString();

          remaning = totOperators - completedCount;

          // operatorFound = true;
          // operatorEditable = false;
          // empEditable = false;

          if (remaning == 0) {
            sessionCompleted = true;
          } else {
            sessionCompleted = false;
          }
        }
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void getFailCount() {}
  void testAlert(BuildContext context, String s) {
    exceptionDialog() {
      return Get.defaultDialog(
          content: Container(
            child: Text(s),
          ),
          title: "",
          confirmTextColor: const Color(0xffffffff),
          cancelTextColor: const Color(0xffF7931C),
          buttonColor: const Color(0xffF7931C));
    }

    exceptionDialog();
  }

  void reAuditFunction(context, StyleAuditData styleAudit) {
    auditCount = auditCount - passCount;
    passCount = 0;
    scoreCardData.passedPcs = passCount;
    notifyListeners();
  }

  postAudit(context, StyleAuditData styleAudit) {
    FocusScope.of(context).requestFocus(FocusNode());

    notifyListeners();
    showProgress(context);
    scoreCardData.operationCode = scoreCardData.operationCode ?? 'NA';
    scoreCardData.partCode = scoreCardData.partCode ?? 'NA';
    postScoreData = SaveGarFitAuditResponseModel();
    notifyListeners();
    _useCase.postAuditData(scoreCardData, (data) async {
      postScoreData = data;
      savedAudit =
          styleAudit.orderNo.toString() + styleAudit.sessionName.toString();
      if (postScoreData.isSuccess ?? false) {
        if (!reOperator) {
          remaning = remaning - 1;
          // operatorsCntController.text = remaning.toString();
        }
        completedOperators = completedOperators + 1;
        completedPcs = completedPcs + failCount + passCount;
        defectPcs = defectPcs + failCount;
        DHU = ((defectPcs / completedPcs) * 100);
        allDefectFinal = [];
        top3DefectArray = [];
        top3TotalData = [];
        top3Final = [];
        countDetails = {};
        selectFavoriteBackup = [];
        empEditable = true;

        SharedPreferenceHelper.setString(
            Constants.current7audit,
            ((postScoreData.data?.styleNo ?? "") +
                (postScoreData.data?.sessionName ?? "")));

        notifyListeners();

        if (remaning == 0) {
          sessionCompleted = true;
        } else {
          sessionCompleted = false;
        }

        // if (failCount == 0) {
        //   green = green + 1;
        // } else if (failCount == 1) {
        //   yellow = yellow + 1;
        // } else {
        //   red = red + 1;
        // }

        if (reOperator) {
          if (failCount == 0) {
            green = green + 1;
          } else if (failCount == 1) {
            yellow = yellow + 1;
          } else {
            red = red + 1;
          }
        }
        notifyListeners();
        clearData();

        DateTime dateToday = DateTime.now();
        String currentDate = dateToday.toString().substring(0, 10);
        String userN =
            await SharedPreferenceHelper.getString(Constants.userDisplayName);
        String unitCode = await SharedPreferenceHelper.getString('unitCode');

        // getFlagInfo(context, unitCode, userN, currentDate, styleAudit);
        updateScoreCard(context, styleAudit);
        // getFinalAudit(context);
        getOpCnt(context, styleAudit);
        getDefectPart(
          context,
          styleAudit.unitCode ?? '',
          styleAudit.auditType ?? '',
          styleAudit.schDate ?? '',
          styleAudit.schDate ?? '',
          styleAudit.auditorName1 ?? '',
          styleAudit.sewLine ?? '',
          styleAudit.sessionName ?? '',
        );
        // getDefectCntData(context, unitCode, currentDate, userN, styleAudit);

        // DateTime dateToday = DateTime.now();
        // String currentDate = dateToday.toString().substring(0, 10);
        // getDefectPart(context, currentDate);

        // typeOnchange(styleAudit.auditType ?? '');
        if ((styleAuditData.auditType ?? '') == 'FAG') {
          sessionCompleted = true;
        }
      } else {
        showErrorAlert(postScoreData.message ?? "");
      }

      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
      dismissProgress();
    });
  }

  getFinalAudit(context, unitCode) {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    finalAudit = FinalAuditModel();
    notifyListeners();
    _useCase.getFinalAuditReport(unitCode, currentDate, (data) {
      finalAudit = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  UpdateScoreCardAuditStatus(context, unitCode, StyleAuditData styleAuditdata) {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    endSession = true;
    notifyListeners();
    UpdateScoreCardAuitDetail = UpdateScoreCardAuditStatusModel();
    notifyListeners();
    _useCase.UpdateScoreCardAuditStatusData(
        unitCode,
        currentDate,
        scoreCardData.auditType,
        styleAuditdata.auditorName,
        styleAuditdata.orderNo,
        styleAuditdata.sewLine,
        styleAuditdata.sessionName, (data) {
      UpdateScoreCardAuitDetail = data;

      // if (UpdateScoreCardAuitDetail.isSuccess ?? false) {}
      // endSession = false;

      auditStarted = false;
      sessionCompleted = false;

      copyFitOrderScheduleResponseAPI(
          context,
          styleAuditdata.orderSchID.toString(),
          (int.parse((styleAuditdata.sessionName ?? '')[1]) + 1).toString(),
          scoreCardData.auditType ?? '');

      notifyListeners();
      // if (styleAuditdata.preID != null) {
      //   UpdateSessionFlagAPI(context, styleAuditdata);
      // } else {
      //   if (UpdateScoreCardAuitDetail.isSuccess ?? false) {
      //     resetData();
      //     updateChartValues();
      //     copyFitOrderScheduleResponseAPI(
      //         context,
      //         styleAuditdata.orderSchID.toString(),
      //         (int.parse((styleAuditdata.sessionName ?? '')[1]) + 1).toString(),
      //         scoreCardData.auditType ?? '');
      //     // Navigator.pushReplacementNamed(
      //     //     context, Constants.fitAuditDashBoardRoute);
      //   }
      // }
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage.toString());
      dismissProgress();
    });
  }

  UpdateSessionFlagAPI(context, StyleAuditData styleAuditdata) {
    UpdateSessionFlagDetail = UpdateSessionFlagModel();
    notifyListeners();
    _useCase.UpdateSessionFlagData(styleAuditdata.preID, (data) {
      UpdateSessionFlagDetail = data;
      endSession = false;
      if (UpdateSessionFlagDetail.isSuccess ?? false) {}
      endSession = false;

      notifyListeners();
      if (UpdateSessionFlagDetail.isSuccess ?? false) {
        resetData();
        updateChartValues();
        // copyFitOrderScheduleResponseAPI(
        //     context,
        //     styleAuditdata.orderSchID.toString(),
        //     (int.parse((styleAuditdata.sessionName ?? '')[1]) + 1).toString(),
        //     scoreCardData.auditType ?? '');
        // Navigator.pushReplacementNamed(context, Constants.dashBoardRoute);
      }

      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  UpdateSessionFlagAPIFitAudit(context, int orderSchID) {
    UpdateSessionFlagDetail = UpdateSessionFlagModel();
    notifyListeners();
    _useCase.UpdateSessionFlagData(orderSchID, (data) {
      UpdateSessionFlagDetail = data;
      endSession = false;
      if (UpdateSessionFlagDetail.isSuccess ?? false) {}
      endSession = false;

      notifyListeners();
      if (UpdateSessionFlagDetail.isSuccess ?? false) {
        resetData();
        updateChartValues();
      }

      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  updateChartValues() {
    green = 0;
    yellow = 0;
    red = 0;
    remaning = 0;
    // operatorsCntController.text = remaning.toString();
    sessionCompleted = false;
    completedOperators = 1;
    completedPcs = 0;
    defectPcs = 0;
    DHU = 0;

    operatorEditable = true;
    reOperator = false;
    completedOperatorsArray = [];
    completedOperatorsFinal = [];
    completedOperatorsDetails = {};

    notifyListeners();
  }

  void selectDeleteItem(int index) {
    var array = GetListGarFitAuditDataByParamsResponsData.data ?? [];
    array[index].delete = true;
    array[index].edit = false;
    notifyListeners();
  }

  int editIndex = 0;
  void selectEditItem(int index, int id) {
    var array = GetListGarFitAuditDataByParamsResponsData.data ?? [];
    array[index].edit = true;
    array[index].delete = false;
    editIndex = index;
    getScorecardDataById(id);
    notifyListeners();
  }

  void cancelDeleteItem(int index) {
    var array = GetListGarFitAuditDataByParamsResponsData.data ?? [];
    array[index].delete = false;
    notifyListeners();
  }

  void cancelEditItem(int index) {
    var array = GetListGarFitAuditDataByParamsResponsData.data ?? [];
    array[index].edit = false;
    notifyListeners();
  }

  void deleteItem(int id, String operatorCode, context) async {
    showProgress(context);
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    scoreCardData.auditDate = currentDate;
    deleteResponse = DeleteScoreCardHeadByIdModel();
    notifyListeners();
    _useCase.deleteScoreCardHeadById(id, (data) async {
      deleteResponse = data;

      completedPcs = completedPcs + failCount + passCount;
      defectPcs = defectPcs + failCount;
      DHU = ((defectPcs / completedPcs) * 100);
      flagInfoData = FlagInfoModel();
      defectsCntData = GetDefectsCntModel();
      optData = OperatorsChart();
      var completedArr = completedOperatorsArray;
      for (int i = 0; i < completedArr.length; i++) {
        if (completedArr[i] == operatorCode) {
          completedArr.removeAt(i);
        }
      }
      completedOperatorsArray = completedArr;
      notifyListeners();
      String unitCode = await SharedPreferenceHelper.getString('unitCode');
      getOpCnt(context, styleAuditData);
      getFlagInfo(context, unitCode, styleAuditData.auditorName, currentDate,
          styleAuditData);
      getDefectCntData(context, unitCode, currentDate,
          styleAuditData.auditorName, styleAuditData);
      getDefectPart(
        context,
        styleAuditData.unitCode ?? '',
        styleAuditData.auditType ?? '',
        styleAuditData.schDate ?? '',
        styleAuditData.schDate ?? '',
        styleAuditData.auditorName1 ?? '',
        styleAuditData.sewLine ?? '',
        styleAuditData.sessionName ?? '',
      );
      GetListGarFitAuditDataByParamsResponseAPI(
          context,
          unitCode,
          styleAuditData.schDate!.substring(0, 10),
          styleAuditData.auditType,
          styleAuditData.auditorName,
          styleAuditData.orderNo,
          styleAuditData.sewLine);

      // getScoreCardEntryList(
      //     context,
      //     unitCode,
      //     styleAuditData.auditType,
      //     styleAuditData.schDate!.substring(0, 10),
      //     styleAuditData.auditorName,
      //     styleAuditData.sewLine,
      //     styleAuditData.orderNo,
      //     styleAuditData.sessionName);
      remaning = remaning + 1;
      // operatorsCntController.text = remaning.toString();
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void deleteOneItem(context, int index) {
    updateEditList();
    var dataArray = editList.data?.scoreCardDetlModels ?? [];
    dataArray[index].active = "N";
    dataArray[index].isActive = false;

    scoreCardData.garFitAuditDetlModels =
        [...dataArray].cast<GarFitAuditDetlModels>();

    notifyListeners();

    // showProgress(context);
    notifyListeners();
    // _useCase.postAuditData(scoreCardData, (data) async {
    //   // postScoreData = data;
    //   // selectEditItem(index, postScoreData.data?.id ?? 0);

    //   dismissProgress();
    // }, (errorMessage) {
    //   dismissProgress();
    // });
  }

  getScorecardDataById(id) {
    editList = GetScorecardDataByIdModel();
    notifyListeners();
    _useCase.getScorecardDataByIdData(id, (data) {
      editList = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  updateScoreCard(context, StyleAuditData styleAudit) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    selectFavorite = [];
    allDefectFinal = [];
    allDefectDetails = [];
    getOperCodeByPartIdDetail = GetOperCodeByPartIdModel();
    defaultCategory = null;
    defectImage = null;
    defectSearchController.clear();

    scoreCardData.createdDate =
        "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z";
    scoreCardData.createdBy = userN;
    scoreCardData.modifiedDate =
        "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z";
    scoreCardData.modifiedBy = userN;
    scoreCardData.isActive = true;
    scoreCardData.id = 0;
    scoreCardData.entityID = styleAudit.entityID;

    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    scoreCardData.auditDate = currentDate;
    scoreCardData.sessionName = styleAudit.sessionName;
    scoreCardData.unitCode = styleAudit.unitCode;
    scoreCardData.lineName = styleAudit.lineName;
    scoreCardData.lineCode = styleAudit.sewLine;

    // scoreCardData.sesStartDtTime = DateTime.now()
    //         .toString()
    //         .replaceAll(" ", "T")
    //         .substring(0, DateTime.now().toString().length - 3) +
    //     "Z";
    // scoreCardData.sesEndDtTime = DateTime.now()
    //         .toString()
    //         .replaceAll(" ", "T")
    //         .substring(0, DateTime.now().toString().length - 3) +
    //     "Z";
    // scoreCardData.totOperators = styleAudit.totOperators;

    scoreCardData.auditorName = userN;
    scoreCardData.buyerCode = styleAudit.buyerCode;
    scoreCardData.styleNo = styleAudit.styleNo;
    scoreCardData.orderNo = styleAudit.orderNo;
    // scoreCardData.operatorCode = "000131";
    // orderNooperatorName = "ROHINI";

    // scoreCardData.partCode = "1";
    // scoreCardData.operationCode = "1";
    scoreCardData.defectPcs = 0;
    scoreCardData.passedPcs = 0;
    scoreCardData.inspectedPcs = auditPcs;

    scoreCardData.remarks = "";
    remark = '';
    // scoreCardData.flagColor = "";
    scoreCardData.hostName = styleAudit.orderSchID.toString();
    scoreCardData.active = "Y";
    scoreCardData.garFitAuditDetlModels = [];

    operatorFound = false;
    operatorEditable = true;
    empEditable = true;
    operatorSearch.clear();
    endSession = false;
    auditCount = 0;
    failCount = 0;
    passCount = 0;
    selectFavoriteBackup = [];

    scoreCardData.auditType = styleAudit.auditType;

    // typeOnchangeOnInt(styleAudit.auditType ?? '');

    notifyListeners();
  }

  updateEditList() async {
    scoreCardData.createdDate = editList.data?.createdDate;
    scoreCardData.createdBy = editList.data?.createdBy;
    scoreCardData.modifiedDate = editList.data?.createdDate;
    scoreCardData.modifiedBy = editList.data?.modifiedBy;
    scoreCardData.isActive = editList.data?.isActive;
    scoreCardData.id = editList.data?.id;
    scoreCardData.entityID = editList.data?.entityID;
    scoreCardData.auditType = editList.data?.auditType;
    scoreCardData.auditDate = editList.data?.auditDate;
    scoreCardData.sessionName = editList.data?.sessionName;
    scoreCardData.unitCode = editList.data?.unitCode;
    scoreCardData.lineName = editList.data?.sewLine;
    scoreCardData.lineCode = editList.data?.sewLine;
    scoreCardData.totOperators = editList.data?.totOperators;
    scoreCardData.auditorName = editList.data?.auditorName;
    scoreCardData.buyerCode = editList.data?.buyerCode;
    scoreCardData.styleNo = editList.data?.styleNo;
    scoreCardData.orderNo = editList.data?.orderNo;
    scoreCardData.defectPcs = editList.data?.defectPcs;

    scoreCardData.inspectedPcs = editList.data?.inspectedPcs;
    auditPcs = editList.data?.inspectedPcs ?? 0;
    scoreCardData.remarks = editList.data?.remarks;
    // scoreCardData.flagColor = editList.data?.flagColor;
    scoreCardData.hostName = editList.data?.hostName;
    scoreCardData.active = editList.data?.active;
    // scoreCardData.scoreCardDetlModels =
    //     (editList.data?.scoreCardDetlModels ?? []).cast<ScoreCardDetlModels>();
    notifyListeners();
  }

  void showErrorAlert(String message) {
    CodeSnippet.instance.showAlertMsg(message);
  }

  favDefectDataWithLanguage(context) async {
    String languagecode =
        await SharedPreferenceHelper.getString(Constants.currentLang);
    isFavLoading = true;
    notifyListeners();

    favDefectDataWithLanguageDetail = FavDefectDataWithLanguageModel();
    notifyListeners();
    _useCase.favDefectDataWithLanguageData(
        languagecode == "" ? "EN" : languagecode, (data) {
      favDefectDataWithLanguageDetail = data;
      notifyListeners();
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    });
  }

  bool isFavLoading = false;
  UpdateIsFavModel updateIsFavModelResponse = UpdateIsFavModel();

  void saveFreqUsedDefects(context, defectCode, active) async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    SaveFreqUsedDefectsModel saveFreqUsedDefectsDetail =
        SaveFreqUsedDefectsModel();
    saveFreqUsedDefectsDetail.createdDate = currentDate;
    saveFreqUsedDefectsDetail.createdBy = userN;
    saveFreqUsedDefectsDetail.modifiedDate = currentDate;
    saveFreqUsedDefectsDetail.modifiedBy = userN;
    saveFreqUsedDefectsDetail.userName = userN;
    saveFreqUsedDefectsDetail.unitCode = unitCode;
    saveFreqUsedDefectsDetail.auditType = styleAuditData.auditType ?? '';
    saveFreqUsedDefectsDetail.defectCode = defectCode;
    saveFreqUsedDefectsDetail.ChkType = 'NA';

    saveFreqUsedDefectsDetail.id = 0;
    saveFreqUsedDefectsDetail.active = 'Y';
    saveFreqUsedDefectsDetail.hostName = 'host';
    saveFreqUsedDefectsDetail.isActive = true;

    isFavLoading = true;
    notifyListeners();
    SaveFreqUsedDefectsResponseModel SaveFreqUsedDefectsResponseDetail =
        SaveFreqUsedDefectsResponseModel();
    SaveFreqUsedDefectsResponseDetail = SaveFreqUsedDefectsResponseModel();
    notifyListeners();
    _useCase.postSaveFreqUsedDefects(saveFreqUsedDefectsDetail, (data) async {
      SaveFreqUsedDefectsResponseDetail = data;
      String unitCode = await SharedPreferenceHelper.getString('unitCode');
      notifyListeners();
      if (SaveFreqUsedDefectsResponseDetail.isSuccess ?? false) {
        Navigator.pop(context);
        String unitCode = await SharedPreferenceHelper.getString('unitCode');
        getAllDefectswithFreqUsedDefectsByParams(context, unitCode,
            scoreCardData.auditType ?? '', styleAuditData.auditorName ?? '');
        getFreqUsedDefectsByParams(context, unitCode,
            scoreCardData.auditType ?? '', styleAuditData.auditorName ?? '');
      }
      dismissProgress();
      isFavLoading = false;
      notifyListeners();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
      showErrorAlert(errorMessage.toString());
      isFavLoading = false;
      notifyListeners();
    });
  }

  ShoworHideIsFavResponseModel showorHideIsFavResponseDetail =
      ShoworHideIsFavResponseModel();
  void showorHideIsFavAPI(context, defectCode, active) async {
    isFavLoading = true;
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String defCode = defectCode;
    String Status = active;
    String auditType = scoreCardData.auditType ?? '';

    notifyListeners();
    showorHideIsFavResponseDetail = ShoworHideIsFavResponseModel();
    notifyListeners();
    _useCase.showorHideIsFavAPIdata(unitCode, auditType, userN, defCode, Status,
        (data) async {
      showorHideIsFavResponseDetail = data;
      notifyListeners();
      if (showorHideIsFavResponseDetail.isSuccess ?? false) {
        Navigator.pop(context);
        String unitCode = await SharedPreferenceHelper.getString('unitCode');
        getAllDefectswithFreqUsedDefectsByParams(context, unitCode,
            scoreCardData.auditType ?? '', styleAuditData.auditorName ?? '');
        getFreqUsedDefectsByParams(context, unitCode,
            scoreCardData.auditType ?? '', styleAuditData.auditorName ?? '');
      }
      dismissProgress();
      isFavLoading = false;
      notifyListeners();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
      // showErrorAlert(errorMessage.toString());
      saveFreqUsedDefects(context, defectCode, active);
      isFavLoading = false;
      notifyListeners();
    });
  }

  GetAllDefectswithFreqUsedDefectsByParamsModel
      getAllDefectswithFreqUsedDefectsByParamsDetail =
      GetAllDefectswithFreqUsedDefectsByParamsModel();
  getAllDefectswithFreqUsedDefectsByParams(
    context,
    String unitcode,
    String audittype,
    String username,
  ) async {
    String languagecode =
        await SharedPreferenceHelper.getString(Constants.currentLang);
    isFavLoading = true;
    notifyListeners();

    getAllDefectswithFreqUsedDefectsByParamsDetail =
        GetAllDefectswithFreqUsedDefectsByParamsModel();
    notifyListeners();
    _useCase.getAllDefectswithFreqUsedDefectsByParamsData(
        unitcode, audittype, username, languagecode == "" ? "EN" : languagecode,
        (data) {
      getAllDefectswithFreqUsedDefectsByParamsDetail = data;
      notifyListeners();
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    });
  }

  GetFreqUsedDefectsByParamsModel GetFreqUsedDefectsByParamsDetail =
      GetFreqUsedDefectsByParamsModel();

  getFreqUsedDefectsByParams(
    context,
    String unitcode,
    String audittype,
    String username,
  ) async {
    String languagecode =
        await SharedPreferenceHelper.getString(Constants.currentLang);
    isFavLoading = true;
    notifyListeners();

    GetFreqUsedDefectsByParamsDetail = GetFreqUsedDefectsByParamsModel();
    notifyListeners();
    _useCase.getFreqUsedDefectsByParamsData(
        unitcode, audittype, username, languagecode == "" ? "EN" : languagecode,
        (data) {
      GetFreqUsedDefectsByParamsDetail = data;

      notifyListeners();
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
    });
  }

  GetLineQCFrequentUsedOperationsandPartsModel
      getLineQCFrequentUsedOperationsandPartsModel =
      GetLineQCFrequentUsedOperationsandPartsModel();
  getLineQCFrequentUsedOperationsandPartsData(
    context,
    String unitcode,
    String Rencentdays,
    String audittype,
    String checkername,
    String orderno,
  ) {
    isFavLoading = true;
    notifyListeners();
    getLineQCFrequentUsedOperationsandPartsModel =
        GetLineQCFrequentUsedOperationsandPartsModel();
    notifyListeners();
    _useCase.getLineQCFrequentUsedOperationsandPartsDatas(
        unitcode, Rencentdays, audittype, checkername, orderno, (data) {
      getLineQCFrequentUsedOperationsandPartsModel = data;
      isFavLoading = false;
      notifyListeners();
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      // showErrorAlert(errorMessage);
      showErrorAlert('No operations found');
      dismissProgress();
    });
  }

  UploadImageFitAuditFileListResponse uploadImageResponse =
      UploadImageFitAuditFileListResponse();

  void sewlineUpdater(String sewLine) {
    styleAuditData.lineName = sewLine;

    notifyListeners();
  }

  void refreshPartOperation() async {
    String lan = await SharedPreferenceHelper.getString(Constants.currentLang);
    scoreCardData.partCode = "";
    scoreCardData.operationCode = "NA";
    getSleeves(context, lan.isEmpty ? 'EN' : lan, styleAuditData.productType);
  }

  GetUDMasterByTypeResponseModel getUDMasterByTypeResponse =
      GetUDMasterByTypeResponseModel();
  getUDMasterByTypeResponseAPI(String type) {
    getUDMasterByTypeResponse = GetUDMasterByTypeResponseModel();
    notifyListeners();
    _useCase.getUDMasterByTypeResponseAPI(type, (data) {
      getUDMasterByTypeResponse = data;
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void typeOnchange(String value) async {
    scoreCardData.auditType = value;
    styleAuditData.auditType = value;

    if (value == 'FAG') {
      operatorsCntOnChange('1');
      operatorsCntController.text = '1';
      completedOperatorsArray.add(operatorSearch.text);
      reOperatorChecker();
      scoreCardData.totOperators = 1;
      operatorSearch.text = '';
      scoreCardData.partCode = 'NA';
      scoreCardData.operationCode = 'NA';
      scoreCardData.operatorCode = 'NA';
      scoreCardData.operatorName = 'NA';
      operatorFound = true;
      operatorEditable = false;
      empEditable = false;
    } else {
      operatorsCntOnChange('');
      operatorFound = false;
      operatorEditable = true;
      empEditable = true;
      operatorSearch.clear();
    }
    notifyListeners();
  }

  void auditPcsCntOnChange(
    String value,
  ) {
    if (value.isNotEmpty) {
      auditPcs = int.parse(value);
      scoreCardData.inspectedPcs = auditPcs;
      notifyListeners();
    }
  }

  void updatePassedWithInspected() {
    if (scoreCardData.passedPcs == null || scoreCardData.passedPcs == 0) {
      scoreCardData.passedPcs = auditPcs;
      passCount = auditPcs;
    }

    notifyListeners();
  }

  bool isCameraScreen = false;
  void setIsCameraScreen() {
    isCameraScreen = !isCameraScreen;
    notifyListeners();
  }

  Future<bool> fitAuditExitAction() async {
    if (isCameraScreen) {
      isCameraScreen = false;
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  Future<String> saveFileList(String imagePath) async {
    // final directory = await getApplicationDocumentsDirectory();
    // final name = basename(imagePath);
    // final image = File('${directory.path}/$name');

    File imagefile = File(imagePath);
    Uint8List imagebytes = await imagefile.readAsBytes();
    String base64string = base64.encode(imagebytes);
    defectbase = base64string;

    // postImageUploadList(context, name, base64string);

    notifyListeners();
    return base64string;
  }

  UploadImageFitAuditFileListResponse uploadImageResponseList =
      UploadImageFitAuditFileListResponse();
  List<File> capturedImages = [];
  postImageUploadList(BuildContext context, List<File> capturedImages) async {
    showProgress(context);
    uploadImageResponse = UploadImageFitAuditFileListResponse();
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    notifyListeners();
    _useCase.postImageUploadData(
        UploadImageFitAuditFileListRequest(uploadBase64Datacollection: [
          for (int i = 0; i < capturedImages.length; i++)
            UploadBase64DatacollectionFitAudit(
                // fName: ((DateTime.now().toString().split('.')[1]) +
                //     (i).toString()),
                fName:
                    ('${capturedImages[i].path.split(' ')[1].split('.')[1]}.${capturedImages[i].path.split(' ')[1].split('.')[2]}'),
                packAttach: (await saveFileList(capturedImages[i].path)),
                auditType: styleAuditData.auditType,
                insType: styleAuditData.insType,
                factoryCode: styleAuditData.unitCode,
                round: scoreCardData.sessionName,
                sewLine: scoreCardData.lineName,
                defectName: (scoreCardData.garFitAuditDetlModels ?? [])
                        .isNotEmpty
                    ? (scoreCardData.garFitAuditDetlModels ?? [])[0].defectCode
                    : 'NA')
        ]), (data) {
      uploadImageResponse = data;

      List<GarFitAuditImagesModels> scoreCardImagesModels = [];
      scoreCardImagesModels.addAll([
        for (int i = 0; i < (uploadImageResponse.data ?? []).length; i++)
          GarFitAuditImagesModels(
              createdDate:
                  "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
              createdBy: userN,
              modifiedDate:
                  "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
              modifiedBy: userN,
              isActive: true,
              id: 0,
              garFitAuditDetlID: 0,
              garFitAuditHeadID: 0,
              // scDetlID: 0,
              active: 'Y',
              fName: uploadImageResponse.data?[i].filename ?? '',
              filePath: uploadImageResponse.data?[i].filepath ?? '',
              hostName: "",
              packAttach: '')
      ]);

      if (auditCurrentCheck == 'pass') {
        var newList = scoreCardData.garFitAuditDetlModels ?? [];
        newList.add(GarFitAuditDetlModels(
            createdDate:
                "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
            createdBy: userN,
            modifiedDate:
                "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
            modifiedBy: userN,
            isActive: true,
            id: 0,
            garFitAuditHeadID: 0,
            fitAuditStatus: auditCurrentCheck == 'pass'
                ? 'P'
                : auditCurrentCheck == 'fail'
                    ? 'D'
                    : 'NA',
            remarks:
                remarkController.text.isEmpty ? 'NA' : remarkController.text,
            // scHeadID: 0,
            defectCode: 'NA',
            garSize: "NA",
            tagId: "NA",
            isClosed: "Y",
            hostName: "NA",
            active: "Y",
            garFitAuditImagesModels: []));

        scoreCardData.garFitAuditDetlModels = newList;

        scoreCardData
            .garFitAuditDetlModels?[
                (scoreCardData.garFitAuditDetlModels ?? []).length - 1]
            .garFitAuditImagesModels = scoreCardImagesModels;
        selectFavorite = ['NA'];
        inspect(scoreCardData);
      } else {
        scoreCardData
            .garFitAuditDetlModels?[
                (scoreCardData.garFitAuditDetlModels ?? []).length - 1]
            .garFitAuditImagesModels = scoreCardImagesModels;
      }
      capturedImages.clear();
      isCameraScreen = false;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      Navigator.pushReplacementNamed(context, Constants.fitAuditDashBoardRoute);
      dismissProgress();
    });
  }

  void saveImagesForCamera(List<File> capturedImages) {}
  void notifyCamery() {
    notifyListeners();
  }

  void imageUploadMaker() {
    if (auditCurrentCheck == 'pass') {
      if ((scoreCardData.garFitAuditDetlModels ?? []).isEmpty) {}
    }
  }

  CopyFitOrderScheduleResponseModel copyFitOrderScheduleResponse =
      CopyFitOrderScheduleResponseModel();
  copyFitOrderScheduleResponseAPI(
    context,
    String orderschId,
    String round,
    String newaudittype,
  ) async {
    copyFitOrderScheduleResponse = CopyFitOrderScheduleResponseModel();
    notifyListeners();
    _useCase.copyFitOrderScheduleResponseAPI(orderschId, round, newaudittype,
        (data) async {
      copyFitOrderScheduleResponse = data;
      if (copyFitOrderScheduleResponse.isSuccess == true) {
        updateScoreCard(context, styleAuditData);
        DateTime dateToday = DateTime.now();
        String currentDate = dateToday.toString().substring(0, 10);
        String userN =
            await SharedPreferenceHelper.getString(Constants.userDisplayName);
        scoreCardData.active = 'Y';
        scoreCardData.auditDate = currentDate;
        scoreCardData.auditType = scoreCardData.sessionName =
            ((copyFitOrderScheduleResponse
                        .data?.auditScheduleHeadEntityModels ??
                    [])[0]
                .auditType);
        styleAuditData.auditType = scoreCardData.auditType;
        scoreCardData.auditorName = userN;
        scoreCardData.buyerCode = styleAuditData.buyerCode;
        scoreCardData.createdBy = userN;
        scoreCardData.createdDate = currentDate;
        scoreCardData.defectPcs = 0;
        scoreCardData.entityID = styleAuditData.entityID;
        scoreCardData.garFitAuditDetlModels = [];
        scoreCardData.hostName = styleAuditData.orderSchID.toString();
        scoreCardData.id = 0;
        scoreCardData.inspectedPcs = auditPcs;
        scoreCardData.isActive = true;
        scoreCardData.lineName = styleAuditData.lineName;
        scoreCardData.lineCode = styleAuditData.sewLine;
        scoreCardData.modifiedBy = userN;
        scoreCardData.modifiedDate = currentDate;
        scoreCardData.operationCode = null;
        // scoreCardData.operatorCode = '';
        scoreCardData.orderNo = styleAuditData.orderNo;
        scoreCardData.partCode = null;
        scoreCardData.passedPcs = 0;
        scoreCardData.remarks = '';
        scoreCardData.sessionName = ((copyFitOrderScheduleResponse
                    .data?.auditScheduleHeadEntityModels ??
                [])[0]
            .sessionName);
        scoreCardData.styleNo = styleAuditData.styleNo;
        // scoreCardData.totOperators = 0;
        scoreCardData.unitCode = styleAuditData.unitCode;

        // styleAuditData.auditType = null;
        styleAuditData.auditorName = userN;
        styleAuditData.buyerCode = styleAuditData.buyerCode;
        styleAuditData.createdBy = userN;
        styleAuditData.createdDate = currentDate;
        styleAuditData.entityID = styleAuditData.entityID;
        styleAuditData.hostName = styleAuditData.orderSchID.toString();
        styleAuditData.id = 0;
        styleAuditData.isActive = true;
        styleAuditData.lineName = styleAuditData.lineName;
        styleAuditData.modifiedBy = userN;
        styleAuditData.modifiedDate = currentDate;
        // styleAuditData.operatorCode = '';
        styleAuditData.orderNo = styleAuditData.orderNo;
        styleAuditData.sessionName = ((copyFitOrderScheduleResponse
                    .data?.auditScheduleHeadEntityModels ??
                [])[0]
            .sessionName);
        styleAuditData.styleNo = styleAuditData.styleNo;
        // styleAuditData.totOperators = 0;
        styleAuditData.unitCode = styleAuditData.unitCode;
        styleAuditData.sessionName = scoreCardData.sessionName;
        styleAuditData.orderSchID = ((copyFitOrderScheduleResponse
                    .data?.auditScheduleHeadEntityModels ??
                [])[0]
            .orderSchID);

        selectFavoriteBackup = [];
        remark = '';
        typeOnchange(styleAuditData.auditType ?? '');
        // styleAuditData.orderSchID = copyFitOrderScheduleResponse
        //             .data?.s;

        // if ((copyFitOrderScheduleResponse.data?.auditScheduleHeadEntityModels ??
        //                 [])[0]
        //             .orderSchID !=
        //         null &&
        //     (copyFitOrderScheduleResponse.data?.auditScheduleHeadEntityModels ??
        //                 [])[0]
        //             .orderSchID !=
        //         0) {
        // UpdateSessionFlagAPIFitAudit(
        //     context,
        //     ((copyFitOrderScheduleResponse
        //                     .data?.auditScheduleHeadEntityModels ??
        //                 [])[0]
        //             .orderSchID) ??
        //         0);
        // }
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      Navigator.pushReplacementNamed(context, Constants.fitAuditDashBoardRoute);
      dismissProgress();
    });
  }

  GetListGarFitAuditDataByParamsResponseModel
      GetListGarFitAuditDataByParamsResponsData =
      GetListGarFitAuditDataByParamsResponseModel();
  GetListGarFitAuditDataByParamsResponseAPI(
      context, unitcode, auditDate, audittype, auditername, orderno, sewline) {
    GetListGarFitAuditDataByParamsResponsData =
        GetListGarFitAuditDataByParamsResponseModel();
    notifyListeners();
    _useCase.GetListGarFitAuditDataByParamsResponseAPI(
        unitcode, auditDate, audittype, auditername, orderno, sewline, (data) {
      GetListGarFitAuditDataByParamsResponsData = data;
      inspect(GetListGarFitAuditDataByParamsResponsData);
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      debugPrint(errorMessage);
      dismissProgress();
    });
  }

  GetUDMasterByTypeAuditPcsResponseModel getUDMasterByTypeResponseAuditPcs =
      GetUDMasterByTypeAuditPcsResponseModel();
  getUDMasterByTypeResponseAPIauditPcs(String type) {
    getUDMasterByTypeResponseAuditPcs =
        GetUDMasterByTypeAuditPcsResponseModel();
    notifyListeners();
    _useCase.getUDMasterByTypeResponseAPIauditPcs(type, (data) {
      getUDMasterByTypeResponseAuditPcs = data;
      if ((getUDMasterByTypeResponseAuditPcs.data ?? []).isNotEmpty) {
        auditPcs = int.parse(
            ((getUDMasterByTypeResponseAuditPcs.data ?? [])[0].code ?? '0'));
        scoreCardData.inspectedPcs = auditPcs;
      }
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void saveFunctionFAP() {
    bool imageAddedChecker = false;
    for (int i = 0;
        i < (scoreCardData.garFitAuditDetlModels ?? []).length;
        i++) {
      for (int j = 0;
          j <
              ((scoreCardData.garFitAuditDetlModels ?? [])[i]
                          .garFitAuditImagesModels ??
                      [])
                  .length;
          j++) {
        if (((scoreCardData.garFitAuditDetlModels ?? [])[i]
                    .garFitAuditImagesModels ??
                [])
            .isNotEmpty) {
          imageAddedChecker = true;
        }
      }
    }

    if (auditCurrentCheck == "fail") {
      if (selectFavorite.isNotEmpty &&
          (scoreCardData.remarks ?? '').isNotEmpty) {
        if (auditCount < auditPcs) {
          defectListGenerator();
          defectImage = null;
          auditStep = 1;
          failCount = failCount + 1;
          auditCount = auditCount + 1;
          scoreCardData.defectPcs = failCount;
          scoreCardData.passedPcs = passCount;
          scoreCardData.remarks = remark;
          remarkController.clear();
          defaultCategory = null;
          defectSearchController.clear();
          tagName.clear();
          allDefectData.data?.allDefects = searchDefect;
          selectFavorite = [];
          auditCurrentCheck = '';
        }
        if (auditCount == auditPcs) {
          isPass = false;
        }
        notifyListeners();
      } else {
        showErrorAlert('Please add defect and comment');
      }
    } else if (auditCurrentCheck == 'pass') {
      if (auditCount < auditPcs) {
        defectListGenerator();
        defectImage = null;
        auditStep = 1;
        passCount = passCount + 1;
        auditCount = auditCount + 1;
        scoreCardData.defectPcs = failCount;
        scoreCardData.passedPcs = passCount;
        scoreCardData.remarks = remark;
        remarkController.clear();
        defaultCategory = null;
        defectSearchController.clear();
        tagName.clear();
        allDefectData.data?.allDefects = searchDefect;
        selectFavorite = [];
        auditCurrentCheck = '';
      }
      if (auditCount == auditPcs) {
        isPass = false;
      }
      notifyListeners();
    }
  }

  void saveFunctionFAG() {
    bool imageAddedChecker = false;
    for (int i = 0;
        i < (scoreCardData.garFitAuditDetlModels ?? []).length;
        i++) {
      for (int j = 0;
          j <
              ((scoreCardData.garFitAuditDetlModels ?? [])[i]
                          .garFitAuditImagesModels ??
                      [])
                  .length;
          j++) {
        if (((scoreCardData.garFitAuditDetlModels ?? [])[i]
                    .garFitAuditImagesModels ??
                [])
            .isNotEmpty) {
          imageAddedChecker = true;
        }
      }
    }

    if (auditCurrentCheck == "fail") {
      if (imageAddedChecker &&
          selectFavorite.isNotEmpty &&
          (scoreCardData.remarks ?? '').isNotEmpty) {
        if (auditCount < auditPcs) {
          defectListGenerator();
          defectImage = null;
          auditStep = 1;
          failCount = failCount + 1;
          auditCount = auditCount + 1;
          scoreCardData.defectPcs = failCount;
          scoreCardData.passedPcs = passCount;
          scoreCardData.remarks = remark;
          remarkController.clear();
          defaultCategory = null;
          defectSearchController.clear();
          tagName.clear();
          allDefectData.data?.allDefects = searchDefect;
          selectFavorite = [];
          auditCurrentCheck = '';
        }
        if (auditCount == auditPcs) {
          isPass = false;
        }
        notifyListeners();
      } else {
        showErrorAlert('Please add image and comment');
      }
    } else if (auditCurrentCheck == 'pass') {
      if (imageAddedChecker &&
          selectFavorite.isNotEmpty &&
          (scoreCardData.remarks ?? '').isNotEmpty) {
        if (auditCount < auditPcs) {
          defectListGenerator();
          defectImage = null;
          auditStep = 1;
          passCount = passCount + 1;
          auditCount = auditCount + 1;
          scoreCardData.defectPcs = failCount;
          scoreCardData.passedPcs = passCount;
          scoreCardData.remarks = remark;
          remarkController.clear();
          defaultCategory = null;
          defectSearchController.clear();
          tagName.clear();
          allDefectData.data?.allDefects = searchDefect;
          selectFavorite = [];
          auditCurrentCheck = '';
        }
        if (auditCount == auditPcs) {
          isPass = false;
        }
        notifyListeners();
      } else {
        showErrorAlert('Please add image and comment');
      }
    }
  }

  void saveFunctionFAF() {
    bool imageAddedChecker = false;
    for (int i = 0;
        i < (scoreCardData.garFitAuditDetlModels ?? []).length;
        i++) {
      for (int j = 0;
          j <
              ((scoreCardData.garFitAuditDetlModels ?? [])[i]
                          .garFitAuditImagesModels ??
                      [])
                  .length;
          j++) {
        if (((scoreCardData.garFitAuditDetlModels ?? [])[i]
                    .garFitAuditImagesModels ??
                [])
            .isNotEmpty) {
          imageAddedChecker = true;
        }
      }
    }

    if (auditCurrentCheck == "fail") {
      if (imageAddedChecker &&
          selectFavorite.isNotEmpty &&
          (scoreCardData.remarks ?? '').isNotEmpty) {
        if (auditCount < auditPcs) {
          defectListGenerator();
          defectImage = null;
          auditStep = 1;
          failCount = failCount + 1;
          auditCount = auditCount + 1;
          scoreCardData.defectPcs = failCount;
          scoreCardData.passedPcs = passCount;
          scoreCardData.remarks = remark;
          remarkController.clear();
          defaultCategory = null;
          defectSearchController.clear();
          tagName.clear();
          allDefectData.data?.allDefects = searchDefect;
          selectFavorite = [];
          auditCurrentCheck = '';
        }
        if (auditCount == auditPcs) {
          isPass = false;
        }
        notifyListeners();
      } else {
        showErrorAlert('Please add image and comment');
      }
    } else if (auditCurrentCheck == 'pass') {
      if (auditCount < auditPcs) {
        defectListGenerator();
        defectImage = null;
        auditStep = 1;
        passCount = passCount + 1;
        auditCount = auditCount + 1;
        scoreCardData.defectPcs = failCount;
        scoreCardData.passedPcs = passCount;
        scoreCardData.remarks = remark;
        remarkController.clear();
        defaultCategory = null;
        defectSearchController.clear();
        tagName.clear();
        allDefectData.data?.allDefects = searchDefect;
        selectFavorite = [];
        auditCurrentCheck = '';
      }
      if (auditCount == auditPcs) {
        isPass = false;
      }
      notifyListeners();
    }
  }
}
