import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/local/shared_prefs.dart';
import 'package:qapp/app/data/network/api_service.dart';
import 'package:qapp/app/features/splash/splash_use_case.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/utils/code_snippet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/local/shared_prefs_helper.dart';

class SplashViewModel extends BaseViewModel {
  final SplashUseCase _useCase = AppManager.instance.splashUseCase();

  Future<void> checkAndNavigate(BuildContext context) async {
    notifyListeners();
    bool isLoggedIn = await _useCase.checkIfUserIsLoggedIn();
    String firstMenu =
        await SharedPreferenceHelper.getString(Constants.firstMenu);
    String userName =
        await SharedPreferenceHelper.getString(Constants.userName);

    if (isLoggedIn) {
      notifyListeners();
      String authToken = await _useCase.getAuthToken();
      String userN = await SharedPrefs.displayName;
      ApiService.instance.updateAuthToken(authToken);
      ApiService.instance.token = authToken;

      if (firstMenu == "7.0 Audit") {
        Navigator.pushNamedAndRemoveUntil(
            context, Constants.dashBoardRoute, (Route<dynamic> route) => false);
      } else if (firstMenu == "Internal Audit") {
        Navigator.pushNamedAndRemoveUntil(
            context,
            Constants.internalAuditUserboardRoute,
            (Route<dynamic> route) => false);
      } else if (firstMenu == "Line QC") {
        Navigator.pushNamedAndRemoveUntil(
            context, Constants.userBoardRoute, (Route<dynamic> route) => false);
      } else if (firstMenu == "PreProdnQA") {
        Navigator.pushNamedAndRemoveUntil(
            context, Constants.beforeWash, (Route<dynamic> route) => false);
      } else {
        SharedPreferences prefs = await SharedPreferenceHelper.prefs;
        prefs.clear();
        Navigator.pushNamedAndRemoveUntil(context, Constants.onBoardingRoute,
            (Route<dynamic> route) => false);
      }
    } else {
      SharedPreferences prefs = await SharedPreferenceHelper.prefs;
      prefs.clear();
      Navigator.pushNamedAndRemoveUntil(
          context, Constants.onBoardingRoute, (Route<dynamic> route) => false);
    }
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

  void showErrorAlert(String message) {
    CodeSnippet.instance.showAlertMsg(message);
  }
}
