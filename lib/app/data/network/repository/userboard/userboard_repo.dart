import 'package:qapp/app/data/network/dto/DefectPartModel.dart';
import 'package:qapp/app/data/network/dto/GetAuidtDefectByCountModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectCodeByTagIdModel.dart';
import 'package:qapp/app/data/network/dto/GetDefectLevelListModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCDefectLevelReportModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectCountModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQcdefectbypartsModel.dart';
import 'package:qapp/app/data/network/dto/GetQcWidgetInfoModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';

import '../../dto/UserAppModel.dart';

abstract class UserboardRepository {
  Future<ApiResult<UserAppModel>> loginwithUserApp();
  Future<ApiResult<ScheduleModel>> getScoreCardAuditInfo(
      String auditorId, String date, String auditorName);
  Future<ApiResult<DefectPartModel>> getdefectByParts(
      String auditorId, String date, String auditorName);

  Future<ApiResult<GetQcWidgetInfoModel>> getQcWidgetInfoData(
      String unitCode,
      String auditDate,
      String audittype,
      String checkername,
      String currentime);
  Future<ApiResult<GetLineQcdefectCountModel>> getLineQcdefectCountData(
    String unitCode,
    String auditDate,
    String audittype,
    String checkername,
  );

  Future<ApiResult<GetLineQCDefectLevelReportModel>>
      getLineQCDefectLevelReportAPIdatas(
    String unitCode,
    String audittype,
    String auditDate,
    String checkername,
  );

  Future<ApiResult<GetDsListModel>> getDsListData(String orderno);
  Future<ApiResult<GetDsListModel>> getQcSummaryData(
      String orderno,
      String unitcode,
      String auditDate,
      String audittype,
      String checkername,
      String sewline,
      String colorCode);
  Future<ApiResult<GetDefectLevelListModel>> getDefectLevelData(
      String unitcode, String auditDate, String audittype, String checkername);
  Future<ApiResult<GetDefectCodeByTagIdModel>> getDefectCodeByTagIdData(
      String tagId);

  Future<ApiResult<GetAuidtDefectByCountModel>> getAuidtDefectByCountDatas(
    unitCode,
    auditDate,
    audittype,
  );
  Future<ApiResult<GetLineQcdefectbypartsModel>> getLineQcdefectbypartsDatas(
    unitCode,
    auditDate,
    audittype,
    checkername,
  );
}
