import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/GetAllLanguageInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetLanguageAssignmentByUsercodeModel.dart';
import 'package:qapp/app/data/network/dto/GetMenusByRoleandAppModel.dart';
import 'package:qapp/app/data/network/dto/ResetPasswordBody.dart';
import 'package:qapp/app/data/network/dto/ResetPasswordResponse.dart';
import 'package:qapp/app/data/network/dto/UpdateLanguageAssignmentAuditsByUsercodeModel.dart';
import 'package:qapp/app/data/network/dto/UserAppModel.dart';
import 'package:qapp/app/data/network/dto/forgot_password_model.dart';
import 'package:qapp/app/data/network/dto/login_model.dart';
import 'package:qapp/app/data/network/exceptions/network_exceptions.dart';
import 'package:qapp/app/widgets/dialog_utils.dart';

import '../../data/network/repository/onboarding/on_boarding_repo_impl.dart';

class OnBoardingUseCase {
  late OnBoardingRepositoryImpl _repositoryImpl;

  OnBoardingUseCase(OnBoardingRepositoryImpl repository) {
    _repositoryImpl = repository;
  }

  RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  void login(
    String userName,
    String passWord,
    Function(LoginModel data) onSuccess,
    Function onError,
  ) async {
    if (isValidEmail(userName)) {
      if (isValidPassword(passWord)) {
        await _repositoryImpl
            .loginWithCredentials(userName, passWord)
            .then((value) => value.when(success: (LoginModel data) {
                  if (data.isSuccess!) {
                    onSuccess(data);
                  } else {
                    onError(data.message!);

                    exceptionDialog(data.message!);
                  }
                }, failure: (NetworkExceptions failure) {
                  Fimber.d("===>" + failure.toString());
                  DialogUtils.instance.dismissProgressbar();
                }));
      } else {
        onError('Enter user name and password');
      }
    } else {
      onError('Enter valid user name');
    }
  }

  bool isValidPassword(String password) =>
      password.isNotEmpty && password.length != 6;

  bool isValidEmail(String email) =>
      email.isNotEmpty && emailRegex.hasMatch(email);

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

  void onForgotPassword(
    String userName,
    Function onSuccess,
    Function onError,
  ) async {
    await _repositoryImpl
        .forgotPassword(userName)
        .then((value) => value.when(success: (ForgetPasswordModel data) {
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

  void onResetPassword(
    String userName,
    Function onSuccess,
    Function onError,
  ) async {
    await _repositoryImpl
        .forgotPassword(userName)
        .then((value) => value.when(success: (ForgetPasswordModel data) {
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

  void resetPassword(
    ResetPasswordRequest data,
    Function onSuccess,
    Function onError,
  ) async {
    await _repositoryImpl
        .resetPassword(
          data,
        )
        .then((value) => value.when(success: (ResetPasswordResponse data) {
              if (data.isSuccess ?? false) {
                onSuccess(data);
              } else {
                onError(data.message);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              DialogUtils.instance.dismissProgressbar();
            }));
  }

  void getLanguageAssignmentByUsercodeData(
    String usercode,
    Function onSuccess,
    Function onError,
  ) async {
    await _repositoryImpl.getLanguageAssignmentByUsercodeDatas(usercode).then(
        (value) =>
            value.when(success: (GetLanguageAssignmentByUsercodeModel data) {
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

  void getAllLanguageInfoData(
    Function onSuccess,
    Function onError,
  ) async {
    await _repositoryImpl
        .getAllLanguageInfoDatas()
        .then((value) => value.when(success: (GetAllLanguageInfoModel data) {
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

  void GetMenusByRoleandAppData(
    String currentRole,
    Function onSuccess,
    Function onError,
  ) async {
    await _repositoryImpl.GetMenusByRoleandAppDatas(currentRole)
        .then((value) => value.when(success: (GetMenusByRoleandAppModel data) {
              if (data.isSuccess ?? true) {
                onSuccess(data);
              } else {
                onError(data.isSuccess);
              }
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              onError(failure);
            }));
  }

  void updateLanguageAssignmentAuditsByUsercode(
    String usercode,
    String languagecode,
    Function onSuccess,
    Function onError,
  ) async {
    await _repositoryImpl
        .updateLanguageAssignmentAuditsByUsercodeDatas(usercode, languagecode)
        .then((value) => value.when(
                success: (UpdateLanguageAssignmentAuditsByUsercodeModel data) {
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

  void loginUserApp(Function onSuccess, Function onError) async {
    await _repositoryImpl
        .loginwithUserApp()
        .then((value) => value.when(success: (UserAppModel data) {
              onSuccess(data);
            }, failure: (NetworkExceptions failure) {
              Fimber.d("===>" + failure.toString());
              onError(failure);
            }));
  }
}
