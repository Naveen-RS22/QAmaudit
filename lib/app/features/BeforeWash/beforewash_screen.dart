import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_view_model.dart';
import 'package:qapp/app/features/BeforeWash/widgets/info_card.dart';
import 'package:qapp/app/features/BeforeWash/widgets/step_card.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/widgets/app_logo_with_name.dart';
import 'package:qapp/app/widgets/profile_tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../audit/widgets/option_card.dart';

class BeforeWashScreen extends StatefulWidget {
  static const String path = "BeforeWashScreen";
  const BeforeWashScreen({Key? key}) : super(key: key);
  @override
  BeforeWashState createState() => BeforeWashState();
}

class BeforeWashState extends State<BeforeWashScreen> {
  BeforewashViewModal views = BeforewashViewModal();

  int roleCounts = 0;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  bool audit7 = false;
  bool internalAudit = false;
  bool lineQCA = false;
  bool preProd = false;
  String? selectedBuyerDiv;
  String? selectedStyleNumber;
  String? selectedMeasureStage;
  String? selectedType;
  String? selectedStandard;

  List<String> buyerdivitems = ['ARROWMT', 'BRMT', 'TALBB'];
  List<String> stylenumber = [
    'ATF SUM22 SAMPLING/31477',
    '612737 / 33886',
    'Option 3'
  ];
  List<String> measurestageitems = ['Stage 1', 'Stage 2', 'Stage 3'];
  List<String> typeitems = ['Type 1', 'Type 2', 'Type 3'];
  List<String> aqlitems = ['Standard 1', 'Standard 2', 'Standard 3'];

  @override
  void initState() {
    // final views = BeforewashViewModal();
    final views = Provider.of<BeforewashViewModal>(context, listen: false);
    getRoleCount();
    getRoleAccess();

    Future.delayed(Duration.zero, () {
      views.onGetInit(
        context,
      );
    });
    super.initState();
  }

  void getRoleCount() async {
    roleCounts = await SharedPreferenceHelper.getInt(Constants.roleCount);
  }

  void getRoleAccess() async {
    audit7 = await SharedPreferenceHelper.getBool(Constants.audit7);
    internalAudit = await SharedPreferenceHelper.getBool(Constants.IA);
    lineQCA = await SharedPreferenceHelper.getBool(Constants.lineQC);
    preProd = await SharedPreferenceHelper.getBool(Constants.PreProdnQA);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void showStatus(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                color: Colors.transparent,
                width: 50,
                height: 100,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('loading...'),
                    SizedBox(height: 20),
                    CircularProgressIndicator(
                      color: Colors.amber,
                    )
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final views = Provider.of<BeforewashViewModal>(
      context,
    );
    // return Scaffold(
    //     body: SafeArea(
    //   child: _buildBody(
    //     context,
    //     views,
    //   ),
    // ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView.builder(
          itemCount: roleCounts > 1 ? 2 : 1,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return index == 0
                ? _buildBody(
              context,
              views,
            )
                : _menuControl(context, false, false, false, false);
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          },
        ),
      ),
    );
  }

  Widget _menuControl(context, audit7, internalAudit, lineQCA, preProd) {
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

  // Widget _menuTwoSlide(
  //     context, String titleString, String image1, String image2) {
  //   return Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.35,
  //             width: MediaQuery.of(context).size.width * 0.2,
  //             child: GlassmorphicContainer(
  //               width: double.infinity,
  //               height: double.infinity,
  //               borderRadius: 20,
  //               blur: 90,
  //               border: 2,
  //               linearGradient: LinearGradient(
  //                   begin: Alignment.topLeft,
  //                   end: Alignment.bottomRight,
  //                   colors: [
  //                     const Color(0xFFe6e6e6).withOpacity(0.1),
  //                     const Color(0xFFe6e6e6).withOpacity(0.05),
  //                   ],
  //                   stops: const [
  //                     0.1,
  //                     1,
  //                   ]),
  //               borderGradient: LinearGradient(
  //                 begin: Alignment.topLeft,
  //                 end: Alignment.bottomRight,
  //                 colors: [
  //                   const Color(0xFFe6e6e6).withOpacity(0.5),
  //                   const Color((0xFFe6e6e6)).withOpacity(0.5),
  //                 ],
  //               ),
  //               child: Padding(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Container(
  //                             height:
  //                                 (MediaQuery.of(context).size.height * 0.35) /
  //                                     3,
  //                             width:
  //                                 (MediaQuery.of(context).size.width * 0.2) / 3,
  //                             decoration: BoxDecoration(
  //                               image: DecorationImage(
  //                                 image: AssetImage(image1),
  //                                 fit: BoxFit.cover,
  //                               ),
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 15,
  //                           ),
  //                           Container(
  //                             height:
  //                                 (MediaQuery.of(context).size.height * 0.35) /
  //                                     3,
  //                             width:
  //                                 (MediaQuery.of(context).size.width * 0.2) / 3,
  //                             decoration: BoxDecoration(
  //                               image: DecorationImage(
  //                                 image: AssetImage(image2),
  //                                 fit: BoxFit.cover,
  //                               ),
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 10,
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   )),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           Text(titleString)
  //         ],
  //       ));
  // }

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

  // Widget _menuTwoModelPopup(
  //     context,
  //     String titleString1,
  //     String titleStringN,
  //     String titleString2,
  //     String image1,
  //     String image2,
  //     Audit7,
  //     internalAudit,
  //     lineQCA,
  //     preProd) {
  //   return Dialog(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     elevation: 0,
  //     backgroundColor: Colors.transparent,
  //     child: Padding(
  //         padding: const EdgeInsets.all(30),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SizedBox(
  //               height: MediaQuery.of(context).size.height * 0.725,
  //               width: MediaQuery.of(context).size.width * 0.35,
  //               child: GlassmorphicContainer(
  //                 width: double.infinity,
  //                 height: double.infinity,
  //                 borderRadius: 20,
  //                 blur: 90,
  //                 border: 2,
  //                 linearGradient: LinearGradient(
  //                     begin: Alignment.topLeft,
  //                     end: Alignment.bottomRight,
  //                     colors: [
  //                       const Color(0xFFe6e6e6).withOpacity(0.1),
  //                       const Color(0xFFe6e6e6).withOpacity(0.05),
  //                     ],
  //                     stops: const [
  //                       0.1,
  //                       1,
  //                     ]),
  //                 borderGradient: LinearGradient(
  //                   begin: Alignment.topLeft,
  //                   end: Alignment.bottomRight,
  //                   colors: [
  //                     const Color(0xFFe6e6e6).withOpacity(0.5),
  //                     const Color((0xFFe6e6e6)).withOpacity(0.5),
  //                   ],
  //                 ),
  //                 child: SingleChildScrollView(
  //                     child: Padding(
  //                         padding: const EdgeInsets.all(30.0),
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               crossAxisAlignment: CrossAxisAlignment.end,
  //                               children: [
  //                                 Visibility(
  //                                   visible: Audit7 ? false : true,
  //                                   child: GestureDetector(
  //                                       onTap: () {
  //                                         Get.back();
  //                                         Navigator.pushNamed(context,
  //                                             Constants.dashBoardRoute);
  //                                         // if (titleString1 == "7.O Audit") {
  //                                         //   Navigator.pushNamed(
  //                                         //       context, Constants.userBoardRoute);
  //                                         //   return;
  //                                         // }
  //                                         // const _snackBar = SnackBar(
  //                                         //     content: Text('Coming soon !!!'),
  //                                         //     backgroundColor: Color(0xffF7931C),
  //                                         //     duration: Duration(seconds: 3),
  //                                         //     action: null);
  //                                         // ScaffoldMessenger.of(context)
  //                                         //     .showSnackBar(_snackBar);
  //                                       },
  //                                       child: Column(
  //                                         children: [
  //                                           Container(
  //                                             height: (MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                     0.75) /
  //                                                 3,
  //                                             width: (MediaQuery.of(context)
  //                                                         .size
  //                                                         .width *
  //                                                     0.55) /
  //                                                 4,
  //                                             decoration: BoxDecoration(
  //                                               image: DecorationImage(
  //                                                 image: AssetImage(image1),
  //                                                 fit: BoxFit.cover,
  //                                               ),
  //                                               borderRadius:
  //                                                   BorderRadius.circular(10),
  //                                             ),
  //                                             child: null,
  //                                           ),
  //                                           Align(
  //                                               alignment:
  //                                                   Alignment.bottomCenter,
  //                                               child: Padding(
  //                                                 padding:
  //                                                     const EdgeInsets.all(20),
  //                                                 child: Text(titleString1,
  //                                                     style: const TextStyle(
  //                                                         color: Colors.white)),
  //                                               )),
  //                                         ],
  //                                       )),
  //                                 ),
  //                                 const SizedBox(
  //                                   width: 8,
  //                                 ),
  //                                 GestureDetector(
  //                                     onTap: () {
  //                                       Get.back();
  //                                       Navigator.pushNamed(
  //                                           context,
  //                                           Constants
  //                                               .internalAuditUserboardRoute);
  //                                       // const _snackBar = SnackBar(
  //                                       //     content: Text('Coming soon !!!'),
  //                                       //     backgroundColor: Color(0xffF7931C),
  //                                       //     duration: Duration(seconds: 3),
  //                                       //     action: null);
  //                                       // ScaffoldMessenger.of(context)
  //                                       //     .showSnackBar(_snackBar);
  //                                     },
  //                                     child: Column(
  //                                       children: [
  //                                         Container(
  //                                           height: (MediaQuery.of(context)
  //                                                       .size
  //                                                       .height *
  //                                                   0.75) /
  //                                               3,
  //                                           width: (MediaQuery.of(context)
  //                                                       .size
  //                                                       .width *
  //                                                   0.55) /
  //                                               4,
  //                                           decoration: BoxDecoration(
  //                                             image: DecorationImage(
  //                                               image: AssetImage(image2),
  //                                               fit: BoxFit.cover,
  //                                             ),
  //                                             borderRadius:
  //                                                 BorderRadius.circular(10),
  //                                           ),
  //                                           child: null,
  //                                         ),
  //                                         Align(
  //                                             alignment: Alignment.bottomCenter,
  //                                             child: Padding(
  //                                               padding:
  //                                                   const EdgeInsets.all(20),
  //                                               child: Text(titleString2,
  //                                                   style: const TextStyle(
  //                                                       color: Colors.white)),
  //                                             )),
  //                                       ],
  //                                     )),
  //                                 const SizedBox(
  //                                   width: 8,
  //                                 ),
  //                               ],
  //                             ),
  //                             const SizedBox(
  //                               height: 10,
  //                             ),
  //                           ],
  //                         ))),
  //               ),
  //             ),
  //           ],
  //         )),
  //   );
  // }

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
      BeforewashViewModal views,
      ) =>
      Container(
        color: const Color(0xfff6f8fa),

        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: _buildAppBar(views),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFirstRow(
                    context,
                    views,
                  ),
                  const SizedBox(height: 20),
                  _buildFourthRow(
                    context,
                    views,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _buildAppBar(
      BeforewashViewModal views,
      ) {
    return GlassmorphicContainer(
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
            Row(
              children: [
                const AppLogoWithName(
                  back: true,
                ),
                VerticalDivider(
                  color: context.res.color.bgColorBlue.withOpacity(0.2),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Measurement Audit",
                      style: TextStyle(
                        color: context.res.color.black,
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    // Text(
                    //   "PreProduction Sample check",
                    //   style: TextStyle(
                    //     color: context.res.color.textGray,
                    //     fontSize: 12,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
            Row(
              children: [
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
                    height: 25,
                    width: 25,
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
                      child: const Text('Logout'),
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
  }

  _buildFirstRow(
      BuildContext context,
      BeforewashViewModal views,
      ) {
    return BootstrapContainer(
        fluid: true,
        padding: const EdgeInsets.all(10),
        // decoration: const BoxDecoration(color: Colors.white),
        children: <Widget>[

          BootstrapCol(
            sizes: 'col-12',
            child: BootstrapRow(
              height: 100,
              children: <BootstrapCol>[
                BootstrapCol(
                    sizes: 'col-3',
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      // margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(20),
                      // color: const Color(0xfff6f8fa),
                      child: InfoCard(
                        views: views,
                      ),
                    )),

                BootstrapCol(
                  sizes: 'col-2',
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    // margin: const EdgeInsets.only(right: 20),

                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        // const Text(
                        //   'Enter Pcs:',
                        //   style: TextStyle(fontWeight: FontWeight.w600),
                        // ),

                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            onChanged: (e) {},
                            maxLength: 8,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            ],
                            decoration: const InputDecoration(
                              counterText: '',
                              hintText: "",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-2',
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.all(10),
                    // margin: const EdgeInsets.only(right: 20),

                    child: Row(
                      children: [
                        const Text(
                          'Enter Size:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        SizedBox(
                          child: DropdownButton<String>(
                            value: selectedBuyerDiv,
                            hint: const Text(''),
                            underline: Container(), // Placeholder text
                            onChanged: (newValue) {
                              setState(() {
                                selectedBuyerDiv = newValue;
                              });
                            },
                            items: ['S', 'M', 'L', 'XL'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-2',
                  child:  GestureDetector(
                    onTap: () {
                      // widget.views.getAqlBaseInfo(context);
                      // widget.views.getAqlBaseInfoBase(context);
                      // widget.views.getVisualAllDefect(context);
                      // widget.views.defectCalculation();
                    },
                    child: Container(
                      height: 65,
                      padding: EdgeInsets.all(10),
                      margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),

                      decoration: BoxDecoration(

                        color: const Color(0xff1fb146),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-3',
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.fromLTRB(0, 5, 10, 10),

                    child: Row(
                      children: [
                        const Text(
                          "Pass:",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " 6",
                          style: TextStyle(color: context.res.color.textColorGreen),
                        ),
                        const SizedBox(width: 10),
                        const Text("Fail:", style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(" 3", style: TextStyle(color: context.res.color.textColorRed)),
                        const SizedBox(width: 10),
                        const Text("Remain:", style: TextStyle(fontWeight: FontWeight.w600)),
                        const Text(" 1"),
                      ],
                    ),
                  ),
                ),
                // BootstrapCol(
                //   sizes: 'col-2',
                //   child: Container(
                //     decoration: const BoxDecoration(color: Colors.white),
                //     padding: const EdgeInsets.all(15),
                //     child: Column(
                //       children: [
                //         const Text(
                //           "Pass:",
                //           style: TextStyle(fontWeight: FontWeight.w600),
                //         ),
                //         Text(
                //           " 6",
                //           style: TextStyle(color: context.res.color.textColorGreen),
                //         ),
                //         const SizedBox(width: 20),
                //         const Text("Fail:", style: TextStyle(fontWeight: FontWeight.w600)),
                //         Text(" 3", style: TextStyle(color: context.res.color.textColorRed)),
                //         const SizedBox(width: 20),
                //         const Text("Remain:", style: TextStyle(fontWeight: FontWeight.w600)),
                //         const Text(" 1"),
                //       ],
                //     ),
                //   ),
                // ),




              ],
            ),
          ),
          // BootstrapContainer(
          //   fluid: true,
          //     children: <Widget>[
          //
          //       BootstrapRow(
          //         height: 100,
          //         children: <BootstrapCol>[
          //           // BootstrapCol(
          //           //     sizes: 'col-3',
          //           //     child: Container(
          //           //       decoration: const BoxDecoration(color: Colors.white),
          //           //       margin: const EdgeInsets.only(right: 20),
          //           //       padding: const EdgeInsets.all(20),
          //           //       // color: const Color(0xfff6f8fa),
          //           //       child: InfoCard(
          //           //         views: views,
          //           //       ),
          //           //     )),
          //
          //           BootstrapCol(
          //             sizes: 'col-2',
          //             child: Container(
          //               decoration: const BoxDecoration(color: Colors.white),
          //               child: Row(
          //                 children: [
          //                   const Text(
          //                     'Enter Qty:',
          //                     style: TextStyle(fontWeight: FontWeight.w600),
          //                   ),
          //
          //                   SizedBox(
          //                     width: 60,
          //                     child: TextFormField(
          //                       cursorColor: Colors.black,
          //                       keyboardType: TextInputType.number,
          //                       onChanged: (e) {},
          //                       maxLength: 8,
          //                       inputFormatters: <TextInputFormatter>[
          //                         FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          //                       ],
          //                       decoration: const InputDecoration(
          //                         counterText: '',
          //                         hintText: "Enter Qty",
          //                         border: InputBorder.none,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           BootstrapCol(
          //             sizes: 'col-3',
          //             child: Container(
          //               decoration: const BoxDecoration(color: Colors.white),
          //               child: Row(
          //                 children: [
          //                   const Text(
          //                     'Enter Size:',
          //                     style: TextStyle(fontWeight: FontWeight.w600),
          //                   ),
          //
          //                   SizedBox(
          //                     child: DropdownButton<String>(
          //                       value: selectedBuyerDiv,
          //                       hint: const Text('Select Size'),
          //                       underline: Container(), // Placeholder text
          //                       onChanged: (newValue) {
          //                         setState(() {
          //                           selectedBuyerDiv = newValue;
          //                         });
          //                       },
          //                       items: ['S', 'M', 'L', 'XL'].map<DropdownMenuItem<String>>((String value) {
          //                         return DropdownMenuItem<String>(
          //                           value: value,
          //                           child: Text(value),
          //                         );
          //                       }).toList(),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           BootstrapCol(
          //             sizes: 'col-2',
          //             child:  GestureDetector(
          //               onTap: () {
          //                 // widget.views.getAqlBaseInfo(context);
          //                 // widget.views.getAqlBaseInfoBase(context);
          //                 // widget.views.getVisualAllDefect(context);
          //                 // widget.views.defectCalculation();
          //               },
          //               child: Container(
          //                 height: 50,
          //
          //                 decoration: BoxDecoration(
          //                   color: const Color(0xff1fb146),
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //                 child: const Center(
          //                   child: Text(
          //                     'Start',
          //                     style: TextStyle(
          //                         color: Colors.white, fontSize: 15),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           BootstrapCol(
          //             sizes: 'col-3',
          //             child: Container(
          //               decoration: const BoxDecoration(color: Colors.white),
          //               padding: const EdgeInsets.all(15),
          //               child: Row(
          //                 children: [
          //                   const Text(
          //                     "Pass:",
          //                     style: TextStyle(fontWeight: FontWeight.w600),
          //                   ),
          //                   Text(
          //                     " 6",
          //                     style: TextStyle(color: context.res.color.textColorGreen),
          //                   ),
          //                   const SizedBox(width: 20),
          //                   const Text("Fail:", style: TextStyle(fontWeight: FontWeight.w600)),
          //                   Text(" 3", style: TextStyle(color: context.res.color.textColorRed)),
          //                   const SizedBox(width: 20),
          //                   const Text("Remain:", style: TextStyle(fontWeight: FontWeight.w600)),
          //                   const Text(" 1"),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           // BootstrapCol(
          //           //   sizes: 'col-2',
          //           //   child: Container(
          //           //     decoration: const BoxDecoration(color: Colors.white),
          //           //     padding: const EdgeInsets.all(15),
          //           //     child: Column(
          //           //       children: [
          //           //         const Text(
          //           //           "Pass:",
          //           //           style: TextStyle(fontWeight: FontWeight.w600),
          //           //         ),
          //           //         Text(
          //           //           " 6",
          //           //           style: TextStyle(color: context.res.color.textColorGreen),
          //           //         ),
          //           //         const SizedBox(width: 20),
          //           //         const Text("Fail:", style: TextStyle(fontWeight: FontWeight.w600)),
          //           //         Text(" 3", style: TextStyle(color: context.res.color.textColorRed)),
          //           //         const SizedBox(width: 20),
          //           //         const Text("Remain:", style: TextStyle(fontWeight: FontWeight.w600)),
          //           //         const Text(" 1"),
          //           //       ],
          //           //     ),
          //           //   ),
          //           // ),
          //
          //
          //
          //
          //         ],
          //       ),
          //
          //     ]
          //
          // ),

        ]);
  }

  _buildFourthRow(
      BuildContext context,
      BeforewashViewModal views,
      ) {
    return BootstrapContainer(
        fluid: true,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(color: Colors.white),
        children: <Widget>[
          // BootstrapRow(
          //   height: 60,
          //   children: <BootstrapCol>[
          //     BootstrapCol(
          //         sizes: 'col-3',
          //         child: AbsorbPointer(
          //             absorbing:
          //                 views.saveWashData.orderNo != null ? false : true,
          //             child: Opacity(
          //                 opacity:
          //                     views.saveWashData.orderNo != null ? 1.0 : 0.4,
          //                 child:  Container()))),
          //     BootstrapCol(
          //         sizes: 'col-9',
          //         child: Opacity(
          //           opacity: (views.saveWashData.orderNoString ?? '').isEmpty
          //               ? 0.5
          //               : 1.0,
          //           child: AbsorbPointer(
          //             absorbing:
          //                 (views.saveWashData.orderNoString ?? '').isEmpty
          //                     ? true
          //                     : false,
          //             child: StepCard(
          //               views: views,
          //             ),
          //           ),
          //         )),
          //   ],
          // ),
        ]);
  }
}
