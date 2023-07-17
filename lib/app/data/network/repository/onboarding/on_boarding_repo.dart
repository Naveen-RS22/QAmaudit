import 'package:qapp/app/data/network/dto/GetAllLanguageInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetLanguageAssignmentByUsercodeModel.dart';
import 'package:qapp/app/data/network/dto/GetMenusByRoleandAppModel.dart';
import 'package:qapp/app/data/network/dto/ResetPasswordBody.dart';
import 'package:qapp/app/data/network/dto/ResetPasswordResponse.dart';
import 'package:qapp/app/data/network/dto/UpdateLanguageAssignmentAuditsByUsercodeModel.dart';
import 'package:qapp/app/data/network/dto/UserAppModel.dart';
import 'package:qapp/app/data/network/dto/forgot_password_model.dart';
import 'package:qapp/app/data/network/dto/login_model.dart';
import 'package:qapp/app/data/network/exceptions/api_result.dart';

abstract class OnBoardingRepository {
  Future<ApiResult<LoginModel>> loginWithCredentials(username, password);

  Future<ApiResult<ForgetPasswordModel>> forgotPassword(username);

  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest data);
  Future<ApiResult<GetAllLanguageInfoModel>> getAllLanguageInfoDatas();
  Future<ApiResult<GetMenusByRoleandAppModel>> GetMenusByRoleandAppDatas(
      currentRole);

  Future<ApiResult<GetLanguageAssignmentByUsercodeModel>>
      getLanguageAssignmentByUsercodeDatas(usercode);
  Future<ApiResult<UpdateLanguageAssignmentAuditsByUsercodeModel>>
      updateLanguageAssignmentAuditsByUsercodeDatas(usercode, language);
  Future<ApiResult<UserAppModel>> loginwithUserApp();
}
