import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CodeSnippet {
  static final CodeSnippet _singleton = CodeSnippet._internal();

  CodeSnippet._internal();

  static CodeSnippet get instance => _singleton;

  Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      showAlertMsg('No internet connection available"');
      return false;
    } on SocketException catch (_) {
      showAlertMsg('No internet connection available');
      return false;
    }
  }

  showAlertMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.red[400], textColor: Colors.white);
  }

  showSuccessMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.green[100], textColor: Colors.black);
  }

  showWhiteMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.white, textColor: Colors.black);
  }
}
