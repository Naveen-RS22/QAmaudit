import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/fitaudit/widgets/action_card.dart';
import 'package:qapp/app/features/fitaudit/widgets/camera_widget.dart';
import 'package:qapp/app/features/fitaudit/widgets/final_audit_card.dart';
import 'package:qapp/app/features/fitaudit/widgets/info_card.dart';
import 'package:qapp/app/features/fitaudit/widgets/menu_card.dart';
import 'package:qapp/app/features/fitaudit/widgets/option_card.dart';
import 'package:qapp/app/features/fitaudit/widgets/second_card.dart';
import 'package:qapp/app/features/fitauditdashboard/profile_screen.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_view_model.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/widgets/app_logo_with_name.dart';
import 'package:qapp/app/widgets/profile_tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_builder/timer_builder.dart';

class FitAuditScreen extends StatefulWidget {
  static const String path = "FitAuditScreen";
  const FitAuditScreen({Key? key}) : super(key: key);
  @override
  _FitAuditScreenState createState() => _FitAuditScreenState();
}

class _FitAuditScreenState extends State<FitAuditScreen> {
  void initFunction() {
    final views = Provider.of<FitAuditViewModal>(
      context,
    );

    final dashBoardViews = Provider.of<FitDashboardViewModel>(
      context,
    );
    var sytles = dashBoardViews.scheduleList.data ?? [];

    final styleAudit =
        ModalRoute.of(context)?.settings.arguments as StyleAuditData;
    //views.updateScoreCard(context, styleAudit);
  }

  @override
  void initState() {
    final views = Provider.of<FitAuditViewModal>(context, listen: false);
    final inlineviews = Provider.of<InlineViewModal>(context, listen: false);

    Future.delayed(Duration.zero, () async {
      inlineviews.isApprovalScreenFalse();
      final styleAudit =
          ModalRoute.of(context)?.settings.arguments as StyleAuditData;

      var styleSession =
          (styleAudit.styleNo).toString() + (styleAudit.sessionName).toString();
      var localStyleSession =
          await SharedPreferenceHelper.getString(Constants.current7audit);

      if (styleSession != localStyleSession) {}

      // views.operatorsCntController.text = styleAudit.totOperators.toString();
      views.onGetInit(context, styleAudit, inlineviews);
      // views.resetData();
      // views.onGetInit(context, StyleAuditData());
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initFunction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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

  Widget timerText({required FitAuditViewModal views}) {
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

  Widget resetTimerText({required FitAuditViewModal views}) {
    return const Row(
      children: [
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
    final views = Provider.of<FitAuditViewModal>(
      context,
    );
    final inlineviews = Provider.of<InlineViewModal>(
      context,
    );

    final dashBoardViews = Provider.of<FitDashboardViewModel>(
      context,
    );
    final styleAuditdata2 =
        ModalRoute.of(context)?.settings.arguments as StyleAuditData;
    return Scaffold(
        body: WillPopScope(
      onWillPop: views.fitAuditExitAction,
      child: SafeArea(
        child: inlineviews.isApprovalScreen
            ? ApprovalScreen(inlineviews, views)
            : _buildBody(
                context, views, inlineviews, dashBoardViews, styleAuditdata2),
      ),
    ));
  }

  _buildBody(
    BuildContext context,
    FitAuditViewModal views,
    InlineViewModal inlineviews,
    FitDashboardViewModel dashboardViews,
    StyleAuditData styleAuditdata,
  ) =>
      Container(
        color: Colors.white,
        child: Column(
          children: [
            if (!views.isCameraScreen)
              GestureDetector(
                onTap: () {},
                child: _buildAppBar(views),
              ),
            if (views.isCameraScreen)
              Expanded(
                  child: CameraWidget(
                viewsData: views,
              )),
            if (views.isDefectList)
              _buildDefectList(
                views,
              ),
            if (!views.isCameraScreen && !views.isDefectList)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTimer(context, views),
                      _buildSecondRow(
                          context, views, dashboardViews, styleAuditdata),
                      const SizedBox(height: 10),
                      !views.sessionCompleted
                          ? _buildThirdRow(context, views)
                          : Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Center(
                                    child: Container(
                                      color: Colors.amberAccent,
                                      child: GestureDetector(
                                        onTap: () async {
                                          String unitCode =
                                              await SharedPreferenceHelper
                                                  .getString('unitCode');
                                          views.UpdateScoreCardAuditStatus(
                                              context,
                                              unitCode,
                                              styleAuditdata);
                                          // Navigator.pop(context);
                                        },
                                        child: Opacity(
                                          opacity: 1.0,
                                          child: Container(
                                            height: 50,
                                            width: 200,
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 10, 30, 10),
                                            decoration: BoxDecoration(
                                                color: Colors.blue.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Center(
                                              child: Text(
                                                views.endSession
                                                    ? "Loading..."
                                                    : "Confirm Audit",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      // Container(),
                      views.nextOperatorAction
                          ? const SizedBox(height: 20)
                          : Container(),
                      views.nextOperatorAction
                          ? _buildFourthRow(
                              context, views, inlineviews, styleAuditdata)
                          : Container(),
                      _buildDefectList(views),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );

  _buildAppBar(
    FitAuditViewModal views,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 92,
      borderRadius: 0,
      blur: 10,
      alignment: Alignment.topCenter,
      border: 0,
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
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 40, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppLogoWithName(
              back: true,
            ),
            Row(
              children: [
                Image(
                  height: 35,
                  width: 35,
                  image: AssetImage(ImagePath.clockIcon),
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {},
                    child: views.enableRound
                        ? timerText(views: views)
                        : resetTimerText(views: views)),
                const SizedBox(
                  width: 10,
                ),
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
                    views.setDefectList(false);
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
                          onTap: () async {
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

  _buildTimer(BuildContext context, FitAuditViewModal views) =>
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

  _buildSecondRow(
          BuildContext context,
          FitAuditViewModal views,
          FitDashboardViewModel dashboardViews,
          StyleAuditData styleAuditdata) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InfoCard(
              views: views,
              dashBoardViews: dashboardViews,
              styleAuditdata: styleAuditdata),
          const SizedBox(
            width: 10,
          ),
        ],
      );

  _buildThirdRow(
    BuildContext context,
    FitAuditViewModal views,
  ) =>
      Visibility(
        visible: !views.isDefectList,
        child: Opacity(
          opacity: views.operatorFound ? 1.0 : 0.45,
          child: AbsorbPointer(
            absorbing: views.operatorFound ? false : true,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondCard(auditStep: views.auditStep, views: views),
                  // OptionCard(), ActionCard()
                ],
              ),
            ),
          ),
        ),
      );

  _buildFourthRow(
    BuildContext context,
    FitAuditViewModal views,
    InlineViewModal inlineviews,
    StyleAuditData styleAuditData,
  ) {
    return Visibility(
        visible: !views.isDefectList && !views.sessionCompleted,
        child: Opacity(
            opacity: (views.operatorFound) ? 1.0 : 0.45,
            child: AbsorbPointer(
                absorbing: (views.operatorFound) ? false : true,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OptionCard(views: views),
                    MenuCard(views: views),

                    if (!views.sessionCompleted)
                      Opacity(
                          opacity: views.scoreCardData.auditType != 'FAG'
                              ? (views.operatorFound &&
                                      views.sleeveAttachmentValue != null &&
                                      views.sleeveValue != null)
                                  ? 1.0
                                  : 0.45
                              : 1.0,
                          child: AbsorbPointer(
                              absorbing: views.scoreCardData.auditType != 'FAG'
                                  ? (views.operatorFound &&
                                          views.sleeveAttachmentValue != null &&
                                          views.sleeveValue != null)
                                      ? false
                                      : true
                                  : false,
                              child: ActionCard(
                                  views: views,
                                  inlineviews: inlineviews,
                                  styleAuditData: styleAuditData)))
                    // OptionCard(), ActionCard()
                  ],
                ))));
  }

  _buildDefectList(
    FitAuditViewModal views,
  ) {
    return Visibility(
      visible: views.isDefectList,
      child: Flexible(
        fit: FlexFit.loose,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: FinalAuditCard(
              viewsData: views,
            )),
          ],
        ),
      ),
    );
  }
}

class ApprovalScreen extends StatelessWidget {
  final InlineViewModal view;
  final FitAuditViewModal auditView;
  const ApprovalScreen(
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
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: DropdownButton<String>(
                        value: view.selectedSession,
                        isExpanded: true,
                        hint: const Text("Select Session"),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          view.setSelectedSession7audit(
                              newValue.toString(), auditView.styleAuditData);
                        },
                        items:
                            (view.getAllSessionMasterbyunitcodeData.data ?? [])
                                .map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              // view.selectedSessionValidation(item.id);
                            },
                            value: item.sessionCode.toString(),
                            child: Text(item.sessionName.toString()),
                          );
                        }).toList(),
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
                    'Line : ${view.styleAuditData?.lineName ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Style : ${view.styleAuditData?.styleNo ?? ''}',
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
                        (view.getLineQCApprovalByParamsList.data ?? []).isEmpty,
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
          if ((view.getLineQCApprovalByAuditTypeApproverData.data ?? [])
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
          if ((view.getLineQCApprovalByAuditTypeApproverData.data ?? [])
              .isNotEmpty)
            Expanded(
                child: ListView.builder(
              itemCount:
                  (view.getLineQCApprovalByAuditTypeApproverData.data ?? [])
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
                              view.getLineQCApprovalByAuditTypeApproverData
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
                                  view.getLineQCApprovalByAuditTypeApproverData
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
                              (view.getLineQCApprovalByAuditTypeApproverData
                                              .data?[index].remarks ??
                                          '')
                                      .isEmpty
                                  ? '-'
                                  : view.getLineQCApprovalByAuditTypeApproverData
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
