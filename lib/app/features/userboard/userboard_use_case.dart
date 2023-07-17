import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByCountModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectCodeByTagIdModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectLevelListModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCDefectLevelReportModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectCountModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectbypartsModel.dart';
import 'package:qapp/app/data/network/dto/GetQcWidgetInfoModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/data/network/repository/userboard/userboard_repo_impl.dart';

import '../../data/local/shared_prefs_helper.dart';
import '../../data/network/dto/UserAppModel.dart';
import '../../res/constants.dart';

class UserboardUseCase {
  late UserboardRepositoryImpl _userboardRepositoryImpl;

  UserboardUseCase(UserboardRepositoryImpl repository) {
    _userboardRepositoryImpl = repository;
  }

  void loginUserApp(Function onSuccess, Function onError) async {
    await _userboardRepositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              onSuccess(null);
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>$failure");
              onError(failure);
            }));
  }

  void getDefectpart(
    String unitCode,
    String currentDate,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _userboardRepositoryImpl
        .getdefectByParts(unitCode, currentDate, userN)
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

  void getLineQcdefectbypartsData(
    unitCode,
    currentDate,
    finalAuditRound,
    checkername,
    Function onSuccess,
    Function onError,
  ) async {
    await _userboardRepositoryImpl
        .getLineQcdefectbypartsDatas(
            unitCode, currentDate, finalAuditRound, checkername)
        .then(
            (value) => value.when(success: (GetLineQcdefectbypartsModel data) {
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

  void getAuidtDefectByCountData(
    unitCode,
    currentDate,
    finalAuditRound,
    Function onSuccess,
    Function onError,
  ) async {
    await _userboardRepositoryImpl
        .getAuidtDefectByCountDatas(unitCode, currentDate, finalAuditRound)
        .then((value) => value.when(success: (GetAuidtDefectByCountModel data) {
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
    String unitCode,
    String currentDate,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _userboardRepositoryImpl
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

  void getQcWidgetInfos(
    String unitCode,
    String currentDate,
    String finalAuditRound,
    String timeStamps,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _userboardRepositoryImpl
        .getQcWidgetInfoData(
            unitCode, currentDate, finalAuditRound, userN, timeStamps)
        .then((value) => value.when(success: (GetQcWidgetInfoModel data) {
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

  void getLineQcdefectCounts(
    String unitCode,
    String auditDate,
    String audittype,
    String checkername,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _userboardRepositoryImpl
        .getLineQcdefectCountData(
          unitCode,
          auditDate,
          audittype,
          checkername,
        )
        .then((value) => value.when(success: (GetLineQcdefectCountModel data) {
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

  void getLineQCDefectLevelReportAPIdata(
    unitCode,
    audittype,
    auditDate,
    checkername,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _userboardRepositoryImpl
        .getLineQCDefectLevelReportAPIdatas(
          unitCode,
          audittype,
          auditDate,
          checkername,
        )
        .then((value) =>
            value.when(success: (GetLineQCDefectLevelReportModel data) {
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

  void getDsLists(
    String orderNo,
    Function onSuccess,
    Function onError,
  ) async {
    await _userboardRepositoryImpl
        .getDsListData(orderNo)
        .then((value) => value.when(success: (GetDsListModel data) {
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

  void getQcSummarys(
    String unitCode,
    String currentDate,
    String finalAuditRound,
    String orderNo,
    String sawLine,
    String colorCode,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _userboardRepositoryImpl
        .getQcSummaryData(orderNo, unitCode, currentDate, finalAuditRound,
            userN, sawLine, colorCode)
        .then((value) => value.when(success: (GetDsListModel data) {
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

  void getDefectLevelLists(
    String unitCode,
    String audittype,
    String currentDate,
    Function onSuccess,
    Function onError,
  ) async {
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    await _userboardRepositoryImpl
        .getDefectLevelData(unitCode, currentDate, audittype, userN)
        .then((value) => value.when(success: (GetDefectLevelListModel data) {
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

  void getDefectCodeByTagIds(
    String tagId,
    Function onSuccess,
    Function onError,
  ) async {
    await _userboardRepositoryImpl
        .getDefectCodeByTagIdData(tagId)
        .then((value) => value.when(success: (GetDefectCodeByTagIdModel data) {
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
