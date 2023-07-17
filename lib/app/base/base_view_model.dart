import 'package:flutter/material.dart';

import '../widgets/dialog_utils.dart';

abstract class BaseViewModel with ChangeNotifier {
  void showProgress(BuildContext context) {
    DialogUtils.instance.showProgress(context);
  }

  void dismissProgress() {
    DialogUtils.instance.dismissProgressbar();
  }
}
