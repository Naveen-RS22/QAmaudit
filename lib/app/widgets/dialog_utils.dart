import 'package:flutter/material.dart';

class DialogUtils {
  BuildContext? _context;
  bool _isProgressDialogShown = false;
  static final DialogUtils _singleton = DialogUtils._internal();

  DialogUtils._internal();

  static DialogUtils get instance => _singleton;

  void showProgress(BuildContext context) {
    _context = context;
    _isProgressDialogShown = true;
    showDialog(
        barrierDismissible: false,
        context: _context!,
        builder: (context) {
          return Dialog(
              child: Container(
            color: Colors.transparent,
            width: 50,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('loading...'),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  color: Colors.amber,
                )
              ],
            ),
          ));
        });
  }

  void dismissProgressbar() {
    if (_isProgressDialogShown) {
      Navigator.pop(_context!);
      _isProgressDialogShown = false;
    } //pop dialog
  }
}
