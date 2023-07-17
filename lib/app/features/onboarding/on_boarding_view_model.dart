import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/api_service.dart';
import 'package:qapp/app/data/network/dto/GetAllLanguageInfoModel.dart';
import 'package:qapp/app/data/network/dto/GetLanguageAssignmentByUsercodeModel.dart';
import 'package:qapp/app/data/network/dto/GetMenusByRoleandAppModel.dart';
import 'package:qapp/app/data/network/dto/UserModel.dart';
import 'package:qapp/app/data/network/dto/ResetPasswordBody.dart';
import 'package:qapp/app/data/network/dto/UserAppModel.dart';
import 'package:qapp/app/features/onboarding/data/intro_data.dart';
import 'package:qapp/app/features/onboarding/on_boarding_use_case.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/utils/code_snippet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OnBoardingViewModel extends BaseViewModel {
  final OnBoardingUseCase _useCase = AppManager.instance.onBoardingUseCase();
  final pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  final boxHeight = 150.0;
  String forgotPasswordEmail = '';
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  String userName = '';
  String passWord = '';

  TextEditingController old = TextEditingController();
  TextEditingController newp = TextEditingController();
  TextEditingController conf = TextEditingController();

  final items = [
    IntroData('Title of the slider 1',
        '                     Interactive user board with real-time data for data-directed decision-making. Highly structured and efficient schedules for a user to perform daily tasks. '),
    IntroData('Title of the slider 2',
        '                     Digitized data entry and constructive defect and image capturing process. A bar chart provides a simple, quick, and clear understanding of the status for the user on the shop floor.'),
    IntroData('Title of the slider 3',
        '                     Report generation using real-time data for analytical purposes. Provides detailed view and summary view with different report filtering options.'),
  ];

  final String forgotPasswordContent =
      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.';

  GetAllLanguageInfoModel getAllLanguageInfoDetail = GetAllLanguageInfoModel();
  GetMenusByRoleandAppModel GetMenusByRoleDetail = GetMenusByRoleandAppModel();

  GetLanguageAssignmentByUsercodeModel getLanguageAssignmentByUsercodeDetail =
      GetLanguageAssignmentByUsercodeModel();

  UserAppModel userApps = UserAppModel();
  String authToken = '';

  void proceedToLogin(BuildContext context) async {
    if (kDebugMode) {
      userName = 'venkatesh@altascio.com';
      passWord = 'Password@123';

      // userName = 'nivedha@ambattur.com';
      // passWord = 'password123';

      // userName = 'punitha@altascio.com';
      // passWord = 'Metrics@123';

      // userName = 'punitha@ambattur.com';
      // passWord = 'password123';

      // userName = 's_vadivu@ambattur.com';
      // passWord = 'password123';

      // userName = 'asha@ambattur.com';
      // passWord = 'password123';

      // userName = 'seeni@ambattur.com';
      // passWord = 'password123';

      // userName = 'mathankumar@ambattur.com';
      // passWord = 'Mathan@123';

      // userName = 'demo@ithred.com';
      // passWord = 'password123';

      // userName = 'mosesqa@ambattur.com';
      // passWord = 'password123';

      // userName = 'tindia1@ambattur.com';
      // passWord = 'password123';

      // userName = 'b9b10@ambattur.com';
      // passWord = 'password123';
    }
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    prefs.clear();
    notifyListeners();

    showProgress(context);
    _useCase.login(userName, passWord, (data) async {
      dismissProgress();
      FocusScope.of(context).requestFocus(FocusNode());

      authToken = data.data?.authUser?.accessToken ?? "";
      SharedPreferenceHelper.setString(Constants.tokenData, authToken);
      ApiService.instance.updateAuthToken(authToken);
      String userN = (data.data?.authUser?.displayName ?? "");
      SharedPreferenceHelper.setBool(Constants.isLoggedIn, true);
      SharedPreferenceHelper.setString(
          Constants.loginData, data.toJson().toString());

      SharedPreferenceHelper.setString(
          Constants.userCode, data.data?.authUser?.userCode ?? "");
      SharedPreferenceHelper.setString(
          Constants.userDisplayName, (data.data?.authUser?.displayName ?? ""));

      if (data.data?.authUser?.unitCodes?.isEmpty ?? false) {
        showErrorAlert(' No unit code found');
      }
      String unitCode = data.data?.authUser?.unitCodes?[0].toString() ?? '';
      if (unitCode == "") {
        SharedPreferenceHelper.setString('unitCode', ('D15-2'));
      } else {
        SharedPreferenceHelper.setString('unitCode', (unitCode));
      }

      SharedPreferenceHelper.setString(
          Constants.userDisplayName2, (data.data?.authUser?.displayName ?? ""));

      SharedPreferenceHelper.setString(
          Constants.userName, data.data?.authUser?.userName ?? "");
      SharedPreferenceHelper.setString(
          Constants.entityCode, data.data?.authUser?.entityCode ?? "");
      SharedPreferenceHelper.setString(Constants.entityLocationCode,
          data.data?.authUser?.entityLocationCode ?? "");
      notifyListeners();

      userApps = UserAppModel.fromJson(await userAPPAPI());
      if (userApps.isSuccess ?? false) {
        if ((userApps.data?.length ?? 0) > 0) {
          notifyListeners();
          var userArray = userApps.data ?? [];
          String currentRol = '';
          String currentRolName = '';
          if (userArray.isNotEmpty) {
            // for (int i = 0; i < userArray.length; i++) {
            //   if (userArray[i].serviceKey != "CNF") {
            //     SharedPreferenceHelper.setString(
            //         Constants.qamCode, userArray[i].serviceKey.toString());
            //     SharedPreferenceHelper.setString(Constants.cnfCode, 'CNF');
            //   }
            // }
            // for (int i = 0; i < userArray.length; i++) {
            //   if (userArray[i].serviceKey == "QAM") {
            //     currentRol = userArray[i].roleCode.toString();
            //     SharedPreferenceHelper.setString(
            //         Constants.currentRole, currentRol);
            //     currentRolName = userArray[i].roleName.toString();
            //     SharedPreferenceHelper.setString(
            //         Constants.currentRoleName, currentRolName);
            //   } else if (userArray[i].serviceKey == "CNF") {
            //     SharedPreferenceHelper.setString(
            //         Constants.cnfCode, userArray[i].serviceKey.toString());
            //   }
            // }
            for (int i = 0; i < userArray.length; i++) {
              if (userArray[i].serviceKey == "QAM") {
                SharedPreferenceHelper.setString(
                    Constants.qamCode, userArray[i].serviceKey.toString());
                currentRol = userArray[i].roleCode.toString();
                SharedPreferenceHelper.setString(
                    Constants.currentRole, currentRol);
                currentRolName = userArray[i].roleName.toString();
                SharedPreferenceHelper.setString(
                    Constants.currentRoleName, currentRolName);
                SharedPreferenceHelper.setString(Constants.cnfCode, 'CNF');
              }
              if (userArray[i].serviceKey == "CNF") {
                SharedPreferenceHelper.setString(
                    Constants.cnfCode, userArray[i].serviceKey.toString());
              }
            }
          } else {
            notifyListeners();
            _useCase.exceptionDialog("No Userapps found");
          }
          if (currentRol == "") {
            notifyListeners();
            _useCase.exceptionDialog("No roles assigned(UserApps)");
            return;
          }

          getLanguageAssignmentByUsercodeDetail =
              GetLanguageAssignmentByUsercodeModel.fromJson(
                  await getLanguageAssignmentByUsercodeAPI());
          GetMenusByRoleDetail = GetMenusByRoleandAppModel.fromJson(
              await getMenusByRoleandAppAPI(currentRol));

          if (getLanguageAssignmentByUsercodeDetail.isSuccess ?? false) {
            currentLang = (getLanguageAssignmentByUsercodeDetail
                    .data?[0].languageAssigned?[0].language
                    .toString())
                .toString();
            SharedPreferenceHelper.setString(
                Constants.currentLang,
                currentLang == ""
                    ? "EN"
                    : currentLang.isEmpty
                        ? "EN"
                        : currentLang);
          }

          if (GetMenusByRoleDetail.isSuccess ?? false) {
            var dataArr = GetMenusByRoleDetail.data ?? [];
            SharedPreferenceHelper.setInt(Constants.roleCount, dataArr.length);

            SharedPreferenceHelper.setString(
                Constants.firstMenu, dataArr[0].menuName ?? "");
            String firstMen = dataArr[0].menuName ?? "";
            SharedPreferenceHelper.setString("time", DateTime.now().toString());

            for (int i = 0; i < (dataArr.length); i++) {
              if (dataArr[i].menuName == "7.0 Audit") {
                SharedPreferenceHelper.setBool(Constants.audit7, true);
              } else {
                SharedPreferenceHelper.setBool(Constants.audit7, false);
              }
              if (dataArr[i].menuName == "Internal Audit") {
                SharedPreferenceHelper.setBool(Constants.IA, true);
              } else {
                SharedPreferenceHelper.setBool(Constants.IA, false);
              }
              if (dataArr[i].menuName == "Line QC") {
                SharedPreferenceHelper.setBool(Constants.lineQC, true);
              } else {
                SharedPreferenceHelper.setBool(Constants.lineQC, false);
              }
              if (dataArr[i].menuName == "PreProdnQA") {
                SharedPreferenceHelper.setBool(Constants.PreProdnQA, true);
              } else {
                SharedPreferenceHelper.setBool(Constants.PreProdnQA, false);
              }
            }
            // timeChecker(context);
            // TextInput.finishAutofillContext();
            if (Platform.isAndroid) {
              await insertUser(UserModel(
                  userCode: data.data?.authUser?.userCode ?? '',
                  username: userName,
                  password: passWord));
            }

            passWord = '';
            userName = '';
            userNameController.text = '';
            passWordController.text = '';
            if (firstMen == "7.0 Audit") {
              Navigator.pushNamedAndRemoveUntil(context,
                  Constants.dashBoardRoute, (Route<dynamic> route) => false);
            } else if (firstMen == "Internal Audit") {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  Constants.internalAuditUserboardRoute,
                  (Route<dynamic> route) => false);
            } else if (firstMen == "Line QC") {
              Navigator.pushNamedAndRemoveUntil(context,
                  Constants.userBoardRoute, (Route<dynamic> route) => false);
            } else if (firstMen == "PreProdnQA") {
              Navigator.pushNamedAndRemoveUntil(context, Constants.beforeWash,
                  (Route<dynamic> route) => false);
            } else {
              _useCase
                  .exceptionDialog("No roles assigned(No valid roles found)");
            }
          }
        } else {
          notifyListeners();
          _useCase.exceptionDialog("No Userapps found");
        }
      }
      debugPrint(userApps.isSuccess.toString());
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
      showErrorAlert(errorMessage);
    });
  }

  void onForgotPasswordMailChanged(String email) {
    forgotPasswordEmail = email;
    notifyListeners();
  }

  bool isForgotEmailValid = false;

  void validateEmail() {
    notifyListeners();
    isForgotEmailValid = _useCase.isValidEmail(forgotPasswordEmail);
    notifyListeners();
  }

  bool isForgotPassword = false;

  void setForgotPassword(bool isForgotPassword) {
    this.isForgotPassword = isForgotPassword;
    notifyListeners();
  }

  void onRequestPasswordClick(BuildContext context) {
    showErrorAlert(forgotPasswordEmail);
    if (forgotPasswordEmail.isNotEmpty) {
      notifyListeners();
      if (_useCase.isValidEmail(forgotPasswordEmail)) {
        onForgotPassword(context);
      } else {
        showErrorAlert('Invalid username!');
      }
    } else {
      showErrorAlert('Enter the username to reset your password!');
    }
  }

  showErrorAlert(String message) {
    CodeSnippet.instance.showAlertMsg(message);
  }

  void showSuccessAlert(String message) {
    CodeSnippet.instance.showSuccessMsg(message);
  }

  void logoutFun(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, Constants.onBoardingRoute, (Route<dynamic> route) => false);
  }

  void onForgotPassword(BuildContext context) {
    showProgress(context);
    notifyListeners();
    _useCase.onForgotPassword(userName, (data) {
      dismissProgress();
      notifyListeners();
      _useCase.exceptionDialog(data.message);
    }, (errorMessage) {
      dismissProgress();
      showErrorAlert(errorMessage);
    });
  }

  ResetPasswordRequest resetPass = ResetPasswordRequest();
  void clearResetValues() {
    old.text = '';
    newp.text = '';
    conf.text = '';

    notifyListeners();
  }

  void resetPasswrodFunction(BuildContext context) async {
    if (old.text.isEmpty || newp.text.isEmpty || conf.text.isEmpty) {
      showErrorAlert('Password is missing');
    } else if (newp.text != conf.text) {
      showErrorAlert('Password not match');
    } else {
      String userK = await SharedPreferenceHelper.getString(Constants.userCode);
      resetPass.userKey = userK;
      resetPass.currentPassword = old.text;
      resetPass.password = newp.text;
      showProgress(context);
      notifyListeners();
      _useCase.resetPassword(resetPass, (data) {
        dismissProgress();
        if (data.isSuccess) {
          FocusScope.of(context).requestFocus(FocusNode());
          old.text = '';
          newp.text = '';
          conf.text = '';
          showSuccessAlert('Changed Successfully');
        }
      }, (errorMessage) {
        dismissProgress();
        showErrorAlert(errorMessage);
      });
    }
  }

  String currentLang = "EN";
  bool firstTime = true;
  int timer = 2;
  void initFunciton() {
    if (timer > 0) {
      getLanguageAssignmentByUsercode();
      getAllLanguageInfo();
      timer = timer - 1;
    }
  }

  getLanguageAssignmentByUsercode() async {
    String usercode =
        await SharedPreferenceHelper.getString(Constants.userCode);
    notifyListeners();
    _useCase.getLanguageAssignmentByUsercodeData(usercode, (data) {
      getLanguageAssignmentByUsercodeDetail = data;
      currentLang = (getLanguageAssignmentByUsercodeDetail
              .data?[0].languageAssigned?[0].language
              .toString())
          .toString();
      SharedPreferenceHelper.setString(
          Constants.currentLang,
          currentLang == ""
              ? "EN"
              : currentLang.isEmpty
                  ? "EN"
                  : currentLang);
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });

    firstTime = false;
  }

  getAllLanguageInfo() {
    notifyListeners();
    _useCase.getAllLanguageInfoData((data) {
      getAllLanguageInfoDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
    firstTime = false;
  }

  void languageChangeFunction(String code) async {
    currentLang = code;
    String usercode =
        await SharedPreferenceHelper.getString(Constants.userCode);
    notifyListeners();
    _useCase.updateLanguageAssignmentAuditsByUsercode(usercode, code, (data) {
      getLanguageAssignmentByUsercode();
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
    notifyListeners();
  }

  exceptionDialog(String? message) {
    return Get.defaultDialog(
        title: "Errors",
        middleText: message ?? 'Some error occurred!',
        textCancel: "OK",
        confirmTextColor: const Color(0xffffffff),
        cancelTextColor: const Color(0xffF7931C),
        onCancel: () {},
        buttonColor: const Color(0xffF7931C));
  }

  Future userAPPAPI() async {
    var uris = Uri.http(ApiConstants.baseUrlhttp,
        '/api/Platform/UserApps/customerCode/userCode');
    if (ApiConstants.baseUrl == "https://gateway03.ithred.io/api/" ||
        ApiConstants.baseUrl == "https://gateway03c.ithred.io/api/") {
      uris = Uri.https(ApiConstants.baseUrlhttp,
          '/api/Platform/UserApps/customerCode/userCode');
    } else {
      uris = Uri.http(ApiConstants.baseUrlhttp,
          '/api/Platform/UserApps/customerCode/userCode');
    }

    String token = authToken;

    try {
      final response = await http.get(
        uris,
        headers: {
          "Content-Type": "application/json",
          'Authorization': token,
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      showErrorAlert(e.toString());
      debugPrint(e.toString());
    }
  }

  Future httpLoginAPI() async {
    var uris = Uri.http('api.bulkpe.inddd', '/api/login');
    if (ApiConstants.baseUrl == "https://gateway03.ithred.io/api/" ||
        ApiConstants.baseUrl == "https://gateway03c.ithred.io/api/") {
      uris = Uri.https('api.bulkpe.inddd', '/api/login');
    } else {
      uris = Uri.http('api.bulkpe.inddd', '/api/login');
    }
    String token = authToken;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(uris,
          headers: headers,
          body: jsonEncode({"phone": "8637685085", "password": "Venkat@123"}));

      showErrorAlert(response.body.toString());
      debugPrint(response.body.toString());
      return jsonDecode(response.body);
    } catch (e) {
      showErrorAlert(e.toString());
      debugPrint(e.toString());
    }
  }

  Future getLanguageAssignmentByUsercodeAPI() async {
    var uris = Uri.http(ApiConstants.baseUrlhttp, '/api/Apps/Get');
    if (ApiConstants.baseUrl == "https://gateway03.ithred.io/api/" ||
        ApiConstants.baseUrl == "https://gateway03c.ithred.io/api/") {
      uris = Uri.https(ApiConstants.baseUrlhttp, '/api/Apps/Get');
    } else {
      uris = Uri.http(ApiConstants.baseUrlhttp, '/api/Apps/Get');
    }

    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    String token = authToken;
    String? userCode = prefs.getString(Constants.userCode);
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "${ApiConstants.getLanguageAssignmentByUsercode}$userCode",
      "bodyContent": ""
    };

    try {
      final response = await http.post(uris,
          headers: {
            "Content-Type": "application/json",
            'Authorization': token,
          },
          body: jsonEncode(apiData));

      return jsonDecode(response.body);
    } catch (e) {
      showErrorAlert(e.toString());
      debugPrint(e.toString());
    }
  }

  Future getMenusByRoleandAppAPI(currentRol) async {
    var uris = Uri.http(ApiConstants.baseUrlhttp, '/api/Apps/Get');

    if (ApiConstants.baseUrl == "https://gateway03.ithred.io/api/" ||
        ApiConstants.baseUrl == "https://gateway03c.ithred.io/api/") {
      uris = Uri.https(ApiConstants.baseUrlhttp, '/api/Apps/Get');
    } else {
      uris = Uri.http(ApiConstants.baseUrlhttp, '/api/Apps/Get');
    }
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    String token = authToken;
    String? userCode = prefs.getString(Constants.userCode);
    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints": "${ApiConstants.getMenusByRoleandApp}/$currentRol/QAM",
      "bodyContent": ""
    };

    try {
      final response = await http.post(uris,
          headers: {
            "Content-Type": "application/json",
            'Authorization': token,
          },
          body: jsonEncode(apiData));

      return jsonDecode(response.body);
    } catch (e) {
      showErrorAlert(e.toString());
      debugPrint(e.toString());
    }
  }

  late Future<Database> database;
  List<UserModel> savedUsers = [];
  void dbInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'qam.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(userCode TEXT PRIMARY KEY, username TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(UserModel loginModel) async {
    final db = await database;
    await db.insert(
      'users',
      loginModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserModel>> userList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return UserModel(
        userCode: maps[i]['userCode'],
        username: maps[i]['username'],
        password: maps[i]['password'],
      );
    });
  }

  void clearAllDataFromDB() async {
    final db = await database;
    await db.delete('users');
  }

  void savedUserChecker(context) async {
    // clearAllDataFromDB();
    if (Platform.isAndroid) {
      savedUsers = await userList();

      if (savedUsers.isNotEmpty) {
        FocusScope.of(context).requestFocus(FocusNode());
        Get.defaultDialog(
            title: '',
            content: SizedBox(
              width: 400,
              child: Column(
                children: [
                  for (int i = 0; i < savedUsers.length; i++)
                    GestureDetector(
                        onTap: () {
                          TextEditingController(
                              text: savedUsers[i].username ?? '');
                          TextEditingController(
                              text: savedUsers[i].password ?? '');
                          userNameController.text =
                              savedUsers[i].username ?? '';
                          passWordController.text =
                              savedUsers[i].password ?? '';
                          userName = savedUsers[i].username ?? '';
                          passWord = savedUsers[i].password ?? '';
                          notifyListeners();
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.2,
                                          color: const Color(0xff000000)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(savedUsers[i].username ?? '')),
                            ),
                          ],
                        )),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid) {
                        clearAllDataFromDB();
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: const Color(0xff000000)),
                          borderRadius: BorderRadius.circular(40)),
                      child: const Text('Clear'),
                    ),
                  )
                ],
              ),
            ),
            confirmTextColor: const Color(0xffffffff),
            cancelTextColor: const Color(0xffF7931C),
            buttonColor: const Color(0xffF7931C));
      }
    }
  }
}
