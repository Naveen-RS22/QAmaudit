import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_view_model.dart';
import 'package:qapp/app/features/iaDashboard/widgets/audit_summary_card.dart';
import 'package:qapp/app/features/iaDashboard/widgets/defects_by_parts_chart.dart';
import 'package:qapp/app/features/iaDashboard/widgets/final_audit_card.dart';
import 'package:qapp/app/features/iaDashboard/widgets/pieces_status_card.dart';
import 'package:qapp/app/features/iaDashboard/widgets/time_session_card.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_screen.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/widgets/app_logo_with_name.dart';
import 'package:qapp/app/widgets/profile_tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_builder/timer_builder.dart';

import 'widgets/style_info_card.dart';
import 'widgets/time_spent_card.dart';
import 'package:multiselect/multiselect.dart';

class IADashboardScreen extends StatefulWidget {
  static const String path = "IAdashboardScreen";

  const IADashboardScreen({Key? key}) : super(key: key);

  @override
  _IADashboardScreenState createState() => _IADashboardScreenState();
}

class _IADashboardScreenState extends State<IADashboardScreen> {
  IADashboardViewModel viewModel = IADashboardViewModel();
  int roleCounts = 0;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  bool Audit7 = false;
  bool internalAudit = false;
  bool lineQCA = false;
  bool preProd = false;

  @override
  void initState() {
    final viewsData = Provider.of<IADashboardViewModel>(context, listen: false);
    getRoleCount();
    getRoleAccess();
    viewsData.onGetAuditSummary(context);
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
    final views = Provider.of<IADashboardViewModel>(context);
    final viewsData = Provider.of<IADashboardViewModel>(context);
    final inlineViewData = Provider.of<InlineViewModal>(context);
    final iaViewData = Provider.of<InternalAuditViewModal>(context);

    // return Scaffold(
    //   body: SafeArea(child: _buildBody(context, views, viewsData)),
    // );
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          itemCount: roleCounts > 1 ? 2 : 1,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return index == 0
                ? _buildBody(
                    context,
                    views,
                    inlineViewData,
                    iaViewData,
                    viewsData,
                  )
                : _menuControl(context);
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          },
        ),
      ),
    );
  }

  Widget _menuControl(context) {
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
          IADashboardViewModel views,
          InlineViewModal inlineViewData,
          InternalAuditViewModal iaViewData,
          IADashboardViewModel viewsData) =>
      Column(
        children: [
          _buildAppBar(views),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _buildTimer(context, views),
                  _buildSecondRow(context, views),
                  const SizedBox(height: 10),
                  if (views.styleInfoExpanded)
                    _buildThirdRow(context, views, inlineViewData, iaViewData),
                  _buildLastRow(
                      context, views, inlineViewData, iaViewData, viewsData)
                ],
              ),
            ),
          ),
        ],
      );

  _buildThirdRow(BuildContext context, IADashboardViewModel views,
          InlineViewModal inlineView, InternalAuditViewModal iaView) =>
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
                    inlineView.clearSaveOrderScheduleRequestData(iaView);
                    inlineView.getUserDepartmentListAPI(context);
                    inlineView.getActiveAuditTypeByRptGroupAPIIA(context, 'QA');
                    inlineView.getAllBuyerDivInfoDataAPI(context);
                    inlineView.GetAllActiveFactoryAPI(context);
                    // widget.iaViewData.GetDsheadByParamAPI(context, widget.views.s);
                    iaView.GetUDMasterByTypeAPI(context, 'AQLTYPE');

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
                    'Sch Date',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Style No',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Ins Type',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Buyer Code',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Order No',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    'Order Qty',
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
                itemCount: (views.getAuditStyleDetail.data ?? []).length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(
                        ((views.getAuditStyleDetail.data ?? [])[index]
                                    .schDate ??
                                '')
                            .toString()
                            .substring(0, 10),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.getAuditStyleDetail.data ?? [])[index].styleno ??
                            '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.getAuditStyleDetail.data ?? [])[index].insType ??
                            '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.getAuditStyleDetail.data ?? [])[index].buycode ??
                            '',
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.getAuditStyleDetail.data ?? [])[index]
                            .orderno
                            .toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      )),
                      Expanded(
                          child: Text(
                        (views.getAuditStyleDetail.data ?? [])[index]
                            .orderQty
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
                                            const InternalAuditScreen(),
                                        settings: RouteSettings(
                                            arguments: (views
                                                    .getAuditStyleDetail.data ??
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
            // for (StyleAuditData item in (views.getAuditStyleDetail.data ?? []))

            //   Row(
            //     children: [
            //       Expanded(
            //           child: Text(
            //         item.styleNo ?? '',
            //         style: const TextStyle(color: Color(0xffffffff)),
            //       )),
            //       Expanded(
            //           child: Text(
            //         item.lineName ?? '',
            //         style: const TextStyle(color: Color(0xffffffff)),
            //       )),
            //       Expanded(
            //           child: Text(
            //         item.buyerCode ?? '',
            //         style: const TextStyle(color: Color(0xffffffff)),
            //       )),
            //       Expanded(
            //           child: Text(
            //         item.orderNo.toString(),
            //         style: const TextStyle(color: Color(0xffffffff)),
            //       )),
            //       Expanded(
            //           child: Text(
            //         item.styleNo ?? '',
            //         style: const TextStyle(color: Color(0xffffffff)),
            //       )),
            //       Expanded(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => const InlineScreen(),
            //                         settings: RouteSettings(arguments: item)));
            //               },
            //               child: Container(
            //                 height: 30,
            //                 width: 30,
            //                 decoration: BoxDecoration(
            //                   color: context.res.color.black,
            //                   borderRadius: BorderRadius.circular(8.0),
            //                 ),
            //                 child: Center(
            //                   child: Icon(
            //                     Icons.arrow_forward,
            //                     size: 18,
            //                     color: context.res.color.white,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
          ],
        ),
      );

  _buildAppBar(IADashboardViewModel view) => GlassmorphicContainer(
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
                    onTap: () {
                      //Navigator.pushNamed(context, Constants.inlineRoute);
                    },
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

  _buildTimer(BuildContext context, IADashboardViewModel views) =>
      TimerBuilder.periodic(const Duration(seconds: 1), builder: (context) {
        return Align(
          alignment: Alignment.topRight,
          child: Text(
            views.getSystemTime(),
            style: const TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        );
      });

  _buildSecondRow(BuildContext context, IADashboardViewModel views) {
    int? totalCount = views.getAuditDetail.data?.totalCnt ?? 0;
    int? passCnt = views.getAuditDetail.data?.passCnt ?? 0;
    int? failCnt = views.getAuditDetail.data?.failCnt ?? 0;

    double? passPercent = (passCnt * 100) / totalCount;
    double? failPercent = (failCnt * 100) / totalCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AuditSummaryCard(views: views),
        TimeSpentCard(views: views),
        PiecesStatusCard(
            'Audit Pass',
            passCnt.isNaN ? "0.0" : passCnt.toString(),
            totalCount.isNaN ? "0.0" : totalCount.toString(),
            passPercent.isNaN ? "0.0" : passPercent.toString(),
            true,
            views),
        PiecesStatusCard(
            'Audit Fail',
            failCnt.isNaN ? "0.0" : failCnt.toString(),
            totalCount.isNaN ? "0.0" : totalCount.toString(),
            failPercent.isNaN ? "0.0" : failPercent.toString(),
            false,
            views),
      ],
    );
  }

  _buildLastRow(
          BuildContext context,
          IADashboardViewModel views,
          InlineViewModal inlineViewData,
          InternalAuditViewModal iaViewData,
          IADashboardViewModel viewsData) =>
      Flexible(
        fit: FlexFit.loose,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child:
                    FinalAuditCard(viewModel: viewModel, viewsData: viewsData)),
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
                                views: views,
                                inlineViewData: inlineViewData,
                                iaViewData: iaViewData),
                          TimeSessionCard(
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
                                              padding: const EdgeInsets.all(20),
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
                                              padding: const EdgeInsets.all(20),
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

class InfoPopup extends StatefulWidget {
  final IADashboardViewModel view;
  final InlineViewModal inlineView;

  const InfoPopup(this.view, this.inlineView, {Key? key}) : super(key: key);

  @override
  InfoPopupState createState() => InfoPopupState();
}

class InfoPopupState extends State<InfoPopup> {
  IADashboardViewModel views = IADashboardViewModel();
  InlineViewModal inlineView = InlineViewModal();
  InternalAuditViewModal iaView = InternalAuditViewModal();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    views = Provider.of<IADashboardViewModel>(context, listen: true);
    inlineView = Provider.of<InlineViewModal>(context, listen: true);
    iaView = Provider.of<InternalAuditViewModal>(context, listen: true);

    return AlertDialog(
      content: SizedBox(
        height: 550,
        width: MediaQuery.of(context).size.width * 0.55,
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
                        items: (inlineView
                                    .getActiveAuditTypeByRptGroupDataIA.data ??
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
                              inlineView.orderNoOnchangeIA(
                                item.orderno ?? 0,
                                iaView,
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
                              inlineView.showDateIA(context, true);
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
                    const Text('Inspection Type'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value: inlineView.saveOrderScheduleRequestData.insType,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items: ([
                          {'type': 'PR', 'value': 'Pilot Run'},
                          {'type': 'HP', 'value': '100 pcs'},
                          {'type': 'I', 'value': 'Interim'},
                          {'type': 'PF', 'value': 'Pre final'},
                          {'type': 'F', 'value': 'Final'},
                        ]).map((item) {
                          return DropdownMenuItem(
                            value: item['type'].toString(),
                            onTap: () {},
                            child: Text(item['value'].toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          inlineView.insTypeOnchange((newValue ?? ''));
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
                    const Text('AQL Standards'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value: inlineView.saveOrderScheduleRequestData.aqlStd,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items: (iaView.GetUDMasterByTypeData.data ?? [])
                            .map((item) {
                          return DropdownMenuItem(
                            value: item.code.toString(),
                            onTap: () {},
                            child: Text(item.typeDesc.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          inlineView.aqlStdOnchange((newValue ?? ''));
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
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("PO.No (No.of PO's selected 0)"),
                    const SizedBox(
                      height: 10,
                    ),
                    DropDownMultiSelect(
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      options: iaView.options,
                      whenEmpty: 'Select',
                      onChanged: (value) {
                        List<String> newVal = [];
                        for (int i = 0; i < value.length; i++) {
                          newVal.add(value[i].toString());
                        }
                        iaView.poOptionOnChange(newVal, inlineView);
                      },
                      selectedValues: iaView.selectedOptionList.value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Obx(() => Text(iaView.selectedOption.value)),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Order Qty'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        color: const Color(0xfff6fafd),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(inlineView
                                    .saveOrderScheduleRequestData.orderQty
                                    .toString())),
                          ],
                        )),
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
                    inlineView.postSaveOrderScheduleIA(context, () {
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
}
