import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/TimeSpendModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/fitauditdashboard/fitaudit_dashboard_repo_impl.dart';

import '../../data/local/shared_prefs_helper.dart';
import '../../data/network/dto/UserAppModel.dart';
import '../../res/constants.dart';

class FitDashboardUseCase {
  late FitDashboardRepositoryImpl _dashboardRepositoryImpl;

  FitDashboardUseCase(FitDashboardRepositoryImpl repository) {
    _dashboardRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _dashboardRepositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              onSuccess(data);
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getAuditSummary(
    unitCode,
    currentDate,
    currentAuditType,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName2);
    await _dashboardRepositoryImpl
        .getAuditSummary(
          unitCode,
          currentDate,
          userN,
          currentAuditType,
        )
        .then((value) => value.when(success: (AuditSummaryModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getDefectpart(
    unitcode,audittype,auditDate,auditername,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _dashboardRepositoryImpl
        .getdefectByParts( unitcode,audittype,auditDate,auditername)
        .then((value) => value.when(success: (DefectPartModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getFinalAuditReport(
    unitcode,
    audittype,
    auditDate,
    auditername,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _dashboardRepositoryImpl
        .getFinalAuditStatus(unitcode, audittype, auditDate, auditername)
        .then((value) => value.when(success: (FinalAuditModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getScheduleList(
    unitCode,
    currentDate,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _dashboardRepositoryImpl
        .getScoreCardAuditInfo(unitCode, currentDate, userN)
        .then((value) => value.when(success: (ScheduleModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getTimeSpendModel(
    unitcode,
    audittype,
    auditDate,
    auditername,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _dashboardRepositoryImpl
        .getTimeSpentDetail(unitcode, audittype, auditDate, auditername)
        .then((value) => value.when(success: (TimeSpentModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  exceptionDialog(String? message) {
    return Get.defaultDialog(
        title: "Error",
        middleText: message ?? 'Some error occurred!',
        textCancel: "OK",
        confirmTextColor: const Color(0xffffffff),
        cancelTextColor: const Color(0xffF7931C),
        onCancel: () {},
        buttonColor: const Color(0xffF7931C));
  }
}
