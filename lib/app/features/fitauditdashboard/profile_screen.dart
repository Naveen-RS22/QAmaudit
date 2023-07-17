import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/api_constants.dart';
import 'package:qapp/app/data/network/dto/GetLanguageAssignmentByUsercodeModel.dart';
import 'package:qapp/app/features/onboarding/on_boarding_view_model.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/utils/code_snippet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ota_update/ota_update.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  OnBoardingViewModel viewModel = OnBoardingViewModel();
  GetLanguageAssignmentByUsercodeModel getLanguageAssignmentByUsercodeDetail =
      GetLanguageAssignmentByUsercodeModel();
  String currentLang = '';

  Future getlanguageassigmentAPI() async {
    var uris = Uri.http(ApiConstants.baseUrlhttp, '/api/Apps/Get');

    if (ApiConstants.baseUrl == "https://gateway03.ithred.io/api/" ||
        ApiConstants.baseUrl == "https://gateway03c.ithred.io/api/") {
      uris = Uri.https(ApiConstants.baseUrlhttp, '/api/Apps/Get');
    } else {
      uris = Uri.http(ApiConstants.baseUrlhttp, '/api/Apps/Get');
    }
    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    String token = await SharedPreferenceHelper.getString(Constants.tokenData);
    String usercode =
        await SharedPreferenceHelper.getString(Constants.userCode);

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "AssignmentAudits/GetLanguageAssignmentByUsercode/$usercode",
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
      debugPrint(e.toString());
    }
  }

  Future UpdateLanguageAssignmentAuditsByUsercodeAPI(
      String languagecode) async {
    var uris = Uri.http(ApiConstants.baseUrlhttp, '/api/Apps/Post');
    if (ApiConstants.baseUrl == "https://gateway03.ithred.io/api/" ||
        ApiConstants.baseUrl == "https://gateway03c.ithred.io/api/") {
      uris = Uri.https(ApiConstants.baseUrlhttp, '/api/Apps/Post');
    } else {
      uris = Uri.http(ApiConstants.baseUrlhttp, '/api/Apps/Post');
    }

    SharedPreferences prefs = await SharedPreferenceHelper.prefs;
    String token = await SharedPreferenceHelper.getString(Constants.tokenData);
    String usercode =
        await SharedPreferenceHelper.getString(Constants.userCode);

    Map<String, dynamic> apiData;
    apiData = {
      "appCode": prefs.getString(Constants.cnfCode),
      "entityCode": prefs.getString(Constants.entityCode),
      "appEndpoints":
          "AssignmentAudits/UpdateLanguageAssignmentAuditsByUsercode?usercode=$usercode&languagecode=$languagecode",
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
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    // viewModel = Provider.of<OnBoardingViewModel>(context, listen: true);
    super.initState();
    intitFunction();
  }

  void intitFunction() async {
    getLanguageAssignmentByUsercodeDetail =
        GetLanguageAssignmentByUsercodeModel.fromJson(
            await getlanguageassigmentAPI());
    currentLang =
        (getLanguageAssignmentByUsercodeDetail.data?[0].languageAssigned ??
                [])[0]
            .language
            .toString();
    if (mounted) {
      setState(() {});
    }
    print(currentLang);
  }

  // @override
  // @protected
  // @mustCallSuper
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   viewModel = Provider.of<OnBoardingViewModel>(context, listen: true);
  //   viewModel.initFunciton();
  // }

  OtaEvent? currentEvent;
  bool loading = false;
  void tryOTA() {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      OtaUpdate()
          .execute(
        'https://api.bulkpe.in/otaapp.apk',
        // OPTIONAL
        destinationFilename: 'otaapp.apk',
        //OPTIONAL, ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
      )
          .listen(
        (OtaEvent event) {
          setState(() => currentEvent = event);
        },
      );
      showErrorAlert((currentEvent?.status ?? '').toString());

      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      showErrorAlert('Failed to make OTA update. Details: $e');
    }
  }

  void showErrorAlert(String message) {
    CodeSnippet.instance.showAlertMsg(message);
  }

  @override
  Widget build(BuildContext context) {
    // viewModel = Provider.of<OnBoardingViewModel>(context, listen: true);
    // viewModel.initFunciton();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: _profileWidget(viewModel)),
    );
  }

  _profileWidget(OnBoardingViewModel viewModel) => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.loginBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [_buildLogin(context, viewModel)],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: false,
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  _buildLogin(BuildContext context, OnBoardingViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.75,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 30,
        blur: 90,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFe6e6e6).withOpacity(0.1),
              const Color(0xFFe6e6e6).withOpacity(0.05),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFe6e6e6).withOpacity(0.5),
            const Color((0xFFe6e6e6)).withOpacity(0.5),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // tryOTA();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Personal Preferance',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        if (loading)
                          const CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Language',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            if ((getLanguageAssignmentByUsercodeDetail
                                        .data?[0].languageList ??
                                    [])
                                .isNotEmpty)
                              for (int i = 0;
                                  i <
                                      (getLanguageAssignmentByUsercodeDetail
                                                  .data?[0].languageList ??
                                              [])
                                          .length;
                                  i++)
                                GestureDetector(
                                  onTap: () {
                                    print((getLanguageAssignmentByUsercodeDetail
                                                .data?[0].languageList ??
                                            [])[i]
                                        .languageName);
                                    UpdateLanguageAssignmentAuditsByUsercodeAPI(
                                        (getLanguageAssignmentByUsercodeDetail
                                                    .data?[0].languageList ??
                                                [])[i]
                                            .languageCode
                                            .toString());

                                    setState(() {
                                      currentLang =
                                          (getLanguageAssignmentByUsercodeDetail
                                                      .data?[0].languageList ??
                                                  [])[i]
                                              .languageCode
                                              .toString();
                                    });

                                    SharedPreferenceHelper.setString(
                                        Constants.currentLang,
                                        currentLang.isEmpty
                                            ? "EN"
                                            : currentLang);
                                  },
                                  child: Container(
                                    width: 75,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: currentLang ==
                                                (getLanguageAssignmentByUsercodeDetail
                                                            .data?[0]
                                                            .languageList ??
                                                        [])[i]
                                                    .languageCode
                                            ? const Color(0xfff6802a)
                                            : Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Text(
                                      (getLanguageAssignmentByUsercodeDetail
                                                  .data?[0].languageList ??
                                              [])[i]
                                          .translationName
                                          .toString(),
                                      style: TextStyle(
                                        color: currentLang ==
                                                (getLanguageAssignmentByUsercodeDetail
                                                            .data?[0]
                                                            .languageList ??
                                                        [])[i]
                                                    .languageCode
                                            ? const Color(0xffffffff)
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Metrics',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(3)),
                              child: const Text(
                                'Feet',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color(0xfff6802a),
                                  borderRadius: BorderRadius.circular(3)),
                              child: const Text(
                                'Meters',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Currency',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(3)),
                              child: const Text(
                                'Rupees',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color(0xfff6802a),
                                  borderRadius: BorderRadius.circular(3)),
                              child: const Text(
                                'Dollars',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(3)),
                              child: const Text(
                                'Pounds',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reset Password',
                          style: TextStyle(fontSize: 30),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: viewModel.old,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            hintText: 'Old Password',
                            hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black45),
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.black),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          onChanged: (name) => {viewModel.userName = name},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: viewModel.newp,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            hintText: 'New Password',
                            hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black45),
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.black),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          onChanged: (name) => {viewModel.userName = name},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: viewModel.conf,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            hintText: 'Re-enter Password',
                            hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black45),
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.black),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          onChanged: (name) => {viewModel.userName = name},
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  viewModel.resetPasswrodFunction(context);
                                },
                                child: Center(
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 10, 30, 10),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      'Reset',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// IMPORT PACKAGE


  // RUN OTA UPDATE 
  // START LISTENING FOR DOWNLOAD PROGRESS REPORTING EVENTS
  