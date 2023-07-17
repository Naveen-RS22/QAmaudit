import 'dart:async';
import 'dart:convert';
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
import 'package:qapp/app/data/network/dto/GetAllGarOperationMasterModel.dart';
import 'package:qapp/app/data/network/dto/GetAllGarPartDataModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectsCntModel.dart';

import 'package:qapp/app/data/network/dto/GetEmpData.dart';
import 'package:qapp/app/data/network/dto/GetFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCFrequentUsedOperationsandPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetOperCodeByPartIdModel.dart';
import 'package:qapp/app/data/network/dto/GetScoreCardEntryListModel.dart';
import 'package:qapp/app/data/network/dto/GetScorecardDataByIdModel.dart';
import 'package:qapp/app/data/network/dto/OperatorsChartsModel.dart';
import 'package:qapp/app/data/network/dto/PostScoreDataModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveScoreCard.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UpdateScoreCardAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateSessionFlagModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/audit/audit_use_case.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';

import 'package:qapp/app/utils/code_snippet.dart';

import '../../data/local/shared_prefs_helper.dart';
import '../../data/network/dto/DefectPartModel.dart';
import '../../res/constants.dart';

class AuditViewModal extends BaseViewModel {
  final AuditUserCase _useCase = AppManager.instance.auditUseCase();
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

  List<ScoreCardDetlModels> top3TotalData = [];

  var top3Final = [];
  List top3Data = [];
  List<Map<String, dynamic>> allDefectDetails = [];

  final tagName = TextEditingController();
  final operatorSearch = TextEditingController();
  final defectSearchController = TextEditingController();
  final remarkController = TextEditingController();
  final operatorsCntController = TextEditingController();

  static const countDown = Duration(minutes: 10);

  FinalAuditModel finalAudit = FinalAuditModel();
  GetAllGarPartDataModel sleevesData = GetAllGarPartDataModel();
  GetAllGarOperationMasterModel sleevesAttachmentData =
      GetAllGarOperationMasterModel();
  GetFavouriteModel favoriteData = GetFavouriteModel();
  GetAllDefectsModel allDefectData = GetAllDefectsModel();
  GetDefectTranslationMasterByLanguageCodeModel getDefectTranslation =
      GetDefectTranslationMasterByLanguageCodeModel();

  PostScoreDataModel postScoreData = PostScoreDataModel();
  GetEmpDataModel empData = GetEmpDataModel();
  OperatorsChart optData = OperatorsChart();
  DefectPartModel defectPart = DefectPartModel();
  // SaveScoreCardModel scoreCardData = SaveScoreCardModel();
  SaveScoreCardModel scoreCardData = SaveScoreCardModel();
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
        print(e);
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

    postImageUpload(context, name, base64string);

    notifyListeners();
    return File(imagePath).copy(image.path);
  }

  void setDefectList(val) async {
    isDefectList = val;
    print(val);
    if (val == true) {
      String unitCode = await SharedPreferenceHelper.getString('unitCode');
      getScoreCardEntryList(
          context,
          unitCode,
          styleAuditData.auditType,
          styleAuditData.schDate!.substring(0, 10),
          styleAuditData.auditorName,
          styleAuditData.sewLine,
          styleAuditData.orderNo,
          styleAuditData.sessionName);
    }
    notifyListeners();
  }

  getDefectPart(context, unitCode, String currentDate) {
    defectPart = DefectPartModel();
    notifyListeners();
    _useCase.getDefectpart(unitCode, currentDate, (data) {
      defectPart = data;
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
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
    notifyListeners();
  }

  void operatorsCntOnChange(
      String value, BuildContext context, StyleAuditData styleInfo) {
    if (value.isNotEmpty) {
      scoreCardData.totOperators = int.parse(value);
      remaning = int.parse(operatorsCntController.text);
      // getOpCnt(context, styleInfo);
      notifyListeners();
    }
  }

  void nextOperatorFunction() {}
  void failFunction() {
    // if (tagName.text.isNotEmpty) {
    if (auditCount < 7) {
      auditStep = 2;
      auditStepUpdate(3);
      auditCurrentCheck = 'fail';
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
    if (auditCount < 7) {
      isPass = true;
      auditStep = 1;
      auditCount = auditCount + 1;
      auditCurrentCheck = 'pass';
      passCount = passCount + 1;
      // completedPcs = completedPcs + 1;
      // DHU = (defectPcs * 100) / completedPcs;

      if (auditCount == 7) {
        isPass = false;
      }
      notifyListeners();
    }
  }

  void defectListGenerator() {
    allDefectFinal.addAll(selectFavorite);

    top3TotalData = [...scoreCardData.scoreCardDetlModels ?? []];
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

    var data = scoreCardData.scoreCardDetlModels ?? [];

    var newMap =
        groupBy(top3TotalData, (ScoreCardDetlModels obj) => obj.defectCode);
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

  void saveFunction() {
    if (auditCount < 7) {
      // if (auditCurrentCheck == 'fail') {

      defectListGenerator();
      defectImage = null;
      auditStep = 1;
      failCount = failCount + 1;
      auditCount = auditCount + 1;
      scoreCardData.defectPcs = failCount;
      // }

      scoreCardData.remarks = remarkController.text;
      remarkController.clear();
      defaultCategory = null;
      defectSearchController.clear();
      tagName.clear();
      allDefectData.data?.allDefects = searchDefect;
      selectFavorite = [];
      auditCurrentCheck = '';
    }
    if (auditCount == 7) {
      isPass = false;
    }
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

    allDefectFinal = [];
    countDetails = {};
    finalAudit = FinalAuditModel();
    sleevesData = GetAllGarPartDataModel();
    sleevesAttachmentData = GetAllGarOperationMasterModel();
    favoriteData = GetFavouriteModel();
    allDefectData = GetAllDefectsModel();

    postScoreData = PostScoreDataModel();
    empData = GetEmpDataModel();
    optData = OperatorsChart();
    scoreCardData = SaveScoreCardModel();
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
          title: "Audit 7.0",
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

    if (operatorFound) {
      if (failCount == 0) {
        scoreCardData.flagColor = "G";
      } else if (failCount == 1) {
        scoreCardData.flagColor = "O";
      } else {
        scoreCardData.flagColor = "R";
      }

      passCount = (failCount - 7).abs();
      auditCount = 7;
      scoreCardData.sesEndDtTime =
          "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z";

      notifyListeners();
    }

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
      scoreCardData.sesStartDtTime =
          "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z";
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
      var newList = scoreCardData.scoreCardDetlModels ?? [];
      newList.add(ScoreCardDetlModels(
          createdDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          createdBy: userN,
          modifiedDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          modifiedBy: userN,
          isActive: true,
          id: 0,
          scHeadID: 0,
          defectCode: selectedFavorite,
          garSize: "L",
          tagId: tagName.text,
          isClosed: "Y",
          hostName: defectName,
          active: "Y",
          scoreCardImagesModels: []));

      scoreCardData.scoreCardDetlModels = newList;
      notifyListeners();
    } else {
      selectFavorite.removeAt(findItem);
      scoreCardData.scoreCardDetlModels?.removeAt(findItem);
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
    scoreCardData.scoreCardDetlModels = [];
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
    updateScoreCard(context, styleAudit);
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    getOpCnt(context, styleAudit);
    getDefectPart(context, unitCode, currentDate);

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

      // int optCount = optData.data?.totalcount ?? 0;
      // int nextoperatorCal = scoreCardData.totOperators ?? 0;
      // final nextoptData = nextoperatorCal - optCount;
      // if (optData.data != null) {
      //   final opCnt = optData.data!.operatorcnt?.length ?? [].length;
      //   for (int i = 0; i < opCnt; i++) {
      //     Operatorcnt info = optData.data!.operatorcnt![i];
      //     if (info.flgcolor == "G") {
      //       green = info.operCnt ?? 0;
      //       passCnt = info.operCnt ?? 0;
      //     } else if (info.flgcolor == "R") {
      //       red = info.operCnt ?? 0;
      //       FailCnt = info.operCnt ?? 0;
      //     } else {
      //       yellow = info.operCnt ?? 0;
      //       yellowCnt = info.operCnt ?? 0;
      //     }
      //   }
      // }

      // remainingCnt = nextoptData;
      // if (nextoptData <= 0) {
      //   nextOperatorAction = false;
      // }

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
    notifyListeners();
  }

  postAudit(context, StyleAuditData styleAudit) {
    FocusScope.of(context).requestFocus(FocusNode());

    notifyListeners();
    showProgress(context);
    scoreCardData.operationCode = scoreCardData.operationCode ?? '';
    scoreCardData.partCode = scoreCardData.partCode ?? '';
    postScoreData = PostScoreDataModel();
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

        getOpCnt(context, styleAudit);
        getFlagInfo(context, unitCode, userN, currentDate, styleAudit);
        updateScoreCard(context, styleAudit);
        // getFinalAudit(context);
        getDefectCntData(context, unitCode, currentDate, userN, styleAudit);

        // DateTime dateToday = DateTime.now();
        // String currentDate = dateToday.toString().substring(0, 10);
        // getDefectPart(context, currentDate);
      } else {
        showErrorAlert(postScoreData.message ?? "");
      }

      dismissProgress();
    }, (errorMessage) {
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
        styleAuditdata.auditType,
        styleAuditdata.auditorName,
        styleAuditdata.orderNo,
        styleAuditdata.sewLine,
        styleAuditdata.sessionName, (data) {
      UpdateScoreCardAuitDetail = data;

      // if (UpdateScoreCardAuitDetail.isSuccess ?? false) {}
      // endSession = false;

      notifyListeners();
      if (styleAuditdata.preID != null) {
        UpdateSessionFlagAPI(context, styleAuditdata);
      } else {
        if (UpdateScoreCardAuitDetail.isSuccess ?? false) {
          resetData();
          updateChartValues();
          Navigator.pushReplacementNamed(context, Constants.dashBoardRoute);
        }
      }
      dismissProgress();
    }, (errorMessage) {
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
        Navigator.pushReplacementNamed(context, Constants.dashBoardRoute);
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
    var array = getScoreCardEntryListDetail.data ?? [];
    array[index].delete = true;
    array[index].edit = false;
    notifyListeners();
  }

  int editIndex = 0;
  void selectEditItem(int index, int id) {
    var array = getScoreCardEntryListDetail.data ?? [];
    array[index].edit = true;
    array[index].delete = false;
    editIndex = index;
    getScorecardDataById(id);
    notifyListeners();
  }

  void cancelDeleteItem(int index) {
    var array = getScoreCardEntryListDetail.data ?? [];
    array[index].delete = false;
    notifyListeners();
  }

  void cancelEditItem(int index) {
    var array = getScoreCardEntryListDetail.data ?? [];
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

      getScoreCardEntryList(
          context,
          unitCode,
          styleAuditData.auditType,
          styleAuditData.schDate!.substring(0, 10),
          styleAuditData.auditorName,
          styleAuditData.sewLine,
          styleAuditData.orderNo,
          styleAuditData.sessionName);
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

    scoreCardData.scoreCardDetlModels =
        [...dataArray].cast<ScoreCardDetlModels>();

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
    scoreCardData.auditType = "7.0";
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    scoreCardData.auditDate = currentDate;
    scoreCardData.sessionName = styleAudit.sessionName;
    scoreCardData.unitCode = styleAudit.unitCode;
    scoreCardData.sewLine = styleAudit.sewLine;
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
    scoreCardData.totOperators = 0;
    scoreCardData.auditorName = userN;
    scoreCardData.buyerCode = styleAudit.buyerCode;
    scoreCardData.styleNo = styleAudit.styleNo;
    scoreCardData.orderNo = styleAudit.orderNo;
    // scoreCardData.operatorCode = "000131";
    // scoreCardData.operatorName = "ROHINI";

    // scoreCardData.partCode = "1";
    // scoreCardData.operationCode = "1";
    scoreCardData.defectPcs = 0;
    scoreCardData.inspectedPcs = 7;
    scoreCardData.remarks = "";
    scoreCardData.flagColor = "";
    scoreCardData.hostName = "";
    scoreCardData.active = "Y";
    scoreCardData.scoreCardDetlModels = [];

    operatorFound = false;
    operatorEditable = true;
    empEditable = true;
    operatorSearch.clear();
    operatorFound = false;
    endSession = false;
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
    scoreCardData.sewLine = editList.data?.sewLine;
    scoreCardData.totOperators = editList.data?.totOperators;
    scoreCardData.auditorName = editList.data?.auditorName;
    scoreCardData.buyerCode = editList.data?.buyerCode;
    scoreCardData.styleNo = editList.data?.styleNo;
    scoreCardData.orderNo = editList.data?.orderNo;
    scoreCardData.defectPcs = editList.data?.defectPcs;
    scoreCardData.inspectedPcs = editList.data?.inspectedPcs;
    scoreCardData.remarks = editList.data?.remarks;
    scoreCardData.flagColor = editList.data?.flagColor;
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
            styleAuditData.auditType ?? '', styleAuditData.auditorName ?? '');
        getFreqUsedDefectsByParams(context, unitCode,
            styleAuditData.auditType ?? '', styleAuditData.auditorName ?? '');
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
            styleAuditData.auditType ?? '', styleAuditData.auditorName ?? '');
        getFreqUsedDefectsByParams(context, unitCode,
            styleAuditData.auditType ?? '', styleAuditData.auditorName ?? '');
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

  UploadImageResponseModel uploadImageResponse = UploadImageResponseModel();

  postImageUpload(BuildContext context, String fName, String packAttach) async {
    showProgress(context);
    uploadImageResponse = UploadImageResponseModel();
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    notifyListeners();
    _useCase.postImageUploadData(
        UploadImageModel(uploadBase64Datacollection: [
          UploadBase64Datacollection(
              fName: fName,
              packAttach: packAttach,
              auditType: styleAuditData.auditType,
              insType: styleAuditData.insType,
              factoryCode: styleAuditData.unitCode,
              defectName: selectFavorite[0])
        ]), (data) {
      uploadImageResponse = data;

      List<ScoreCardImagesModels> scoreCardImagesModels = [];
      scoreCardImagesModels.add(ScoreCardImagesModels(
          createdDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          createdBy: userN,
          modifiedDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          modifiedBy: userN,
          isActive: true,
          id: 0,
          scDetlID: 0,
          fName: uploadImageResponse.data?[0].filename ?? '',
          filePath: uploadImageResponse.data?[0].filepath ?? '',
          hostName: "",
          packAttach: ''));

      scoreCardData
          .scoreCardDetlModels?[
              (scoreCardData.scoreCardDetlModels ?? []).length - 1]
          .scoreCardImagesModels = scoreCardImagesModels;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void sewlineUpdater(String sewLine) {
    print('----');
    print(sewLine);
    print('----');
    styleAuditData.lineName = sewLine;

    notifyListeners();
  }

  void refreshPartOperation() async {
    String lan = await SharedPreferenceHelper.getString(Constants.currentLang);
    scoreCardData.partCode = "";
    scoreCardData.operationCode = "NA";
    getSleeves(context, lan.isEmpty ? 'EN' : lan, styleAuditData.productType);
  }
}
