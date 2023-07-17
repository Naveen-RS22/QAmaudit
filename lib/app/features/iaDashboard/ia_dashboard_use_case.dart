import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/GetAuditStyleDataModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByCountModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtSummarylistModel.dart';
import 'package:qapp/app/data/network/dto/GetIAAuditSummaryModel.dart';
import 'package:qapp/app/data/network/dto/getIAAuditInfo.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/iaDashboard/ia_dashboard_repo_impl.dart';

import '../../data/network/dto/UserAppModel.dart';

class IADashboardUseCase {
  late IADashboardRepositoryImpl _iaDashboardRepositoryImpl;

  IADashboardUseCase(IADashboardRepositoryImpl repository) {
    _iaDashboardRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _iaDashboardRepositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              //if (data.isSuccess ?? true) {
              onSuccess(null);
              // } else {
              //   onError(data.message);
              // }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              onError(failure);
            }));
  }

  void getAuidtDefectByCountData(
    unitCode,
    currentDate,
    audittype,
    auditorname,
    Function onSuccess,
    Function onError,
  ) async {
    await _iaDashboardRepositoryImpl
        .getAuidtDefectByCountDatas(
          unitCode,
          currentDate,
          audittype,
          auditorname,
        )
        .then((value) => value.when(success: (GetAuidtDefectByCountModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              onError(failure);
            }));
  }

  void getAuditStyleData(
    unitCode,
    currentDate,
    auditername,
    Function onSuccess,
    Function onError,
  ) async {
    await _iaDashboardRepositoryImpl
        .getAuditStyleDatas(unitCode, currentDate, auditername, "IA")
        .then((value) => value.when(success: (GetAuditStyleDataModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              onError(failure);
            }));
  }

  void getAuditSummarysData(
    unitCode,
    currentDate,
    auditername,
    Function onSuccess,
    Function onError,
  ) async {
    await _iaDashboardRepositoryImpl
        .getAuditSummarysDatas(unitCode, currentDate, auditername, "IA")
        .then((value) => value.when(success: (GetIAAuditSummaryModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              onError(failure);
            }));
  }

  void getAuidtSummarylistData(
    unitCode,
    currentDate,
    Instype,
    auditorname,
    Function onSuccess,
    Function onError,
  ) async {
    await _iaDashboardRepositoryImpl
        .getAuidtSummarylistDatas(
            unitCode, currentDate, "IA", Instype, auditorname)
        .then((value) => value.when(success: (GetAuidtSummarylistModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              onError(failure);
            }));
  }

  void getAuidtDefectByPartsData(
    unitCode,
    currentDate,
    audittypem,
    auditorname,
    Function onSuccess,
    Function onError,
  ) async {
    await _iaDashboardRepositoryImpl
        .getAuidtDefectByPartsDatas(
            unitCode, currentDate, audittypem, auditorname)
        .then((value) => value.when(success: (GetAuidtDefectByPartsModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              onError(failure);
            }));
  }

  void getIAAuditData(
    unitCode,
    currentDate,
    auditername,
    Function onSuccess,
    Function onError,
  ) async {
    await _iaDashboardRepositoryImpl
        .getIAAuditDatas(unitCode, currentDate, auditername, "IA")
        .then((value) => value.when(success: (GetIAAuditInfo data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
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
