import 'package:flutter/cupertino.dart';
import 'package:qapp/app/res/colors.dart';
import 'package:qapp/app/res/dimens.dart';

class Resources {
  final BuildContext context;

  Resources(this.context);

  Colors get color {
    return Colors();
  }

  Dimens get dimension {
    return Dimens();
  }

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}
