import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/features/inline/inline_screen.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';

import 'package:qapp/app/features/userboard/userboard_view_model.dart';
import 'package:qapp/app/features/userboard/widgets/defects_by_parts_chart.dart';
import 'package:qapp/app/features/userboard/widgets/final_audit_card.dart';
import 'package:qapp/app/features/userboard/widgets/pieces_status_card.dart';
import 'package:qapp/app/features/userboard/widgets/time_session_card.dart';

import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/widgets/app_logo_with_name.dart';
import 'package:qapp/app/widgets/profile_tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/style_info_card.dart';

class UserboardScreen extends StatefulWidget {
  static const String path = "UserboardScreen";

  const UserboardScreen({Key? key}) : super(key: key);

  @override
  _UserboardScreenState createState() => _UserboardScreenState();
}

class _UserboardScreenState extends State<UserboardScreen> {
  UserboardViewModel viewModel = UserboardViewModel();
  InlineViewModal inlineViewModel = InlineViewModal();

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  int roleCounts = 0;

  bool Audit7 = false;
  bool internalAudit = false;
  bool lineQCA = false;
  bool preProd = false;

  @override
  void initState() {
    final viewsData = Provider.of<UserboardViewModel>(context, listen: false);
    final inlineViewMData =
        Provider.of<InlineViewModal>(context, listen: false);
    Future.delayed(Duration.zero, () {
      getRoleCount();
      getRoleAccess();
      // viewsData.onGetAuditSummary(context);
      viewsData.resetDashBoardScreen();
      viewsData.onGetAuditSummaryForStyleInfo(context);
    });
    super.initState();
  }

  void getRoleCount() async {
    roleCounts = await SharedPreferenceHelper.getInt(Constants.roleCount);
  }

  void getRoleAccess() async {
    Audit7 = await SharedPreferenceHelper.getBool(Constants.audit7);
    internalAudit = await SharedPreferenceHelper.getBool(Constants.IA);
    lineQCA = await SharedPreferenceHelper.getBool(Constants.lineQC);
    preProd = await SharedPreferenceHelper.getBool(Constants.PreProdnQA);
  }

  @override
  Widget build(BuildContext context) {
    final views = Provider.of<UserboardViewModel>(context);
    final viewsData = Provider.of<UserboardViewModel>(context);
    final inlineViewData = Provider.of<InlineViewModal>(context);
    final iaViewData = Provider.of<InternalAuditViewModal>(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () async {
            String vl =
                await SharedPreferenceHelper.getString(Constants.currentLang);
          },
          child: PageView.builder(
            itemCount: roleCounts > 1 ? 2 : 1,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? _buildBody(
                      context, views, viewsData, inlineViewData, iaViewData)
                  : _menuControl(context, false, false, false, false);
            },
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            },
          ),
        ),
      ),
    );
  }

  Widget _menuControl(context, Audit7, internalAudit, lineQCA, preProd) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/login/loginBg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              verticalDirection: VerticalDirection.down,
              children: [
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _menuModelPopup(context);
                          });
                    },
                    child: _menuSlide(context)),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _menuModelTwoPopup(context);
                          });
                    },
                    child: _menuSlideTwo(context)),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _menuThreeModelPopup(
                                context,
                                "PreProduction Sample",
                                "assets/dashboard/SPI.png");
                          });
                    },
                    child: _menuThreeSlide(
                        context,
                        "PreProduction Sample",
                        "assets/dashboard/Fusing.png",
                        "assets/dashboard/SPI.png")),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _menuFourModelPopup(context, "Image Gallery",
                                "assets/dashboard/endline.png");
                          });
                    },
                    child: _menuFourSlide(
                        context,
                        "Image Gallery",
                        "assets/dashboard/endline.png",
                        "assets/dashboard/endline.png")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuSlide(context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.2,
              child: GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 90,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/dashboard/cutting.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/dashboard/inline.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/dashboard/endline.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/dashboard/finishing.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Quality Control")
          ],
        ));
  }

  Widget _menuSlideTwo(context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.2,
              child: GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 90,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/dashboard/Audit.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/dashboard/Audit.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/dashboard/Internal.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Quality Audit")
          ],
        ));
  }

  Widget _menuTwoSlide(
      context, String titleString, String image1, String image2) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.2,
              child: GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 90,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(image1),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(image2),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(titleString)
          ],
        ));
  }

  Widget _menuThreeSlide(
      context, String titleString, String image1, String image2) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.2,
              child: GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 90,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(image1),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(titleString)
          ],
        ));
  }

  Widget _menuFourSlide(
      context, String titleString, String image1, String image2) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.2,
              child: GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 90,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * 0.35) /
                                      3,
                              width:
                                  (MediaQuery.of(context).size.width * 0.2) / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(image1),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(titleString)
          ],
        ));
  }

  Widget _menuModelPopup(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.725,
                width: MediaQuery.of(context).size.width * 0.35,
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 20,
                  blur: 90,
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
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Navigator.pushNamed(
                                          context, Constants.CutInspection);
                                      // const _snackBar = SnackBar(
                                      //     content: Text('Coming soon !!!'),
                                      //     backgroundColor: Color(0xffF7931C),
                                      //     duration: Duration(seconds: 3),
                                      //     action: null);
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(_snackBar);
                                    },
                                    child: Column(children: [
                                      Container(
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75) /
                                              3,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55) /
                                              4,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/dashboard/cutting.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: null),
                                      const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              "Cutting",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ]),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Navigator.pushNamed(
                                          context, Constants.userBoardRoute);
                                    },
                                    child: Column(children: [
                                      Container(
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75) /
                                              3,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55) /
                                              4,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/dashboard/inline.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: null),
                                      const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text("Inline",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )),
                                    ]),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();

                                      Navigator.pushNamed(
                                          context, Constants.userBoardRoute);
                                    },
                                    child: Column(children: [
                                      Container(
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75) /
                                              3,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55) /
                                              4,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/dashboard/endline.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: null),
                                      const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text("Endline",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )),
                                    ]),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.back();
                                        Navigator.pushNamed(
                                            context, Constants.userBoardRoute);
                                        // const _snackBar = SnackBar(
                                        //     content: Text('Coming soon !!!'),
                                        //     backgroundColor: Color(0xffF7931C),
                                        //     duration: Duration(seconds: 3),
                                        //     action: null);
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(_snackBar);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.75) /
                                                  3,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.55) /
                                                  4,
                                              decoration: BoxDecoration(
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/dashboard/finishing.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: null),
                                          const Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text("Finishing",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              )),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ))),
                ),
              ),
            ],
          )),
    );
  }

  Widget _menuModelTwoPopup(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.725,
                width: MediaQuery.of(context).size.width * 0.35,
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 20,
                  blur: 90,
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
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Navigator.pushNamed(
                                          context, Constants.dashBoardRoute);
                                      // const _snackBar = SnackBar(
                                      //     content: Text('Coming soon !!!'),
                                      //     backgroundColor: Color(0xffF7931C),
                                      //     duration: Duration(seconds: 3),
                                      //     action: null);
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(_snackBar);
                                    },
                                    child: Column(children: [
                                      Container(
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75) /
                                              3,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55) /
                                              4,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/dashboard/Audit.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: null),
                                      const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              "7.0 Audit",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ]),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Navigator.pushNamed(context,
                                          Constants.fitAuditDashBoardRoute);
                                    },
                                    child: Column(children: [
                                      Container(
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75) /
                                              3,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55) /
                                              4,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/dashboard/Audit.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: null),
                                      const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text("Fit Audit",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )),
                                    ]),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();

                                      Navigator.pushNamed(
                                          context,
                                          Constants
                                              .internalAuditUserboardRoute);
                                    },
                                    child: Column(children: [
                                      Container(
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75) /
                                              3,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55) /
                                              4,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/dashboard/Internal.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: null),
                                      const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text("Internal Audit",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )),
                                    ]),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ))),
                ),
              ),
            ],
          )),
    );
  }

  Widget _menuTwoModelPopup(
      context,
      String titleString1,
      String titleStringN,
      String titleString2,
      String image1,
      String image2,
      Audit7,
      internalAudit,
      lineQCA,
      preProd) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.725,
                width: MediaQuery.of(context).size.width * 0.35,
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 20,
                  blur: 90,
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
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: Audit7 ? false : true,
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          Navigator.pushNamed(context,
                                              Constants.dashBoardRoute);
                                          // if (titleString1 == "7.O Audit") {
                                          //   Navigator.pushNamed(
                                          //       context, Constants.userBoardRoute);
                                          //   return;
                                          // }
                                          // const _snackBar = SnackBar(
                                          //     content: Text('Coming soon !!!'),
                                          //     backgroundColor: Color(0xffF7931C),
                                          //     duration: Duration(seconds: 3),
                                          //     action: null);
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(_snackBar);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.75) /
                                                  3,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.55) /
                                                  4,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(image1),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: null,
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(titleString1,
                                                      style: const TextStyle(
                                                          color: Colors.white)),
                                                )),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.back();
                                        Navigator.pushNamed(
                                            context,
                                            Constants
                                                .internalAuditUserboardRoute);
                                        // const _snackBar = SnackBar(
                                        //     content: Text('Coming soon !!!'),
                                        //     backgroundColor: Color(0xffF7931C),
                                        //     duration: Duration(seconds: 3),
                                        //     action: null);
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(_snackBar);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.75) /
                                                3,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.55) /
                                                4,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(image2),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: null,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Text(titleString2,
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                              )),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ))),
                ),
              ),
            ],
          )),
    );
  }

  Widget _menuThreeModelPopup(
    context,
    String titleString1,
    String image1,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.725,
                width: MediaQuery.of(context).size.width * 0.35,
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 20,
                  blur: 90,
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
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.back();
                                        Navigator.pushNamed(
                                            context, Constants.beforeWash);
                                        // if (titleString1 == "7.O Audit") {
                                        //   Navigator.pushNamed(
                                        //       context, Constants.userBoardRoute);
                                        //   return;
                                        // }
                                        // const _snackBar = SnackBar(
                                        //     content: Text('Coming soon !!!'),
                                        //     backgroundColor: Color(0xffF7931C),
                                        //     duration: Duration(seconds: 3),
                                        //     action: null);
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(_snackBar);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.75) /
                                                3,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.55) /
                                                4,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(image1),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: null,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Text(titleString1,
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                              )),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ))),
                ),
              ),
            ],
          )),
    );
  }

  Widget _menuFourModelPopup(
    context,
    String titleString1,
    String image1,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.725,
                width: MediaQuery.of(context).size.width * 0.35,
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 20,
                  blur: 90,
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
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.back();
                                        Navigator.pushNamed(
                                            context, Constants.imageGallery);
                                        // if (titleString1 == "7.O Audit") {
                                        //   Navigator.pushNamed(
                                        //       context, Constants.userBoardRoute);
                                        //   return;
                                        // }
                                        // const _snackBar = SnackBar(
                                        //     content: Text('Coming soon !!!'),
                                        //     backgroundColor: Color(0xffF7931C),
                                        //     duration: Duration(seconds: 3),
                                        //     action: null);
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(_snackBar);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.75) /
                                                3,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.55) /
                                                4,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(image1),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: null,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Text(titleString1,
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                              )),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ))),
                ),
              ),
            ],
          )),
    );
  }

  _buildBody(
          BuildContext context,
          UserboardViewModel views,
          UserboardViewModel viewsData,
          InlineViewModal inlineViewData,
          InternalAuditViewModal iaViewData) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: _buildAppBar(views),
          ),
          if (views.isDashScreen)
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      views.finalAuditRoundOnChangeStyleChange(context, 'IL');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: views.finalAuditRound == 'IL'
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                              width: 1),
                          color: views.finalAuditRound == 'IL'
                              ? Colors.blue
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Inline',
                        style: TextStyle(
                            color: views.finalAuditRound == 'IL'
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      views.finalAuditRoundOnChangeStyleChange(context, 'EL');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: views.finalAuditRound == 'EL'
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                              width: 1),
                          color: views.finalAuditRound == 'EL'
                              ? Colors.blue
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Endline',
                        style: TextStyle(
                            color: views.finalAuditRound == 'EL'
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      views.finalAuditRoundOnChangeStyleChange(context, 'FG');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: views.finalAuditRound == 'FG'
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                              width: 1),
                          color: views.finalAuditRound == 'FG'
                              ? Colors.blue
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Finishing',
                        style: TextStyle(
                            color: views.finalAuditRound == 'FG'
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      views.setIsDashboardScreen(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 1),
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'View Dashbord',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          if (views.isDashScreen)
            entryWidget(views, context, inlineViewData, iaViewData),
          if (!views.isDashScreen)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSecondRow(context, views),
                    const SizedBox(height: 10),
                    if (views.styleInfoExpanded)
                      _buildThirdRow(
                          context, views, inlineViewData, iaViewData),
                    _buildLastRow(context, views, viewsData, inlineViewData)
                  ],
                ),
              ),
            ),
        ],
      );

  Expanded entryWidget(UserboardViewModel views, BuildContext context,
      InlineViewModal inlineViewData, InternalAuditViewModal iaViewData) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: _buildThirdRowForOpenDash(
                context, views, inlineViewData, iaViewData),
          )
        ],
      ),
    );
  }

  _buildThirdRow(BuildContext context, UserboardViewModel views,
          InlineViewModal inlineView, InternalAuditViewModal iaViewData) =>
      Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [
              context.res.color.cardGradStart,
              context.res.color.cardGradEnd
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Style Information',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffffffff),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    inlineView.clearSaveOrderScheduleRequestData(iaViewData);
                    inlineView.getUserDepartmentListAPI(context);
                    inlineView.getActiveAuditTypeByRptGroupAPI(context, 'LQ');
                    inlineView.getUserDepartmentListAPI(context);
                    inlineView.getActiveAuditTypeByRptGroupAPI(context, 'LQ');
                    inlineView.getAllBuyerDivInfoDataAPI(context);
                    inlineView.GetAllActiveFactoryAPI(context);

                    Future<void> infoPopup() async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: true, // user must tap button!
                        builder: (context) {
                          return InfoPopup(views, inlineView);
                        },
                      );
                    }

                    infoPopup();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        const Text('Add New Schedule'),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(ImagePath.PlusCircle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (!views.isDashScreen)
                  GestureDetector(
                    onTap: () {
                      views.setStyleInfoExpanded();
                    },
                    child: SvgPicture.asset(ImagePath.minIcon),
                  )
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Row(
                children: [
                  Expanded(
                      child: Text(
                    'Style No',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Line',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Div',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Order No',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Color',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Total Inspected Pcs',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Total Defect Pcs',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'DHU %',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Action',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: (views.scheduleList.data ?? []).length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index].styleNo ?? '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index].lineName ?? '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index].buyerCode ?? '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index]
                            .orderNo
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index].styleNo ?? '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        ((views.scheduleList.data ?? [])[index]
                                    .totalInspectedPcs ??
                                0)
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        ((views.scheduleList.data ?? [])[index]
                                    .totalDefectPcs ??
                                0)
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        ((views.scheduleList.data ?? [])[index].dhu ?? 0)
                            .toStringAsFixed(2)
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const InlineScreen(),
                                        settings: RouteSettings(
                                            arguments:
                                                (views.scheduleList.data ??
                                                    [])[index])));
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: context.res.color.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: context.res.color.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );

  _buildThirdRowForOpenDash(BuildContext context, UserboardViewModel views,
          InlineViewModal inlineView, InternalAuditViewModal iaViewData) =>
      Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [
              context.res.color.cardGradStart,
              context.res.color.cardGradEnd
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Style Information',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffffffff),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    inlineView.clearSaveOrderScheduleRequestData(iaViewData);
                    inlineView.getUserDepartmentListAPI(context);
                    inlineView.getActiveAuditTypeByRptGroupAPI(context, 'LQ');
                    inlineView.getUserDepartmentListAPI(context);
                    inlineView.getActiveAuditTypeByRptGroupAPI(context, 'LQ');
                    inlineView.getAllBuyerDivInfoDataAPI(context);
                    inlineView.GetAllActiveFactoryAPI(context);

                    Future<void> infoPopup() async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: true, // user must tap button!
                        builder: (context) {
                          return InfoPopup(views, inlineView);
                        },
                      );
                    }

                    infoPopup();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        const Text('Add New Schedule'),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(ImagePath.PlusCircle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (!views.isDashScreen)
                  GestureDetector(
                    onTap: () {
                      views.setStyleInfoExpanded();
                    },
                    child: SvgPicture.asset(ImagePath.minIcon),
                  )
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Row(
                children: [
                  Expanded(
                      child: Text(
                    'Style No',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Line',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Div',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Order No',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Color',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Total Inspected Pcs',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Total Defect Pcs',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'DHU %',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Action',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (views.scheduleList.data ?? []).length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index].styleNo ?? '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index].lineName ?? '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index].buyerCode ?? '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index]
                            .orderNo
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.scheduleList.data ?? [])[index].styleNo ?? '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        ((views.scheduleList.data ?? [])[index]
                                    .totalInspectedPcs ??
                                0)
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        ((views.scheduleList.data ?? [])[index]
                                    .totalDefectPcs ??
                                0)
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        ((views.scheduleList.data ?? [])[index].dhu ?? 0)
                            .toStringAsFixed(2)
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const InlineScreen(),
                                        settings: RouteSettings(
                                            arguments:
                                                (views.scheduleList.data ??
                                                    [])[index])));
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: context.res.color.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: context.res.color.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );

  _buildAppBar(UserboardViewModel view) => GlassmorphicContainer(
        width: double.infinity,
        height: 92,
        borderRadius: 0,
        blur: 10,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFe6e6e6).withOpacity(0.1),
              const Color(0xFF227DD7).withOpacity(0.05),
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
          padding: const EdgeInsets.fromLTRB(20, 10, 40, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppLogoWithName(
                back: false,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        view.setIsDashboardScreen(context);
                      },
                      child: const Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.blue,
                      )),
                  const SizedBox(width: 16),
                  GestureDetector(
                      onTap: () {
                        view.refreshData(context);
                      },
                      child: Image(
                        height: 30,
                        width: 30,
                        image: AssetImage(ImagePath.refreshIcon),
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(width: 16),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Constants.calendarRoute);
                      },
                      child: Image(
                        height: 35,
                        width: 35,
                        image: AssetImage(ImagePath.calendarIcon),
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(width: 16),
                  VerticalDivider(
                    color: context.res.color.bgColorBlue.withOpacity(0.2),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {},
                    child: Image(
                      height: 30,
                      width: 30,
                      image: AssetImage(ImagePath.notificationDummy),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 40),
                  PopupMenuButton(
                    onSelected: (result) {},
                    offset: const Offset(-20, 45),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        value: 1,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Constants.profileRoute);
                            },
                            child: const Text('Reset password')),
                      ),
                      PopupMenuItem(
                        value: 2,
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferenceHelper.prefs;
                          prefs.clear();

                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              Constants.onBoardingRoute,
                              (Route<dynamic> route) => false);
                        },
                        child: Container(child: const Text('Logout')),
                      ),
                    ],
                    child: const ProfileToolBar(),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  _buildSecondRow(BuildContext context, UserboardViewModel views) {
    var inspData = views.getQcData.data?.inspectedInfo ?? [];

    int? inspectedPcs = inspData.isNotEmpty ? inspData[0].inspectedPcs : 0;
    int? currentInspectedPcs =
        inspData.isNotEmpty ? inspData[0].currentInspectedPcs : 0;
    int? prevInspectedPcs =
        inspData.isNotEmpty ? inspData[0].prevInspectedPcs : 0;
    int? passedPcs = inspData.isNotEmpty ? inspData[0].passedPcs : 0;
    int? currentPassedPcs =
        inspData.isNotEmpty ? inspData[0].currentPassedPcs : 0;
    int? prevPassedPcs = inspData.isNotEmpty ? inspData[0].prevPassedPcs : 0;
    int? defectedPcs = inspData.isNotEmpty ? inspData[0].defectedPcs : 0;
    int? currentDefectedPcs =
        inspData.isNotEmpty ? inspData[0].currentDefectedPcs : 0;
    int? prevDefectedPcs =
        inspData.isNotEmpty ? inspData[0].prevDefectedPcs : 0;

    double inspPercent = 0;
    bool? insCheckerPercent;
    bool insppcsStatus = false;
    if (currentInspectedPcs == 0 || prevInspectedPcs == 0) {
      inspPercent = 0;
      insCheckerPercent = false;
    } else {
      int val1 = currentInspectedPcs! - prevInspectedPcs!;
      double val2 = val1 / prevInspectedPcs;
      inspPercent = val2 * 100;
      insCheckerPercent = true;
      if (inspPercent > 0) {
        insppcsStatus = true;
      } else {
        insppcsStatus = false;
      }
    }

    double passPercent = 0;
    bool? passCheckerPercent;
    bool passStatus = false;

    if (currentPassedPcs == 0 || prevPassedPcs == 0) {
      passPercent = 0;
      passCheckerPercent = false;
    } else {
      int val1 = currentPassedPcs! - prevPassedPcs!;
      double val2 = val1 / prevPassedPcs;
      passPercent = val2 * 100;
      passCheckerPercent = true;

      if (passPercent > 0) {
        passStatus = true;
      } else {
        passStatus = false;
      }
    }

    double defPercent = 0;
    bool? defCheckerPercent;
    bool defStatus = false;

    if (currentDefectedPcs == 0 || prevDefectedPcs == 0) {
      defPercent = 0;
      defCheckerPercent = false;
    } else {
      int val1 = currentDefectedPcs! - prevDefectedPcs!;
      double val2 = val1 / prevDefectedPcs;
      defPercent = val2 * 100;
      defCheckerPercent = true;
      if (defPercent > 0) {
        defStatus = true;
      } else {
        defStatus = false;
      }
    }

    double curDHUPercent = 0;
    double prevDHUPercent = 0;
    double DHUPercent = 0;
    double DHUPercentTotal = 0;
    bool? DHUCheckerPercentTotal;
    bool? DHUCheckerPercent;
    bool DHUStatus = false;

    if (defectedPcs == 0 || inspectedPcs == 0) {
      DHUPercentTotal = 0;
      DHUCheckerPercentTotal = false;
    } else {
      DHUPercentTotal = ((defectedPcs ?? 0) / (inspectedPcs ?? 0)) * 100;
      DHUCheckerPercentTotal = true;
    }

    if (currentDefectedPcs == 0 || currentInspectedPcs == 0) {
      curDHUPercent = 0;
    } else {
      curDHUPercent =
          ((currentDefectedPcs ?? 0) / (currentInspectedPcs ?? 0)) * 100;
    }

    if (prevDefectedPcs == 0 || prevInspectedPcs == 0) {
      prevDHUPercent = 0;
    } else {
      prevDHUPercent = ((prevDefectedPcs ?? 0) / (prevInspectedPcs ?? 0)) * 100;
    }

    if (curDHUPercent == 0 || prevDHUPercent == 0) {
      DHUCheckerPercent = false;
    } else {
      DHUCheckerPercent = true;
    }

    DHUPercent = prevDHUPercent - curDHUPercent;
    if (DHUPercent > 0) {
      DHUStatus = true;
    } else {
      DHUStatus = false;
    }

    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PiecesStatusCard(
              views,
              "Inspected Pcs",
              inspectedPcs ?? 0,
              currentInspectedPcs ?? 0,
              inspPercent,
              insppcsStatus,
              insCheckerPercent,
              false),
          PiecesStatusCard(
              views,
              "Passed Pcs",
              passedPcs ?? 0,
              currentPassedPcs ?? 0,
              passPercent,
              passStatus,
              passCheckerPercent,
              false),
          PiecesStatusCard(
              views,
              "Defect Pcs",
              defectedPcs ?? 0,
              currentDefectedPcs ?? 0,
              defPercent,
              defStatus,
              defCheckerPercent,
              false),
          PiecesStatusCard(
              views,
              "DHU %",
              DHUPercent.round(),
              curDHUPercent.round(),
              curDHUPercent,
              DHUStatus,
              DHUCheckerPercentTotal,
              DHUCheckerPercent),
        ],
      ),
    );
  }

  _buildLastRow(BuildContext context, UserboardViewModel views,
          UserboardViewModel viewsData, InlineViewModal inlineViewData) =>
      Flexible(
        fit: FlexFit.loose,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: FinalAuditCard(views: views)),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(child: DefectsByPartsWidgets(views: views)),
                    Expanded(
                      child: Column(
                        children: [
                          if (!views.styleInfoExpanded)
                            StyleInfoCard(
                                views: views, inlineViewData: inlineViewData),
                          TopThreeDefects(
                            views: views,
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      );
}

class InfoPopup extends StatefulWidget {
  final UserboardViewModel view;
  final InlineViewModal inlineView;

  const InfoPopup(this.view, this.inlineView, {Key? key}) : super(key: key);

  @override
  InfoPopupState createState() => InfoPopupState();
}

class InfoPopupState extends State<InfoPopup> {
  UserboardViewModel views = UserboardViewModel();
  InlineViewModal inlineView = InlineViewModal();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    views = Provider.of<UserboardViewModel>(context, listen: true);
    inlineView = Provider.of<InlineViewModal>(context, listen: true);

    return AlertDialog(
      content: SizedBox(
        height: 450,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'New Schedule',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Unit Code'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value: inlineView.saveOrderScheduleRequestData.unitCode,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items: (inlineView.GetAllActiveFactoryData.data ?? [])
                            .map((item) {
                          return DropdownMenuItem(
                            value: item.uCode.toString(),
                            onTap: () {},
                            child: Text(item.uCode.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          inlineView.unitCodeOnchange(context, newValue ?? '');
                        },
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Audit Type'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value:
                            inlineView.saveOrderScheduleRequestData.auditType,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items:
                            (inlineView.getActiveAuditTypeByRptGroupData.data ??
                                    [])
                                .map((item) {
                          return DropdownMenuItem(
                            value: item.auditCode.toString(),
                            onTap: () {
                              inlineView.auditTypeOnchange(
                                context,
                                item.auditCode ?? '',
                                item.id ?? 0,
                              );
                            },
                            child: Text(item.auditName.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Buyer Division'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value:
                            inlineView.saveOrderScheduleRequestData.buyerCode,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items: (inlineView.getAllBuyerDivInfoData.data ?? [])
                            .map((item) {
                          return DropdownMenuItem(
                            value: item.buyerCode.toString(),
                            onTap: () {
                              // inlineView.buyerCodeOnchange(
                              //   context,
                              //   item.buyDivCode ?? '',
                              // );
                            },
                            child: Text(item.buyerCode.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          print(newValue);
                          inlineView.buyerCodeOnchange(
                            context,
                            newValue ?? '',
                          );
                        },
                      ),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Style No / Order No'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value: inlineView.saveOrderScheduleRequestData.styleNo,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items: (inlineView.getOrderRegWithbuyerData.data ?? [])
                            .map((item) {
                          return DropdownMenuItem(
                            value: item.styleNo.toString(),
                            onTap: () {
                              inlineView.styleNoOnchange(
                                item.styleNo ?? '',
                              );
                              inlineView.orderNoOnchange(
                                item.orderno ?? 0,
                              );
                            },
                            child: Text('${item.styleNo}  ${item.orderno}'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Start Date'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              inlineView.showDate(context, true);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                color: const Color(0xfff6fafd),
                                child: Row(
                                  children: [
                                    Text((inlineView.saveOrderScheduleRequestData
                                                    .fromDate ??
                                                '')
                                            .isNotEmpty
                                        ? (inlineView
                                                .saveOrderScheduleRequestData
                                                .fromDate ??
                                            '')
                                        : 'Select'),
                                    const Spacer(),
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.orange,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('End Date'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              inlineView.showDate(context, false);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                color: const Color(0xfff6fafd),
                                child: Row(
                                  children: [
                                    Text((inlineView.saveOrderScheduleRequestData
                                                    .toDate ??
                                                '')
                                            .isNotEmpty
                                        ? (inlineView
                                                .saveOrderScheduleRequestData
                                                .toDate ??
                                            '')
                                        : 'Select'),
                                    const Spacer(),
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.orange,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sewing Line'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value: (inlineView
                                        .saveOrderScheduleRequestData.sewLine ??
                                    '')
                                .isEmpty
                            ? null
                            : inlineView.saveOrderScheduleRequestData.sewLine,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items: (inlineView.getSewLineInfoData.data ?? [])
                            .map((item) {
                          return DropdownMenuItem(
                            value: item.lineCode.toString(),
                            onTap: () {},
                            child: Text(item.lineName.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          inlineView.sewLineOnchange((newValue ?? ''));
                        },
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Target per hour'),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            initialValue: (inlineView
                                        .saveOrderScheduleRequestData
                                        .targetPerHour ??
                                    '')
                                .toString(),
                            onChanged: (val) {
                              inlineView.targetPerHourOnchange(
                                  int.parse((val).toString()));
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              filled: true, //<-- SEE HERE
                              fillColor: Color(0xfff6fafd), //<-- SEE HERE
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Assigned To'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value:
                            inlineView.saveOrderScheduleRequestData.auditorName,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items: (inlineView.getAssigneeDetailByIDdata.data
                                    ?.assignmentAuditsModels ??
                                [])
                            .map((item) {
                          return DropdownMenuItem(
                            value: item.username.toString(),
                            onTap: () {},
                            child: Text(item.username.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          inlineView.auditorNameOnchange((newValue ?? ''));
                        },
                      ),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    inlineView.postSaveOrderSchedule(context, () {
                      views.onGetAuditSummary(context);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xffF06434),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      'Create Schedule',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget scheduleDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: SizedBox(
        height: 700,
        child: Column(
          children: [
            Row(
              children: [
                const Text('New Schedule'),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
