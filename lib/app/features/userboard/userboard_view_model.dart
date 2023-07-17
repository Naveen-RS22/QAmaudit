import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';

import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByCountModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectCodeByTagIdModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectLevelListModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCDefectLevelReportModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectCountEntrypartModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectCountModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectbypartsModel.dart';
import 'package:qapp/app/data/network/dto/GetQcWidgetInfoModel.dart';
import 'package:qapp/app/data/network/dto/TimeSpendModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/userboard/userboard_use_case.dart';
import 'package:qapp/app/features/userboard/widgets/final_audit_card.dart';

import 'package:qapp/app/utils/code_snippet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/shared_prefs_helper.dart';
import '../../res/constants.dart';

class UserboardViewModel extends BaseViewModel {
  final UserboardUseCase _useCase = AppManager.instance.userboardUseCase();
  final pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  AuditSummaryModel auditSummary = AuditSummaryModel();
  TimeSpentModel timeSpent = TimeSpentModel();
  DefectPartModel defectPart = DefectPartModel();
  ScheduleModel scheduleList = ScheduleModel();

  FinalAuditModel finalAudit = FinalAuditModel();
  FinalAuditModel finalAuditPri = FinalAuditModel();
  FinalAuditModel finalAuditSec = FinalAuditModel();
  GetQcWidgetInfoModel getQcData = GetQcWidgetInfoModel();
  GetLineQcdefectCountModel getLineQcDefect = GetLineQcdefectCountModel();
  GetDsListModel getDsData = GetDsListModel();
  GetDefectLevelListModel getDefectLevel = GetDefectLevelListModel();
  List<DefectFinalAudit> listData = [];
  GetDefectCodeByTagIdModel getDefectCode = GetDefectCodeByTagIdModel();
  GetAuidtDefectByCountModel getAuidtDefectByCountDetail =
      GetAuidtDefectByCountModel();
  GetLineQcdefectbypartsModel getLineQcdefectbypartsDetail =
      GetLineQcdefectbypartsModel();
  GetLineQcdefectCountModel getDefectCount = GetLineQcdefectCountModel();
  GetLineQcdefectCountEntrypartModel getDefectCountEntry =
      GetLineQcdefectCountEntrypartModel();
  GetLineQCDefectLevelReportModel getLineQCDefectLevelReportData =
      GetLineQCDefectLevelReportModel();

  String finalAuditRound = "IL";
  bool isFirst = false;
  String currentDates = "";
  final datetime = DateTime.now();

  bool styleInfoExpanded = false;

  void setStyleInfoExpanded() {
    styleInfoExpanded = !styleInfoExpanded;
    notifyListeners();
  }

  void finalAuditRoundOnChange(context, String round) async {
    finalAuditRound = round;
    notifyListeners();
    onGetAuditSummary(context);
  }

  void onGetAuditSummary(BuildContext context) async {
    isFirst = true;
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    currentDates = currentDate;
    String times = "${dateToday.hour}:${dateToday.minute}:${dateToday.second}";
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);

    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    clearData();
    // timeChecker(context);
    getDefectLevelList(context, unitCode, finalAuditRound, currentDate);
    getSchduleList(context, unitCode, currentDate);
    getLineQcdefectbyparts(
        context, unitCode, currentDate, finalAuditRound, userN);
    getLineQcdefectCount(
        context, unitCode, currentDate, finalAuditRound, userN);
    getLineQCDefectLevelReportAPI(
        context, unitCode, finalAuditRound, currentDate, userN);
    getQcWidgetInfo(context, unitCode, currentDate, finalAuditRound, times);
    dismissProgress();
  }

  void onGetAuditSummaryForStyleInfo(BuildContext context) async {
    isFirst = true;
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    currentDates = currentDate;
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    clearData();
    getSchduleList(context, unitCode, currentDate);
    dismissProgress();
  }

  void logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, Constants.onBoardingRoute, (Route<dynamic> route) => false);
  }

  void refreshData(BuildContext context) async {
    // String currentDate = DateFormat('yMd').format(datetime);
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String times = "${dateToday.hour}:${dateToday.minute}:${dateToday.second}";
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    clearData();
    getQcWidgetInfo(context, unitCode, currentDate, finalAuditRound, times);
    getDefectLevelList(context, unitCode, finalAuditRound, currentDate);
    getSchduleList(context, unitCode, currentDate);
    getLineQcdefectbyparts(
        context, unitCode, currentDate, finalAuditRound, userN);
    getLineQcdefectCount(
        context, unitCode, currentDate, finalAuditRound, userN);
    getLineQCDefectLevelReportAPI(
        context, unitCode, finalAuditRound, currentDate, userN);
    // getDefectPart(context, unitCode, currentDate);
    notifyListeners();
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferenceHelper.prefs;
        prefs.clear();
        Navigator.pushNamedAndRemoveUntil(context, Constants.onBoardingRoute,
            (Route<dynamic> route) => false);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Session Expired"),
      content: const Text(
          "Your current session timeout. Continue login with session"),
      actions: [
        okButton,
      ],
    );
  }

  getAuidtDefectByCount(
    context,
    unitCode,
    String currentDate,
    String finalAuditRound,
  ) {
    getAuidtDefectByCountDetail = GetAuidtDefectByCountModel();
    notifyListeners();
    _useCase.getAuidtDefectByCountData(unitCode, currentDate, finalAuditRound,
        (data) {
      getAuidtDefectByCountDetail = data;
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
      notifyListeners();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getSchduleList(context, String unitCode, String currentDate) {
    scheduleList = ScheduleModel();
    notifyListeners();
    _useCase.getScheduleList(unitCode, currentDate, (data) {
      scheduleList = data;

      if (finalAuditRound == "FG") {
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
          if (newList[i].auditType == finalAuditRound) {
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

  getDefectPart(context, String unitCode, String currentDate) {
    defectPart = DefectPartModel();
    notifyListeners();
    _useCase.getDefectpart(unitCode, currentDate, (data) {
      defectPart = data;
      notifyListeners();
      dismissProgress();
      notifyListeners();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getQcWidgetInfo(
    context,
    unitCode,
    currentDate,
    finalAuditRound,
    timeStamp,
  ) {
    getQcData = GetQcWidgetInfoModel();
    notifyListeners();
    _useCase.getQcWidgetInfos(unitCode, currentDate, finalAuditRound, timeStamp,
        (data) {
      getQcData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      // showErrorAlert(errorMessage.toString());
      dismissProgress();
    });
  }

  getDefectLevelList(
    context,
    unitCode,
    String audittype,
    String currentDate,
  ) {
    notifyListeners();
    getDefectLevel = GetDefectLevelListModel();
    notifyListeners();
    _useCase.getDefectLevelLists(unitCode, audittype, currentDate, (data) {
      getDefectLevel = data;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getLineQcdefectbyparts(context, String unitCode, String currentDate,
      String finalAuditRound, String checkername) {
    getLineQcdefectbypartsDetail = GetLineQcdefectbypartsModel();
    notifyListeners();
    _useCase.getLineQcdefectbypartsData(
        unitCode, currentDate, finalAuditRound, checkername, (data) {
      getLineQcdefectbypartsDetail = data;
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
      notifyListeners();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getLineQcdefectCount(
    context,
    String unitCode,
    String auditDate,
    String audittype,
    String checkername,
  ) {
    getDefectCount = GetLineQcdefectCountModel();
    notifyListeners();
    _useCase.getLineQcdefectCounts(unitCode, auditDate, audittype, checkername,
        (data) {
      getDefectCount = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getLineQCDefectLevelReportAPI(
      context, unitCode, audittype, auditDate, checkername) {
    getLineQCDefectLevelReportData = GetLineQCDefectLevelReportModel();
    notifyListeners();
    _useCase.getLineQCDefectLevelReportAPIdata(
        unitCode, audittype, auditDate, checkername, (data) {
      getLineQCDefectLevelReportData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  void clearData() {
    getQcData = GetQcWidgetInfoModel();
    scheduleList = ScheduleModel();
    defectPart = DefectPartModel();
    getAuidtDefectByCountDetail = GetAuidtDefectByCountModel();
    getLineQcdefectbypartsDetail = GetLineQcdefectbypartsModel();
    getDefectCount = GetLineQcdefectCountModel();
    getDefectCountEntry = GetLineQcdefectCountEntrypartModel();
    getLineQCDefectLevelReportData = GetLineQCDefectLevelReportModel();
    getDefectLevel = GetDefectLevelListModel();
    listData = [];
  }

  void showErrorAlert(String message) {
    CodeSnippet.instance.showAlertMsg(message);
  }

  void timeChecker(context) {
    Timer.periodic(const Duration(seconds: 0), ((Timer timer) {
      functionBack(context);
    }));
  }

  functionBack(context) async {
    String time = await SharedPreferenceHelper.getString("time");
    String curTime = DateTime.now().toString();
    DateTime prevTime = DateTime.parse(time.isEmpty ? curTime : time);
    DateTime currentTime = DateTime.parse(curTime);
    Duration diff = currentTime.difference(prevTime);
    if (diff.inMinutes > 180) {
      showErrorAlert('Session timeout');
      logoutUser(context);
      return;
    }
  }

  bool isDashScreen = true;
  bool isStyleInfoScreen = false;

  setIsDashboardScreen(BuildContext context) {
    isDashScreen = !isDashScreen;
    isStyleInfoScreen = false;
    if (isDashScreen) {
      onGetAuditSummaryForStyleInfo(context);
    } else {
      onGetAuditSummary(context);
    }
    print(isDashScreen);
    notifyListeners();
  }

  setisStyleInfoScreen(BuildContext context) {
    isStyleInfoScreen = true;
    isDashScreen = false;
    onGetAuditSummaryForStyleInfo(context);
    notifyListeners();
  }

  void resetDashBoardScreen() {
    isDashScreen = true;
    isStyleInfoScreen = false;
    print(isDashScreen);
    notifyListeners();
  }

  void finalAuditRoundOnChangeStyleChange(context, String round) async {
    finalAuditRound = round;
    notifyListeners();
    onGetAuditSummaryForStyleInfo(context);
  }
}
