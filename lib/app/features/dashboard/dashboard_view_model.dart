import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/network/api_service.dart';
import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/TimeSpendModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/dashboard/dashboard_use_case.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';

import 'package:qapp/app/utils/code_snippet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/shared_prefs_helper.dart';
import '../../res/constants.dart';

class DashboardViewModel extends BaseViewModel {
  final DashboardUseCase _useCase = AppManager.instance.dashboardUseCase();
  final pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  AuditSummaryModel auditSummary = AuditSummaryModel();
  TimeSpentModel timeSpent = TimeSpentModel();
  DefectPartModel defectPart = DefectPartModel();
  ScheduleModel scheduleList = ScheduleModel();
  FinalAuditModel finalAudit = FinalAuditModel();
  FinalAuditModel finalAuditPri = FinalAuditModel();
  FinalAuditModel finalAuditSec = FinalAuditModel();
  late Map<String?, List<AuditData>> filterList;
  List<String?> filterKeys = [];
  String finalAuditRound = "R1";
  bool isFirst = false;

  final datetime = DateTime.now();

  bool styleInfoExpanded = false;

  void setStyleInfoExpanded() {
    styleInfoExpanded = !styleInfoExpanded;
    notifyListeners();
  }

  resetData() {
    auditSummary = AuditSummaryModel();
    timeSpent = TimeSpentModel();
    defectPart = DefectPartModel();
    scheduleList = ScheduleModel();

    finalAudit = FinalAuditModel();
    finalAuditPri = FinalAuditModel();
    finalAuditSec = FinalAuditModel();
    filterKeys = [];
    filterList = {};
    notifyListeners();
  }

  // void finalAuditRoundOnChange(String round) {

  //   // finalAuditSec.data = [];

  //   finalAudit.data = [];

  //   int finalAuditLength = finalAuditPri.data?.length ?? 1;

  //   for (int i = 0; i < finalAuditLength; i++) {
  //     if (finalAuditPri.data?[i].sessionName == round) {
  //       finalAudit.data?.add(finalAuditPri.data![i]);
  //     }
  //   }
  //   finalAuditRound = round;
  //   finalAudit = finalAudit;

  //   notifyListeners();

  //   // if (round == "R1") {
  //   //   finalAudit.data = r1Data;

  //   // } else if (round == "R2") {
  //   //   finalAudit.data = r2Data;

  //   // } else {
  //   //   finalAudit.data = [];
  //   // }

  //   // finalAuditRound = round;
  //   // notifyListeners();
  // }

  // getFinalAuditStatic(context) {
  //   // finalAudit.data = finalAuditStatic;
  //   // finalAuditPri.data = finalAuditStatic;

  //   finalAuditRoundOnChange("R1");
  //   notifyListeners();
  @override
  notifyListeners();
  //   //_useCase.exceptionDialog(data.message);
  // }

  void finalAuditRoundOnChange(int round) async {
    // finalAuditRound = round;
    finalAuditSec.data = [];
    String getKey = filterKeys[round] ?? "";
    finalAuditRound = getKey;
    int finalAuditLength = filterList[getKey]?.length ?? 0;
    for (int i = 0; i < finalAuditLength; i++) {
      finalAuditSec.data?.add(filterList[getKey]![i]);
    }

    //finalAuditSec.data?.add(filterList[getKey]!);
    finalAudit = finalAuditSec;
    notifyListeners();
  }

  void onGetAuditSummary(
      BuildContext context, InlineViewModal inlineviews) async {
    String authToken =
        await SharedPreferenceHelper.getString(Constants.tokenData);
    ApiService.instance.token = authToken;
    // showProgress(context);
    notifyListeners();
    // _useCase.loginUserApp((data) async {
    isFirst = true;
    // String currentDate = DateFormat('yMd').format(datetime);
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    resetData();
    // timeChecker(context);
    getFinalAudit(context, unitCode, currentDate);
    getAudit(context, unitCode, currentDate);
    getTimeline(context, unitCode, currentDate);

    getDefectPart(context, unitCode, currentDate);
    getSchduleList(context, unitCode, currentDate);

    dismissProgress();
    notifyListeners();
    //_useCase.exceptionDialog(data.message);
    // }, (errorMessage) {
    //   showErrorAlert(errorMessage.toString());
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
    // SharedPreferenceHelper.setString(Constants.tokenData, "");
    Navigator.pushNamedAndRemoveUntil(
        context, Constants.onBoardingRoute, (Route<dynamic> route) => true);

    // Navigator.pushReplacement<void, void>(
    //   context,
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) => const OnBoardingScreen(),
    //   ),
    // );
  }

  void refreshData(BuildContext context) async {
    // String currentDate = DateFormat('yMd').format(datetime);
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    getFinalAudit(context, unitCode, currentDate);
    getAudit(context, unitCode, currentDate);
    getTimeline(context, unitCode, currentDate);
    getDefectPart(context, unitCode, currentDate);
    getSchduleList(context, unitCode, currentDate);
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

  getAudit(context, String unitCode, String currentDate) {
    auditSummary = AuditSummaryModel();
    notifyListeners();
    _useCase.getAuditSummary(unitCode, currentDate, (data) {
      auditSummary = data;
      ChangeNotifier().notifyListeners();
      notifyListeners();
      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getTimeline(context, String unitCode, String currentDate) {
    timeSpent = TimeSpentModel();
    notifyListeners();
    _useCase.getTimeSpendModel(unitCode, currentDate, (data) {
      timeSpent = data;
      notifyListeners();

      dismissProgress();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getFinalAudit(context, String unitCode, String currentDate) {
    finalAudit = FinalAuditModel(data: []);
    finalAuditPri = FinalAuditModel(data: []);
    finalAuditSec = FinalAuditModel(data: []);
    filterList = {};
    filterKeys = [];
    notifyListeners();
    _useCase.getFinalAuditReport(unitCode, currentDate, (data) {
      //
      finalAudit = data;
      // if ((finalAudit.isSuccess ?? false) == false) {
      //   getFinalAudit(context, unitCode, currentDate);
      //   return;
      // }
      finalAuditPri = data;
      if (finalAudit.data?.isNotEmpty ?? false) {
        var newMap =
            groupBy(finalAudit.data!, (AuditData obj) => obj.sessionName);

        filterList = newMap;
        filterKeys = newMap.keys.toList();
        finalAuditRoundOnChange(0);
      }
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
      // final ScheduleModel newList = data;
      scheduleList = data;
      if (scheduleList.data?.isNotEmpty ?? false) {
        List<StyleAuditData> datas =
            scheduleList.data!.where((o) => o.auditType == '7.0').toList();
        scheduleList.data = [];
        for (int i = 0; i < datas.length; i++) {
          StyleAuditData info = datas[i];
          scheduleList.data?.add(info);
        }
      }
      dismissProgress();
      notifyListeners();
      notifyListeners();
      //_useCase.exceptionDialog(data.message);
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
    }, (errorMessage) {
      dismissProgress();
    });
  }

  clearData() {
    auditSummary = AuditSummaryModel();
    timeSpent = TimeSpentModel();
    defectPart = DefectPartModel();
    scheduleList = ScheduleModel();

    finalAudit = FinalAuditModel();
    finalAuditPri = FinalAuditModel();
    finalAuditSec = FinalAuditModel();
    filterList = {};
    filterKeys = [];
    notifyListeners();
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

  List<Timespentdetail2> selectRoundDropdown = [];

  roundeSetter(int orderNo, String styleNo) {
    selectRoundDropdown = [];
    for (int i = 0; i < (timeSpent.data?.timespentdetail ?? []).length; i++) {
      if ((timeSpent.data?.timespentdetail ?? [])[i].orderNo == orderNo &&
          (timeSpent.data?.timespentdetail ?? [])[i].styleNo == styleNo) {
        selectRoundDropdown.add(Timespentdetail2(
          auditDate: (timeSpent.data?.timespentdetail ?? [])[i].auditDate,
          auditorName: (timeSpent.data?.timespentdetail ?? [])[i].auditorName,
          orderNo: (timeSpent.data?.timespentdetail ?? [])[i].orderNo,
          sessionName: (timeSpent.data?.timespentdetail ?? [])[i].sessionName,
          sewline: (timeSpent.data?.timespentdetail ?? [])[i].sewline,
          styleNo: (timeSpent.data?.timespentdetail ?? [])[i].styleNo,
          totalMins: (timeSpent.data?.timespentdetail ?? [])[i].totalMins,
          unitCode: (timeSpent.data?.timespentdetail ?? [])[i].unitCode,
        ));
        notifyListeners();
      }
    }
  }
}
