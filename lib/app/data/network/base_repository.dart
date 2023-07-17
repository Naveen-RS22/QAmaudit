import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/res/constants.dart';

class BaseRepository {
  Future<bool> isLoggedIn() {
    return SharedPreferenceHelper.getBool(Constants.isLoggedIn);
  }

  Future<String> getAuthToken() {
    return SharedPreferenceHelper.getString(Constants.tokenData);
  }
}
