import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/GetEmpData.dart';
import 'package:qapp/app/data/network/dto/TimeSpendModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';

import '../../dto/UserAppModel.dart';

abstract class DashboardRepository {
  Future<ApiResult<UserAppModel>> loginwithUserApp();
  Future<ApiResult<ScheduleModel>> getScoreCardAuditInfo(
      auditorId, date, auditorName);
  Future<ApiResult<FinalAuditModel>> getFinalAuditStatus(
      auditorId, date, auditorName);
  Future<ApiResult<TimeSpentModel>> getTimeSpentDetail(
      auditorId, date, auditorName);
  Future<ApiResult<DefectPartModel>> getdefectByParts(
      auditorId, date, auditorName);
  Future<ApiResult<AuditSummaryModel>> getAuditSummary(
      auditorId, date, auditorName);

  //7.0 AUDIT API`S
  Future<ApiResult<AuditSummaryModel>> getDefectCount(
    unitCode,
    auditDate,
    auditorName,
    sewLine,
  );
  Future<ApiResult<GetEmpDataModel>> getEmployeeCode();
  Future<ApiResult<AuditSummaryModel>> saveAudit();
  Future<ApiResult<AuditSummaryModel>> getSleeves();
  Future<ApiResult<AuditSummaryModel>> getSleeveAttachments();
  Future<ApiResult<AuditSummaryModel>> getFavorites();
  Future<ApiResult<AuditSummaryModel>> getAllDefects();
}
