import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';

class SharedPrefs {
  static Future<bool> get authenticated =>
      SharedPreferenceHelper.getBool(Constants.isLoggedIn);

  static Future<String> get loginUser =>
      SharedPreferenceHelper.getString(Constants.loginData);
  static Future<String> get authToken =>
      SharedPreferenceHelper.getString(Constants.tokenData);
  static Future<String> get userCode =>
      SharedPreferenceHelper.getString(Constants.userCode);
  static Future<String> get userName =>
      SharedPreferenceHelper.getString(Constants.userName);
  static Future<String> get displayName =>
      SharedPreferenceHelper.getString(Constants.userDisplayName);
  static Future<String> get entityCode =>
      SharedPreferenceHelper.getString(Constants.entityCode);
  static Future<String> get entityLocationCode =>
      SharedPreferenceHelper.getString(Constants.entityLocationCode);
  static Future setIsLoggedIn(bool value) =>
      SharedPreferenceHelper.setBool(Constants.isLoggedIn, value);

  static Future<String> get current7audit =>
      SharedPreferenceHelper.getString(Constants.current7audit);

  Future<void> clear() async {
    await Future.wait(<Future>[
      setIsLoggedIn(false),
    ]);
  }
}
