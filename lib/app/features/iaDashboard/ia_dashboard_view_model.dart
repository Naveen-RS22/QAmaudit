import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/GetAuditStyleDataModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByCountModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtSummarylistModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectTranslationMasterByLanguageCodeModel.dart';
import 'package:qapp/app/data/network/dto/GetIAAuditSummaryModel.dart';
import 'package:qapp/app/data/network/dto/TimeSpendModel.dart';
import 'package:qapp/app/data/network/dto/getIAAuditInfo.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_use_case.dart';

import 'package:qapp/app/utils/code_snippet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/shared_prefs_helper.dart';
import '../../res/constants.dart';

class IADashboardViewModel extends BaseViewModel {
  final IADashboardUseCase _useCase = AppManager.instance.iaDashboardUseCase();
  final pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  AuditSummaryModel auditSummary = AuditSummaryModel();
  TimeSpentModel timeSpent = TimeSpentModel();
  DefectPartModel defectPart = DefectPartModel();
  ScheduleModel scheduleList = ScheduleModel();

  FinalAuditModel finalAudit = FinalAuditModel();
  FinalAuditModel finalAuditPri = FinalAuditModel();
  FinalAuditModel finalAuditSec = FinalAuditModel();

  GetIAAuditInfo getAuditDetail = GetIAAuditInfo();
  GetAuidtDefectByCountModel getAuidtDefectByCountDetail =
      GetAuidtDefectByCountModel();

  GetAuidtDefectByPartsModel getAuidtDefectByPartsData =
      GetAuidtDefectByPartsModel();

  GetAuidtSummarylistModel getAuidtSummarylistData = GetAuidtSummarylistModel();

  GetIAAuditSummaryModel getAuditSummaryData = GetIAAuditSummaryModel();

  GetAuditStyleDataModel getAuditStyleDetail = GetAuditStyleDataModel();

  GetDefectTranslationMasterByLanguageCodeModel getDefectTranslation =
      GetDefectTranslationMasterByLanguageCodeModel();

  late Map<String?, List<AuditData>> filterList;
  List<Map<String, String>> filterKeyss = [
    {"id": "PR", "text": "Pilot"},
    {"id": "HP", "text": "100 Pcs"},
    {"id": "I", "text": "Interim"},
    {"id": "PF", "text": "Pre Final"},
    {"id": "F", "text": "Final"},
  ];
  String finalAuditRound = "PR";
  bool isFirst = false;

  final datetime = DateTime.now();

  bool styleInfoExpanded = false;
  void setStyleInfoExpanded() {
    styleInfoExpanded = !styleInfoExpanded;
    notifyListeners();
  }

  void finalAuditRoundOnChange(context, String round) async {
    DateTime dateToday = DateTime.now();
    String auditername =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    finalAuditRound = round;

    getAuidtSummarylist(context, unitCode, currentDate, round, auditername);
    notifyListeners();
  }

  void resetData() {
    finalAuditRound = "PR";
    auditSummary = AuditSummaryModel();
    timeSpent = TimeSpentModel();
    defectPart = DefectPartModel();
    scheduleList = ScheduleModel();

    finalAudit = FinalAuditModel();
    finalAuditPri = FinalAuditModel();
    finalAuditSec = FinalAuditModel();

    getAuditDetail = GetIAAuditInfo();
    getAuidtDefectByCountDetail = GetAuidtDefectByCountModel();

    getAuidtDefectByPartsData = GetAuidtDefectByPartsModel();

    getAuidtSummarylistData = GetAuidtSummarylistModel();

    getAuditSummaryData = GetIAAuditSummaryModel();

    getAuditStyleDetail = GetAuditStyleDataModel();

    notifyListeners();
  }

  void onGetAuditSummary(BuildContext context) async {
    String auditername =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    // showProgress(context);
    notifyListeners();
    // _useCase.loginUserApp((data) async {
    isFirst = true;
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    resetData();
    // timeChecker(context);

    getAuditStyle(context, unitCode, currentDate, auditername);
    // getAuditStyle(context, unitCode, '2023-01-26', auditername);
    getIAAudit(context, unitCode, currentDate, auditername);
    getAuidtDefectByCount(context, unitCode, currentDate, 'IA', auditername);
    getAuidtDefectByParts(context, unitCode, currentDate, 'IA', auditername);
    getAuidtSummarylist(context, unitCode, currentDate, "PR", auditername);
    getAuditSummarys(context, unitCode, currentDate, auditername);

    dismissProgress();
    notifyListeners();
    //_useCase.exceptionDialog(data.message);
    // }, (errorMessage) {
    //   dismissProgress();
    //   logoutUser(context);
    //   showErrorAlert("Your session timeout. Kindly login again");
    //   //showErrorAlert(errorMessage);
    //   showAlertDialog(context);
    // });
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
    String auditername =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    getAuditStyle(context, unitCode, currentDate, auditername);
    getIAAudit(context, unitCode, currentDate, auditername);
    getAuidtDefectByCount(context, unitCode, currentDate, 'IA', auditername);
    getAuidtDefectByParts(context, unitCode, currentDate, 'IA', auditername);
    getAuidtSummarylist(context, unitCode, currentDate, "PR", auditername);
    getAuditSummarys(context, unitCode, currentDate, auditername);
  }

  showAlertDialog(BuildContext context) {
    // Create button
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

  String getSystemTime() {
    DateTime dateToday = DateTime.now();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(dateToday.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('dd-MM-yyyy h:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  getIAAudit(context, String unitCode, String currentDate, String auditername) {
    getAuditDetail = GetIAAuditInfo();
    notifyListeners();
    _useCase.getIAAuditData(unitCode, currentDate, auditername, (data) {
      getAuditDetail = data;
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getAuditSummarys(
      context, String unitCode, String currentDate, String auditername) {
    getAuditSummaryData = GetIAAuditSummaryModel();
    notifyListeners();
    _useCase.getAuditSummarysData(unitCode, currentDate, auditername, (data) {
      getAuditSummaryData = data;
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getAuidtSummarylist(context, String unitCode, String currentDate,
      String Instype, String auditorname) {
    getAuidtSummarylistData = GetAuidtSummarylistModel();
    notifyListeners();
    _useCase.getAuidtSummarylistData(
        unitCode, currentDate, Instype, auditorname, (data) {
      getAuidtSummarylistData = data;
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getAuidtDefectByParts(context, String unitCode, String currentDate,
      String audittype, String auditorname) {
    getAuidtDefectByPartsData = GetAuidtDefectByPartsModel();
    notifyListeners();
    _useCase.getAuidtDefectByPartsData(
        unitCode, currentDate, audittype, auditorname, (data) {
      getAuidtDefectByPartsData = data;
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getAuidtDefectByCount(context, String unitCode, String currentDate,
      String audittype, String auditorname) {
    getAuidtDefectByCountDetail = GetAuidtDefectByCountModel();
    notifyListeners();
    _useCase.getAuidtDefectByCountData(
        unitCode, currentDate, audittype, auditorname, (data) {
      getAuidtDefectByCountDetail = data;
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getAuditStyle(
      context, String unitCode, String currentDate, String auditername) {
    getAuditStyleDetail = GetAuditStyleDataModel();
    notifyListeners();
    _useCase.getAuditStyleData(unitCode, currentDate, auditername, (data) {
      getAuditStyleDetail = data;
      ChangeNotifier().notifyListeners();

      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
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
}
