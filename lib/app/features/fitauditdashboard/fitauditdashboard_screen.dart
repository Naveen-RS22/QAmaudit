import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';

import 'package:qapp/app/features/fitauditdashboard/widgets/audit_summary_card.dart';
import 'package:qapp/app/features/fitauditdashboard/widgets/defects_by_parts_chart.dart';
import 'package:qapp/app/features/fitauditdashboard/widgets/final_audit_card.dart';
import 'package:qapp/app/features/fitauditdashboard/widgets/pieces_status_card.dart';
import 'package:qapp/app/features/fitauditdashboard/widgets/time_session_card.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_view_model.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_screen.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/widgets/app_logo_with_name.dart';
import 'package:qapp/app/widgets/profile_tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/style_info_card.dart';
import 'widgets/time_spent_card.dart';

class FitAuditDashboardScreen extends StatefulWidget {
  static const String path = "FitAuditdashboardScreen";

  const FitAuditDashboardScreen({Key? key}) : super(key: key);

  @override
  _FitAuditDashboardScreenState createState() =>
      _FitAuditDashboardScreenState();
}

class _FitAuditDashboardScreenState extends State<FitAuditDashboardScreen> {
  FitDashboardViewModel viewModel = FitDashboardViewModel();

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  int roleCounts = 0;

  bool Audit7 = false;
  bool internalAudit = false;
  bool lineQCA = false;
  bool preProd = false;

  @override
  void initState() {
    final viewsData =
        Provider.of<FitDashboardViewModel>(context, listen: false);
    final inlineView = Provider.of<InlineViewModal>(context, listen: false);

    getRoleCount();
    getRoleAccess();
    viewsData.onGetAuditSummary(context);
    inlineView.setisReportScreenFalse();

    Future.delayed(Duration.zero, () {
      viewModel.resetData();
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

  void UserBoardNavigator() {
    Navigator.pushNamed(context, Constants.userBoardRoute);
  }

  @override
  Widget build(BuildContext context) {
    final views = Provider.of<FitDashboardViewModel>(context);
    final auditviews = Provider.of<FitAuditViewModal>(context);

    final inlineviews = Provider.of<InlineViewModal>(context);
    final auditview = Provider.of<FitAuditViewModal>(context);

    final viewsData = Provider.of<FitDashboardViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          itemCount: roleCounts > 1 ? 2 : 1,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            //   child: inlineviews.isApprovalScreen
            // ? ApprovalScreen(inlineviews, views)
            // : _buildBody(
            //     context, views, inlineviews, dashBoardViews, styleAuditdata2),
            return index == 0
                ? Container(
                    child: inlineviews.isApprovalScreen
                        ? ApprovalScreen(views, inlineviews, auditview)
                        : _buildBody(context, views, auditviews, inlineviews,
                            viewsData, roleCounts),
                  )
                : GestureDetector(
                    onTap: () {
                      // views.showErrorAlert(internalAudit.toString());
                    },
                    child: _menuControl(
                        context, Audit7, internalAudit, lineQCA, preProd),
                  );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          },
        ),
      ),
    );
    //body: _buildBody(context, views),
  }

  _buildBody(
          BuildContext context,
          FitDashboardViewModel views,
          FitAuditViewModal auditviews,
          InlineViewModal inlineviews,
          FitDashboardViewModel viewsData,
          roleCounts) =>
      Column(
        children: [
          GestureDetector(
            onTap: (() async {
              // views.timeChecker(context);
            }),
            child: _buildAppBar(views),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSecondRow(context, views),
                  const SizedBox(height: 10),
                  if (views.styleInfoExpanded) _buildThirdRow(context, views),
                  _buildLastRow(
                      context, views, auditviews, inlineviews, viewsData)
                ],
              ),
            ),
          ),
        ],
      );

  _buildAppBar(FitDashboardViewModel view) => GlassmorphicContainer(
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
                            onTap: () async {
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

  _buildSecondRow(BuildContext context, FitDashboardViewModel views) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AuditSummaryCard(views: views),
          TimeSpentCard(views: views),
          PiecesStatusCard('420', '420', '95%', true, views),
          PiecesStatusCard('20', '420', '5%', false, views),
        ],
      );

  _buildThirdRow(BuildContext context, FitDashboardViewModel views) =>
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Row(
                    children: [Text('Add New Schedule'), Icon(Icons.add)],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    views.setStyleInfoExpanded();
                  },
                  child: const Icon(Icons.compare_arrows),
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
                    'Action',
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
                ],
              ),
            ),
            for (StyleAuditData item in (views.scheduleList.data ?? []))
              Row(
                children: [
                  Expanded(
                      child: Text(
                    item.styleNo ?? '',
                    style: const TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    item.lineName ?? '',
                    style: const TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    item.buyerCode ?? '',
                    style: const TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    item.orderNo.toString(),
                    style: const TextStyle(color: Color(0xffffffff)),
                  )),
                  Expanded(
                      child: Text(
                    item.styleNo ?? '',
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
                                        const FitAuditScreen(),
                                    settings: RouteSettings(arguments: item)));
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
              ),
          ],
        ),
      );

  _buildLastRow(
          BuildContext context,
          FitDashboardViewModel views,
          FitAuditViewModal auditviews,
          InlineViewModal inlineviews,
          FitDashboardViewModel viewsData) =>
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
                            StyleInfoCard(views: views),
                          TimeSessionCard(
                              views: views,
                              auditviews: auditviews,
                              inlineviews: inlineviews),
                        ],
                      ),
                    )
                  ],
                ))
          ],
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
                            width:
                                (MediaQuery.of(context).size.width * 0.2) / 3,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/dashboard/cutting.png"),
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
                            width:
                                (MediaQuery.of(context).size.width * 0.2) / 3,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/dashboard/endline.png"),
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
                            width:
                                (MediaQuery.of(context).size.width * 0.2) / 3,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/dashboard/Audit.png"),
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
                            width:
                                (MediaQuery.of(context).size.width * 0.2) / 3,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/dashboard/Audit.png"),
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
                            width:
                                (MediaQuery.of(context).size.width * 0.2) / 3,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/dashboard/Internal.png"),
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
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
                                (MediaQuery.of(context).size.height * 0.35) / 3,
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
                                        width:
                                            (MediaQuery.of(context).size.width *
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                        width:
                                            (MediaQuery.of(context).size.width *
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
                                        width:
                                            (MediaQuery.of(context).size.width *
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
                                        width:
                                            (MediaQuery.of(context).size.width *
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                        width:
                                            (MediaQuery.of(context).size.width *
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

                                    Navigator.pushNamed(context,
                                        Constants.internalAuditUserboardRoute);
                                  },
                                  child: Column(children: [
                                    Container(
                                        height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75) /
                                            3,
                                        width:
                                            (MediaQuery.of(context).size.width *
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
                                        Navigator.pushNamed(
                                            context, Constants.dashBoardRoute);
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
                                              padding: const EdgeInsets.all(20),
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

class ApprovalScreen extends StatelessWidget {
  final FitDashboardViewModel dashView;
  final InlineViewModal view;
  final FitAuditViewModal auditView;
  const ApprovalScreen(
    this.dashView,
    this.view,
    this.auditView, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  view.setIsApprovalScreen(false);
                },
                child: const Icon(Icons.close),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: const Text(
              'Approval',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade400,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        view.currentApprovalUser == 'SUP'
                            ? 'Supervisor'
                            : view.currentApprovalUser == 'QA'
                                ? 'LINE QC'
                                : view.currentApprovalUser == 'QCM'
                                    ? 'QCM'
                                    : '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: DropdownButton<String>(
                          value: view.selectedSession,
                          isExpanded: true,
                          hint: const Text("Select Round"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          onChanged: (String? newValue) {
                            view.setSelectedSession7audit(
                                newValue.toString(), auditView.styleAuditData);
                          },
                          items: (dashView.selectRoundDropdown).map((item) {
                            return DropdownMenuItem(
                              onTap: () {
                                // view.selectedSessionValidation(item.id);
                              },
                              value: item.sessionName.toString(),
                              child: Text(item.sessionName ?? ''),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name : ${view.currentApprovalUserName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Line : ${auditView.styleAuditData.lineName ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Style : ${auditView.styleAuditData.styleNo ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,

                    maxLength: 100,
                    enabled:
                        (view.GetLineQCApprovalByParamsApproverTypeUserCodeData7Audit
                                    .isSuccess ??
                                false)
                            ? false
                            : true,
                    controller: view.approvalRemark,
                    // onChanged: (value) {
                    //   widget.views.operatorsCntOnChange(
                    //       value, context, widget.styleAuditdata);
                    // },

                    maxLines: null,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: 'Remarks',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  if ((view.getLineQCApprovalByParamsList.data ?? [])
                      .isNotEmpty) {
                  } else if (view.selectedSession == null) {
                    view.showErrorAlert('Select Round');
                  } else {
                    view.postSaveLineQCApproval7audit(
                        context, auditView.styleAuditData);
                  }
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      'Approve',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Container(
                  color: Colors.orange.shade300,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Session',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              SizedBox(
                width: 160,
                child: Container(
                    color: Colors.orange.shade300,
                    padding: const EdgeInsets.all(10),
                    child: const Text('Approved Time',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ))),
              ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: Container(
                    color: Colors.orange.shade300,
                    padding: const EdgeInsets.all(10),
                    child: const Text('Remark',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ))),
              )
            ],
          ),
          if ((view.getLineQCApprovalByAuditTypeUsercodeData.data ?? [])
              .isEmpty)
            Container(
              margin: const EdgeInsets.only(top: 2),
              color: Colors.yellow.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      'No data',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          if ((view.getLineQCApprovalByAuditTypeUsercodeData.data ?? [])
              .isNotEmpty)
            Expanded(
                child: ListView.builder(
              itemCount:
                  (view.getLineQCApprovalByAuditTypeUsercodeData.data ?? [])
                      .length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Container(
                            color: Colors.yellow.shade100,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              view.getLineQCApprovalByAuditTypeUsercodeData
                                      .data?[index].sessionCode ??
                                  '',
                              style: const TextStyle(fontSize: 16),
                            )),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                        width: 160,
                        child: Container(
                            color: Colors.yellow.shade100,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(
                                  view.getLineQCApprovalByAuditTypeUsercodeData
                                          .data?[index].approveDateTime ??
                                      '0000-00-00T00:00:00')),
                              style: const TextStyle(fontSize: 16),
                            )),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        child: Container(
                            color: Colors.yellow.shade100,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              (view.getLineQCApprovalByAuditTypeUsercodeData
                                              .data?[index].remarks ??
                                          '')
                                      .isEmpty
                                  ? '-'
                                  : view.getLineQCApprovalByAuditTypeUsercodeData
                                          .data?[index].remarks ??
                                      '',
                              style: const TextStyle(fontSize: 16),
                            )),
                      ),
                    ],
                  ),
                );
              },
            )),
        ],
      ),
    );
  }
}
