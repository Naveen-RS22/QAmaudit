import 'package:flutter/material.dart';

class Colors {
  Color get colorPrimary => const Color(0xffffffff);
  Color get colorAccent => const Color(0xffe5e5e5);

  final Map<int, Color> _primary = {
    50: const Color.fromRGBO(22, 134, 206, 0.1),
    100: const Color.fromRGBO(22, 134, 206, 0.2),
    200: const Color.fromRGBO(22, 134, 206, 0.3),
    300: const Color.fromRGBO(22, 134, 206, 0.4),
    400: const Color.fromRGBO(22, 134, 206, 0.5),
    500: const Color.fromRGBO(22, 134, 206, 0.6),
    600: const Color.fromRGBO(22, 134, 206, 0.7),
    700: const Color.fromRGBO(22, 134, 206, 0.8),
    800: const Color.fromRGBO(22, 134, 206, 0.9),
    900: const Color.fromRGBO(22, 134, 206, 1.0),
  };



  MaterialColor get materialColorAccent => MaterialColor(0xffffffff, _primary);

  Color get textOrange => const Color(0xffF57234);
  Color get textGray => const Color(0xff919191);
  Color get white => const Color(0xffffffff);
  Color get black => const Color(0xff000000);
  Color get cardBg1 => const Color(0xff676767);
  Color get cardBg2 => const Color(0xffD9DCE0);
  Color get textColorGreen => const Color(0xff1FB146);
  Color get textColorRed => const Color(0xffFF4343);
  Color get cardGradStart => const Color(0xffF7931D);
  Color get cardGradEnd => const Color(0xffF57234);
  Color get bgColorBlue => const Color(0xff227DD7);
  Color get progressOrange => const Color(0xffF7931D);
  Color get inlineTopContainerBg => const Color(0xffF6F8FA);
  Color get dividerColor => const Color(0xffE6E6E6);
  Color get gray => const Color(0xffE7EDF4);

}
