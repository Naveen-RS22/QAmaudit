import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/network/dto/FavDefectDataWithLanguageModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
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
import 'package:qapp/app/data/network/dto/SaveLineQCModel.dart';
import 'package:qapp/app/data/network/dto/SaveOrderScheduleRequestModel.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsclosedTagModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/class%20SaveOrderScheduleResponseModel%20%7B.dart';
import 'package:qapp/app/data/network/dto/GetLineQCApprovalByParamsListModel.dart';
import 'package:qapp/app/data/network/dto/GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel.dart';
import 'package:qapp/app/data/network/dto/dsa.dart';
// import 'package:qapp/app/data/network/dto/ds.dart';
import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';

import 'package:qapp/app/features/inline/inline_use_case.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/utils/code_snippet.dart';

import '../../data/local/shared_prefs_helper.dart';
import '../../data/network/dto/DefectPartModel.dart';
import '../../data/network/dto/GetDefectCodeByTagIdModel.dart';
import '../../data/network/dto/GetLineQcdefectCountModel.dart';
import '../../data/network/dto/QCSummaryModel.dart';
import '../../data/network/dto/SaveInlineData.dart';
import '../../res/constants.dart';

class InlineViewModal extends BaseViewModel {
  final InlineUserCase _useCase = AppManager.instance.inlineUseCase();
  final pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);

  String? sleeveValue;
  String? sleeveAttachmentValue;
  String? garTagList;
  String? tagNumber;
  String finalDropDown = "FG";
  List selectFavorite = [];

  bool enableRound = false;
  Timer? timer;
  int auditStep = 1;
  int auditCount = 0;
  int failCount = 0;
  int passCount = 0;
  int garStatus = 0;
  int? remainingCnt;
  int? passCnt;
  int? failCnt;
  int? yellowCnt;
  String auditCurrentCheck = "";
  String empCodeString = "";
  String defectSearch = "";
  String? defaultCategory;
  bool operatorFound = false;
  bool isCount = true;
  bool nextOperatorAction = true;
  bool isPass = false;
  bool tagDisable = false;
  StyleAuditData? styleAuditData;
  bool isReportScreen = false;
  bool isScheduleScreen = false;
  int currentReportScreen = 1;
  int currentDefectScreen = 1;
  bool isDefectScreen = false;

  List<String> finishDropDownList = [
    'Presentation Checking',
    'Inside Checking',
    "Outside Checking"
  ];
  List<Map<String, String>> finishDropDownList2 = [
    {"id": "FG", "text": "Presentation Checking"},
    {"id": "FG-I", "text": "Inside Checking"},
    {"id": "FG-O", "text": "Outside Checking"},
  ];
  List<Map<String, String>> finishDropDownList3 = [];
  final operatorSearch = TextEditingController();
  final defectSearchController = TextEditingController();
  final remarkController = TextEditingController();

  FinalAuditModel finalAudit = FinalAuditModel();
  GetAllGarPartDataModel partData = GetAllGarPartDataModel();
  GetAllGarOperationMasterModel operationDatas =
      GetAllGarOperationMasterModel();

  GetOperCodeByPartIdModel getOperCodeByPartIdDetail =
      GetOperCodeByPartIdModel();
  GetFavouriteModel favoriteData = GetFavouriteModel();
  GetAllDefectsModel allDefectData = GetAllDefectsModel();
  GetAllDefectsModel allDefectData2 = GetAllDefectsModel();
  LineQCSave postScoreData = LineQCSave();

  OperatorsChart optData = OperatorsChart();

  GetDsListModel getDsData = GetDsListModel();
  QCSummaryModel getQCSummary = QCSummaryModel();
  DefectPartModel defectPart = DefectPartModel();
  GetDefectCodeByTagIdModel getTagId = GetDefectCodeByTagIdModel();
  GetLineQcdefectCountModel getDefectCount = GetLineQcdefectCountModel();
  GetLineQcdefectCountEntrypartModel getDefectCountEntrysDetail =
      GetLineQcdefectCountEntrypartModel();

  GetLineQCTop3DefectModel getLineQCTop3DefectDetail =
      GetLineQCTop3DefectModel();

  SaveInlineData scoreCardData = SaveInlineData();

  UpdateIsclosedTagModel updateIsclosedTagData = UpdateIsclosedTagModel();
  GetTagInfoModel getTagInfoDetail2 = GetTagInfoModel();
  List<String> getTagInfoDetail = [];

  GetDefectTranslationMasterByLanguageCodeModel getDefectTranslation =
      GetDefectTranslationMasterByLanguageCodeModel();
  FavDefectDataWithLanguageModel favDefectDataWithLanguageDetail =
      FavDefectDataWithLanguageModel();
  GetFreqUsedDefectsByParamsModel GetFreqUsedDefectsByParamsDetail =
      GetFreqUsedDefectsByParamsModel();
  List<AllDefects> searchDefect = [];
  String? garSize;

  int totalCompleted = 0;
  int alterUp = 0;
  int alterDown = 0;
  double DHU = 0;
  int pass = 0;
  int alter = 0;
  int reAlter = 0;
  int reject = 0;

  String currentAudit = "";
  bool reAlterStatus = false;
  int? tagOID;
  String? tagOID2;

  final tagName = TextEditingController();
  String lang = "";

  bool isApprovalScreen = false;
  String currentApprovalUser = 'SUP';
  String? currentApprovalUserName;
  String? selectedSession;
  TextEditingController approvalRemark = TextEditingController(text: '');

  bool enableCamera = false;

  bool insideCamera = false;
  void isApprovalScreenFalse() {
    isApprovalScreen = false;
    getLineQCApprovalByAuditTypeApproverData =
        GetLineQCApprovalByAuditTypeApproverModel();
    notifyListeners();
    notifyListeners();
  }

  void enableCameraOnlyFunction() {
    enableCamera = !enableCamera;
    notifyListeners();
  }

  void enableCameraFunction(bool insideCam) {
    enableCamera = !enableCamera;
    insideCamera = insideCam;
    notifyListeners();
  }

  void qrFounded(String qrText) {
    // print('-------------');
    // print(qrText.split('\n'));
    // print(qrText.split('\n')[qrText.split('\n').length - 2]);
    // print(qrText.split('\n').length);
    // print('-------------');

    if (qrText.split('\n').length > 5) {
      String qrLineQC = '';
      String tagID = '';
      qrLineQC = '';
      qrLineQC = qrText.split('\n')[qrText.split('\n').length - 3].trim();
      tagID = qrText
          .split('\n')[qrText.split('\n').length - 2]
          .trim()
          .replaceAll('\r', '');

      for (String item in getTagInfoDetail) {
        if (tagID == item) {
          enableCamera = false;
          showErrorAlert('Tag ID exists');
          notifyListeners();
          return;
        }
      }
      if (qrLineQC.trim() == (styleAuditData?.auditType ?? '').trim()) {
        enableCamera = false;
        tagName.text = qrText
            .split('\n')[qrText.split('\n').length - 2]
            .trim()
            .replaceAll('\r', '');
        qrLineQC = '';
        qrLineQC = qrText.split('\n')[qrText.split('\n').length - 3].trim();
        print('----------');
        print(tagName.text);
        print('----------');
        tagOID = null;
        tagOID2 = null;
        reAlterStatus = false;
        notifyListeners();
      } else {
        enableCamera = false;
        showErrorAlert('Invalid Audit Type');
        notifyListeners();
      }
    } else {
      showErrorAlert('Invalid QR Code');
    }

    notifyListeners();
  }

  void outsidQRFounded(String qrText, BuildContext context) {
    // print('-------------');
    // print(qrText.split('\n'));
    // print(qrText.split('\n')[qrText.split('\n').length - 2]);
    // print(qrText.split('\n').length);
    // print('-------------');

    if (qrText.split('\n').length > 5) {
      String qrLineQC = '';
      String tagID = '';
      qrLineQC = '';
      qrLineQC = qrText.split('\n')[qrText.split('\n').length - 3].trim();
      tagID = qrText
          .split('\n')[qrText.split('\n').length - 2]
          .trim()
          .replaceAll('\r', '');

      int checker =
          getTagInfoDetail.indexWhere(((element) => element == tagID));
      print('--------------------------');
      print(checker);
      print('--------------------------');
      if (checker >= 0) {
        if (qrLineQC.trim() == (styleAuditData?.auditType ?? '').trim()) {
          enableCamera = false;
          tagName.text = qrText
              .split('\n')[qrText.split('\n').length - 2]
              .trim()
              .replaceAll('\r', '');
          qrLineQC = '';
          qrLineQC = qrText.split('\n')[qrText.split('\n').length - 3].trim();
          tagOID = null;
          tagOID2 = null;
          reAlterStatus = false;
          tagIdsetter3(context, tagName.text);
          notifyListeners();
        } else {
          enableCamera = false;
          showErrorAlert('Invalid Audit Type');
          notifyListeners();
        }
      } else {
        enableCamera = false;
        showErrorAlert('Tag ID does not exists');
      }
    } else {
      showErrorAlert('Invalid QR Code');
    }

    notifyListeners();
  }

  void setSelectedSession(String session) {
    selectedSession = session;
    approvalRemark = TextEditingController(text: '');
    notifyListeners();
    // getLineQCApprovalByParamsListData(context);
    GetLineQCApprovalByParamsApproverTypeUserCodeAPI(context);
  }

  void setSelectedSession7audit(String session, StyleAuditData scoreCardData) {
    selectedSession = session;
    approvalRemark = TextEditingController(text: '');
    notifyListeners();
    // getLineQCApprovalByParamsListData7audit(context, scoreCardData);
    GetLineQCApprovalByParamsApproverTypeUserCode7AuditAPI(
        context, scoreCardData);
  }

  void selectedSessionValidation() {}

  void setIsApprovalScreen(bool status) async {
    isApprovalScreen = status;
    notifyListeners();

    String userCode =
        await SharedPreferenceHelper.getString(Constants.userCode);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    if (status) {
      selectedSession = null;
      getLineQCApprovalByParamsList = GetLineQCApprovalByParamsListModel();
      approvalRemark = TextEditingController(text: '');
      notifyListeners();
      getAllSessionMasterbyunitcode(context);

      getLineQCApprovalByAuditTypeUsercodeAPI(
        context,
        unitCode,
        scoreCardData.auditType ?? '',
        scoreCardData.auditDate ?? '',
        userCode,
      );
    }
  }

  void setIsApprovalScreen7audit(
    bool status,
    StyleAuditData? styleAuditData,
  ) async {
    isApprovalScreen = status;
    notifyListeners();

    String userCode =
        await SharedPreferenceHelper.getString(Constants.userCode);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    DateTime dateToday = DateTime.now();
    String currentDate2 = dateToday.toString().substring(0, 10);
    if (status) {
      // selectedSession = null;
      getLineQCApprovalByParamsList = GetLineQCApprovalByParamsListModel();
      approvalRemark = TextEditingController(text: '');
      notifyListeners();
      GetLineQCApprovalByParamsApproverTypeUserCode7AuditAPI(
          context, styleAuditData ?? StyleAuditData());
      // setSelectedSession7audit(styleAuditData?.sessionName ?? '',
      //     styleAuditData ?? StyleAuditData());

      getLineQCApprovalByAuditTypeUsercodeAPI(
        context,
        unitCode,
        '7.0',
        currentDate2,
        userCode,
      );
    }
  }

  void setcurrentApprovalUser(String user) {
    currentApprovalUser = user;

    notifyListeners();
  }

  void setcurrentApprovalUserName(String user) {
    currentApprovalUserName = user;

    notifyListeners();
  }

  void getLang() async {
    lang = await SharedPreferenceHelper.getString(Constants.currentLang);
    notifyListeners();
  }

  File? defectImage;
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

    postImageUpload(context, name, base64string);

    notifyListeners();
    return File(imagePath).copy(image.path);
  }

  void clearDefectImage() {
    defectImage = null;
    notifyListeners();
  }

  void tagIdClear() {
    tagName.clear();
    selectFavorite = [];
    tagOID = null;
    tagOID2 = null;
    tagDisable = false;
    reAlterStatus = false;
    notifyListeners();
  }

  void tagIdsetter(context, String val, int? id) {
    tagName.text = val;
    tagOID = id;
    reAlterStatus = true;
    Navigator.pop(context);
    notifyListeners();
  }

  void tagIdsetter2(
    context,
    String val,
  ) {
    tagName.text = val;
    tagOID = 1;
    tagOID2 = val.trim();
    reAlterStatus = true;
    tagDisable = true;
    Navigator.pop(context);
    notifyListeners();
  }

  void tagIdsetter3(
    context,
    String val,
  ) {
    tagName.text = val;
    tagOID = 1;
    tagOID2 = val.trim();
    reAlterStatus = true;
    tagDisable = true;
    notifyListeners();
  }

  void tagNumberChange(val) {
    tagOID = null;
    tagOID2 = null;
    reAlterStatus = false;
    notifyListeners();
  }

  void remarksOnChange(String value) {
    notifyListeners();
  }

  void nextOperatorFunction() {}

  void passFunction(context, StyleAuditData styleAuditData) {
    garStatus = 1;

    if (reAlterStatus) {
      scoreCardData.recheckedPcs = 1;
      scoreCardData.passedPcs = 1;
      scoreCardData.inspectedPcs = 0;
      scoreCardData.rejectedPcs = 0;
      scoreCardData.defectPcs = 0;
    } else {
      scoreCardData.passedPcs = 1;
      scoreCardData.inspectedPcs = 1;
      scoreCardData.rejectedPcs = 0;
      scoreCardData.recheckedPcs = 0;
      scoreCardData.defectPcs = 0;
    }
    currentAudit = "pass";
    notifyListeners();
    postAudit(context);
  }

  void alterFunction() {
    currentAudit = "alter";
    auditStep = 3;
    auditStepUpdate(3);
    tagDisable = true;
    notifyListeners();
  }

  void rejectFunction() {
    currentAudit = "reject";
    auditStepUpdate(3);
    auditStep = 3;
    tagDisable = true;

    notifyListeners();
  }

  void currentAuditCancel() {
    currentAudit = "";
    currentoperationName = '';
    scoreCardData.operationCode = 'NA';

    selectFavorite = [];
    auditStep = 1;
    tagDisable = false;
    tagIdClear();
    notifyListeners();
  }

  void saveFunction(context) {
    if (!reAlterStatus) {
      if (currentAudit == "alter") {
        scoreCardData.defectPcs = 1;
        scoreCardData.inspectedPcs = 1;
        scoreCardData.recheckedPcs = 0;
        scoreCardData.rejectedPcs = 0;
        scoreCardData.passedPcs = 0;
      }
    }

    if (!reAlterStatus) {
      if (currentAudit == "reject") {
        scoreCardData.rejectedPcs = 1;
        scoreCardData.inspectedPcs = 1;
        scoreCardData.defectPcs = 0;
        scoreCardData.recheckedPcs = 0;
        scoreCardData.passedPcs = 0;
      }
    }

    if (reAlterStatus) {
      if (currentAudit == "reject") {
        scoreCardData.rejectedPcs = 1;
        scoreCardData.recheckedPcs = 1;
        scoreCardData.defectPcs = 0;
        scoreCardData.inspectedPcs = 0;
        scoreCardData.passedPcs = 0;
      }

      if (currentAudit == "alter") {
        scoreCardData.defectPcs = 0;
        scoreCardData.recheckedPcs = 0;
        scoreCardData.rejectedPcs = 0;
        scoreCardData.inspectedPcs = 0;
        scoreCardData.passedPcs = 0;
      }
    }

    postAudit(context);
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
      defaultCategory = null;
      List<AllDefects> search(String input) {
        return (searchDefect)
            .where((e) =>
                e.defectName!.toLowerCase().contains(input.toLowerCase()))
            .toList();
      }

      var newList = search(value);
      allDefectData.data?.allDefects = newList;
    } else {
      allDefectData2.data?.allDefects = searchDefect;
      allDefectData = allDefectData2;
    }
    notifyListeners();
  }

  void clearData() {
    isApprovalScreenFalse();
    isApprovalScreen = false;
    getTagInfoDetail = [];
    getTagInfoDetail2 = GetTagInfoModel();
    nextOperatorAction = true;
    defaultCategory = null;

    failCount = 0;
    passCount = 0;
    auditCurrentCheck = "";
    empCodeString = "";
    operatorSearch.clear();

    tagNumber = null;
    garSize = null;
    garStatus = 0;
    operatorFound = false;
    auditCount = 0;
    isPass = false;
    remarkController.clear();
    defectSearchController.text = '';
    currentoperationName = '';
    scoreCardData.operationCode = 'NA';
    selectFavorite = [];
    tagName.clear();
    auditStep = 1;
    tagDisable = false;

    isApprovalScreen = false;
    currentApprovalUser = 'SUP';
    currentApprovalUserName = null;
    selectedSession = null;
    approvalRemark = TextEditingController(text: '');
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDatasession = null;
    GetAllLineQCsDefectdetailsByRangeDaysummaryDataSession = null;
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsSession = null;
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsDate = null;
    isReportScreen = false;
    isScheduleScreen = false;
    currentReportScreen = 1;
    currentDefectScreen = 1;
    isDefectScreen = false;
    notifyListeners();
  }

  void resetAuditStep() {
    auditStep = 1;
    auditCurrentCheck = "";
    notifyListeners();
  }

  void auditStepUpdate(int step) {
    auditStep = step;
    notifyListeners();
  }

  void selectFavoriteFunction(String selectedFavorite) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    int findItem =
        selectFavorite.indexWhere((element) => element == selectedFavorite);
    if (findItem < 0) {
      selectFavorite.add(selectedFavorite);
      var newList = scoreCardData.lineQcDetlModels ?? [];
      newList.add(LineQcDetlModels(
        createdDate:
            "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
        createdBy: userN,
        modifiedDate:
            "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
        modifiedBy: userN,
        isActive: true,
        id: 0,
        lqcHeadID: 0,
        garType: currentAudit == 'reject' ? 'RJ' : 'RC',
        lineQcTagDetlEntityModels: [
          LineQcTagDetlEntityModels(
              tagId: tagName.text,
              garSize: garSize ?? "",
              createdDate:
                  "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
              createdBy: userN,
              hostName: '',
              id: 0,
              isActive: true,
              isClosed: '',
              lqcDetlID: 0,
              modifiedBy: userN,
              modifiedDate:
                  "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z")
        ],
        defectPcs: 1,
        defectCode: selectedFavorite,
        lineQcImagesEntityModels: [],
        hostName: "",
      ));

      scoreCardData.lineQcDetlModels = newList;
    } else {
      selectFavorite.removeAt(findItem);
      scoreCardData.lineQcDetlModels?.removeAt(findItem);
    }

    notifyListeners();
  }

  void sleeveValueOnchange(context, String sleeve, int? id) async {
    sleeveValue = sleeve;
    scoreCardData.partCode = sleeve.toString();
    currentoperationName = '';
    scoreCardData.operationCode = 'NA';
    getOperCodeByPartIdDetail.data = [];

    scoreCardData.passedPcs = 0;
    scoreCardData.inspectedPcs = 0;
    scoreCardData.rejectedPcs = 0;
    scoreCardData.recheckedPcs = 0;
    scoreCardData.defectPcs = 0;
    notifyListeners();

    if (id != 0) {
      // getOperCodeByPartId(context, id);
      String lan =
          await SharedPreferenceHelper.getString(Constants.currentLang);
      getSleevesAttachments(context, lan.isEmpty ? 'EN' : lan, id.toString());
    }
  }

  void sleeveAttachmentValueOnchange(
      String sleeveAttachment, String sleeveName) {
    sleeveAttachmentValue = sleeveAttachment;
    currentoperationName = sleeveName;
    scoreCardData.operationCode = sleeveAttachment.toString();

    scoreCardData.passedPcs = 0;
    scoreCardData.inspectedPcs = 0;
    scoreCardData.rejectedPcs = 0;
    scoreCardData.recheckedPcs = 0;
    scoreCardData.defectPcs = 0;
    notifyListeners();
  }

  void sizeValueOnchange(String sleeveAttachment) {
    garSize = sleeveAttachment;
    notifyListeners();
  }

  void finishValueOnchange(context, String type) {
    scoreCardData.auditType = type;

    scoreCardData.passedPcs = 0;
    scoreCardData.inspectedPcs = 0;
    scoreCardData.rejectedPcs = 0;
    scoreCardData.recheckedPcs = 0;
    scoreCardData.defectPcs = 0;
    notifyListeners();
    onGetInit(context, styleAuditData ?? StyleAuditData());
  }

  void onGetInit2(
    BuildContext context,
    StyleAuditData styleAudit,
  ) {
    scoreCardData.auditType = styleAudit.auditType;
  }

  void onGetInit(
    BuildContext context,
    StyleAuditData styleAudit,
  ) async {
    styleAuditData = styleAudit;
    notifyListeners();
    clearData();
    currentAuditCancel();
    updateScoreCard(context, styleAudit);
    getLang();
    DateTime dateToday = DateTime.now();
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String currentDate =
        "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z";
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String currentDate2 = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    showProgress(context);
    notifyListeners();
    // GetSessionCodeDataAPI(context, '${now.hour}:${now.minute}');
    // getPart(context, lan.isEmpty ? 'EN' : lan);
    getDsList(context, styleAudit.orderNo.toString());
    String lan = await SharedPreferenceHelper.getString(Constants.currentLang);
    getSleeves(context, lan.isEmpty ? 'EN' : lan, styleAudit.productType);
    getAllSessionMasterbyunitcode(context);
    getQCSummaryAssigner();
    getQcSummary(
      context,
      styleAudit.orderNo.toString(),
      unitCode,
      currentDate2,
      scoreCardData.auditType ?? "",
      userN,
      styleAudit.sewLine.toString(),
      styleAudit.auditorName4 ?? "",
      styleAudit,
    );
    getTagInfo(
        context,
        unitCode,
        currentDate,
        styleAuditData?.auditType,
        styleAuditData?.sewLine,
        styleAuditData?.orderNo,
        styleAuditData?.auditorName4,
        userN);

    dismissProgress();
  }

  void getQCSummaryAssigner() {
    List<QCSummaryData> newList = [];
    newList = [
      QCSummaryData(
        unitCode: '',
        auditDate: '',
        auditType: '',
        checkerName: '',
        color: '',
        orderNo: 0,
        sewLine: '',
        inspectedPcs: 0,
        passedPcs: 0,
        defectPcs: 0,
        rejectedPcs: 0,
        recheckedPcs: 0,
      )
    ];
    getQCSummary.data = newList;

    notifyListeners();
  }

  getFavoriteDefect(context) {
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

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  bool isFavLoading = false;

  getAllDefect(context) {
    isFavLoading = true;
    notifyListeners();
    allDefectData2 = GetAllDefectsModel();
    allDefectData = GetAllDefectsModel();
    notifyListeners();
    _useCase.getAllDefuctData((data) {
      allDefectData2 = data;
      allDefectData = data;

      List<AllDefects> listOf = [];
      var newList = allDefectData.data?.allDefects ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      allDefectData.data?.allDefects = listOf;
      allDefectData2.data?.allDefects = listOf;

      searchDefect = listOf;
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

  getPart(context, productType) {
    partData = GetAllGarPartDataModel();
    notifyListeners();
    _useCase.getPartData('', productType, (data) {
      partData = data;

      List<GarPartData> listOf = [];
      var newList = partData.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      partData.data = listOf;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
      showErrorAlert('Invalid ProductType');
    });
  }

  getOperations(context, language, partid) {
    operationDatas = GetAllGarOperationMasterModel();
    notifyListeners();
    _useCase.getOperationData(language, partid, (data) {
      operationDatas = data;
      List<OperationData> listOf = [];
      var newList = operationDatas.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      operationDatas.data = listOf;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
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

  getDefectCnt(context) {
    notifyListeners();
    _useCase.getFavoriteDefuctData((data) {
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  bool tagLoading = false;
  getTagInfo(
    context,
    unitcode,
    auditdt,
    AuditType,
    SewLine,
    OrderNo,
    color,
    CheckerName,
  ) {
    tagLoading = true;
    notifyListeners();
    getTagInfoDetail = [];
    getTagInfoDetail2 = GetTagInfoModel();
    notifyListeners();
    _useCase.getTagInfoData(
        unitcode, auditdt, AuditType, SewLine, OrderNo, color, CheckerName,
        (data) {
      getTagInfoDetail2 = data;
      getTagInfoDetail = getTagInfoDetail2.data ?? [];
      tagLoading = false;
      notifyListeners();
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      tagLoading = false;
      notifyListeners();
      dismissProgress();
    });
    tagLoading = false;
    notifyListeners();
  }

  operatorFoundChange() {
    operatorFound = true;
    notifyListeners();
  }

  getOpCnt(
    context,
    StyleAuditData styleAudit,
  ) {
    optData = OperatorsChart();
    notifyListeners();
    _useCase.getOperatorsCntData(scoreCardData, (data) {
      optData = data;
      int optCount = optData.data?.totalcount ?? 1;
      int nextoperatorCal = styleAudit.totOperators ?? 1;
      final nextoptData = optCount - nextoperatorCal;
      if (nextoptData == 0) {
        nextOperatorAction = false;
      }
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  String count = '';
  void newFunction() {
    Timer.periodic(const Duration(seconds: 0), (timer) {
      count = timer.tick.toString();
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

  void getAfterPostData(context) async {
    DateTime dateToday = DateTime.now();

    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    String userCode =
        await SharedPreferenceHelper.getString(Constants.userCode);

    if (currentAudit == 'pass') {
      totalCompleted = totalCompleted + 1;
      pass = pass + 1;
      getQCSummary.data?[0].inspectedPcs = totalCompleted;
      getQCSummary.data?[0].passedPcs = pass;
    } else if (currentAudit == 'alter') {
      totalCompleted = totalCompleted + 1;
      alter = alter + 1;
      getQCSummary.data?[0].inspectedPcs = totalCompleted;
      getQCSummary.data?[0].defectPcs = alter;
    } else if (currentAudit == 'reject') {
      totalCompleted = totalCompleted + 1;
      reject = reject + 1;
      getQCSummary.data?[0].inspectedPcs = totalCompleted;
      getQCSummary.data?[0].rejectedPcs = reject;
    } else if (currentAudit == 'reAlter') {
      getQCSummary.data?[0].recheckedPcs = reAlter;
      reAlter = reAlter + 1;
    }
    if (reAlterStatus) {
      if (currentAudit == "pass" || currentAudit == "reject") {
        getQCSummary.data?[0].recheckedPcs = reAlter;
        reAlter = reAlter + 1;
        String userCode =
            await SharedPreferenceHelper.getString(Constants.userCode);
        updateIsclosedTag(context, tagOID2.toString().trim(), userCode);
      }
    }

    if (currentAudit == "pass" || currentAudit == "reject") {
      if (reAlterStatus) {}
    }

    scoreCardData.sessionCode = postScoreData.data?.sessionCode;

    scoreCardData.lineQcDetlModels = [];

    reAlterStatus = false;
    tagDisable = false;
    tagOID = null;
    tagDisable = false;
    defectImage = null;
    currentAudit = "";

    //

    getTagInfo(
        context,
        unitCode,
        currentDate,
        styleAuditData?.auditType,
        styleAuditData?.sewLine,
        styleAuditData?.orderNo,
        styleAuditData?.auditorName4,
        userN);

    currentAuditCancel();
    notifyListeners();
    currentAudit = "";
    notifyListeners();

    dismissProgress();
  }

  void fallBackFuntion() {
    if (currentAudit == "pass") {
      int passedPcs = scoreCardData.passedPcs ?? 0;
      int inspectedPcs = scoreCardData.inspectedPcs ?? 0;
      scoreCardData.passedPcs = passedPcs - 1;
      scoreCardData.inspectedPcs = inspectedPcs - 1;
    }
    if (currentAudit == "alter") {
      int defectPcs = scoreCardData.defectPcs ?? 0;
      int inspectedPcs = scoreCardData.inspectedPcs ?? 0;
      scoreCardData.defectPcs = defectPcs - 1;
      scoreCardData.inspectedPcs = inspectedPcs - 1;
    }
    if (currentAudit == "reAlter") {
      int recheckedPcs = scoreCardData.recheckedPcs ?? 0;
      scoreCardData.recheckedPcs = recheckedPcs - 1;
    }
    if (currentAudit == "reject") {
      int rejectedPcs = scoreCardData.rejectedPcs ?? 0;
      int inspectedPcs = scoreCardData.inspectedPcs ?? 0;

      scoreCardData.rejectedPcs = rejectedPcs - 1;
      scoreCardData.inspectedPcs = inspectedPcs - 1;
    }
    currentAudit = "";
    notifyListeners();
  }

  postAudit(
    context,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showProgress(context);
    String loc =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);
    DateTime dateToday = DateTime.now().toUtc();
    DateTime dateToday2 = DateTime.now();
    if (loc == "IND") {
      String times =
          "${dateToday.add(const Duration(minutes: 330)).hour}:${dateToday.add(const Duration(minutes: 330)).minute}:00";

      scoreCardData.currentTime = times;
      notifyListeners();
    } else if (loc == "JOR") {
      String times =
          "${dateToday.add(const Duration(minutes: 180)).hour}:${dateToday.add(const Duration(minutes: 180)).minute}:00";
      scoreCardData.currentTime = times;
      notifyListeners();
    } else {
      String times = "${dateToday.hour}:${dateToday.minute}:00";
      scoreCardData.currentTime = times;
      notifyListeners();
    }
    notifyListeners();

    postScoreData = LineQCSave();
    notifyListeners();
    _useCase.postAuditData(scoreCardData, (data) {
      dismissProgress();
      postScoreData = data;
      if (postScoreData.isSuccess ?? false) {
        clearData();
        showProgress(context);
        getAfterPostData(context);
        dismissProgress();
        notifyListeners();
      } else {
        showErrorAlert(postScoreData.message ?? "");
      }
    }, (errorMessage) {
      showErrorAlert(errorMessage);

      fallBackFuntion();
      dismissProgress();
    });
  }

  updateScoreCard(context, StyleAuditData styleAudit) async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    scoreCardData.inspectedPcs = 0;
    scoreCardData.passedPcs = 0;
    scoreCardData.defectPcs = 0;
    scoreCardData.recheckedPcs = 0;
    scoreCardData.rejectedPcs = 0;
    currentAudit = "";
    pass = 0;
    alter = 0;
    reAlter = 0;
    totalCompleted = 0;
    reject = 0;
    tagDisable = false;
    tagOID = null;
    scoreCardData.createdDate = currentDate;
    scoreCardData.createdBy = userN;
    scoreCardData.modifiedBy = userN;
    scoreCardData.isActive = true;
    scoreCardData.id = 0;
    scoreCardData.entityID = styleAudit.entityID;

    scoreCardData.auditDate = currentDate;
    scoreCardData.color = styleAudit.auditorName4;
    scoreCardData.unitCode = styleAudit.unitCode;
    scoreCardData.sewLine = styleAudit.sewLine;
    scoreCardData.floorName = 'NA';

    scoreCardData.sessionCode = '';
    scoreCardData.checkerName = userN;
    scoreCardData.buyerCode = styleAudit.buyerCode;
    scoreCardData.styleNo = styleAudit.styleNo;
    scoreCardData.orderNo = styleAudit.orderNo;

    scoreCardData.partCode = "";
    scoreCardData.operationCode = "NA";

    scoreCardData.inspectedPcs = 0;
    scoreCardData.passedPcs = 0;
    scoreCardData.rejectedPcs = 0;
    scoreCardData.defectPcs = 0;

    scoreCardData.recheckedPcs = 0;

    scoreCardData.hostName = "";
    scoreCardData.lineQcDetlModels = [];

    favoriteData = GetFavouriteModel();
    allDefectData = GetAllDefectsModel();
    allDefectData2 = GetAllDefectsModel();
    partData = GetAllGarPartDataModel();
    operationDatas = GetAllGarOperationMasterModel();
    getOperCodeByPartIdDetail = GetOperCodeByPartIdModel();
    getDsData = GetDsListModel();
    getQCSummary = QCSummaryModel();
    getDefectCount = GetLineQcdefectCountModel();

    enableCamera = false;
    notifyListeners();
  }

  getDsList(context, String orderNo) {
    getDsData = GetDsListModel();
    notifyListeners();
    _useCase.getDsLists(orderNo, (data) {
      getDsData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getQcSummary(
    context,
    String orderNo,
    String unitCode,
    String currentDate,
    String auditType,
    String userN,
    String sawLine,
    String colorCode,
    StyleAuditData styleInfo,
  ) {
    getQCSummary = QCSummaryModel();
    notifyListeners();
    _useCase.getQcSummarys(
        orderNo, unitCode, currentDate, auditType, userN, sawLine, colorCode,
        (data) {
      getQCSummary = data;
      if (getQCSummary.isSuccess ?? false) {
        var data = getQCSummary.data ?? [];
        if (data.isNotEmpty) {
          totalCompleted = data[0].inspectedPcs ?? 0;
          pass = data[0].passedPcs ?? 0;
          alter = data[0].defectPcs ?? 0;
          reject = data[0].rejectedPcs ?? 0;
          reAlter = data[0].recheckedPcs ?? 0;
          notifyListeners();
        }
      }
      if (getQCSummary.data?.isEmpty ?? false) {
        getQCSummaryAssigner();
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getDefectCodeByTagId(
    String tagId,
    StyleAuditData? styleAudit,
  ) {
    tagNumber = tagId;
    int orderno = styleAudit?.orderNo ?? 0;
    String color = styleAudit?.auditorName4 ?? "";
    String audittype = styleAudit?.auditType ?? "";
    getTagId = GetDefectCodeByTagIdModel();
    notifyListeners();
    _useCase.getDefectCodeByTagIds(tagId, orderno, color, audittype, (data) {
      getTagId = data;
      if (getTagId.data?.isNotEmpty ?? false) {
        reAlterStatus = true;
      } else {
        reAlterStatus = false;
        tagName.clear();
        showErrorAlert("no data found");
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
      dismissProgress();
    });
  }

  getLineQcdefectCountEntry(context, String unitCode, String currentDate,
      String auditType, String sewLine, String auditorname, int orderno) {
    getDefectCountEntrysDetail = GetLineQcdefectCountEntrypartModel();
    notifyListeners();
    _useCase.getLineQcdefectCountEntryData(
        unitCode, currentDate, auditType, sewLine, auditorname, orderno,
        (data) {
      getDefectCountEntrysDetail = data;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getLineQCTop3Defect(context, String unitCode, String currentDate,
      String auditType, String sewLine, String auditorname, int orderno) {
    getLineQCTop3DefectDetail = GetLineQCTop3DefectModel();

    notifyListeners();
    _useCase.getLineQCTop3DefectData(
        unitCode, currentDate, auditType, sewLine, auditorname, orderno,
        (data) {
      getLineQCTop3DefectDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  updateIsclosedTag(context, id, user) {
    updateIsclosedTagData = UpdateIsclosedTagModel();
    notifyListeners();
    _useCase.updateIsclosedTagData(id, user, (data) {
      updateIsclosedTagData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void showErrorAlert(String message) {
    CodeSnippet.instance.showAlertMsg(message);
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

  getFreqUsedDefectsByParams(
    context,
    String unitcode,
    String audittype,
    String username,
  ) async {
    String languagecode =
        await SharedPreferenceHelper.getString(Constants.currentLang);
    isFavLoading = true;
    GetFreqUsedDefectsByParamsDetail = GetFreqUsedDefectsByParamsModel();
    notifyListeners();

    GetFreqUsedDefectsByParamsDetail = GetFreqUsedDefectsByParamsModel();
    GetFreqUsedDefectsByParamsDetailFiltered = [];
    notifyListeners();
    _useCase.getFreqUsedDefectsByParamsData(
        unitcode, audittype, username, languagecode == "" ? "EN" : languagecode,
        (data) {
      GetFreqUsedDefectsByParamsDetail = data;
      GetFreqUsedDefectsByParamsDetailFiltered =
          GetFreqUsedDefectsByParamsDetail.data ?? [];
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

  List<GetFreqUsedDefectsByParamsData>
      GetFreqUsedDefectsByParamsDetailFiltered = [];
  void GetFreqUsedDefectsByParamsDetailSearxh(String search) {
    GetFreqUsedDefectsByParamsDetailFiltered = search.isEmpty
        ? (GetFreqUsedDefectsByParamsDetail.data ?? [])
        : (GetFreqUsedDefectsByParamsDetail.data ?? [])
            .where((item) => (item.defectName ?? '')
                .toLowerCase()
                .contains(search.toLowerCase()))
            // ||
            // (item.operationName ?? '')
            //     .toLowerCase()
            //     .contains(search.toLowerCase()) ||

            .toList();
    notifyListeners();
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
    getAllDefectswithFreqUsedDefectsByParamsDetailFiltered = [];
    notifyListeners();
    _useCase.getAllDefectswithFreqUsedDefectsByParamsData(
        unitcode, audittype, username, languagecode == "" ? "EN" : languagecode,
        (data) {
      getAllDefectswithFreqUsedDefectsByParamsDetail = data;
      getAllDefectswithFreqUsedDefectsByParamsDetailFiltered =
          getAllDefectswithFreqUsedDefectsByParamsDetail.data ?? [];
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

  TextEditingController defectsSearchController = TextEditingController();

  List<GetAllDefectswithLang>
      getAllDefectswithFreqUsedDefectsByParamsDetailFiltered = [];
  void getAllDefectswithFreqUsedDefectsByParamsSearch(String search) {
    getAllDefectswithFreqUsedDefectsByParamsDetailFiltered = search.isEmpty
        ? (getAllDefectswithFreqUsedDefectsByParamsDetail.data ?? [])
        : (getAllDefectswithFreqUsedDefectsByParamsDetail.data ?? [])
            .where((item) => (item.defectName ?? '')
                .toLowerCase()
                .contains(search.toLowerCase()))
            // ||
            // (item.operationName ?? '')
            //     .toLowerCase()
            //     .contains(search.toLowerCase()) ||

            .toList();
    notifyListeners();
  }

  UpdateIsFavModel updateIsFavModelResponse = UpdateIsFavModel();
  void addToFavorite(context, defectcode, status) {
    isFavLoading = true;
    notifyListeners();
    updateIsFavModelResponse = UpdateIsFavModel();
    notifyListeners();
    _useCase.postIsFav(defectcode, status, (data) async {
      updateIsFavModelResponse = data;
      notifyListeners();
      if (updateIsFavModelResponse.isSuccess ?? false) {
        Navigator.pop(context);
        getAllDefect(context);
        getDefectTranslationMasterByLanguageCode(context);
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
    saveFreqUsedDefectsDetail.auditType = scoreCardData.auditType ?? '';
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
      String auditType = scoreCardData.auditType ?? '';

      notifyListeners();
      if (SaveFreqUsedDefectsResponseDetail.isSuccess ?? false) {
        Navigator.pop(context);
        String unitCode = await SharedPreferenceHelper.getString('unitCode');
        getAllDefectswithFreqUsedDefectsByParams(
            context, unitCode, auditType, styleAuditData?.auditorName ?? '');
        getFreqUsedDefectsByParams(
            context, unitCode, auditType, styleAuditData?.auditorName ?? '');
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
        getAllDefectswithFreqUsedDefectsByParams(
            context, unitCode, auditType, styleAuditData?.auditorName ?? '');
        getFreqUsedDefectsByParams(
            context, unitCode, auditType, styleAuditData?.auditorName ?? '');
      }
      dismissProgress();
      isFavLoading = false;
      notifyListeners();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
      saveFreqUsedDefects(context, defectCode, active);
      isFavLoading = false;
      notifyListeners();
    });
  }

  void setisReportScreenFalse() {
    isReportScreen = false;
    // notifyListeners();
  }

  void setIsReportScreen() async {
    isReportScreen = !isReportScreen;
    isScheduleScreen = false;
    isDefectScreen = false;

    currentReportScreen = 1;

    GetAllLineQCsDefectdetailsByRangeHourlyDefectsController.text = '';
    GetAllLineQCsDefectdetailsByRangeDaysummaryDataController.text = '';
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsListController.text = '';
    notifyListeners();
    DateTime dateToday = DateTime.now();

    GetAllLineQCsDefectdetailsByRangeDaysummaryDate =
        dateToday.toString().substring(0, 10);
    // GetAllLineQCsDefectdetailsByRangeHourlyDefectsSession =
    //     (getAllSessionMasterbyunitcodeData.data ?? [])[0].sessionCode ?? '';
    // GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDatasession =
    //     (getAllSessionMasterbyunitcodeData.data ?? [])[0].sessionCode ?? '';
    notifyListeners();
  }

  void setIsScheduleScreen() {
    isScheduleScreen = !isScheduleScreen;
    isDefectScreen = false;
    isReportScreen = false;
    notifyListeners();
  }

  void setisDefectScreen() {
    isDefectScreen = !isDefectScreen;
    isScheduleScreen = false;
    isReportScreen = false;
    currentDefectScreen = 1;
    defectsSearchController.text = '';
    notifyListeners();
    if (isDefectScreen) {
      getFreqUsedDefectsByParams(
          context,
          scoreCardData.unitCode.toString(),
          scoreCardData.auditType.toString(),
          scoreCardData.checkerName.toString());
      getAllDefectswithFreqUsedDefectsByParams(
          context,
          scoreCardData.unitCode.toString(),
          scoreCardData.auditType.toString(),
          scoreCardData.checkerName.toString());
    }
    notifyListeners();
  }

  cancelDefectScreenAndClearDefects() {
    isDefectScreen = false;
    isScheduleScreen = false;
    isReportScreen = false;
    currentDefectScreen = 1;
    selectFavorite = [];

    notifyListeners();
  }

  void setCurrentDefectScreen(int screen) {
    currentDefectScreen = screen;
    defectsSearchController.text = '';
    GetFreqUsedDefectsByParamsDetailFiltered =
        GetFreqUsedDefectsByParamsDetail.data ?? [];
    getAllDefectswithFreqUsedDefectsByParamsDetailFiltered =
        getAllDefectswithFreqUsedDefectsByParamsDetail.data ?? [];
    notifyListeners();
  }

  void setCurrentReportScreen(int screen) {
    currentReportScreen = screen;
    notifyListeners();
  }

  GetLineQCDefectsCountandoverallReportModel
      lineQCDefectsCountandoverallReportModel =
      GetLineQCDefectsCountandoverallReportModel();

  getGetLineQCDefectsCountandoverallReport(context, unitcode, createdDate,
      auditType, checkerName, orderno, sewLine) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    lineQCDefectsCountandoverallReportModel =
        GetLineQCDefectsCountandoverallReportModel();
    notifyListeners();
    _useCase.getLineQCDefectsCountandoverallReportData(
        unitcode, createdDate, auditType, userN, orderno.toString(), sewLine,
        (data) {
      lineQCDefectsCountandoverallReportModel = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetAllLineQCsDefectdetailsByRangeHourlysummaryModel
      getAllLineQCsDefectdetailsByRangeHourlysummaryData =
      GetAllLineQCsDefectdetailsByRangeHourlysummaryModel();

  int getAllLineQCsDefectdetailsByRangeHourlysummaryDataInspectedPcs = 0;
  int getAllLineQCsDefectdetailsByRangeHourlysummaryDataReInspectedPcs = 0;
  getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
      context,
      unitcode,
      createdDate,
      auditType,
      checkerName,
      orderno,
      sewLine,
      sessioncode) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    getAllLineQCsDefectdetailsByRangeHourlysummaryData =
        GetAllLineQCsDefectdetailsByRangeHourlysummaryModel();
    notifyListeners();
    _useCase.getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
        unitcode,
        createdDate,
        auditType,
        userN,
        orderno.toString(),
        sewLine,
        sessioncode, (data) {
      getAllLineQCsDefectdetailsByRangeHourlysummaryData = data;
      getAllLineQCsDefectdetailsByRangeHourlysummaryDataInspectedPcs = 0;
      getAllLineQCsDefectdetailsByRangeHourlysummaryDataReInspectedPcs = 0;
      for (int i = 0;
          i <
              (getAllLineQCsDefectdetailsByRangeHourlysummaryData.data ?? [])
                  .length;
          i++) {
        // print(i);
        getAllLineQCsDefectdetailsByRangeHourlysummaryDataInspectedPcs =
            getAllLineQCsDefectdetailsByRangeHourlysummaryDataInspectedPcs +
                ((getAllLineQCsDefectdetailsByRangeHourlysummaryData.data ??
                            [])[i]
                        .inspectedPcs ??
                    0);
        getAllLineQCsDefectdetailsByRangeHourlysummaryDataReInspectedPcs =
            getAllLineQCsDefectdetailsByRangeHourlysummaryDataReInspectedPcs +
                ((getAllLineQCsDefectdetailsByRangeHourlysummaryData.data ??
                            [])[i]
                        .recheckedPcs ??
                    0);
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetAllLineQCsDefectdetailsByRangeDaysummaryModel
      GetAllLineQCsDefectdetailsByRangeDaysummaryData =
      GetAllLineQCsDefectdetailsByRangeDaysummaryModel();

  GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(context, unitcode, createdDate,
      auditType, checkerName, orderno, sewLine, sessioncode) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    GetAllLineQCsDefectdetailsByRangeDaysummaryData =
        GetAllLineQCsDefectdetailsByRangeDaysummaryModel();
    GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData = [];
    notifyListeners();
    _useCase.GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
        unitcode,
        createdDate,
        auditType,
        userN,
        orderno.toString(),
        sewLine,
        sessioncode, (data) {
      GetAllLineQCsDefectdetailsByRangeDaysummaryData = data;
      GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData =
          GetAllLineQCsDefectdetailsByRangeDaysummaryData.data ?? [];
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsData =
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel();

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
      context,
      unitcode,
      createdDate,
      auditType,
      checkerName,
      orderno,
      sewLine,
      sessioncode) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsData =
        GetAllLineQCsDefectdetailsByRangeHourlyDefectsModel();
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData = [];
    notifyListeners();
    _useCase.GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
        unitcode,
        createdDate,
        auditType,
        userN,
        orderno.toString(),
        sewLine,
        sessioncode, (data) {
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsData = data;
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData =
          GetAllLineQCsDefectdetailsByRangeHourlyDefectsData.data ?? [];
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListData =
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel();

  GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
      context,
      unitcode,
      createdDate,
      auditType,
      checkerName,
      orderno,
      sewLine,
      sessioncode) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsListData =
        GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModel();
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData = [];
    notifyListeners();
    _useCase.GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
        unitcode,
        createdDate,
        auditType,
        userN,
        orderno.toString(),
        sewLine,
        sessioncode, (data) {
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListData = data;
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData =
          GetAllLineQCsDefectdetailsByRangeHourlyDefectsListData.data ?? [];
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetSessionCodeModel GetSessionCodeData = GetSessionCodeModel();

  GetSessionCodeDataAPI(
    context,
    currenttime,
  ) async {
    GetSessionCodeData = GetSessionCodeModel();
    notifyListeners();
    _useCase.GetSessionCodeDataAPI(currenttime, (data) {
      GetSessionCodeData = data;
      scoreCardData.sessionCode = GetSessionCodeData.data?.sessionCode ?? '';
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  String currentSort = '';

  void changeInlineSortOP() {
    currentSort = currentSort == ''
        ? 'opASC'
        : currentSort == 'opASC'
            ? 'opDSC'
            : 'opASC';
    notifyListeners();

    checkerSorterOP();
  }

  void changeInlineSortDEF() {
    currentSort = currentSort == ''
        ? 'defASC'
        : currentSort == 'defASC'
            ? 'defDSC'
            : 'defASC';
    notifyListeners();

    checkerSorterDEF();
  }

  void checkerSorterOP() {
    List<LineQCreport> data =
        lineQCDefectsCountandoverallReportModel.data ?? [];
    if (currentSort == 'opASC') {
      data.sort((a, b) =>
          a.operationName.toString().compareTo(b.operationName.toString()));
    }
    if (currentSort == 'opDSC') {
      data.sort((a, b) =>
          b.operationName.toString().compareTo(a.operationName.toString()));
    }

    lineQCDefectsCountandoverallReportModel.data = data;
    notifyListeners();
  }

  void checkerSorterDEF() {
    List<LineQCreport> data =
        lineQCDefectsCountandoverallReportModel.data ?? [];
    if (currentSort == 'defASC') {
      data.sort(
          (a, b) => a.defectName.toString().compareTo(b.defectName.toString()));
    }

    if (currentSort == 'defDSC') {
      data.sort(
          (a, b) => b.defectName.toString().compareTo(a.defectName.toString()));
    }

    lineQCDefectsCountandoverallReportModel.data = data;
    notifyListeners();
  }

  GetLineQCFrequentUsedOperationsandPartsModel
      getLineQCFrequentUsedOperationsandPartsModel =
      GetLineQCFrequentUsedOperationsandPartsModel();
  String currentoperationName = '';

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
      dismissProgress();
    });
  }

  GetAppDetlListModel getAppDetlListData = GetAppDetlListModel();
  void cleargetAppDetlListData() {
    getAppDetlListData = GetAppDetlListModel();
    notifyListeners();
  }

  void setcurrentApprovalUserDefault() {
    currentApprovalUser = 'SUP';
    notifyListeners();
  }

  getAppDetlList(context) async {
    getAppDetlListData = GetAppDetlListModel();
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    notifyListeners();
    _useCase.getAppDetlListData(
        unitCode, styleAuditData?.auditType ?? '', currentApprovalUser, (data) {
      getAppDetlListData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getAppDetlList7audit(
    context,
  ) async {
    getAppDetlListData = GetAppDetlListModel();
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    notifyListeners();
    _useCase.getAppDetlListData(unitCode, '7.0', currentApprovalUser, (data) {
      getAppDetlListData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetAllSessionMasterbyunitcode getAllSessionMasterbyunitcodeData =
      GetAllSessionMasterbyunitcode();
  getAllSessionMasterbyunitcode(context) async {
    getAllSessionMasterbyunitcodeData = GetAllSessionMasterbyunitcode();
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    notifyListeners();
    _useCase.getAllSessionMasterbyunitcode(unitCode, (data) {
      getAllSessionMasterbyunitcodeData = data;
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsSession =
          (getAllSessionMasterbyunitcodeData.data ?? [])[0].sessionCode ?? '';
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDatasession =
          (getAllSessionMasterbyunitcodeData.data ?? [])[0].sessionCode ?? '';

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  RemoveDefectsByIDModel RemoveDefectsByIDData = RemoveDefectsByIDModel();
  RemoveDefectsByIDAPI(
      context,
      id,
      bool isremoveinspectedPcscount,
      bool isremoveAlteredPcscount,
      bool isremoveDefectedPcscount,
      bool isremoveRejectedPcscount) async {
    RemoveDefectsByIDData = RemoveDefectsByIDModel();
    notifyListeners();
    _useCase.RemoveDefectsByIDAPI(
        id,
        isremoveinspectedPcscount,
        isremoveAlteredPcscount,
        isremoveDefectedPcscount,
        isremoveRejectedPcscount, (data) {
      RemoveDefectsByIDData = data;

      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
          context,
          styleAuditData?.unitCode,
          styleAuditData?.schDate,
          styleAuditData?.auditType,
          styleAuditData?.createdBy,
          styleAuditData?.orderNo,
          styleAuditData?.sewLine,
          scoreCardData.sessionCode);

      getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
          context,
          styleAuditData?.unitCode,
          styleAuditData?.schDate,
          styleAuditData?.auditType,
          styleAuditData?.createdBy,
          styleAuditData?.orderNo,
          styleAuditData?.sewLine,
          scoreCardData.sessionCode);
      GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
          context,
          styleAuditData?.unitCode,
          styleAuditData?.schDate,
          styleAuditData?.auditType,
          styleAuditData?.createdBy,
          styleAuditData?.orderNo,
          styleAuditData?.sewLine,
          scoreCardData.sessionCode);
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
          context,
          styleAuditData?.unitCode,
          styleAuditData?.schDate,
          styleAuditData?.auditType,
          styleAuditData?.createdBy,
          styleAuditData?.orderNo,
          styleAuditData?.sewLine,
          scoreCardData.sessionCode);

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetLineQCApprovalByParamsListModel getLineQCApprovalByParamsList =
      GetLineQCApprovalByParamsListModel();
  getLineQCApprovalByParamsListData7audit(
      context, StyleAuditData scoreCardData) async {
    getLineQCApprovalByParamsList = GetLineQCApprovalByParamsListModel();
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    notifyListeners();
    _useCase.getLineQCApprovalByParamsListData(
        scoreCardData.unitCode,
        scoreCardData.auditType,
        currentDate,
        scoreCardData.sewLine,
        selectedSession,
        scoreCardData.orderNo,
        currentApprovalUserName ?? '', (data) {
      getLineQCApprovalByParamsList = data;

      if (getLineQCApprovalByParamsList.isSuccess ?? false) {
        approvalRemark.text =
            (getLineQCApprovalByParamsList.data ?? [])[0].remarks ?? '';
      }
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getLineQCApprovalByParamsListData(
    context,
  ) async {
    getLineQCApprovalByParamsList = GetLineQCApprovalByParamsListModel();

    notifyListeners();
    _useCase.getLineQCApprovalByParamsListData(
        styleAuditData?.unitCode,
        styleAuditData?.auditType,
        styleAuditData?.schDate,
        styleAuditData?.sewLine,
        selectedSession,
        styleAuditData?.orderNo,
        currentApprovalUserName ?? '', (data) {
      getLineQCApprovalByParamsList = data;

      if (getLineQCApprovalByParamsList.isSuccess ?? false) {
        approvalRemark.text =
            (getLineQCApprovalByParamsList.data ?? [])[0].remarks ?? '';
      }
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetLineQCApprovalByParamsApproverTypeUserCodeModel
      GetLineQCApprovalByParamsApproverTypeUserCodeData =
      GetLineQCApprovalByParamsApproverTypeUserCodeModel();
  GetLineQCApprovalByParamsApproverTypeUserCodeAPI(
    context,
  ) async {
    GetLineQCApprovalByParamsApproverTypeUserCodeData =
        GetLineQCApprovalByParamsApproverTypeUserCodeModel();
    String usercode =
        await SharedPreferenceHelper.getString(Constants.userCode);

    notifyListeners();
    _useCase.GetLineQCApprovalByParamsApproverTypeUserCodeAPI(
        styleAuditData?.unitCode,
        styleAuditData?.auditType,
        styleAuditData?.schDate,
        styleAuditData?.sewLine,
        selectedSession,
        styleAuditData?.styleNo,
        styleAuditData?.orderNo,
        currentApprovalUser,
        usercode, (data) {
      GetLineQCApprovalByParamsApproverTypeUserCodeData = data;

      if (GetLineQCApprovalByParamsApproverTypeUserCodeData.isSuccess ??
          false) {
        approvalRemark.text =
            GetLineQCApprovalByParamsApproverTypeUserCodeData.data?.remarks ??
                '';
      }
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetLineQCApprovalByParamsApproverTypeUserCodeModel
      GetLineQCApprovalByParamsApproverTypeUserCodeData7Audit =
      GetLineQCApprovalByParamsApproverTypeUserCodeModel();
  GetLineQCApprovalByParamsApproverTypeUserCode7AuditAPI(
    context,
    StyleAuditData scorecard,
  ) async {
    GetLineQCApprovalByParamsApproverTypeUserCodeData7Audit =
        GetLineQCApprovalByParamsApproverTypeUserCodeModel();
    String usercode =
        await SharedPreferenceHelper.getString(Constants.userCode);

    notifyListeners();
    _useCase.GetLineQCApprovalByParamsApproverTypeUserCodeAPI(
        styleAuditDataUnitCode,
        styleAuditDataAuditType,
        styleAuditDataSchDate,
        styleAuditDataSewLine,
        selectedSession,
        styleAuditDataStyleNo,
        styleAuditDataOrderNo,
        currentApprovalUser,
        usercode, (data) {
      GetLineQCApprovalByParamsApproverTypeUserCodeData7Audit = data;

      print('------------------------');
      print(GetLineQCApprovalByParamsApproverTypeUserCodeData7Audit.isSuccess);
      print('------------------------');

      if (GetLineQCApprovalByParamsApproverTypeUserCodeData7Audit.isSuccess ??
          false) {
        approvalRemark.text =
            GetLineQCApprovalByParamsApproverTypeUserCodeData7Audit
                    .data?.remarks ??
                '';
      }
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  SaveLineQCApprovalResponseModel saveLineQCApprovalResponse =
      SaveLineQCApprovalResponseModel();
  postSaveLineQCApproval(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    saveLineQCApprovalResponse = SaveLineQCApprovalResponseModel();
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String usercode =
        await SharedPreferenceHelper.getString(Constants.userCode);
    notifyListeners();
    _useCase.postSaveLineQCApproval(
        SaveLineQCApprovalModel(
          active: 'Y',
          approveDateTime: currentDate,
          approver: currentApprovalUserName,
          userCode: usercode,
          approverType: currentApprovalUser,
          auditDate: styleAuditData?.schDate,
          auditType: styleAuditData?.auditType,
          createdBy: usercode,
          createdDate: currentDate,
          hostName: '',
          id: 0,
          isActive: true,
          modifiedBy: '',
          modifiedDate: currentDate,
          orderNo: styleAuditData?.orderNo,
          remarks: approvalRemark.text,
          sessionCode: selectedSession,
          sewLine: styleAuditData?.sewLine,
          styleNo: styleAuditData?.styleNo,
          unitCode: styleAuditData?.unitCode,
        ), (data) async {
      saveLineQCApprovalResponse = data;
      if (saveLineQCApprovalResponse.isSuccess ?? false) {
        approvalRemark = TextEditingController(text: '');
        getLineQCApprovalByParamsListData(context);
        GetLineQCApprovalByParamsApproverTypeUserCodeAPI(context);

        String userCode =
            await SharedPreferenceHelper.getString(Constants.userCode);
        String unitCode = await SharedPreferenceHelper.getString('unitCode');

        getLineQCApprovalByAuditTypeUsercodeAPI(
          context,
          unitCode,
          scoreCardData.auditType ?? '',
          scoreCardData.auditDate ?? '',
          usercode,
        );
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
      dismissProgress();
    });
  }

  postSaveLineQCApproval7audit(context, StyleAuditData scoreCardData) async {
    FocusScope.of(context).requestFocus(FocusNode());
    saveLineQCApprovalResponse = SaveLineQCApprovalResponseModel();
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String usercode =
        await SharedPreferenceHelper.getString(Constants.userCode);
    notifyListeners();
    _useCase.postSaveLineQCApproval(
        SaveLineQCApprovalModel(
          active: 'Y',
          approveDateTime: currentDate,
          approver: currentApprovalUserName,
          approverType: currentApprovalUser,
          auditDate: currentDate,
          auditType: '7.0',
          createdBy: usercode,
          createdDate: currentDate,
          hostName: '',
          id: 0,
          isActive: true,
          userCode: usercode,
          modifiedBy: '',
          modifiedDate: currentDate,
          orderNo: scoreCardData.orderNo,
          remarks: approvalRemark.text,
          sessionCode: selectedSession,
          sewLine: scoreCardData.sewLine,
          styleNo: scoreCardData.styleNo,
          unitCode: scoreCardData.unitCode,
        ), (data) async {
      saveLineQCApprovalResponse = data;
      if (saveLineQCApprovalResponse.isSuccess ?? false) {
        approvalRemark = TextEditingController(text: '');
        // getLineQCApprovalByParamsListData7audit(context, scoreCardData);
        String userCode =
            await SharedPreferenceHelper.getString(Constants.userCode);
        String unitCode = await SharedPreferenceHelper.getString('unitCode');
        DateTime dateToday = DateTime.now();
        String currentDate = dateToday.toString().substring(0, 10);
        // getLineQCApprovalByAuditTypeApproverAPI(
        //   context,
        //   unitCode,
        //   scoreCardData.auditType ?? '',
        //   currentDate,
        //   currentApprovalUserName ?? '',
        // );
        GetLineQCApprovalByParamsApproverTypeUserCode7AuditAPI(
            context, scoreCardData);

        getLineQCApprovalByAuditTypeUsercodeAPI(
          context,
          unitCode,
          scoreCardData.auditType ?? '',
          currentDate,
          usercode,
        );
        GetLineQCApprovalByParamsApproverTypeUserCode7AuditAPI(
            context, styleAuditData ?? StyleAuditData());
        // setSelectedSession7audit(
        //     scoreCardData.sessionName ?? '', scoreCardData);
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
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
              auditType: styleAuditData?.auditType ?? '',
              insType: styleAuditData?.insType ?? '',
              factoryCode: styleAuditData?.unitCode ?? '',
              defectName: selectFavorite[0])
        ]), (data) {
      uploadImageResponse = data;

      List<LineQcImagesEntityModels> lineQcImagesEntityModels = [];
      lineQcImagesEntityModels.add(LineQcImagesEntityModels(
          createdDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          createdBy: userN,
          modifiedDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          modifiedBy: userN,
          isActive: true,
          id: 0,
          lqcDetlID: 0,
          fName: uploadImageResponse.data?[0].filename ?? '',
          filePath: uploadImageResponse.data?[0].filepath ?? '',
          hostName: "",
          packAttach: ''));

      scoreCardData
          .lineQcDetlModels?[(scoreCardData.lineQcDetlModels ?? []).length - 1]
          .lineQcImagesEntityModels = lineQcImagesEntityModels;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetUserDepartmentListModel getUserDepartmentListData =
      GetUserDepartmentListModel();
  getUserDepartmentListAPI(context) async {
    getUserDepartmentListData = GetUserDepartmentListModel();

    notifyListeners();
    _useCase.getUserDepartmentListAPI((data) {
      getUserDepartmentListData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetActiveAuditTypeByRptGroupModel getActiveAuditTypeByRptGroupData =
      GetActiveAuditTypeByRptGroupModel();
  getActiveAuditTypeByRptGroupAPI(context, String rptgroup) async {
    getActiveAuditTypeByRptGroupData = GetActiveAuditTypeByRptGroupModel();
    notifyListeners();
    _useCase.getActiveAuditTypeByRptGroupAPI(rptgroup, (data) {
      getActiveAuditTypeByRptGroupData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetActiveAuditTypeByRptGroupModel getActiveAuditTypeByRptGroupDataIA =
      GetActiveAuditTypeByRptGroupModel();
  getActiveAuditTypeByRptGroupAPIIA(context, String rptgroup) async {
    getActiveAuditTypeByRptGroupDataIA = GetActiveAuditTypeByRptGroupModel();
    notifyListeners();
    _useCase.getActiveAuditTypeByRptGroupAPI(rptgroup, (data) {
      getActiveAuditTypeByRptGroupDataIA = data;
      for (int i = 0;
          i < (getActiveAuditTypeByRptGroupDataIA.data ?? []).length;
          i++) {
        if ((getActiveAuditTypeByRptGroupDataIA.data ?? [])[i].auditCode ==
            'IA') {
          var data = (getActiveAuditTypeByRptGroupDataIA.data ?? [])[i];
          getActiveAuditTypeByRptGroupDataIA.data = [];
          getActiveAuditTypeByRptGroupDataIA.data = [data];
        }
      }
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetAllBuyerDivInfoModel getAllBuyerDivInfoData = GetAllBuyerDivInfoModel();
  List<GetAllBuyerDivInfoArray> uniquelist = [];
  getAllBuyerDivInfoDataAPI(context) async {
    getAllBuyerDivInfoData = GetAllBuyerDivInfoModel();
    notifyListeners();
    _useCase.getAllBuyerDivInfoDataAPI((data) {
      getAllBuyerDivInfoData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetOrderRegWithbuyerModel getOrderRegWithbuyerData =
      GetOrderRegWithbuyerModel();
  getOrderRegWithbuyerDataAPI(context, buyerdivcode) async {
    getOrderRegWithbuyerData = GetOrderRegWithbuyerModel();
    notifyListeners();
    _useCase.getOrderRegWithbuyerDataAPI(buyerdivcode, (data) {
      getOrderRegWithbuyerData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage);

      dismissProgress();
    });
  }

  GetSewLineInfoModel getSewLineInfoData = GetSewLineInfoModel();
  getSewLineInfoDataAPI(context, ucode) async {
    getSewLineInfoData = GetSewLineInfoModel();
    notifyListeners();
    _useCase.getSewLineInfoDataAPI(ucode, (data) {
      getSewLineInfoData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
      dismissProgress();
    });
  }

  GetAssigneeDetailByIDModel getAssigneeDetailByIDdata =
      GetAssigneeDetailByIDModel();
  getAssigneeDetailByIDAPI(context, audittypeid) async {
    getAssigneeDetailByIDdata = GetAssigneeDetailByIDModel();
    notifyListeners();
    _useCase.getAssigneeDetailByIDAPI(audittypeid, (data) {
      getAssigneeDetailByIDdata = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetAllActiveFactoryModel GetAllActiveFactoryData = GetAllActiveFactoryModel();
  GetAllActiveFactoryAPI(context) async {
    String locationcode =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);
    GetAllActiveFactoryData = GetAllActiveFactoryModel();
    notifyListeners();
    _useCase.GetAllActiveFactoryAPI(locationcode, (data) {
      GetAllActiveFactoryData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
      dismissProgress();
    });
  }

  SaveOrderScheduleResponseModel saveOrderScheduleResponseData =
      SaveOrderScheduleResponseModel();
  SaveOrderScheduleRequestModel saveOrderScheduleRequestData =
      SaveOrderScheduleRequestModel();
  postSaveOrderSchedule(
    context,
    Function callBack,
  ) async {
    //  &&
    //     (saveOrderScheduleRequestData.auditType ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.buyerCode ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.styleNo ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.orderNo.toString()).isNotEmpty &&
    //     (saveOrderScheduleRequestData.fromDate ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.toDate ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.sewLine ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.targetPerHour.toString()).isNotEmpty &&
    //     (saveOrderScheduleRequestData.auditorName ?? '').isNotEmpty
    if ((saveOrderScheduleRequestData.unitCode ?? '').isEmpty) {
      showErrorAlert('Select unitcode');
    } else if ((saveOrderScheduleRequestData.auditType ?? '').isEmpty) {
      showErrorAlert('Select audit type');
    } else if ((saveOrderScheduleRequestData.buyerCode ?? '').isEmpty) {
      showErrorAlert('Select buyer code');
    } else if ((saveOrderScheduleRequestData.styleNo ?? '').isEmpty) {
      showErrorAlert('Select style no');
    } else if ((saveOrderScheduleRequestData.orderNo.toString()).isEmpty) {
      showErrorAlert('Select order no');
    } else if ((saveOrderScheduleRequestData.fromDate ?? '').isEmpty) {
      showErrorAlert('Select from date');
    } else if ((saveOrderScheduleRequestData.toDate ?? '').isEmpty) {
      showErrorAlert('Select to date');
    } else if ((saveOrderScheduleRequestData.sewLine ?? '').isEmpty) {
      showErrorAlert('Select sewline');
    } else if ((saveOrderScheduleRequestData.targetPerHour.toString())
        .isEmpty) {
      showErrorAlert('Select target per hour');
    } else if ((saveOrderScheduleRequestData.auditorName ?? '').isEmpty) {
      showErrorAlert('Select auditor name');
    } else {
      FocusScope.of(context).requestFocus(FocusNode());

      saveOrderScheduleResponseData = SaveOrderScheduleResponseModel();
      String userN =
          await SharedPreferenceHelper.getString(Constants.userDisplayName);
      DateTime dateToday = DateTime.now();
      String currentDate = dateToday.toString().substring(0, 10);
      String entityID =
          await SharedPreferenceHelper.getString(Constants.entityLocationCode);
      notifyListeners();
      saveOrderScheduleRequestData.aqlStd = '';
      saveOrderScheduleRequestData.comments = '';
      saveOrderScheduleRequestData.createdBy = userN;
      saveOrderScheduleRequestData.createdDate = currentDate;
      saveOrderScheduleRequestData.entityID = entityID;
      saveOrderScheduleRequestData.id = 0;
      saveOrderScheduleRequestData.insType = '';
      saveOrderScheduleRequestData.isActive = true;
      saveOrderScheduleRequestData.orderScheduleDetlModels = [];
      saveOrderScheduleRequestData.orderQty = 0;
      saveOrderScheduleRequestData.schFmTime = '00:00';
      saveOrderScheduleRequestData.schToTime = '23:59';
      saveOrderScheduleRequestData.sessionCnt = 'R1';
      saveOrderScheduleRequestData.hostName = '';

      notifyListeners();
      inspect(saveOrderScheduleRequestData);
      showProgress(context);

      _useCase.postSaveOrderSchedule(saveOrderScheduleRequestData, (data) {
        dismissProgress();
        saveOrderScheduleResponseData = data;

        showErrorAlert('Schedule created');
        if (saveOrderScheduleResponseData.isSuccess ?? false) {
          showErrorAlert('Schedule created');
          dismissProgress();
          notifyListeners();
        } else {
          showErrorAlert(saveOrderScheduleResponseData.message ?? "");
        }
      }, (errorMessage) {
        showErrorAlert(errorMessage);
        dismissProgress();
      });

      // callBack();
      Navigator.pop(context);
    }
    // else {
    //   showErrorAlert('All fields are Mandatory Field');
    // }
  }

  postSaveOrderScheduleIA(
    context,
    Function callBack,
  ) async {
    //  &&
    //     (saveOrderScheduleRequestData.auditType ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.buyerCode ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.styleNo ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.orderNo.toString()).isNotEmpty &&
    //     (saveOrderScheduleRequestData.fromDate ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.toDate ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.sewLine ?? '').isNotEmpty &&
    //     (saveOrderScheduleRequestData.targetPerHour.toString()).isNotEmpty &&
    //     (saveOrderScheduleRequestData.auditorName ?? '').isNotEmpty
    if ((saveOrderScheduleRequestData.unitCode ?? '').isEmpty) {
      showErrorAlert('Select unitcode');
    } else if ((saveOrderScheduleRequestData.auditType ?? '').isEmpty) {
      showErrorAlert('Select audit type');
    } else if ((saveOrderScheduleRequestData.buyerCode ?? '').isEmpty) {
      showErrorAlert('Select buyer code');
    } else if ((saveOrderScheduleRequestData.styleNo ?? '').isEmpty) {
      showErrorAlert('Select style no');
    } else if ((saveOrderScheduleRequestData.orderNo.toString()).isEmpty) {
      showErrorAlert('Select order no');
    } else if ((saveOrderScheduleRequestData.fromDate ?? '').isEmpty) {
      showErrorAlert('Select from date');
    } else if ((saveOrderScheduleRequestData.auditorName ?? '').isEmpty) {
      showErrorAlert('Select auditor name');
    } else {
      FocusScope.of(context).requestFocus(FocusNode());

      saveOrderScheduleResponseData = SaveOrderScheduleResponseModel();
      String userN =
          await SharedPreferenceHelper.getString(Constants.userDisplayName);
      DateTime dateToday = DateTime.now();
      String currentDate = dateToday.toString().substring(0, 10);
      String entityID =
          await SharedPreferenceHelper.getString(Constants.entityLocationCode);
      saveOrderScheduleRequestData.targetPerHour = 0;
      notifyListeners();

      notifyListeners();
      inspect(saveOrderScheduleRequestData);
      showProgress(context);

      _useCase.postSaveOrderSchedule(saveOrderScheduleRequestData, (data) {
        dismissProgress();
        saveOrderScheduleResponseData = data;
        callBack();
        showErrorAlert('Schedule created');
        if (saveOrderScheduleResponseData.isSuccess ?? false) {
          showErrorAlert('Schedule created');
          dismissProgress();
          notifyListeners();
        } else {
          showErrorAlert(saveOrderScheduleResponseData.message ?? "");
        }
      }, (errorMessage) {
        showErrorAlert(errorMessage);
        dismissProgress();
      });

      Navigator.pop(context);
    }
    // else {
    //   showErrorAlert('All fields are Mandatory Field');
    // }
  }

  void clearSaveOrderScheduleRequestData(InternalAuditViewModal iaView) async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String entityID =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);
    saveOrderScheduleRequestData = SaveOrderScheduleRequestModel(
      aqlStd: null,
      comments: '',
      createdBy: userN,
      createdDate: currentDate,
      entityID: entityID,
      id: 0,
      insType: null,
      isActive: true,
      sewLine: '',
      orderScheduleDetlModels: [],
      orderQty: 0,
      schFmTime: '00:00',
      schToTime: '23:59',
      sessionCnt: 'R1',
      hostName: '',
    );
    iaView.options = [];
    iaView.selectedOptionList = Rx<List<String>>([]);
    iaView.selectedOption = ''.obs;
    notifyListeners();
  }

  void unitCodeOnchange(BuildContext context, String ucode) {
    saveOrderScheduleRequestData.unitCode = ucode;
    getSewLineInfoDataAPI(context, ucode);
    notifyListeners();
  }

  void auditTypeOnchange(
      BuildContext context, String auditType, int audittypeid) {
    saveOrderScheduleRequestData.auditType = auditType;
    getAssigneeDetailByIDAPI(context, audittypeid);
    notifyListeners();
  }

  void buyerCodeOnchange(BuildContext context, String buyerCode) {
    saveOrderScheduleRequestData.buyerCode = buyerCode;
    getOrderRegWithbuyerDataAPI(context, buyerCode);
    notifyListeners();
  }

  void styleNoOnchange(String styleNo) {
    saveOrderScheduleRequestData.styleNo = styleNo;
    notifyListeners();
  }

  void orderNoOnchange(
    int orderNo,
  ) {
    saveOrderScheduleRequestData.orderNo = orderNo;

    notifyListeners();
  }

  void orderNoOnchangeIA(int orderNo, InternalAuditViewModal iaView) async {
    saveOrderScheduleRequestData.orderNo = orderNo;
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    iaView.GetDsheadByParamAPI(context, unitCode, 'IA', orderNo);
    //  orderNo.toString());
    iaView.options = [];
    iaView.selectedOptionList = Rx<List<String>>([]);
    iaView.selectedOption = ''.obs;
    notifyListeners();
  }

  void sewLineOnchange(String sewLine) {
    saveOrderScheduleRequestData.sewLine = sewLine;
    notifyListeners();
  }

  void aqlStdOnchange(String aqlStd) {
    saveOrderScheduleRequestData.aqlStd = aqlStd;
    notifyListeners();
  }

  void insTypeOnchange(String insType) {
    saveOrderScheduleRequestData.insType = insType;

    notifyListeners();
  }

  void auditorNameOnchange(String auditorName) {
    saveOrderScheduleRequestData.auditorName = auditorName;
    notifyListeners();
  }

  void targetPerHourOnchange(int targetPerHour) {
    saveOrderScheduleRequestData.targetPerHour = targetPerHour;
    notifyListeners();
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

  showDate(BuildContext context, bool isStart) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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
        saveOrderScheduleRequestData.fromDate =
            value.toString().characters.take(10).toString();
      } else {
        saveOrderScheduleRequestData.toDate =
            value.toString().characters.take(10).toString();
      }
      notifyListeners();
      print(value);
      return null;
    });
  }

  showDateIA(BuildContext context, bool isStart) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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
        saveOrderScheduleRequestData.fromDate =
            value.toString().characters.take(10).toString();
        saveOrderScheduleRequestData.toDate =
            value.toString().characters.take(10).toString();
      } else {
        saveOrderScheduleRequestData.toDate =
            value.toString().characters.take(10).toString();
      }
      notifyListeners();
      print(value);
      return null;
    });
  }

  GetLineQCApprovalByAuditTypeApproverModel
      getLineQCApprovalByAuditTypeApproverData =
      GetLineQCApprovalByAuditTypeApproverModel();
  getLineQCApprovalByAuditTypeApproverAPI(
    context,
    String unitcode,
    String audittype,
    String auditdate,
    String approver,
  ) async {
    getLineQCApprovalByAuditTypeApproverData =
        GetLineQCApprovalByAuditTypeApproverModel();
    notifyListeners();
    _useCase.getLineQCApprovalByAuditTypeApproverAPI(
        unitcode, audittype, auditdate, approver, (data) {
      getLineQCApprovalByAuditTypeApproverData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetLineQCApprovalByAuditTypeApproverModel
      getLineQCApprovalByAuditTypeUsercodeData =
      GetLineQCApprovalByAuditTypeApproverModel();
  getLineQCApprovalByAuditTypeUsercodeAPI(
    context,
    String unitcode,
    String audittype,
    String auditdate,
    String usercode,
  ) async {
    getLineQCApprovalByAuditTypeUsercodeData =
        GetLineQCApprovalByAuditTypeApproverModel();
    notifyListeners();
    _useCase.getLineQCApprovalByAuditTypeUsercodeAPI(
        unitcode, audittype, auditdate, usercode, (data) {
      getLineQCApprovalByAuditTypeUsercodeData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  ScheduleModel scheduleList = ScheduleModel();
  getSchduleList(context, String unitCode, String currentDate) {
    scheduleList = ScheduleModel();
    notifyListeners();
    _useCase.getScheduleList(unitCode, currentDate, (data) {
      scheduleList = data;

      if ((styleAuditData?.auditType ?? '') == "FG") {
        List<StyleAuditData> listOf = [];
        var newList = scheduleList.data ?? [];
        for (int i = 0; i < newList.length; i++) {
          if ((newList[i].auditType == "FG") ||
              (newList[i].auditType == "FG-I") ||
              (newList[i].auditType == "FG-O")) {
            listOf.add(newList[i]);
          }
        }
        scheduleList.data = listOf;
      } else {
        List<StyleAuditData> listOf = [];
        var newList = scheduleList.data ?? [];
        for (int i = 0; i < newList.length; i++) {
          if (newList[i].auditType == (styleAuditData?.auditType ?? '')) {
            listOf.add(newList[i]);
          }
        }
        scheduleList.data = listOf;
      }

      dismissProgress();
      notifyListeners();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void changeNewStyleFunction(context, styleAudit) {
    clearData();
    onGetInit(context, styleAudit);
    onGetInit2(context, styleAudit);
    setIsScheduleScreen();
  }

  String? GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDatasession;
  void GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDatasessionOnchange(
      sessionCode) {
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDatasession = sessionCode;
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
        context,
        styleAuditData?.unitCode,
        styleAuditData?.schDate,
        styleAuditData?.auditType,
        styleAuditData?.createdBy,
        styleAuditData?.orderNo,
        styleAuditData?.sewLine,
        sessionCode);
  }

  String? GetAllLineQCsDefectdetailsByRangeDaysummaryDataSession;
  void GetAllLineQCsDefectdetailsByRangeDaysummaryDataSessionOnchange(
      sessionCode) {
    GetAllLineQCsDefectdetailsByRangeDaysummaryDataSession = sessionCode;
    GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
        context,
        styleAuditData?.unitCode,
        styleAuditData?.schDate,
        styleAuditData?.auditType,
        styleAuditData?.createdBy,
        styleAuditData?.orderNo,
        styleAuditData?.sewLine,
        sessionCode);
  }

  String? GetAllLineQCsDefectdetailsByRangeHourlyDefectsSession;

  void GetAllLineQCsDefectdetailsByRangeHourlyDefectsSessionOnchange(
      sessionCode) {
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsSession = sessionCode;
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
        context,
        styleAuditData?.unitCode,
        styleAuditData?.schDate,
        styleAuditData?.auditType,
        styleAuditData?.createdBy,
        styleAuditData?.orderNo,
        styleAuditData?.sewLine,
        sessionCode);
  }

  TextEditingController
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsController =
      TextEditingController();
  List<GetAllLineQCsDefectdetailsByRangeHourlyDefectsModelData>
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData = [];

  void GetAllLineQCsDefectdetailsByRangeHourlyDefectsControllerOnChange(
      String search) {
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData =
        search.isEmpty
            ? (GetAllLineQCsDefectdetailsByRangeHourlyDefectsData.data ?? [])
            : (GetAllLineQCsDefectdetailsByRangeHourlyDefectsData.data ?? [])
                .where((item) =>
                    (item.defectName ?? '')
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    (item.defectCode ?? '')
                        .toLowerCase()
                        .contains(search.toLowerCase()))
                .toList();
    notifyListeners();
    print(GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData);
  }

  TextEditingController
      GetAllLineQCsDefectdetailsByRangeDaysummaryDataController =
      TextEditingController();
  List<GetAllLineQCsDefectdetailsByRangeDaysummaryModelData>
      GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData = [];

  void GetAllLineQCsDefectdetailsByRangeDaysummaryControllerOnChange(
      String search) {
    GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData = search.isEmpty
        ? (GetAllLineQCsDefectdetailsByRangeDaysummaryData.data ?? [])
        : (GetAllLineQCsDefectdetailsByRangeDaysummaryData.data ?? [])
            .where((item) =>
                (item.defectName ?? '')
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                (item.defectCode ?? '')
                    .toLowerCase()
                    .contains(search.toLowerCase()))
            .toList();
    notifyListeners();
    print(GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData);
  }

  TextEditingController
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListController =
      TextEditingController();
  List<GetAllLineQCsDefectdetailsByRangeHourlyDefectsListModelData>
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData = [];

  void GetAllLineQCsDefectdetailsByRangeHourlyDefectsListControllerOnChange(
      String search) {
    GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData = search
            .isEmpty
        ? (GetAllLineQCsDefectdetailsByRangeHourlyDefectsListData.data ?? [])
        : (GetAllLineQCsDefectdetailsByRangeHourlyDefectsListData.data ?? [])
            .where((item) =>
                (item.partName ?? '')
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                (item.operationName ?? '')
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                (item.defectName ?? '')
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                (item.tagId ?? '').toLowerCase().contains(search.toLowerCase()))
            .toList();
    notifyListeners();
    print(GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData);
  }

  String? GetAllLineQCsDefectdetailsByRangeHourlyDefectsDate;
  GetAllLineQCsDefectdetailsByRangeHourlyDefectsDatePicker(
    BuildContext context,
  ) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsDate =
          value.toString().characters.take(10).toString();
      GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
          context,
          styleAuditData?.unitCode,
          value.toString().characters.take(10).toString(),
          styleAuditData?.auditType,
          styleAuditData?.createdBy,
          styleAuditData?.orderNo,
          styleAuditData?.sewLine,
          (GetAllLineQCsDefectdetailsByRangeHourlyDefectsSession ?? '')
                  .isNotEmpty
              ? GetAllLineQCsDefectdetailsByRangeHourlyDefectsSession
              : scoreCardData.sessionCode);
      notifyListeners();
      print(value);
      return null;
    });
  }

  String? GetAllLineQCsDefectdetailsByRangeDaysummaryDate;
  GetAllLineQCsDefectdetailsByRangeDaysummaryDatePicker(
    BuildContext context,
  ) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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
      if (value != null) {
        GetAllLineQCsDefectdetailsByRangeDaysummaryDate =
            value.toString().characters.take(10).toString();
        GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
            context,
            styleAuditData?.unitCode,
            value.toString().characters.take(10).toString(),
            styleAuditData?.auditType,
            styleAuditData?.createdBy,
            styleAuditData?.orderNo,
            styleAuditData?.sewLine,
            (GetAllLineQCsDefectdetailsByRangeDaysummaryDataSession ?? '')
                    .isNotEmpty
                ? GetAllLineQCsDefectdetailsByRangeDaysummaryDataSession
                : scoreCardData.sessionCode);
        notifyListeners();
        print(value);
      }
      return null;
    });
  }

  String? getAllLineQCsDefectdetailsByRangeHourlysummaryDate;
  getAllLineQCsDefectdetailsByRangeHourlysummaryDatePicker(
    BuildContext context,
  ) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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
      getAllLineQCsDefectdetailsByRangeHourlysummaryDate =
          value.toString().characters.take(10).toString();
      getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
          context,
          styleAuditData?.unitCode,
          value.toString().characters.take(10).toString(),
          styleAuditData?.auditType,
          styleAuditData?.createdBy,
          styleAuditData?.orderNo,
          styleAuditData?.sewLine,
          scoreCardData.sessionCode);
      notifyListeners();
      print(value);
      return null;
    });
  }

  String styleAuditDataUnitCode = '';
  String styleAuditDataAuditType = '7.0';
  String styleAuditDataOrderNo = '';
  String styleAuditDataStyleNo = '';
  String styleAuditDataSewLine = '';
  String styleAuditDataSchDate = '';

  void setStyleAuditDataFor7auditApproval(orderNo, styleNo, sewLine) async {
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);

    styleAuditDataUnitCode = unitCode;
    styleAuditDataAuditType = '7.0';
    styleAuditDataOrderNo = orderNo.toString();
    styleAuditDataStyleNo = styleNo;
    styleAuditDataSewLine = sewLine;
    styleAuditDataSchDate = currentDate;
    notifyListeners();
  }

  GetAllGarOperationMasterModel sleevesAttachmentData =
      GetAllGarOperationMasterModel();
  getSleevesAttachments(
    context,
    String lan,
    String partid,
  ) {
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

  GetAllGarPartDataModel sleevesData = GetAllGarPartDataModel();
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

  void refreshPartOperation() async {
    String lan = await SharedPreferenceHelper.getString(Constants.currentLang);
    scoreCardData.partCode = "";
    scoreCardData.operationCode = "NA";
    notifyListeners();
    getSleeves(
        context, lan.isEmpty ? 'EN' : lan, styleAuditData?.productType ?? '');
  }

  bool isremoveinspectedPcscount = false;
  bool isremoveAlteredPcscount = false;
  bool isremoveDefectedPcscount = false;
  bool isremoveRejectedPcscount = false;
  void setIsremoveinspectedPcscount() {
    isremoveinspectedPcscount = !isremoveinspectedPcscount;
    notifyListeners();
  }

  void setIsremoveAlteredPcscount() {
    isremoveAlteredPcscount = !isremoveAlteredPcscount;
    notifyListeners();
  }

  void setIsremoveDefectedPcscount() {
    isremoveDefectedPcscount = !isremoveDefectedPcscount;
    notifyListeners();
  }

  void setIsremoveRejectedPcscount() {
    isremoveRejectedPcscount = !isremoveRejectedPcscount;
    notifyListeners();
  }

  int deleteIndex = 0;
  void resetIsRemove(int index) {
    deleteIndex = index;
    isremoveinspectedPcscount = false;
    isremoveAlteredPcscount = false;
    isremoveDefectedPcscount = false;
    isremoveRejectedPcscount = false;
    notifyListeners();
  }
}
