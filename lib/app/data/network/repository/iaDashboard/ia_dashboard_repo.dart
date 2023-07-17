import 'package:qapp/app/data/network/dto/AuditSummary.dart';
import 'package:qapp/app/data/network/dto/GetAuditStyleDataModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByCountModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByPartsModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtSummarylistModel.dart';
import 'package:qapp/app/data/network/dto/GetIAAuditSummaryModel.dart';
import 'package:qapp/app/data/network/dto/getIAAuditInfo.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';

import '../../dto/UserAppModel.dart';

abstract class IADashboardRepository {
  Future<ApiResult<UserAppModel>> loginwithUserApp();

  Future<ApiResult<AuditSummaryModel>> getAuditSummary(
      auditorId, date, auditorName);

  Future<ApiResult<GetIAAuditInfo>> getIAAuditDatas(
    unitCode,
    auditDate,
    auditorName,
    audittype,
  );
  Future<ApiResult<GetAuidtDefectByCountModel>> getAuidtDefectByCountDatas(
      unitCode, auditDate, audittype, audittorname);
  Future<ApiResult<GetAuidtDefectByPartsModel>> getAuidtDefectByPartsDatas(
      unitCode, auditDate, audittype, auditorname);
  Future<ApiResult<GetAuidtSummarylistModel>> getAuidtSummarylistDatas(
    unitCode,
    auditDate,
    audittype,
    Instype,
    auditorname,
  );
  Future<ApiResult<GetIAAuditSummaryModel>> getAuditSummarysDatas(
    unitcode,
    auditDate,
    auditername,
    audittype,
  );
  Future<ApiResult<GetAuditStyleDataModel>> getAuditStyleDatas(
    unitcode,
    auditDate,
    auditername,
    audittype,
  );
}
