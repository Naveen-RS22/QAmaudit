import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/dto/GetAuditStyleDataModel.dart';
import 'package:qapp/app/features/dashboard/profile_screen.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/internal_audit_report.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/internal_audit_status_report.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/menu_card_measurement.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/menu_card_pack.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/option_card.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/action_card.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/info_card.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/menu_card_visual.dart';
import 'package:qapp/app/features/internalAuditForms/widgets/menu_card3.dart';
import 'package:qapp/app/features/dashboard/dashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/widgets/app_logo_with_name.dart';
import 'package:qapp/app/widgets/profile_tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_builder/timer_builder.dart';

class InternalAuditScreen extends StatefulWidget {
  static const String path = "InternalAuditScreen";
  const InternalAuditScreen({Key? key}) : super(key: key);
  @override
  _InternalAuditScreenState createState() => _InternalAuditScreenState();
}

class _InternalAuditScreenState extends State<InternalAuditScreen> {
  @override
  void initState() {
    final views = Provider.of<InternalAuditViewModal>(context, listen: false);
    Future.delayed(Duration.zero, () {
      final styleAudit =
          ModalRoute.of(context)?.settings.arguments as AuditStyleList;
      views.onGetInit(context, styleAudit);
    });
    super.initState();
  }

  void showStatus(BuildContext context) {
    // _isProgressDialogShown = true;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
            color: Colors.transparent,
            width: 50,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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

  Widget timerText({required InternalAuditViewModal views}) {
    String toDigits(int n) => n.toString().padLeft(2, '0');

    final hours = toDigits(views.duration.inHours.remainder(60));
    final minutes = toDigits(views.duration.inMinutes.remainder(60));
    final seconds = toDigits(views.duration.inSeconds.remainder(60));
    return Row(
      children: [
        Text(hours.toString()),
        const SizedBox(
          width: 5,
        ),
        const Text(":"),
        const SizedBox(
          width: 5,
        ),
        Text(minutes.toString()),
        const SizedBox(
          width: 5,
        ),
        const Text(":"),
        const SizedBox(
          width: 5,
        ),
        Text(seconds.toString()),
      ],
    );
  }

  Widget resetTimerText({required InternalAuditViewModal views}) {
    return Row(
      children: const [
        Text("00"),
        SizedBox(
          width: 5,
        ),
        Text(":"),
        SizedBox(
          width: 5,
        ),
        Text("00"),
        SizedBox(
          width: 5,
        ),
        Text(":"),
        SizedBox(
          width: 5,
        ),
        Text("00"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final views = Provider.of<InternalAuditViewModal>(
      context,
    );
    final dashBoardViews = Provider.of<DashboardViewModel>(
      context,
    );
    final styleAuditdata =
        ModalRoute.of(context)?.settings.arguments as AuditStyleList;
    return Scaffold(
        body: SafeArea(
      child: _buildBody(context, views, dashBoardViews, styleAuditdata),
    ));
  }

  _buildBody(
    BuildContext context,
    InternalAuditViewModal views,
    DashboardViewModel dashboardViews,
    AuditStyleList styleAuditdata,
  ) =>
      Container(
        color: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                views.sessionCompletionTester();
              },
              child: _buildAppBar(views),
            ),
            if (!views.isStatusReportScreen)
              if (!views.isReportScreen)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTimer(context, views),
                        _buildSecondRow(
                            context, views, dashboardViews, styleAuditdata),
                        const SizedBox(height: 20),
                        if (!views.sessionCompleted)
                          _buildFourthRow(context, views, styleAuditdata),
                      ],
                    ),
                  ),
                ),
            if (views.isReportScreen) Expanded(child: _reportScreen(views)),
            if (views.isStatusReportScreen)
              Expanded(child: _statusReportScreen(views)),
          ],
        ),
      );
  _reportScreen(
    InternalAuditViewModal views,
  ) {
    return InternalAuditReport(
      viewsData: views,
    );
  }

  _statusReportScreen(
    InternalAuditViewModal views,
  ) {
    return InternalAuditStatusReport(
      viewsData: views,
    );
  }

  _buildAppBar(
    InternalAuditViewModal views,
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
                      "Internal Audit",
                      style: TextStyle(
                        color: context.res.color.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      (views.styleAuditData.insType ?? '') == "F"
                          ? "Final"
                          : (views.styleAuditData.insType ?? '') == "PF"
                              ? "Pre final"
                              : (views.styleAuditData.insType ?? '') == "I"
                                  ? "Interim"
                                  : (views.styleAuditData.insType ?? '') == "HP"
                                      ? "100 pcs"
                                      : (views.styleAuditData.insType ?? '') ==
                                              "PR"
                                          ? "Pilot run"
                                          : "",
                      style: TextStyle(
                        color: context.res.color.textGray,
                        fontSize: 12,
                      ),
                    ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            ).then((value) => views.refreshPartOperation());
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
  }

  _buildTimer(BuildContext context, InternalAuditViewModal views) =>
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

  _buildSecondRow(BuildContext context, InternalAuditViewModal views,
      DashboardViewModel dashboardViews, AuditStyleList styleAuditdata) {
    bool menuSelect = int.parse(
            views.auditStateData[views.auditState]['total'].toString()) <
        int.parse(views.auditStateData[views.auditState]['size'].toString());
    bool menuSelectStatus = false;
    if (menuSelect && views.enableRound) {
      menuSelectStatus = true;
    } else {
      menuSelectStatus = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoCard(
            views: views,
            dashBoardViews: dashboardViews,
            styleAuditdata: styleAuditdata),
        const SizedBox(
          height: 20,
        ),
        !views.sessionCompleted
            ? Opacity(
                opacity: menuSelectStatus ? 1.0 : 0.5,
                child: AbsorbPointer(
                  absorbing: !menuSelectStatus,
                  child: MenuCards(views: views),
                ),
              )
            : Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        views.updateAuditStatusAPI(context);
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            views.endSessionLoader
                                ? "Loading..."
                                : "Confirm Audit",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
      ],
    );
  }

  _buildFourthRow(
    BuildContext context,
    InternalAuditViewModal views,
    AuditStyleList styleAuditData,
  ) {
    String? partCode = views.saveAuditData.partCode;
    String? operationCode = views.saveAuditData.operationCode;
    bool actionView = false;

    bool menuSelect = int.parse(
            views.auditStateData[views.auditState]['total']) <
        int.parse(views.auditStateData[views.auditState]['size'].toString());
    bool menuSelectStatus = false;
    if (menuSelect && views.enableRound) {
      menuSelectStatus = true;
    } else {
      menuSelectStatus = false;
    }

    if (views.auditState < 2) {
      if (partCode != null) {
        actionView = true;
      } else {
        actionView = false;
      }
    } else {
      ('--------------');
      (views.packId);
      ('--------------');
      // String packID = views.packIdController.text;

      // (packID);
      if (views.packId != "") {
        actionView = true;
      } else {
        actionView = false;
      }
    }

    return BootstrapContainer(
        fluid: true,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(color: Colors.white),
        children: <Widget>[
          BootstrapRow(
            height: 60,
            children: <BootstrapCol>[
              BootstrapCol(
                sizes: 'col-3',
                child: Visibility(
                  child: Opacity(
                    opacity: menuSelectStatus ? 1.0 : 0.5,
                    child: AbsorbPointer(
                        absorbing: !menuSelectStatus,
                        child: GestureDetector(
                            onTap: () {}, child: OptionCard(views: views))),
                  ),
                ),
              ),
              BootstrapCol(
                sizes: 'col-6',
                child: Visibility(
                  // visible: views.auidtFail,

                  visible: true,

                  child: Opacity(
                    opacity: views.auidtFail ? 1.0 : 1.0,
                    child: AbsorbPointer(
                      // absorbing: !views.auidtFail,
                      absorbing: false,
                      child: views.auditState == 0
                          ? MenuCardVisual(views: views)
                          : views.auditState == 1
                              ? MenuCardMeasurement(views: views)
                              : MenuCardPack(views: views),
                    ),
                  ),
                ),
              ),
              BootstrapCol(
                sizes: 'col-3',
                child:
                    // Opacity(
                    //     opacity: actionView ? 1.0 : 0.5,
                    //     child: Opacity(
                    //       opacity: menuSelectStatus ? 1.0 : 0.5,
                    //       child: AbsorbPointer(
                    //           absorbing: !actionView,
                    //           child: AbsorbPointer(
                    //             absorbing: !menuSelectStatus,
                    //             child:
                    ActionCard(
                        views: views,
                        styleAuditData: styleAuditData,
                        actionView: actionView,
                        menuSelectStatus: menuSelectStatus),
                //       )),
                // ))
              ),
            ],
          ),
        ]);
  }
}
