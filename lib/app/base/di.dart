import 'package:qapp/app/data/network/base_repository.dart';
import 'package:qapp/app/data/network/repository/AuditForm/audit_repo_impl.dart';
import 'package:qapp/app/data/network/repository/BeforeWash/beforewash_imp.dart';
import 'package:qapp/app/data/network/repository/FitAuditForm/fit_audit_repo_impl.dart';
import 'package:qapp/app/data/network/repository/ImageGallery/imagegallery_imp.dart';
import 'package:qapp/app/data/network/repository/InlineForm/inline_repo_impl.dart';
import 'package:qapp/app/data/network/repository/InternalAudit/internal_audit_imp.dart';
import 'package:qapp/app/data/network/repository/cutInspection/cutinspection_imp.dart';
import 'package:qapp/app/data/network/repository/dashboard/dashboard_repo_impl.dart';
import 'package:qapp/app/data/network/repository/fitauditdashboard/fitaudit_dashboard_repo_impl.dart';
import 'package:qapp/app/data/network/repository/iaDashboard/ia_dashboard_repo_impl.dart';

import 'package:qapp/app/data/network/repository/onboarding/on_boarding_repo_impl.dart';
import 'package:qapp/app/data/network/repository/userboard/userboard_repo_impl.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_use_case.dart';
import 'package:qapp/app/features/ImageGallery/imagegallery_use_case.dart';

import 'package:qapp/app/features/audit/audit_use_case.dart';
import 'package:qapp/app/features/cutinspection/cutinspection_use_case.dart';
import 'package:qapp/app/features/dashboard/dashboard_use_case.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_use_case.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_use_case.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_use_case.dart';
import 'package:qapp/app/features/inline/inline_use_case.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_use_case.dart';
// import 'package:qapp/app/features/BeforeWash/beforewash_use_case.dart';
// import 'package:qapp/app/features/iaDashboard/ia_dashboard_use_case.dart';
// import 'package:qapp/app/features/inline/inline_use_case.dart';
// import 'package:qapp/app/features/internalAuditForms/internal_audit_use_case.dart';
import 'package:qapp/app/features/onboarding/on_boarding_use_case.dart';
import 'package:qapp/app/features/splash/splash_use_case.dart';
import 'package:qapp/app/features/userboard/userboard_use_case.dart';

class AppManager {
  static final AppManager _singleton = AppManager._internal();

  AppManager._internal();

  static AppManager get instance => _singleton;

  final BaseRepository _repository = BaseRepository();
  final OnBoardingRepositoryImpl _onBoardingRepository =
      OnBoardingRepositoryImpl();
  final DashboardRepositoryImpl _dashboardRepository =
      DashboardRepositoryImpl();
  final FitDashboardRepositoryImpl _fitDashboardRepository =
      FitDashboardRepositoryImpl();

  final AuditRepositoryImpl _auditRepository = AuditRepositoryImpl();
  final FitAuditRepositoryImpl _fitAuditRepository = FitAuditRepositoryImpl();
  final InternalAuditRepositoryImpl _internalAuditRepositoryImpl =
      InternalAuditRepositoryImpl();

  final IADashboardRepositoryImpl _iaDashboardRepository =
      IADashboardRepositoryImpl();

  final UserboardRepositoryImpl _userboardRepository =
      UserboardRepositoryImpl();

  final InlineRepositoryImpl _inlineRepository = InlineRepositoryImpl();
  final BeforewashRepositoryImpl _beforewashRepositoryImpl =
      BeforewashRepositoryImpl();
  final ImageGalleryRepositoryImpl _imageGalleryRepositoryImpl =
      ImageGalleryRepositoryImpl();
  final CutInspectionRepositoryImpl _cutinspectionRepositoryImpl =
      CutInspectionRepositoryImpl();

  OnBoardingUseCase onBoardingUseCase() {
    return OnBoardingUseCase(_onBoardingRepository);
  }

  SplashUseCase splashUseCase() {
    return SplashUseCase(_repository);
  }

  DashboardUseCase dashboardUseCase() {
    return DashboardUseCase(_dashboardRepository);
  }

  FitDashboardUseCase fitDashboardUseCase() {
    return FitDashboardUseCase(_fitDashboardRepository);
  }

  AuditUserCase auditUseCase() {
    return AuditUserCase(_auditRepository);
  }

  FitAuditUserCase fitAuditUseCase() {
    return FitAuditUserCase(_fitAuditRepository);
  }

  InternalAuditUserCase internalAuditUseCase() {
    return InternalAuditUserCase(_internalAuditRepositoryImpl);
  }

  IADashboardUseCase iaDashboardUseCase() {
    return IADashboardUseCase(_iaDashboardRepository);
  }

  UserboardUseCase userboardUseCase() {
    return UserboardUseCase(_userboardRepository);
  }

  InlineUserCase inlineUseCase() {
    return InlineUserCase(_inlineRepository);
  }

  BeforeWashUserCase beforewashUseCase() {
    return BeforeWashUserCase(_beforewashRepositoryImpl);
  }

  ImageGalleryUserCase imageGalleryUseCase() {
    return ImageGalleryUserCase(_imageGalleryRepositoryImpl);
  }

  CutInspectionUserCase cutinspectionUseCase() {
    return CutInspectionUserCase(_cutinspectionRepositoryImpl);
  }
}
