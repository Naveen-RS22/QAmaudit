import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/base/app_scroll_behavior.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_view_model.dart';
import 'package:qapp/app/features/ImageGallery/imagegallery_view_model.dart';
import 'package:qapp/app/features/audit/audit_view_model.dart';
import 'package:qapp/app/features/cutinspection/cutinspection_view_model.dart';
import 'package:qapp/app/features/dashboard/dashboard_view_model.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_view_model.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_view_model.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/features/onboarding/on_boarding_view_model.dart';
import 'package:qapp/app/features/splash/splash_screen.dart';
import 'package:qapp/app/features/userboard/userboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/strings.dart';
import 'package:qapp/app/utils/navigation_manager.dart';

import 'app/features/BeforeWash/beforewash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  );
  // runApp(const MyApp());
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnBoardingViewModel>(
            create: (_) => OnBoardingViewModel()),
        ChangeNotifierProvider<DashboardViewModel>(
            create: (_) => DashboardViewModel()),
        ChangeNotifierProvider<AuditViewModal>(create: (_) => AuditViewModal()),
        ChangeNotifierProvider<InternalAuditViewModal>(
            create: (_) => InternalAuditViewModal()),
        ChangeNotifierProvider<IADashboardViewModel>(
            create: (_) => IADashboardViewModel()),
        ChangeNotifierProvider<UserboardViewModel>(
            create: (_) => UserboardViewModel()),
        ChangeNotifierProvider<InlineViewModal>(
            create: (_) => InlineViewModal()),
        ChangeNotifierProvider<BeforewashViewModal>(
            create: (_) => BeforewashViewModal()),
        ChangeNotifierProvider<ImageGalleryViewModal>(
            create: (_) => ImageGalleryViewModal()),
        ChangeNotifierProvider<CutInspectionViewModel>(
            create: (_) => CutInspectionViewModel()),
        ChangeNotifierProvider<FitAuditViewModal>(
            create: (_) => FitAuditViewModal()),
        ChangeNotifierProvider<FitDashboardViewModel>(
            create: (_) => FitDashboardViewModel()),

      ],
      child: GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: context.res.color.materialColorAccent),
        scrollBehavior: AppScrollBehavior(),
        home: const BeforeWashScreen(),
        onGenerateRoute: NavigationManager.generateRoute,
        initialRoute: Constants.beforeWash,
      ),
    );
  }
}
