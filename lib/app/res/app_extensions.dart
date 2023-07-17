import 'package:flutter/material.dart';
import 'package:qapp/app/res/resources.dart';

extension AppContext on BuildContext {
  Resources get res => Resources.of(this);
}
