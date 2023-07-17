// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dioCli;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
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
import 'package:qapp/app/data/network/dto/GetAuditStyleDataModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectsByCategoryModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModels.dart';
import 'package:qapp/app/data/network/dto/GetDsheadByParamModel.dart';
import 'package:qapp/app/data/network/dto/GetFreqUsedDefectsByParamsModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectCountEntrypartModel.dart';
import 'package:qapp/app/data/network/dto/GetMesMentDefectsByUomModel.dart';
import 'package:qapp/app/data/network/dto/GetOperCodeByPartIdModel.dart';
import 'package:qapp/app/data/network/dto/GetUDMasterByTypeModel.dart';
import 'package:qapp/app/data/network/dto/GetVisualAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/GetVisualFavouriteModal.dart';
import 'package:qapp/app/data/network/dto/IscheckAuidtExistsModel.dart'
    as IscheckAuidtExistsModel;
import 'package:qapp/app/data/network/dto/PostSaveAuditModel.dart';
import 'package:qapp/app/data/network/dto/RemoveAuditQcDetlResponse.dart';

import 'package:qapp/app/data/network/dto/SaveAuditModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsModel.dart';
import 'package:qapp/app/data/network/dto/SaveFreqUsedDefectsResponseModel.dart';
import 'package:qapp/app/data/network/dto/SaveOrderScheduleRequestModel.dart';
import 'package:qapp/app/data/network/dto/ShoworHideIsFavResponseModel.dart';
import 'package:qapp/app/data/network/dto/UpdateAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateInternalAuditStatusModel.dart';
import 'package:qapp/app/data/network/dto/UpdateIsFavModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageModel.dart';
import 'package:qapp/app/data/network/dto/UploadImageResponseModel.dart';
import 'package:qapp/app/data/network/dto/getAllDefectsModel.dart';
import 'package:qapp/app/data/network/dto/getFavouriteModal.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_use_case.dart';

import 'package:qapp/app/utils/code_snippet.dart';
import '../../data/local/shared_prefs_helper.dart';
import '../../res/constants.dart';

class InternalAuditViewModal extends BaseViewModel {
  final InternalAuditUserCase _useCase =
      AppManager.instance.internalAuditUseCase();
  final pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);

  List selectDefect = [];

  List singleMesDefect = [];
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
  bool isCount = true;
  bool nextOperatorAction = true;
  bool isPass = false;
  bool auditStarted = false;

  final tagName = TextEditingController();
  final operatorSearch = TextEditingController();
  final defectSearchController = TextEditingController();
  final remarkController = TextEditingController();
  final packIdController = TextEditingController();

  FocusNode samplesizeFocus = FocusNode();

  static const countDown = Duration(minutes: 10);

  FinalAuditModel finalAudit = FinalAuditModel();

  GetAllGarOperationMasterModel sleevesAttachmentData =
      GetAllGarOperationMasterModel();
  GetFavouriteModel favoriteData = GetFavouriteModel();
  GetAllDefectsModel allDefectData = GetAllDefectsModel();

  GetLineQcdefectCountEntrypartModel getDefectCount =
      GetLineQcdefectCountEntrypartModel();

  List<AllDefects> searchDefect = [];
  List<GetAllDefectswithLang> searchDefect2 = [];

  int auditState = 0;
  int defectState = 0;

  String measurementDefect = "";
  bool enableRound = false;
  bool auidtFail = false;
  String mesType = "P";
  String mesSizeType = "INCH";
  String currentAuditType = "";
  bool packQtyFound = false;
  bool packEnable = false;
  String packId = "";
  String? passType;
  bool sessionCompleted = false;
  bool endSessionLoader = false;
  String savedAudit = "";
  String garSize = "";

  int criticalCount = 0;
  int sewCount = 0;
  int otherCount = 0;

  List visDefect = [];
  Map visCountDetails = {};
  List visDefectFinal = [];

  List mesDefect = [];
  Map mesCountDetails = {};
  List mesDefectFinal = [];

  List packDefects = [];
  Map packCountDetails = {};
  List packDefectFinal = [];

  List<Map<String, dynamic>> auditStateData = [
    {
      'auditType': "Visual",
      "total": "0",
      "failCount": "0",
      "passCount": "0",
      "comment": "",
      "size": "0",
    },
    {
      'auditType': "Measurements",
      "total": "0",
      "failCount": "0",
      "passCount": "0",
      "comment": "",
      "size": "0",
    },
    {
      'auditType': "Pack",
      "total": "0",
      "failCount": "0",
      "passCount": "0",
      "comment": "",
      "size": "0",
    },
  ];

  final sampleSize = TextEditingController();
  final packQty = TextEditingController();
  String packQtyString = "";
  String packQtynoofcartonsString = "";

  final packQtynoofcartons = TextEditingController();
  final noofcartons = TextEditingController();
  final comment = TextEditingController();
  SaveAuditModel saveAuditData = SaveAuditModel();
  GetAllGarPartDataModel getAllGarPartDetail = GetAllGarPartDataModel();
  GetAllGarOperationMasterModel getAllGarOperationMasterDetail =
      GetAllGarOperationMasterModel();
  GetVisualFavouriteModal getVisualFavouriteDetail = GetVisualFavouriteModal();
  GetVisualAllDefectsModel getVisualAllDefectsDetail =
      GetVisualAllDefectsModel();
  GetVisualAllDefectsModel getVisualAllDefectsDetailSearch =
      GetVisualAllDefectsModel();

  GetVisualAllDefectsModel visaulDefect = GetVisualAllDefectsModel();

  GetVisualAllDefectsModel packDefect = GetVisualAllDefectsModel();

  List<GetAllDefectswithLang> packingDefect = [];
  List<GetAllDefectswithLang> packingDefectAll = [];

  var packingDefectFav = [];

  GetVisualAllDefectsModel packFavDefect = GetVisualAllDefectsModel();

  GetMesMentDefectsByUomModel getMesMentDefectsByUomDetail =
      GetMesMentDefectsByUomModel();
  GetMesMentDefectsByUomModel getMesMentDefectsByUomDetailCM =
      GetMesMentDefectsByUomModel();
  GetMesMentDefectsByUomModel getMesMentDefectsByUomDetailINCH =
      GetMesMentDefectsByUomModel();
  GetAqlBaseInfoModel getAqlBaseInfoDetail = GetAqlBaseInfoModel();
  GetDsListModels getDsListDetail = GetDsListModels();
  UpdateInternalAuditStatusModel UpdateInternalAuditDetail =
      UpdateInternalAuditStatusModel();
  PostSaveAuditModel postSaveAuditDetail = PostSaveAuditModel();
  GetDsListModel getDsData = GetDsListModel();

  AuditStyleList styleAuditData = AuditStyleList();

  GetDefectTranslationMasterByLanguageCodeModel getDefectTranslation =
      GetDefectTranslationMasterByLanguageCodeModel();
  FavDefectDataWithLanguageModel favDefectDataWithLanguageDetail =
      FavDefectDataWithLanguageModel();

  String lang = "";

  void getLang() async {
    lang = await SharedPreferenceHelper.getString(Constants.currentLang);
    notifyListeners();
  }

  File? defectImage;
  File? apiImage;
  void getImage(context) async {
    var auditData = saveAuditData.auditQcDetlModels ?? [];
    if (auditData.isNotEmpty) {
      try {
        final image = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 100);
        if (image == null) {
          return;
        }

        final imgPer = await saveFile(image.path, context);
        defectImage = imgPer;
        notifyListeners();

        // apiImage = File(image.path);
        // uploadImage();
      } on PlatformException catch (e) {
        print(e);
      }
    } else {
      showErrorAlert('Please select a defect to add image');
    }
  }

  Future<File> saveFile(String imagePath, context) async {
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

  void auditStateAdd() {
    if (auditState < (packEnable ? 1 : 2)) {
      auditState = auditState + 1;
      selectDefect = [];
      singleMesDefect = [];
      saveAuditData.auditQcDetlModels = [];
      saveAuditData.partCode = "";
      saveAuditData.operationCode = "";
      defectSearchController.text = "";
      defaultCategory = null;
      defectImage = null;

      allDefectData.data?.allDefects = searchDefect;
      packingDefect = packingDefectAll;
      auidtFail = false;
      packIdController.text = "";
      garSize = '';
      passType = null;
      defectState = 1;
      sampleSize.text = auditStateData[auditState]['size'].toString();
      FocusManager.instance.primaryFocus?.unfocus();
      notifyListeners();
    }
  }

  void auditStateRem() {
    if (auditState != 0) {
      auditState = auditState - 1;
      selectDefect = [];
      singleMesDefect = [];
      saveAuditData.auditQcDetlModels = [];
      saveAuditData.partCode = "";
      saveAuditData.operationCode = "";
      defectSearchController.text = "";
      defaultCategory = null;
      defectImage = null;

      allDefectData.data?.allDefects = searchDefect;
      packingDefect = packingDefectAll;
      auidtFail = false;
      packIdController.text = "";
      garSize = '';
      passType = null;
      defectState = 1;
      sampleSize.text = auditStateData[auditState]['size'].toString();
      FocusManager.instance.primaryFocus?.unfocus();
      notifyListeners();
    }
  }

  void sampleSizeChange(String value) {
    if (value.isNotEmpty) {
      auditStateData[auditState]['size'] = value;
      if (auditState == 0) {
        saveAuditData.sampleSize = int.parse(value);
      }
      if (auditState == 1) {
        saveAuditData.measurementPcs = int.parse(value);
      }
      if (auditState == 2) {
        saveAuditData.packCtns = int.parse(value);
      }
    }
  }

  void sampleSizeValidate() {
    showErrorAlert('message');
  }

  void passTypeChange(String value) {
    passType = value;
    saveAuditData.auditCount = value;
    notifyListeners();
  }

  void packIdChange(String value) {
    packId = value;
    saveAuditData.partCode = value;

    notifyListeners();
  }

  void defectStateUpdate(int state) {
    defectState = state;
    notifyListeners();
  }

  void mesTypeChange(String type) {
    mesType = type;
    selectDefect = [];
    singleMesDefect = [];
    saveAuditData.auditQcDetlModels = [];
    notifyListeners();
  }

  void mesSizeTypeChange(String type, BuildContext context) {
    mesSizeType = type;
    selectDefect = [];
    singleMesDefect = [];
    saveAuditData.auditQcDetlModels = [];
    notifyListeners();

    getMesMentDefectsByUom(context, type);
  }

  void passFunction(BuildContext context) {
    int visSampleSize = int.parse(auditStateData[0]['size'].toString());
    int mesSampleSize = int.parse(auditStateData[1]['size'].toString());
    int packSampleSize = int.parse(auditStateData[2]['size'].toString());

    if (mesSampleSize > 0 &&
        mesSampleSize <= visSampleSize &&
        packSampleSize > 0) {
      if (auditState == 0) {
        visualPassFunction(context);
      }
      if (auditState == 1) {
        mesPassFunction(context);
      }
      if (auditState == 2) {
        packPassFunction(context);
      }
    } else {
      if (auditState == 0) {
        visualPassFunction(context);
      }
      if (auditState == 1) {
        mesPassFunction(context);
      }
      if (auditState == 2) {
        packPassFunction(context);
      }
      // showErrorAlert('Invalid measurement/pack sample size');
    }
  }

  void visualResultFunction() {
    int failPcs = int.parse(auditStateData[auditState]['failCount']);
    if (failPcs >
        (getAqlBaseInfoDetail.data?.aqlvmDetlModels?[0].maxAllowVisualDefects ??
            0)) {
      saveAuditData.visualResult = "F";
    } else {
      saveAuditData.visualResult = "P";
    }

    if (saveAuditData.visualResult == "P" &&
        saveAuditData.measurementResult == "P" &&
        saveAuditData.caaResult == "P") {
      saveAuditData.finalResult = "P";
    }

    notifyListeners();
  }

  void visualPassFunction(BuildContext context) {
    if (int.parse(auditStateData[auditState]['total']) <
        int.parse(auditStateData[auditState]['size'].toString())) {
      String total =
          (int.parse(auditStateData[auditState]['total']) + 1).toString();
      int failPcs = int.parse(auditStateData[auditState]['failCount']);
      saveAuditData.visualPassPcs = (int.parse(total) - failPcs).abs();
      saveAuditData.mkType = 'V';
      saveAuditData.inspectedPcs = (saveAuditData.inspectedPcs ?? 0) + 1;
      saveAuditData.vInspectedPcs = (saveAuditData.vInspectedPcs ?? 0) + 1;
      notifyListeners();
      finalResult();
      postAuditData(context, "pass");
    }
  }

  void mesPassFunction(BuildContext context) {
    if (int.parse(auditStateData[auditState]['total']) <
        int.parse(auditStateData[auditState]['size'].toString())) {
      String total =
          (int.parse(auditStateData[auditState]['total']) + 1).toString();
      int failPcs = int.parse(auditStateData[auditState]['failCount']);
      saveAuditData.measurementPassPcs = (int.parse(total) - failPcs).abs();
      saveAuditData.mkType = 'M';
      saveAuditData.inspectedPcs = (saveAuditData.inspectedPcs ?? 0) + 1;
      saveAuditData.mInspectedPcs = (saveAuditData.mInspectedPcs ?? 0) + 1;
      notifyListeners();
      finalResult();
      postAuditData(context, "pass");
    }
  }

  void packPassFunction(BuildContext context) {
    finalResult();
    if (int.parse(auditStateData[auditState]['total']) <
        int.parse(auditStateData[auditState]['size'].toString())) {
      String total =
          (int.parse(auditStateData[auditState]['total']) + 1).toString();
      int failPcs = int.parse(auditStateData[auditState]['failCount']);
      saveAuditData.packPassed = (int.parse(total) - failPcs).abs();
      saveAuditData.mkType = 'P';
      saveAuditData.inspectedPcs = (saveAuditData.inspectedPcs ?? 0) + 1;
      saveAuditData.pInspectedPcs = (saveAuditData.pInspectedPcs ?? 0) + 1;
      notifyListeners();
      finalResult();
      postAuditData(context, "pass");
    }
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

  postAuditData(BuildContext context, String auditType) {
    showProgress(context);
    postSaveAuditDetail = PostSaveAuditModel();
    notifyListeners();
    // saveAuditData.auditPoDetlModels = [];
    _useCase.postAuditDatas(saveAuditData, (data) {
      postSaveAuditDetail = data;

      if (postSaveAuditDetail.isSuccess ?? false) {
        SharedPreferenceHelper.setString(
            Constants.currentInternalAudit, styleAuditData.schhdId.toString());

        savedAudit = styleAuditData.schhdId.toString();
        saveAuditData.auditQcDetlModels = [];
        saveAuditData.auditPoDetlModels = [];

        List<AuditPoDetlModels> auditPoDetlModels = [];

        for (int i = 0;
            i < (postSaveAuditDetail.data?.auditPoDetlModels ?? []).length;
            i++) {
          saveAuditData.auditPoDetlModels?.add(AuditPoDetlModels(
            adHeadID:
                (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i].adHeadID,
            buyerPoNo: (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i]
                .buyerPoNo,
            buyerPoSlno: (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i]
                .buyerPoSlno,
            color: (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i].color,
            createdBy: (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i]
                .createdBy,
            createdDate: (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i]
                .createdDate,
            hostName: '',
            id: (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i].id,
            isActive: true,
            modifiedBy: null,
            modifiedDate: null,
            orderNo:
                (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i].orderNo,
            orderQty:
                (postSaveAuditDetail.data?.auditPoDetlModels ?? [])[i].orderQty,
          ));
        }
        if (auditState == 2) {
          saveAuditData.partCode = "";
        }
        // saveAuditData.operationCode = null;
        defaultCategory = null;
        allDefectData.data?.allDefects = searchDefect;
        packingDefect = packingDefectAll;
        defectSearchController.text = "";
        packIdController.text = '';
        garSize = '';
        selectDefect = [];
        singleMesDefect = [];
        auidtFail = false;
        defectState = 1;
        comment.clear();
        saveAuditData.id = postSaveAuditDetail.data?.id;
        auditStarted = true;
        defectImage = null;

        if (auditType == "fail") {
          String failCount =
              (int.parse(auditStateData[auditState]['failCount']) + 1)
                  .toString();
          auditStateData[auditState]['failCount'] = failCount;
          String total =
              (int.parse(auditStateData[auditState]['total']) + 1).toString();
          auditStateData[auditState]['total'] = total;
        } else {
          String total =
              (int.parse(auditStateData[auditState]['total']) + 1).toString();
          auditStateData[auditState]['total'] = total;
        }
        sessionCompletionTester();
        notifyListeners();
      } else {
        notifyListeners();
        dismissProgress();
      }
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage ?? "Exception");
      dismissProgress();
    });
  }

  void failFunction(BuildContext context) async {
    if (auditState == 0 || auditState == 2) {
      defectStateUpdate(3);
    } else {
      defectStateUpdate(4);
    }
    int visSampleSize = int.parse(auditStateData[0]['size'].toString());
    int mesSampleSize = int.parse(auditStateData[1]['size'].toString());
    int packSampleSize = int.parse(auditStateData[2]['size'].toString());

    if (mesSampleSize > 0 &&
        mesSampleSize <= visSampleSize &&
        packSampleSize > 0) {
      if (int.parse(auditStateData[auditState]['total']) <
          int.parse(auditStateData[auditState]['size'].toString())) {
        auidtFail = true;
        notifyListeners();
      }
    } else {
      auidtFail = true;
      notifyListeners();
    }

    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');

    getFreqUsedDefectsByParamswithChkType(
        context,
        unitCode,
        'IA',
        userN,
        auditState == 0
            ? 'V'
            : auditState == 1
                ? 'M'
                : auditState == 2
                    ? 'P'
                    : '');
  }

  void failCancelFunction() {
    auidtFail = false;
    saveAuditData.auditQcDetlModels = [];
    // saveAuditData.auditPoDetlModels = [];
    selectDefect = [];
    singleMesDefect = [];
    defectSearchController.text = '';
    defaultCategory = null;
    allDefectData.data?.allDefects = searchDefect;
    packingDefect = packingDefectAll;
    defectState = 1;

    notifyListeners();
  }

  void failSaveFunction(BuildContext context, String selectedFavorite) async {
    if (auditState == 0) {
      visualSaveFunction(context);
    }
    if (auditState == 1) {
      mesSaveFunction(context);
    }
    if (auditState == 2) {
      if ((saveAuditData.id ?? 0) != 0) {
        CheckAuditPackIDExistsModel checkAuditPackIDExistsData =
            CheckAuditPackIDExistsModel();
        checkAuditPackIDExistsAPI(context, int id, String packid) {
          checkAuditPackIDExistsData = CheckAuditPackIDExistsModel();
          notifyListeners();
          _useCase.checkAuditPackIDExistsAPI(id, packid, (data) {
            checkAuditPackIDExistsData = data;

            notifyListeners();
            if (checkAuditPackIDExistsData.data == 'false') {
              packSaveFunction(context);
            } else {
              showErrorAlert('Pack ID exist');
            }

            dismissProgress();
          }, (errorMessage) {
            dismissProgress();
          });
        }

        checkAuditPackIDExistsAPI(
            context, (saveAuditData.id ?? 0), saveAuditData.partCode ?? '');
      }
    }
  }

  void visualSaveFunction(BuildContext context) {
    Map<String, int> count = {};
    for (var i in visDefect) {
      count[i] = (count[i] ?? 0) + 1;
    }
    visCountDetails = count;
    var newList = [];
    var newLis2 = [];

    count.forEach((k, v) => newList.add({"defectCode": k, "count": v}));

    var def = getAllDefectswithFreqUsedDefectsByParamswithChkTypeDetail.data;

    for (int i = 0; i < newList.length; i++) {
      var val = def?.firstWhereOrNull(
          (defArr) => defArr.defectCode == newList[i]['defectCode']);

      newLis2.add({
        "name": val?.defectName,
        "code": val?.defectCode,
        "count": newList[i]['count']
      });
    }
    visDefectFinal = [];
    visDefectFinal.addAll(newLis2);

    if (int.parse(auditStateData[auditState]['total']) <
        int.parse(auditStateData[auditState]['size'].toString())) {
      saveAuditData.mkType = 'V';
      saveAuditData.inspectedPcs = (saveAuditData.inspectedPcs ?? 0) + 1;
      saveAuditData.vInspectedPcs = (saveAuditData.vInspectedPcs ?? 0) + 1;
      notifyListeners();
      finalResult();
      postAuditData(context, "fail");
    }
  }

  void packSaveFunction(BuildContext context) {
    Map<String, int> count = {};
    for (var i in packDefects) {
      count[i] = (count[i] ?? 0) + 1;
    }
    packCountDetails = count;
    var newList = [];
    var newLis2 = [];

    count.forEach((k, v) => newList.add({"defectCode": k, "count": v}));

    var def = packingDefectAll;

    for (int i = 0; i < newList.length; i++) {
      var val = def.firstWhereOrNull(
          (defArr) => defArr.defectCode == newList[i]['defectCode']);

      newLis2.add({
        "name": val?.defectName,
        "code": val?.defectCode,
        "count": newList[i]['count']
      });
    }
    packDefectFinal = [];
    packDefectFinal.addAll(newLis2);

    if (int.parse(auditStateData[auditState]['total']) <
        int.parse(auditStateData[auditState]['size'].toString())) {
      saveAuditData.mkType = 'P';
      saveAuditData.inspectedPcs = (saveAuditData.inspectedPcs ?? 0) + 1;
      saveAuditData.pInspectedPcs = (saveAuditData.pInspectedPcs ?? 0) + 1;
      notifyListeners();
      finalResult();
      postAuditData(context, "fail");
    }
  }

  void mesSaveFunction(BuildContext context) {
    mesDefect.addAll(singleMesDefect);

    Map<String, int> count = {};
    for (var i in mesDefect) {
      count[i] = (count[i] ?? 0) + 1;
    }
    mesCountDetails = count;
    var newList = [];
    var newLis2 = [];

    count.forEach((k, v) => newList.add({"name": k, "count": v}));
    mesDefectFinal = [];
    mesDefectFinal.addAll(newList);

    if (int.parse(auditStateData[auditState]['total']) <
        int.parse(auditStateData[auditState]['size'].toString())) {
      saveAuditData.mkType = 'M';
      saveAuditData.inspectedPcs = (saveAuditData.inspectedPcs ?? 0) + 1;
      saveAuditData.mInspectedPcs = (saveAuditData.mInspectedPcs ?? 0) + 1;
      notifyListeners();
      finalResult();
      postAuditData(context, "fail");
    }
  }

  void commentChange(String value) {
    auditStateData[auditState]['comment'] = value;
  }

  void defectCategoryOnChange2(String value) {
    defaultCategory = value;
  }

  void defectSearchFunction2(String value) {
    (value);
    if (value.isNotEmpty) {
      var data = getVisualAllDefectsDetailSearch.data ?? [];
      List search(String value) {
        return (data).where((e) => e.defectName!.contains(value)).toList();
      }

      var newList = search(value);
      getVisualAllDefectsDetail.data = newList.cast<GetVisualAllDefectsArray>();
      notifyListeners();
    } else {
      getVisualAllDefectsDetail = getVisualAllDefectsDetailSearch;
      notifyListeners();
    }
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
  }

  void packingDefectSearchFunction(String value) {
    if (value.isNotEmpty) {
      List<GetAllDefectswithLang> search(String input) {
        return (packingDefectAll)
            .where((e) =>
                e.defectName!.toLowerCase().contains(input.toLowerCase()))
            .toList();
      }

      var newList = search(value);
      packingDefect = newList;
    } else {
      packingDefect = packingDefectAll;
    }

    notifyListeners();
  }

  void resetData() {}

  void clearData() {
    notifyListeners();
  }

  void nextOperator(BuildContext context, styleAudit) {}

  // void nextOperator(BuildContext context) {}

  void onEmpCodeChange(String email) {}

  void resetAuditStep() {}

  void auditStepUpdate(int step) {}

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

  void roundChange(bool value) {}

  void tagNumberOnChange(String value) {}

  void finalResult() {
    if (visDefect.length >
        (getAqlBaseInfoDetail.data?.aqlvmDetlModels?[0].maxAllowVisualDefects ??
            0)) {
      saveAuditData.visualResult = "F";
    } else {
      saveAuditData.visualResult = "P";
    }

    if (mesDefect.length >
        (getAqlBaseInfoDetail
                .data?.aqlvmDetlModels?[0].maxAllowMesurementDefects ??
            0)) {
      saveAuditData.measurementResult = "F";
    } else {
      saveAuditData.measurementResult = "P";
    }
    if (getAqlBaseInfoDetail.data?.aqlpkDetlModels?.isNotEmpty ?? false) {
      if (packDefects.length >
          (getAqlBaseInfoDetail.data?.aqlpkDetlModels?[0].maxAllowPackDefects ??
              0)) {
        saveAuditData.caaResult = "F";
      } else {
        saveAuditData.caaResult = "P";
      }
    } else {
      saveAuditData.caaResult = "P";
    }

    if (criticalCount >
        (getAqlBaseInfoDetail
                .data?.aqlvmDetlModels?[0].maxAllowCriticalDefects ??
            0)) {
      saveAuditData.visualResult = "F";
    }

    if (sewCount >
        (getAqlBaseInfoDetail.data?.aqlvmDetlModels?[0].maxAllowSewDefects ??
            0)) {
      saveAuditData.visualResult = "F";
    }

    if (otherCount >
        (getAqlBaseInfoDetail.data?.aqlvmDetlModels?[0].maxAllowOthDefects ??
            0)) {
      saveAuditData.visualResult = "F";
    }

    if (saveAuditData.visualResult == "P" &&
        saveAuditData.measurementResult == "P" &&
        saveAuditData.caaResult == "P") {
      saveAuditData.finalResult = "P";
    } else {
      saveAuditData.finalResult = "F";
    }

    notifyListeners();
  }

  void selectMeasureDefectFunction(String selectedDefect) async {
    singleMesDefect = [];
    singleMesDefect.add(selectedDefect);

    var auditQcDetlData = saveAuditData.auditQcDetlModels ?? [];
    auditQcDetlData = [];

    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);

    auditQcDetlData.add(AuditQcDetlModels(
      adHeadID: 0,
      chkType: "M",
      comments: "",
      createdBy: "",
      createdDate: currentDate,
      critical: 0,
      defectCode: "NA",
      defectPcs: 1,
      deviation: selectedDefect,
      hostName: "",
      id: 0,
      isActive: true,
      major: 0,
      minor: 1,
      modifiedBy: "",
      modifiedDate: currentDate,
      uom: mesSizeType,
      partCode: saveAuditData.partCode,
      operationCode: saveAuditData.operationCode,
      auditImagesEntityModels: [],
      garSize: garSize,
      packID: saveAuditData.partCode,
      cancel: 'N',
    ));

    saveAuditData.auditQcDetlModels = auditQcDetlData;

    notifyListeners();
  }

  void selectVisualDefectFunction(String selectedDefect, String defectLevel,
      String defectCategory, BuildContext context) async {
    int findItem =
        selectDefect.indexWhere((element) => element == selectedDefect);
    if (findItem < 0) {
      selectDefect.add(selectedDefect);
      visDefect.add(selectedDefect);

// "0001-01-01T00:00:00"
      DateTime dateToday = DateTime.now();
      String currentDate = dateToday.toString().substring(0, 10);
      String currentDateTime =
          '${dateToday.toString().substring(0, 10)}T${dateToday.hour}:${dateToday.minute}:${dateToday.second}';
      print(currentDateTime);

      var auditQcDetlData = saveAuditData.auditQcDetlModels ?? [];

      auditQcDetlData.add(AuditQcDetlModels(
        adHeadID: 0,
        chkType: "V",
        comments: "",
        createdBy: "",
        createdDate: currentDate,
        critical: 0,
        defectCode: selectedDefect,
        defectPcs: 1,
        deviation: "0",
        hostName: "",
        id: 0,
        isActive: true,
        major: 0,
        minor: 1,
        modifiedBy: "",
        modifiedDate: currentDate,
        uom: "",
        partCode: saveAuditData.partCode,
        operationCode: saveAuditData.operationCode,
        auditImagesEntityModels: [],
        garSize: garSize,
        packID: saveAuditData.partCode,
        cancel: 'N',
      ));

      saveAuditData.auditQcDetlModels = auditQcDetlData;

      if (defectLevel == "Critical") {
        criticalCount = criticalCount + 1;
      }
      if (defectCategory == "Sew/Cons") {
        sewCount = sewCount + 1;
      }

      if (defectLevel != "Critical" && defectCategory != "Sew/Cons") {
        otherCount = otherCount + 1;
      }

      notifyListeners();
    } else {
      selectDefect.removeAt(findItem);
      visDefect.removeAt(findItem);
      saveAuditData.auditQcDetlModels?.removeAt(findItem);

      if (defectLevel == "Critical") {
        criticalCount = criticalCount - 1;
      }

      if (defectCategory == "Sew/Cons") {
        sewCount = sewCount - 1;
      }

      if (defectLevel != "Critical" && defectCategory != "Sew/Cons") {
        otherCount = otherCount - 1;
      }

      notifyListeners();
    }

    notifyListeners();

    notifyListeners();
  }

  void selectPackDefectFunction(String selectedDefect, String defectLevel,
      String defectCategory, BuildContext context) async {
    int findItem =
        selectDefect.indexWhere((element) => element == selectedDefect);

    if (findItem < 0) {
      selectDefect.add(selectedDefect);
      packDefects.add(selectedDefect);

      DateTime dateToday = DateTime.now();
      String currentDate = dateToday.toString().substring(0, 10);

      var auditQcDetlData = saveAuditData.auditQcDetlModels ?? [];

      auditQcDetlData.add(AuditQcDetlModels(
        adHeadID: 0,
        chkType: "P",
        comments: "",
        createdBy: "",
        createdDate: currentDate,
        critical: 0,
        defectCode: selectedDefect,
        defectPcs: 1,
        deviation: "0",
        hostName: "",
        id: 0,
        isActive: true,
        major: 0,
        minor: 1,
        modifiedBy: "",
        modifiedDate: currentDate,
        uom: "",
        partCode: saveAuditData.partCode,
        operationCode: saveAuditData.operationCode,
        auditImagesEntityModels: [],
        packID: saveAuditData.partCode,
        cancel: 'N',
      ));

      saveAuditData.auditQcDetlModels = auditQcDetlData;

      if (defectLevel == "Critical") {
        criticalCount = criticalCount + 1;
      }
      if (defectCategory == "Sew/Cons") {
        sewCount = sewCount + 1;
      }

      if (defectLevel != "Critical" && defectCategory != "Sew/Cons") {
        otherCount = otherCount + 1;
      }

      notifyListeners();
    } else {
      selectDefect.removeAt(findItem);
      packDefects.removeAt(findItem);
      saveAuditData.auditQcDetlModels?.removeAt(findItem);

      if (defectLevel == "Critical") {
        criticalCount = criticalCount - 1;
      }

      if (defectCategory == "Sew/Cons") {
        sewCount = sewCount - 1;
      }

      if (defectLevel != "Critical" && defectCategory != "Sew/Cons") {
        otherCount = otherCount - 1;
      }

      notifyListeners();
    }

    notifyListeners();

    notifyListeners();
  }

  void partOnchange(String partCode) {
    saveAuditData.partCode = partCode.toString();

    notifyListeners();
  }

  void sleeveValueOnchange(context, String sleeve, int? id) async {
    saveAuditData.operationCode = '';
    saveAuditData.partCode = sleeve.toString();
    currentoperationName = '';

    getOperCodeByPartIdDetail.data = [];

    notifyListeners();

    if (id != 0) {
      // getOperCodeByPartId(context, id);
      String lan =
          await SharedPreferenceHelper.getString(Constants.currentLang);
      getSleevesAttachments(context, lan.isEmpty ? 'EN' : lan, id.toString());
    }
  }

  void operationOnchange(String operationCode) {
    saveAuditData.operationCode = operationCode.toString();
    notifyListeners();
  }

  void sizeOnchange(String size) {
    garSize = size;
    notifyListeners();
  }

  void sleeveAttachmentValueOnchange(
      String sleeveAttachment, String sleeveName) {
    currentoperationName = sleeveName;
    saveAuditData.operationCode = sleeveAttachment.toString();
    notifyListeners();
  }

  void onGetInit(
    BuildContext context,
    AuditStyleList styleAudit,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);

    styleAuditData = styleAudit;

    packEnable =
        styleAudit.insType == "PF" || styleAudit.insType == "F" ? false : true;

    sessionCompletionTester();
    notifyListeners();

    String nowAudit = styleAudit.schhdId.toString();
    savedAudit =
        await SharedPreferenceHelper.getString(Constants.currentInternalAudit);
    bool reset = savedAudit == nowAudit ? false : true;
    if (reset) {
      updateSaveAuditData(styleAudit);
    }
    IscheckAuidtExistsAPI(
        context,
        unitCode,
        currentDate,
        'IA',
        styleAuditData.insType ?? '',
        styleAuditData.orderno ?? 0,
        styleAuditData.orderQty ?? 0,
        userN);
    getLang();
    updateScoreCardMand(styleAudit);
    notifyListeners();

    getAllGarPartDetailData(context, styleAudit.productType ?? '');
    getAllGarOperationMasterDetailData(context);
    // getVisualFavoriteDefect(context);
    getMesMentDefectsByUom(context, "INCH");
    getMesMentDefectsByUomINCH(context, "INCH");
    // getDefectTranslationMasterByLanguage Code(context);
    getDsList(context, styleAudit.orderno.toString());
    GetDefectsByCategoryAPI(context, 'Packing');
    getDsListDetailData(context, styleAudit.orderno);
    getAllDefectswithFreqUsedDefectsByParamswithChkType(
        context,
        unitCode,
        'IA',
        userN,
        auditState == 0
            ? 'V'
            : auditState == 1
                ? 'M'
                : auditState == 2
                    ? 'P'
                    : '');

    String lan = await SharedPreferenceHelper.getString(Constants.currentLang);
    getSleeves(context, lan.isEmpty ? 'EN' : lan, styleAudit.productType);

    // getVisualAllDefect(context);
    // getAllDefect(context);
    // favDefectDataWithLanguage(context);
    // getSleeves(context);
    // getSleevesAttachments(context);
    // updateScoreCard(context, styleAudit);
    // getFinalAudit(context);
    // dismissProgress();
  }

  void updateSaveAuditData(AuditStyleList styleAudit) async {
    criticalCount = 0;
    sewCount = 0;
    otherCount = 0;

    visDefect = [];
    visCountDetails = {};
    visDefectFinal = [];

    mesDefect = [];
    mesCountDetails = {};
    mesDefectFinal = [];

    packDefects = [];
    packCountDetails = {};
    packDefectFinal = [];

    garSize = "";
    auditStateData = [
      {
        'auditType': "Visual",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
        "defectCount": "",
      },
      {
        'auditType': "Measurements",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
        "defectCount": "",
      },
      {
        'auditType': "Pack",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
        "defectCount": "",
      },
    ];
    sessionCompleted = false;
    mesSizeType = "INCH";
    mesType = "P";
    saveAuditData.auditQcDetlModels = [];
    // saveAuditData.auditPoDetlModels = [];
    packQty.clear();
    packQtynoofcartons.clear();
    packQtyString = '';
    packQtynoofcartonsString = '';
    noofcartons.clear();
    selectDefect = [];
    singleMesDefect = [];
    auidtFail = false;
    enableRound = false;
    cartonRound = false;
    baseRound = false;
    auditState = 0;
    defectState = 0;
    sampleSize.text = "0";
    packQtynoofcartonsString = '';
    packQtyString = '';
    packQtynoofcartons.text = '';
    packQty.text = '';

    notifyListeners();
  }

  void updateScoreCardMand(AuditStyleList styleAudit) async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');

    auditStarted = false;
    isReportScreen = false;
    isDefectSummaryList = false;
    currentReportScreen = 1;

    saveAuditData.createdDate = currentDate;
    saveAuditData.createdBy = userN;
    saveAuditData.modifiedDate = currentDate;
    saveAuditData.modifiedBy = "";
    saveAuditData.isActive = true;
    saveAuditData.id = 0;
    saveAuditData.auditScheduleHeadID = styleAudit.schhdId;
    saveAuditData.entityID = "IND";
    saveAuditData.auditType = "IA";
    saveAuditData.insType = styleAudit.insType;
    saveAuditData.auditDate = currentDate;

    saveAuditData.unitCode = unitCode;
    saveAuditData.floorName = "NA";
    saveAuditData.sewLine = "NA";
    saveAuditData.buyerCode = styleAudit.buycode;
    saveAuditData.styleNo = styleAudit.styleno;
    saveAuditData.orderNo = styleAudit.orderno;

    saveAuditData.orderQty = styleAudit.orderQty;
    saveAuditData.packQty = 0;
    saveAuditData.partCode = "";
    saveAuditData.operationCode = "";
    saveAuditData.sampleSize = 0;
    saveAuditData.measurementPcs = 0;
    saveAuditData.packCtns = 0;
    saveAuditData.visualPassPcs = 0;
    saveAuditData.measurementPassPcs = 0;
    saveAuditData.packPassed = 0;
    saveAuditData.visualResult = "P";
    saveAuditData.measurementResult = "P";
    saveAuditData.caaResult = "P";
    saveAuditData.finalResult = "";
    saveAuditData.auditCount = "I";
    saveAuditData.aqlType = styleAudit.aqltype ?? 'AQL1.5';
    // saveAuditData.aqlBase = "AQL1.5";
    saveAuditData.auditorName = userN;
    saveAuditData.resubmissionDate = currentDate;
    saveAuditData.hostName = "";
    saveAuditData.inspectedPcs = 0;
    saveAuditData.vInspectedPcs = 0;
    saveAuditData.mInspectedPcs = 0;
    saveAuditData.pInspectedPcs = 0;
    saveAuditData.auditQcDetlModels = [];
    saveAuditData.auditPoDetlModels = [];

    List datas = (styleAudit.buyerpono ?? '').toString().split(',');

    List buyerPoNo = [];

    for (int i = 0; i < datas.length; i++) {
      var dat = datas[i].toString().split('-');
      buyerPoNo.add(dat[0].trim());
    }

    List buyerPoSlno = [];

    for (int i = 0; i < datas.length; i++) {
      var dat = datas[i].toString().split('-');
      buyerPoSlno.add(int.parse(dat[1].trim()));
    }

    List<AuditPoDetlModels> auditPoDetlModels = [];
    for (int i = 0; i < buyerPoNo.length; i++) {
      auditPoDetlModels.add(AuditPoDetlModels(
        createdDate:
            '${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z',
        createdBy: userN,
        modifiedDate: null,
        modifiedBy: null,
        adHeadID: 0,
        buyerPoNo: buyerPoNo[i],
        buyerPoSlno: buyerPoSlno[i],
        color: (styleAudit.color ?? []).isNotEmpty
            ? ((styleAudit.color ?? [])[0].color ?? 'NA')
            : 'NA',
        hostName: '',
        id: 0,
        isActive: true,
        orderNo: styleAudit.orderno,
        orderQty: styleAudit.orderQty,
      ));
    }
    saveAuditData.auditPoDetlModels = auditPoDetlModels;

    auditStateData = [
      {
        'auditType': "Visual",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
      },
      {
        'auditType': "Measurements",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
      },
      {
        'auditType': "Pack",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
      },
    ];

    isReportScreen = false;
    isStatusReportScreen = false;
    isDefectSummaryList = false;
    currentReportScreen = 1;
    notifyListeners();
  }

  getAllGarPartDetailData(context, ProductType) {
    getAllGarPartDetail = GetAllGarPartDataModel();
    notifyListeners();
    _useCase.getAllGarPartData(ProductType, (data) {
      getAllGarPartDetail = data;
      List<GarPartData> listOf = [];
      var newList = getAllGarPartDetail.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      getAllGarPartDetail.data = listOf;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert('Invalid ProductType');
      dismissProgress();
    });
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

  getDsListDetailData(context, orderno) {
    getDsListDetail = GetDsListModels();
    notifyListeners();
    _useCase.getDsListDetailDataa(orderno, (data) {
      getDsListDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  UpdateAuditStatusModel updateInternalAuditStatusData =
      UpdateAuditStatusModel();
  UpdateAuditStatusModel updateAuditStatusData = UpdateAuditStatusModel();
  updateAuditStatusAPI(
    context,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName2);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    endSessionLoader = true;
    notifyListeners();
    updateAuditStatusData = UpdateAuditStatusModel();
    notifyListeners();
    _useCase.updateAuditStatusAPIdata(styleAuditData.schhdId, (data) {
      updateAuditStatusData = data;
      endSessionLoader = false;
      notifyListeners();
      if (updateAuditStatusData.isSuccess == true) {
        Navigator.pushReplacementNamed(
            context, Constants.internalAuditUserboardRoute);
      }
      if (updateAuditStatusData.isSuccess == false) {
        showErrorAlert('no records found');
      }
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage.toString());
      dismissProgress();
    });
    endSessionLoader = false;
    notifyListeners();
  }

  UpdateInternalAuditStatus(
    context,
  ) async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName2);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    endSessionLoader = true;
    notifyListeners();
    UpdateInternalAuditDetail = UpdateInternalAuditStatusModel();
    notifyListeners();
    _useCase.UpdateInternalAuditStatusData(
        unitCode,
        styleAuditData.schDate,
        "IA",
        userN,
        styleAuditData.orderno,
        styleAuditData.insType,
        "R1", (data) {
      UpdateInternalAuditDetail = data;
      endSessionLoader = false;
      notifyListeners();
      if (UpdateInternalAuditDetail.isSuccess ?? false) {
        Navigator.pushReplacementNamed(
            context, Constants.internalAuditUserboardRoute);
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
    endSessionLoader = false;
    notifyListeners();
  }

  getAllGarOperationMasterDetailData(context) {
    getAllGarOperationMasterDetail = GetAllGarOperationMasterModel();
    notifyListeners();
    _useCase.getAllGarOperationMasterData((data) {
      getAllGarOperationMasterDetail = data;

      List<OperationData> listOf = [];
      var newList = getAllGarOperationMasterDetail.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      getAllGarOperationMasterDetail.data = listOf;
      notifyListeners();

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getVisualFavoriteDefect(context) {
    isFavLoading = true;
    notifyListeners();
    getVisualFavouriteDetail = GetVisualFavouriteModal();
    notifyListeners();
    _useCase.getVisualFavoriteDefuctData((data) {
      getVisualFavouriteDetail = data;
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

  getVisualAllDefect(context) {
    isFavLoading = true;
    notifyListeners();
    getVisualAllDefectsDetail = GetVisualAllDefectsModel();
    getVisualAllDefectsDetailSearch = GetVisualAllDefectsModel();
    searchDefect = [];
    allDefectData = GetAllDefectsModel();
    notifyListeners();
    _useCase.getVisualAllDefectData((data) {
      getVisualAllDefectsDetail = data;
      getVisualAllDefectsDetailSearch = data;
      searchDefect = data;
      allDefectData = data;
      // defectCalculation();
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

  getAllDefect(context) {
    isFavLoading = true;
    notifyListeners();
    allDefectData = GetAllDefectsModel();
    notifyListeners();
    _useCase.getAllDefuctData((data) {
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

      // defectCalculation();
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

  void defectCalculation() {
    // visaulDefect = getVisualAllDefectsDetail;
    var allDefect =
        getAllDefectswithFreqUsedDefectsByParamswithChkTypeDetail.data ?? [];

    List<GetAllDefectswithLang> visDefect = [];
    List<GetAllDefectswithLang> visDefectFav = [];
    List<GetAllDefectswithLang> pcDefect = [];
    List<GetAllDefectswithLang> pcFavDefect = [];
    for (int i = 0; i < allDefect.length; i++) {
      // visDefect.add(allDefect[i]);
      if (allDefect[i].defectCategory == "Packing") {
        pcDefect.add(allDefect[i]);
        // packDefect.data = pcDefect.cast<GetVisualAllDefectsArray>();
        packingDefect = pcDefect;
        packingDefectAll = pcDefect;

        pcFavDefect.add(allDefect[i]);
        // packFavDefect.data = pcFavDefect.cast<GetVisualAllDefectsArray>();
        packingDefectFav = [];
        for (int i = 0; i < pcFavDefect.length; i++) {
          if (pcFavDefect[i].isFav == "Y") {}
          packingDefectFav.add(pcFavDefect[i]);
        }
      } else {
        if (allDefect[i].isFav == 'Y') {
          visDefect.add(allDefect[i]);
          List<GetVisualAllDefectsArray> newVisDef = [];
          for (int ii = 0; ii < visDefect.length; ii++) {
            newVisDef.add(GetVisualAllDefectsArray(
              createdBy: '',
              createdDate: '',
              defectCategory: visDefect[ii].defectCategory,
              defectCode: visDefect[ii].defectCode,
              defectLevel: visDefect[ii].defectLevel,
              defectName: visDefect[ii].defectName,
              defectProfile: visDefect[ii].defectCode,
              displayName: visDefect[ii].defectName,
              hostName: '',
              id: i,
              indexNo: '',
              isActive: true,
              isFav: visDefect[ii].isFav,
              modifiedBy: '',
              modifiedDate: '',
              shtKey: '',
              translation: visDefect[ii].translation,
            ));
          }
          visaulDefect.data = newVisDef;
        }
        // visaulDefect.data = visDefect;

      }
    }
    notifyListeners();
  }

  getMesMentDefectsByUom(context, Uom) {
    isFavLoading = true;
    notifyListeners();
    getMesMentDefectsByUomDetail = GetMesMentDefectsByUomModel();
    notifyListeners();
    _useCase.getMesMentDefectsByUomData(Uom, (data) {
      getMesMentDefectsByUomDetail = data;
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

  getMesMentDefectsByUomINCH(context, Uom) {
    isFavLoading = true;
    notifyListeners();
    getMesMentDefectsByUomDetailINCH = GetMesMentDefectsByUomModel();
    notifyListeners();
    _useCase.getMesMentDefectsByUomData(Uom, (data) {
      getMesMentDefectsByUomDetailINCH = data;
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

  getAqlBaseInfoBase(context) async {
    int carton =
        noofcartons.text.toString().isEmpty ? 0 : int.parse(noofcartons.text);
    if (auditState == 2) {
      if (carton >= 1 && carton < 1000) {
        getAqlBaseInfo(context, true, false);
      } else {
        showErrorAlert("carton should be between 1 to 999");
      }
    } else {
      getAqlBaseInfo(context, false, true);
    }
  }

  void packQtyChange(String val) {
    if (auditState == 2) {
      packQtynoofcartonsString = val;
    } else {
      packQtyString = val;
    }
  }

  bool cartonRound = false;
  bool baseRound = false;
  getAqlBaseInfo(context, bool cartonRnd, bool baseRnd) async {
    if (packQtyString.isEmpty) {
      showErrorAlert("Enter Quantity ");
    } else {
      int orderQty = saveAuditData.orderQty ?? 0;
      int low = ((85 / 100) * orderQty).round();
      int high = ((110 / 100) * orderQty).round();
      int high2 = ((105 / 100) * orderQty).round();
      int packqty = int.parse(packQtyString);
      // if (orderQty <= 5000
      //     ? packqty <= high && packqty >= low
      //     : packqty <= high2 && packqty >= low) {
      FocusManager.instance.primaryFocus?.unfocus();
      saveAuditData.packQty = int.parse(packQtyString);
      String unitCode = await SharedPreferenceHelper.getString('unitCode');
      notifyListeners();
      getAqlBaseInfoDetail = GetAqlBaseInfoModel();
      notifyListeners();
      _useCase.getAqlBaseInfoData(
          unitCode,
          styleAuditData.buycode,
          styleAuditData.aqltype ?? 'AQL1.5',
          "I",
          saveAuditData.packQty.toString().isEmpty
              ? ''
              : saveAuditData.packQty.toString(),
          noofcartons.text.toString().isEmpty
              ? ''
              : noofcartons.text.toString(), (data) {
        getAqlBaseInfoDetail = data;
        notifyListeners();
        if (cartonRnd) {
          cartonRound = true;
          notifyListeners();
        }
        if (baseRnd) {
          baseRound = true;
          notifyListeners();
        }

        if (getAqlBaseInfoDetail.isSuccess ?? true) {
          enableRound = true;
          if (getAqlBaseInfoDetail.data?.aqlvmDetlModels?.isNotEmpty ?? false) {
            saveAuditData.sampleSize =
                getAqlBaseInfoDetail.data?.aqlvmDetlModels?[0].sampleSize ?? 0;
          }

          if (getAqlBaseInfoDetail.data?.aqlvmDetlModels?.isNotEmpty ?? false) {
            saveAuditData.measurementPcs =
                getAqlBaseInfoDetail.data?.aqlvmDetlModels?[0].mesurementPcs ??
                    0;
          }

          if (getAqlBaseInfoDetail.data?.aqlpkDetlModels?.isNotEmpty ?? false) {
            saveAuditData.packCtns =
                getAqlBaseInfoDetail.data?.aqlpkDetlModels?[0].packSamples ?? 0;
          }
          notifyListeners();
          auditStateData[0]['size'] = saveAuditData.sampleSize;
          auditStateData[1]['size'] = saveAuditData.measurementPcs;
          auditStateData[2]['size'] = saveAuditData.packCtns;
          if (auditState == 0) {
            sampleSize.text = saveAuditData.sampleSize.toString();
          }
          if (auditState == 1) {
            sampleSize.text = saveAuditData.measurementPcs.toString();
          }
          if (auditState == 2) {
            sampleSize.text = saveAuditData.packCtns.toString();
          }
          notifyListeners();
        } else {}
        dismissProgress();
      }, (errorMessage) {
        showErrorAlert("No data found");
        dismissProgress();
      });
      // } else {
      //   showErrorAlert(
      //       "Quantity should be between $low and ${packqty <= 5000 ? high : high2}");
      // }
    }
  }

  @override
  notifyListeners();

  operatorFoundChange() {
    operatorFound = true;
    notifyListeners();
  }

  bool visCom = false;
  bool mesCom = false;
  bool packCom = false;

  void sessionCompletionTester() {
    visCom = false;
    mesCom = false;
    packCom = false;
    notifyListeners();
    visCom = int.parse((auditStateData[0]['total'] ?? '0').toString()) == 0
        ? false
        : int.parse((auditStateData[0]['total'] ?? '0').toString()) >=
                int.parse((auditStateData[0]['size'] ?? '0').toString())
            ? true
            : false;

    mesCom = int.parse((auditStateData[1]['total'] ?? '0').toString()) == 0
        ? false
        : int.parse((auditStateData[1]['total'] ?? '0').toString()) >=
                int.parse((auditStateData[1]['size'] ?? '0').toString())
            ? true
            : false;
    packCom = false;

    if (styleAuditData.insType != 'F' && styleAuditData.insType != 'PF') {
      packCom = true;
    } else if (int.parse((auditStateData[2]['size'] ?? '0').toString()) > 0) {
      packCom = int.parse((auditStateData[2]['total'] ?? '0').toString()) == 0
          ? false
          : int.parse((auditStateData[2]['total'] ?? '0').toString()) >=
                  int.parse((auditStateData[2]['size'] ?? '0').toString())
              ? true
              : false;
    } else {
      packCom = false;
    }

    // print('total${int.parse(auditStateData[2]['total'])}');
    // print('size${int.parse(auditStateData[2]['size'])}');

    // if (!packEnable) {
    //   if (getAqlBaseInfoDetail.data?.aqlpkDetlModels?.isNotEmpty ?? false) {
    //     packCom = int.parse(auditStateData[2]['total']) >=
    //         int.parse(auditStateData[2]['size'].toString());
    //   } else {
    //     packCom = false;
    //   }
    // }
    // if (visCom && mesCom && (packEnable ? true : packCom)) {
    //   sessionCompleted = true;
    // } else {
    //   sessionCompleted = false;
    // }
    if (visCom && mesCom && packCom) {
      sessionCompleted = true;
    } else {
      sessionCompleted = false;
    }

    notifyListeners();
  }

  void sessionEndFunction(BuildContext context) {
    UpdateInternalAuditStatus(context);
  }

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
      // searchDefect2 = getDefectTranslation.data ?? [];
      // defectCalculation();
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

  bool isFavLoading = false;
  UpdateIsFavModel updateIsFavModelResponse = UpdateIsFavModel();

  void saveFreqUsedDefects(context, defectCode, active, ChkType) async {
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
    saveFreqUsedDefectsDetail.auditType = 'IA';
    saveFreqUsedDefectsDetail.defectCode = defectCode;
    saveFreqUsedDefectsDetail.ChkType = ChkType;
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
        getAllDefectswithFreqUsedDefectsByParamswithChkType(
            context,
            unitCode,
            'IA',
            userN,
            auditState == 0
                ? 'V'
                : auditState == 1
                    ? 'M'
                    : auditState == 2
                        ? 'P'
                        : '');
        getFreqUsedDefectsByParamswithChkType(
            context,
            unitCode,
            'IA',
            userN,
            auditState == 0
                ? 'V'
                : auditState == 1
                    ? 'M'
                    : auditState == 2
                        ? 'P'
                        : '');
      }
      dismissProgress();
      isFavLoading = false;
      notifyListeners();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
      showErrorAlert(errorMessage ?? "Exception");
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
    String auditType = 'IA';

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
        getAllDefectswithFreqUsedDefectsByParamswithChkType(
            context,
            unitCode,
            'IA',
            userN,
            auditState == 0
                ? 'V'
                : auditState == 1
                    ? 'M'
                    : auditState == 2
                        ? 'P'
                        : '');
        getFreqUsedDefectsByParamswithChkType(
            context,
            unitCode,
            'IA',
            userN,
            auditState == 0
                ? 'V'
                : auditState == 1
                    ? 'M'
                    : auditState == 2
                        ? 'P'
                        : '');
      }
      dismissProgress();
      isFavLoading = false;
      notifyListeners();
    }, (errorMessage) {
      isFavLoading = false;
      notifyListeners();
      dismissProgress();
      // showErrorAlert(errorMessage.toString());
      saveFreqUsedDefects(
          context,
          defectCode,
          active,
          auditState == 0
              ? 'V'
              : auditState == 1
                  ? 'M'
                  : auditState == 2
                      ? 'P'
                      : '');
      isFavLoading = false;
      notifyListeners();
    });
  }

  GetAllDefectswithFreqUsedDefectsByParamsModel
      getAllDefectswithFreqUsedDefectsByParamswithChkTypeDetail =
      GetAllDefectswithFreqUsedDefectsByParamsModel();
  getAllDefectswithFreqUsedDefectsByParamswithChkType(
    context,
    String unitcode,
    String audittype,
    String username,
    String chktype,
  ) async {
    String languagecode =
        await SharedPreferenceHelper.getString(Constants.currentLang);
    isFavLoading = true;
    notifyListeners();

    getAllDefectswithFreqUsedDefectsByParamswithChkTypeDetail =
        GetAllDefectswithFreqUsedDefectsByParamsModel();
    notifyListeners();
    _useCase.getAllDefectswithFreqUsedDefectsByParamsData(unitcode, audittype,
        username, languagecode == "" ? "EN" : languagecode, chktype, (data) {
      getAllDefectswithFreqUsedDefectsByParamswithChkTypeDetail = data;
      defectCalculation();
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

  GetFreqUsedDefectsByParamsModel getFreqUsedDefectsByParamswithChkTypeDetail =
      GetFreqUsedDefectsByParamsModel();

  getFreqUsedDefectsByParamswithChkType(
    context,
    String unitcode,
    String audittype,
    String username,
    String chktype,
  ) async {
    String languagecode =
        await SharedPreferenceHelper.getString(Constants.currentLang);
    isFavLoading = true;
    notifyListeners();

    getFreqUsedDefectsByParamswithChkTypeDetail =
        GetFreqUsedDefectsByParamsModel();
    notifyListeners();
    _useCase.getFreqUsedDefectsByParamswithChkType(unitcode, audittype,
        username, languagecode == "" ? "EN" : languagecode, chktype, (data) {
      getFreqUsedDefectsByParamswithChkTypeDetail = data;
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

  GetAuditQCFrequentUsedOperationsandPartschecktypeResponseModal
      getLineQCFrequentUsedOperationsandPartsModel =
      GetAuditQCFrequentUsedOperationsandPartschecktypeResponseModal();
  String currentoperationName = '';

  getLineQCFrequentUsedOperationsandPartsData(
    context,
    String unitcode,
    String Rencentdays,
    String audittype,
    String checkername,
    String orderno,
    String checktype,
  ) {
    isFavLoading = true;
    notifyListeners();
    getLineQCFrequentUsedOperationsandPartsModel =
        GetAuditQCFrequentUsedOperationsandPartschecktypeResponseModal();
    notifyListeners();
    _useCase.getLineQCFrequentUsedOperationsandPartsDatas(
        unitcode, Rencentdays, audittype, checkername, orderno, checktype,
        (data) {
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

  Future<void> uploadImage() async {
    String fileName = basename(apiImage!.path);
    String token = await SharedPreferenceHelper.getString(Constants.tokenData);
    String qamCode = await SharedPreferenceHelper.getString(Constants.qamCode);
    String entityCode =
        await SharedPreferenceHelper.getString(Constants.entityCode);
    print("file base name:$fileName");

    try {
      // dioCli.FormData formData = dioCli.FormData.fromMap({
      //   "appCode": qamCode,
      //   "entityCode": entityCode,
      //   "appEndpoints": "UploadImage/UploadAuditFileList",
      //   "bodyContent": {
      //     "files": await dioCli.MultipartFile.fromFile(apiImage!.path,
      //         filename: fileName),
      //   }
      // });
      dioCli.FormData formData = dioCli.FormData.fromMap({
        "files": await dioCli.MultipartFile.fromFile(apiImage!.path,
            filename: fileName),
      });

      print(formData);

      // dioCli.Response response = await dioCli.Dio().post(
      //     "${ApiConstants.baseUrl}Apps/Post",
      //     data: formData,
      //     options: dioCli.Options(headers: {"Authorization": token}));
      dioCli.Response response = await dioCli.Dio().post(
          "http://172.16.9.241:5007/QAM/UploadImage/UploadLineQCFileList",
          data: formData,
          options: dioCli.Options(headers: {"Authorization": token}));
      print("File upload response: $response");
    } catch (e) {
      print("expectation Caugch: $e");
    }
  }

  UploadImageResponseModel uploadImageResponse = UploadImageResponseModel();

  postImageUpload(BuildContext context, String fName, String packAttach) async {
    showProgress(context);
    uploadImageResponse = UploadImageResponseModel();
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');

    notifyListeners();
    _useCase.postImageUploadData(
        UploadImageModel(uploadBase64Datacollection: [
          UploadBase64Datacollection(
              fName: fName,
              packAttach: packAttach,
              auditType: 'IA',
              insType: styleAuditData.insType,
              factoryCode: unitCode,
              defectName: selectDefect.isNotEmpty ? selectDefect[0] : 'NA')
        ]), (data) {
      uploadImageResponse = data;

      List<AuditImagesEntityModels> auditImagesEntityModels = [];
      auditImagesEntityModels.add(AuditImagesEntityModels(
          createdDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          createdBy: userN,
          modifiedDate:
              "${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z",
          modifiedBy: userN,
          isActive: true,
          id: 0,
          adDetlID: 0,
          fName: uploadImageResponse.data?[0].filename ?? '',
          filePath: uploadImageResponse.data?[0].filepath ?? '',
          hostName: auditState == 0
              ? 'V'
              : auditState == 1
                  ? 'M'
                  : auditState == 2
                      ? 'P'
                      : '',
          packAttach: ''));

      saveAuditData
          .auditQcDetlModels?[
              (saveAuditData.auditQcDetlModels ?? []).length - 1]
          .auditImagesEntityModels = auditImagesEntityModels;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetOperCodeByPartIdModel getOperCodeByPartIdDetail =
      GetOperCodeByPartIdModel();
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

  IscheckAuidtExistsModel.IscheckAuidtExistsModel IscheckAuidtExistsData =
      IscheckAuidtExistsModel.IscheckAuidtExistsModel();
  IscheckAuidtExistsAPI(
    context,
    String unitcode,
    String auditdate,
    String audittype,
    String instype,
    int orderno,
    int orderqty,
    String auditorname,
  ) {
    IscheckAuidtExistsData = IscheckAuidtExistsModel.IscheckAuidtExistsModel();
    visCom = false;
    mesCom = false;
    packCom = false;
    auditStateData = [
      {
        'auditType': "Visual",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
      },
      {
        'auditType': "Measurements",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
      },
      {
        'auditType': "Pack",
        "total": "0",
        "failCount": "0",
        "passCount": "0",
        "comment": "",
        "size": "0",
      },
    ];

    notifyListeners();
    _useCase.IscheckAuidtExistsAPI(
        unitcode, auditdate, audittype, instype, orderno, orderqty, auditorname,
        (data) async {
      IscheckAuidtExistsData = data;
      GetAuditHeadDataByIdAPI(context, IscheckAuidtExistsData.data?.id ?? 0);
      GetAuditHeadDataByIdNewAPI(context, IscheckAuidtExistsData.data?.id ?? 0);
      if (IscheckAuidtExistsData.isSuccess ?? false) {
        enableRound = true;
        if (auditState == 2) {
          cartonRound = true;
          notifyListeners();
        }
        if (auditState != 2) {
          baseRound = true;
          notifyListeners();
        }
        saveAuditData.packQty = IscheckAuidtExistsData.data?.packQty ?? 0;
        packQty.text = ((IscheckAuidtExistsData.data?.packQty ?? 0).toString());
        packQtyChange((IscheckAuidtExistsData.data?.packQty ?? 0).toString());

        if (auditState == 0) {
          sampleSize.text =
              (IscheckAuidtExistsData.data?.sampleSize ?? '').toString();
        }
        if (auditState == 1) {
          sampleSize.text =
              (IscheckAuidtExistsData.data?.measurementPcs ?? '').toString();
        }
        if (auditState == 2) {
          sampleSize.text =
              (IscheckAuidtExistsData.data?.packCtns ?? '').toString();
        }
        auditStateData = [
          {
            'auditType': "Visual",
            "total": "0",
            "failCount": "0",
            "passCount": "0",
            "comment": "",
            "size": "0",
          },
          {
            'auditType': "Measurements",
            "total": "0",
            "failCount": "0",
            "passCount": "0",
            "comment": "",
            "size": "0",
          },
          {
            'auditType': "Pack",
            "total": "0",
            "failCount": "0",
            "passCount": "0",
            "comment": "",
            "size": "0",
          },
        ];

        auditStateData = [
          {
            'auditType': "Visual",
            "total":
                IscheckAuidtExistsData.data?.vInspectedPcs.toString() ?? '0',
            "failCount": ((IscheckAuidtExistsData.data?.vInspectedPcs ?? 0) -
                    (IscheckAuidtExistsData.data?.visualPassPcs ?? 0))
                .toString(),
            "passCount":
                IscheckAuidtExistsData.data?.visualPassPcs.toString() ?? '0',
            "comment": "",
            "size": IscheckAuidtExistsData.data?.sampleSize.toString() ?? '0',
          },
          {
            'auditType': "Measurements",
            "total":
                IscheckAuidtExistsData.data?.mInspectedPcs.toString() ?? '0',
            "failCount": ((IscheckAuidtExistsData.data?.mInspectedPcs ?? 0) -
                    (IscheckAuidtExistsData.data?.measurementPassPcs ?? 0))
                .toString(),
            "passCount":
                IscheckAuidtExistsData.data?.measurementPassPcs.toString() ??
                    '0',
            "comment": "",
            "size":
                IscheckAuidtExistsData.data?.measurementPcs.toString() ?? '0',
          },
          {
            'auditType': "Pack",
            "total":
                IscheckAuidtExistsData.data?.pInspectedPcs.toString() ?? '0',
            "failCount": ((IscheckAuidtExistsData.data?.pInspectedPcs ?? 0) -
                    (IscheckAuidtExistsData.data?.packPassed ?? 0))
                .toString(),
            "passCount":
                IscheckAuidtExistsData.data?.packPassed.toString() ?? '0',
            "comment": "",
            "size": IscheckAuidtExistsData.data?.packCtns.toString() ?? '0',
          },
        ];
      }

      DateTime dateToday = DateTime.now();
      String currentDate = dateToday.toString().substring(0, 10);
      String userN =
          await SharedPreferenceHelper.getString(Constants.userDisplayName);
      String unitCode = await SharedPreferenceHelper.getString('unitCode');

      auditStarted = false;

      saveAuditData.createdDate = IscheckAuidtExistsData.data?.createdDate;
      saveAuditData.createdBy = IscheckAuidtExistsData.data?.createdBy;
      saveAuditData.modifiedDate = currentDate;
      saveAuditData.modifiedBy = "";
      saveAuditData.isActive = true;
      saveAuditData.id = IscheckAuidtExistsData.data?.id;
      saveAuditData.entityID = IscheckAuidtExistsData.data?.entityID;
      saveAuditData.auditType = IscheckAuidtExistsData.data?.auditType;
      saveAuditData.insType = IscheckAuidtExistsData.data?.insType;
      saveAuditData.auditDate = IscheckAuidtExistsData.data?.auditDate;

      saveAuditData.unitCode = IscheckAuidtExistsData.data?.unitCode;
      saveAuditData.floorName = IscheckAuidtExistsData.data?.floorName;
      saveAuditData.sewLine = IscheckAuidtExistsData.data?.sewLine;
      saveAuditData.buyerCode = IscheckAuidtExistsData.data?.buyerCode;
      saveAuditData.styleNo = IscheckAuidtExistsData.data?.styleNo;
      saveAuditData.orderNo = IscheckAuidtExistsData.data?.orderNo;

      saveAuditData.orderQty = IscheckAuidtExistsData.data?.orderQty;
      saveAuditData.packQty = IscheckAuidtExistsData.data?.packQty;
      // saveAuditData.partCode = IscheckAuidtExistsData.data?.partCode;
      // saveAuditData.operationCode = IscheckAuidtExistsData.data?.operationCode;
      saveAuditData.sampleSize = IscheckAuidtExistsData.data?.sampleSize;
      saveAuditData.measurementPcs =
          IscheckAuidtExistsData.data?.measurementPcs;
      saveAuditData.packCtns = IscheckAuidtExistsData.data?.packCtns;
      saveAuditData.visualPassPcs = IscheckAuidtExistsData.data?.visualPassPcs;
      saveAuditData.measurementPassPcs =
          IscheckAuidtExistsData.data?.measurementPassPcs;
      saveAuditData.packPassed = IscheckAuidtExistsData.data?.packPassed;
      saveAuditData.visualResult = IscheckAuidtExistsData.data?.visualResult;
      saveAuditData.measurementResult =
          IscheckAuidtExistsData.data?.measurementResult;
      saveAuditData.caaResult = IscheckAuidtExistsData.data?.caaResult;
      saveAuditData.finalResult = IscheckAuidtExistsData.data?.finalResult;
      saveAuditData.auditCount = IscheckAuidtExistsData.data?.auditCount;
      saveAuditData.aqlType = IscheckAuidtExistsData.data?.aqlType;
      // saveAuditData.aqlBase = "AQL1.5";
      saveAuditData.auditorName = userN;
      saveAuditData.resubmissionDate = currentDate;
      saveAuditData.hostName = "";
      saveAuditData.inspectedPcs = IscheckAuidtExistsData.data?.inspectedPcs;
      saveAuditData.vInspectedPcs = IscheckAuidtExistsData.data?.vInspectedPcs;
      saveAuditData.mInspectedPcs = IscheckAuidtExistsData.data?.mInspectedPcs;
      saveAuditData.pInspectedPcs = IscheckAuidtExistsData.data?.pInspectedPcs;
      saveAuditData.auditQcDetlModels = [];
      saveAuditData.auditPoDetlModels = [];
      sessionCompletionTester();
      // List datas = (styleAudit.buyerpono ?? '').toString().split(',');

      // List buyerPoNo = [];

      // for (int i = 0; i < datas.length; i++) {
      //   var dat = datas[i].toString().split('-');
      //   buyerPoNo.add(dat[0].trim());
      // }

      // List buyerPoSlno = [];

      // for (int i = 0; i < datas.length; i++) {
      //   var dat = datas[i].toString().split('-');
      //   buyerPoSlno.add(int.parse(dat[1].trim()));
      // }

      // for (int i = 0; i < buyerPoNo.length; i++) {
      //   List<AuditPoDetlModels> auditPoDetlModels = [];
      //   auditPoDetlModels.add(AuditPoDetlModels(
      //     createdDate:
      //         '${DateTime.now().toString().replaceAll(" ", "T").substring(0, DateTime.now().toString().length - 3)}Z',
      //     createdBy: userN,
      //     modifiedDate: null,
      //     modifiedBy: null,
      //     adHeadID: 0,
      //     buyerPoNo: buyerPoNo[i],
      //     buyerPoSlno: buyerPoSlno[i],
      //     color: (styleAudit.color ?? []).isNotEmpty
      //         ? ((styleAudit.color ?? [])[0].color)
      //         : '',
      //     hostName: '',
      //     id: 0,
      //     isActive: true,
      //     orderNo: styleAudit.orderno,
      //     orderQty: styleAudit.orderQty,
      //   ));

      //   saveAuditData.auditPoDetlModels = auditPoDetlModels;
      // }
      // notifyListeners();

      notifyListeners();
      // dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetDefectsByCategoryModel getDefectsByCategoryDetail =
      GetDefectsByCategoryModel();

  GetDefectsByCategoryAPI(context, String category) {
    getDefectsByCategoryDetail = GetDefectsByCategoryModel();
    notifyListeners();
    _useCase.GetDefectsByCategoryAPI(category, (data) {
      getDefectsByCategoryDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetDsheadByParamModel GetDsheadByParamData = GetDsheadByParamModel();
  var GetDsheadByParamDataItem;
  List<String> options = [];
  Rx<List<String>> selectedOptionList = Rx<List<String>>([]);
  var selectedOption = ''.obs;

  GetDsheadByParamAPI(context, unitcode, audittype, orderno) {
    GetDsheadByParamData = GetDsheadByParamModel();
    options = [];
    notifyListeners();
    _useCase.GetDsheadByParamAPI(unitcode, audittype, orderno, (data) {
      GetDsheadByParamData = data;
      GetDsheadByParamDataItem = (GetDsheadByParamData.data ?? [])
          .map((data) => MultiSelectItem<GetDsheadByParamModelData>(data,
              '${data.dcpoSlNo} || ${data.buyerDCPoNo}  || ${data.buyDcPoQty}'))
          .toList();
      options = [];

      for (int i = 0; i < (GetDsheadByParamData.data ?? []).length; i++) {
        // options.add((GetDsheadByParamData.data ?? [])[i].buyDcPoQty.toString());
        options.add(
            '${(GetDsheadByParamData.data ?? [])[i].dcpoSlNo} || ${(GetDsheadByParamData.data ?? [])[i].buyerDCPoNo} || ${(GetDsheadByParamData.data ?? [])[i].buyDcPoQty}');
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert('PO' + errorMessage);
      dismissProgress();
    });
  }

  void poOptionOnChange(List<String> value, InlineViewModal inlineViewModal) {
    selectedOptionList.value = value;
    selectedOption.value = "";
    for (var element in selectedOptionList.value) {
      selectedOption.value = "${selectedOption.value} $element";
    }

    inlineViewModal.saveOrderScheduleRequestData.orderQty = 0;
    inlineViewModal.saveOrderScheduleRequestData.orderScheduleDetlModels = [];
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    for (int i = 0; i < value.length; i++) {
      inlineViewModal.saveOrderScheduleRequestData.orderQty = int.parse(
              value[i].split(' || ')[2]) +
          int.parse(
              inlineViewModal.saveOrderScheduleRequestData.orderQty.toString());
      String dcpoSlNo = value[i].split(' || ')[0];
      String buyerDCPoNo = value[i].split(' || ')[1];
      String buyDcPoQty = value[i].split(' || ')[2];

      (inlineViewModal.saveOrderScheduleRequestData.orderScheduleDetlModels ??
              [])
          .add(OrderScheduleDetlModels(
              createdDate: currentDate,
              createdBy: '',
              modifiedDate: currentDate,
              modifiedBy: '',
              isActive: true,
              id: 0,
              orderSchID: 0,
              orderNo: inlineViewModal.saveOrderScheduleRequestData.orderNo,
              buyerPoNo: buyerDCPoNo,
              buyerPoSlno: int.parse(dcpoSlNo),
              orderQty: int.parse(buyDcPoQty),
              hostname: '',
              cancel: 'N'));
    }
    inspect(
        inlineViewModal.saveOrderScheduleRequestData.orderScheduleDetlModels);
    notifyListeners();
  }

  GetUDMasterByTypeModel GetUDMasterByTypeData = GetUDMasterByTypeModel();
  GetUDMasterByTypeAPI(
    context,
    type,
  ) {
    GetUDMasterByTypeData = GetUDMasterByTypeModel();
    notifyListeners();
    _useCase.GetUDMasterByTypeAPI(type, (data) {
      GetUDMasterByTypeData = data;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  bool isDefectSummaryList = false;

  void setisDefectSummaryList() {
    isDefectSummaryList = !isDefectSummaryList;
    notifyListeners();
  }

  GetAuditHeadDataByIdNewModel GetAuditHeadDataByIdNewData =
      GetAuditHeadDataByIdNewModel();

  List<AuditImagesEntityModelsNew> auditImagesEntityModelsNew = [];

  var statusReportPieDataVisual = <String, double>{
    "Inspected": 0,
    "Defective": 0,
  };

  var statusReportPieDataMeasurement = <String, double>{
    "Inspected": 0,
    "Defective": 0,
  };
  var statusReportPieDataPack = <String, double>{
    "Inspected": 0,
    "Defective": 0,
  };

  int vCritical = 0;
  int mCritical = 0;
  int pCritical = 0;

  int vMajor = 0;
  int mMajor = 0;
  int pMajor = 0;

  int vMinor = 0;
  int mMinor = 0;
  int pMinor = 0;

  GetAuditHeadDataByIdNewAPI(
    context,
    auditheadid,
  ) {
    GetAuditHeadDataByIdNewData = GetAuditHeadDataByIdNewModel();
    auditImagesEntityModelsNew = [];
    vCritical = 0;
    mCritical = 0;
    pCritical = 0;

    vMajor = 0;
    mMajor = 0;
    pMajor = 0;

    vMinor = 0;
    mMinor = 0;
    pMinor = 0;

    notifyListeners();
    _useCase.GetAuditHeadDataByIdNewAPI(auditheadid, (data) {
      GetAuditHeadDataByIdNewData = data;

      statusReportPieDataVisual = <String, double>{
        "Inspected": double.parse(
            (GetAuditHeadDataByIdNewData.data?.vInspectedPcs ?? 0).toString()),
        "Defective": double.parse(
            ((GetAuditHeadDataByIdNewData.data?.vInspectedPcs ?? 0) -
                            (GetAuditHeadDataByIdNewData.data?.visualPassPcs ??
                                0) ==
                        (GetAuditHeadDataByIdNewData.data?.vInspectedPcs ?? 0)
                    ? 0
                    : (GetAuditHeadDataByIdNewData.data?.vInspectedPcs ?? 0) -
                        (GetAuditHeadDataByIdNewData.data?.visualPassPcs ?? 0))
                .toString()),
      };

      statusReportPieDataMeasurement = <String, double>{
        "Inspected": double.parse(
            (GetAuditHeadDataByIdNewData.data?.mInspectedPcs ?? 0).toString()),
        "Defective": double.parse(((GetAuditHeadDataByIdNewData
                                .data?.mInspectedPcs ??
                            0) -
                        (GetAuditHeadDataByIdNewData.data?.measurementPassPcs ??
                            0) ==
                    (GetAuditHeadDataByIdNewData.data?.mInspectedPcs ?? 0)
                ? 0
                : (GetAuditHeadDataByIdNewData.data?.mInspectedPcs ?? 0) -
                    (GetAuditHeadDataByIdNewData.data?.measurementPassPcs ?? 0))
            .toString()),
      };

      statusReportPieDataPack = <String, double>{
        "Inspected": double.parse(
            (GetAuditHeadDataByIdNewData.data?.pInspectedPcs ?? 0).toString()),
        "Defective": double.parse(
            ((GetAuditHeadDataByIdNewData.data?.pInspectedPcs ?? 0) -
                            (GetAuditHeadDataByIdNewData.data?.packPassed ??
                                0) ==
                        (GetAuditHeadDataByIdNewData.data?.pInspectedPcs ?? 0)
                    ? 0
                    : (GetAuditHeadDataByIdNewData.data?.pInspectedPcs ?? 0) -
                        (GetAuditHeadDataByIdNewData.data?.packPassed ?? 0))
                .toString()),
      };

      for (int i = 0;
          i <
              (GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])
                  .length;
          i++) {
        if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                .chkType ==
            'V') {
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .critical !=
              0) {
            vCritical = vCritical + 1;
          }
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .major !=
              0) {
            vMajor = vMajor + 1;
          }
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .minor !=
              0) {
            vMinor = vMinor + 1;
          }
        }

        if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                .chkType ==
            'M') {
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .critical !=
              0) {
            mCritical = mCritical + 1;
          }
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .major !=
              0) {
            mMajor = mMajor + 1;
          }
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .minor !=
              0) {
            mMinor = mMinor + 1;
          }
        }

        if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                .chkType ==
            'P') {
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .critical !=
              0) {
            pCritical = pCritical + 1;
          }
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .major !=
              0) {
            pMajor = pMajor + 1;
          }
          if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .minor !=
              0) {
            pMinor = pMinor + 1;
          }
        }

        if (((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                    .auditImagesEntityModels ??
                [])
            .isNotEmpty) {
          auditImagesEntityModelsNew.add(
              ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                      .auditImagesEntityModels ??
                  [])[0]);
        }
      }
      getAqlBaseInfoBaseForAuditStatusReport(context);
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getAqlBaseInfoBaseForAuditStatusReport(context) async {
    if (auditState == 2) {
      getAqlBaseInfo(context, true, false);
    } else {
      getAqlBaseInfo(context, false, true);
    }
  }

  int currentReportScreen = 1;
  void setCurrentReportScreen(int screen) {
    currentReportScreen = screen;
    notifyListeners();
  }

  bool isReportScreen = false;
  void setIsReportScreen() async {
    isReportScreen = !isReportScreen;
    isStatusReportScreen = false;
    isDefectSummaryList = false;
    isDeleteSelected = false;
    currentReportScreen = 1;

    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);

    if ((IscheckAuidtExistsData.data?.id ?? 0) == 0) {
      IscheckAuidtExistsAPI(
          context,
          unitCode,
          currentDate,
          'IA',
          styleAuditData.insType ?? '',
          styleAuditData.orderno ?? 0,
          styleAuditData.orderQty ?? 0,
          userN);
    }
    if ((IscheckAuidtExistsData.data?.id ?? 0) != 0) {
      GetAuditHeadDataByIdNewAPI(context, IscheckAuidtExistsData.data?.id ?? 0);
    }

    notifyListeners();
  }

  GetAuditHeadDataByIdModel GetAuditHeadDataByIdData =
      GetAuditHeadDataByIdModel();
  GetAuditHeadDataByIdAPI(context, int auditheadid) {
    GetAuditHeadDataByIdData = GetAuditHeadDataByIdModel();
    notifyListeners();
    _useCase.GetAuditHeadDataByIdAPI(auditheadid, (data) {
      GetAuditHeadDataByIdData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  bool isStatusReportScreen = false;
  void setIsStatusReportScreen() async {
    isStatusReportScreen = !isStatusReportScreen;
    isDefectSummaryList = false;
    isReportScreen = false;
    currentReportScreen = 1;
    currentChkType = '';
    notifyListeners();

    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);

    if ((IscheckAuidtExistsData.data?.id ?? 0) == 0) {
      IscheckAuidtExistsAPI(
          context,
          unitCode,
          currentDate,
          'IA',
          styleAuditData.insType ?? '',
          styleAuditData.orderno ?? 0,
          styleAuditData.orderQty ?? 0,
          userN);
    }
    if ((IscheckAuidtExistsData.data?.id ?? 0) != 0) {
      GetAuditHeadDataByIdNewAPI(context, IscheckAuidtExistsData.data?.id ?? 0);
    }
    notifyListeners();
  }

  String? currentChkType = '';
  chkTypeSetter(String chkType) {
    currentChkType = chkType;
    if (chkType == 'V') {}
    notifyListeners();
  }

  GetAllGarOperationMasterModel sleevesAttachmentData2 =
      GetAllGarOperationMasterModel();
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

  GetAllGarPartDataModel sleevesData = GetAllGarPartDataModel();
  getSleeves(context, languagecode, productType) {
    sleevesData = GetAllGarPartDataModel();
    sleevesAttachmentData = GetAllGarOperationMasterModel();
    notifyListeners();
    _useCase.getSleevesData(languagecode, productType, (data) {
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
    saveAuditData.partCode = "";
    saveAuditData.operationCode = "NA";
    getSleeves(context, lan.isEmpty ? 'EN' : lan, styleAuditData.productType);
  }

  bool isDeleteSelected = false;
  void setDefectSelection(int index) {
    (GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[index]
            .isSelected =
        !((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[index]
                .isSelected ??
            false);
    isDeleteSelected = false;

    for (int i = 0;
        i < (GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? []).length;
        i++) {
      if ((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
              .isSelected ??
          false) {
        isDeleteSelected = true;
      }
    }
    notifyListeners();
  }

  RemoveAuditQcDetlResponse removeAuditQcDetlResponse =
      RemoveAuditQcDetlResponse();
  RemoveAuditQcDetlResponseAPI(context, item) {
    removeAuditQcDetlResponse = RemoveAuditQcDetlResponse();
    notifyListeners();
    _useCase.RemoveAuditQcDetlResponseAPI(item, (data) async {
      removeAuditQcDetlResponse = data;

      String userN =
          await SharedPreferenceHelper.getString(Constants.userDisplayName);
      String unitCode = await SharedPreferenceHelper.getString('unitCode');
      DateTime dateToday = DateTime.now();
      String currentDate = dateToday.toString().substring(0, 10);

      if ((IscheckAuidtExistsData.data?.id ?? 0) == 0) {
        IscheckAuidtExistsAPI(
            context,
            unitCode,
            currentDate,
            'IA',
            styleAuditData.insType ?? '',
            styleAuditData.orderno ?? 0,
            styleAuditData.orderQty ?? 0,
            userN);
      }
      if ((IscheckAuidtExistsData.data?.id ?? 0) != 0) {
        GetAuditHeadDataByIdNewAPI(
            context, IscheckAuidtExistsData.data?.id ?? 0);
      }

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(
          removeAuditQcDetlResponse.message ?? 'Something went wrong');
      dismissProgress();
    });
  }

  List<int> selectedDefectID = [];
  void deleteDefects(BuildContext context) {
    selectedDefectID = [];

    for (int i = 0;
        i < (GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? []).length;
        i++) {
      if (((GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i]
                  .isSelected ??
              false) ==
          true) {
        selectedDefectID.add(
            (GetAuditHeadDataByIdNewData.data?.auditQcDetlModels ?? [])[i].id ??
                0);
      }
    }
    print(selectedDefectID);
    RemoveAuditQcDetlResponseAPI(context, selectedDefectID);
  }
}
