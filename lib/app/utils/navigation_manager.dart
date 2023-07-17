import 'package:flutter/material.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_screen.dart';
import 'package:qapp/app/features/ImageGallery/imagegallery_screen.dart';

import 'package:qapp/app/features/audit/audit_screen.dart';
import 'package:qapp/app/features/cutinspection/cutinspection_screen.dart';
import 'package:qapp/app/features/dashboard/dashboard_screen.dart';
import 'package:qapp/app/features/dashboard/profile_screen.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_screen.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_screen.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_screen.dart';
import 'package:qapp/app/features/inline/inline_screen.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_screen.dart';
import 'package:qapp/app/features/onboarding/on_boarding_screen.dart';
import 'package:qapp/app/features/splash/splash_screen.dart';
import 'package:qapp/app/features/userboard/userboard_screen.dart';
import 'package:qapp/app/res/constants.dart';

// import 'package:qapp/app/features/BeforeWash/measurement_audit_screen.dart';
// import 'package:qapp/app/features/iaDashboard/ia_dashboard_screen.dart';
// import 'package:qapp/app/features/calendar/calendar.dart';
// import 'package:qapp/app/features/camerascreen/camera_screen.dart';
// import 'package:qapp/app/features/inline/inline_screen.dart';
// import 'package:qapp/app/features/userboard/userboard_screen.dart';

class NavigationManager {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Constants.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Constants.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Constants.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Constants.dashBoardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case Constants.auditRoute:
        return MaterialPageRoute(
            builder: (_) => const AuditScreen(),
            settings:
                RouteSettings(arguments: StyleAuditData(totOperators: 55)));
      case Constants.inlineRoute:
        return MaterialPageRoute(
            builder: (_) => const InternalAuditScreen(),
            settings:
                RouteSettings(arguments: StyleAuditData(totOperators: 55)));
      case Constants.internalAuditUserboardRoute:
        return MaterialPageRoute(builder: (_) => const IADashboardScreen());

      case Constants.userBoardRoute:
        return MaterialPageRoute(builder: (_) => const UserboardScreen());
      case Constants.internalAuditForm:
        return MaterialPageRoute(builder: (_) => const InlineScreen());

      // case Constants.calendarRoute:
      //   return MaterialPageRoute(builder: (_) => const CalendarScreen());
      // case Constants.cameraRoute:
      //   return MaterialPageRoute(builder: (_) => const TakePictureScreen());
      case Constants.beforeWash:
        return MaterialPageRoute(builder: (_) => const BeforeWashScreen());

      case Constants.imageGallery:
        return MaterialPageRoute(builder: (_) => const ImageGalleryScreen());
      case Constants.CutInspection:
        return MaterialPageRoute(builder: (_) => const CutInspection());
      case Constants.fitAuditDashBoardRoute:
        return MaterialPageRoute(
            builder: (_) => const FitAuditDashboardScreen());
      case Constants.fitAuditRoute:
        return MaterialPageRoute(builder: (_) => const FitAuditScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${routeSettings.name}'),
                  ),
                ));
    }
  }
}
