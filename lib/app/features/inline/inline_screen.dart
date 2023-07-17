import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/audit/audit_view_model.dart';
import 'package:qapp/app/features/dashboard/profile_screen.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/features/inline/widgets/action_card.dart';
import 'package:qapp/app/features/inline/widgets/info_card.dart';
import 'package:qapp/app/features/inline/widgets/inline_defects.dart';
import 'package:qapp/app/features/inline/widgets/inline_report.dart';
import 'package:qapp/app/features/inline/widgets/inline_schedules.dart';
import 'package:qapp/app/features/inline/widgets/menu_card.dart';
import 'package:qapp/app/features/inline/widgets/option_card.dart';
import 'package:qapp/app/features/inline/widgets/qr_camera.dart';
import 'package:qapp/app/features/inline/widgets/second_card.dart';
import 'package:qapp/app/features/dashboard/dashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/widgets/app_logo_with_name.dart';
import 'package:qapp/app/widgets/profile_tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InlineScreen extends StatefulWidget {
  static const String path = "InlineScreen";
  const InlineScreen({Key? key}) : super(key: key);
  @override
  _InlineScreenState createState() => _InlineScreenState();
}

class _InlineScreenState extends State<InlineScreen> {
  StyleAuditData styleData = StyleAuditData();
  void initFunction() {
    final styleAudit =
        ModalRoute.of(context)?.settings.arguments as StyleAuditData;
    styleData = styleAudit;
  }

  @override
  void initState() {
    final views = Provider.of<InlineViewModal>(context, listen: false);
    final auditView = Provider.of<AuditViewModal>(context, listen: false);
    Future.delayed(Duration.zero, () {
      final styleAudit =
          ModalRoute.of(context)?.settings.arguments as StyleAuditData;
      styleData = styleAudit;
      views.clearData();
      views.onGetInit(context, styleAudit);
      views.onGetInit2(context, styleAudit);
    });
    super.initState();
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
    final views = Provider.of<InlineViewModal>(
      context,
    );
    final auditview = Provider.of<AuditViewModal>(
      context,
    );

    final dashBoardViews = Provider.of<DashboardViewModel>(
      context,
    );
    final styleAuditdata2 =
        ModalRoute.of(context)?.settings.arguments as StyleAuditData;
    return views.enableCamera
        ? const QRcamera()
        : Scaffold(
            body: SafeArea(
            child: views.isApprovalScreen
                ? ApprovalScreen(views)
                : _buildBody(
                    context, views, auditview, dashBoardViews, styleAuditdata2),
          ));
  }

  _buildBody(
    BuildContext context,
    InlineViewModal views,
    AuditViewModal auditview,
    DashboardViewModel dashboardViews,
    StyleAuditData styleAuditdata,
  ) =>
      GestureDetector(
        onTap: () {},
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: (() {
                  // views.setIsReportScreen();
                }),
                child: _buildAppBar(views),
              ),
              if (!views.isReportScreen)
                if (!views.isDefectScreen)
                  if (!views.isScheduleScreen)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSecondRow(
                                context, views, dashboardViews, styleAuditdata),
                            const SizedBox(height: 10),
                            views.nextOperatorAction
                                ? _buildThirdRow(context, views)
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Opacity(
                                      opacity: 1.0,
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 10),
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade300,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: const Center(
                                          child: Text(
                                            "End Session",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            views.nextOperatorAction
                                ? _buildFourthRow(
                                    context, views, auditview, styleAuditdata)
                                : Container(),
                          ],
                        ),
                      ),
                    ),
              if (views.isReportScreen) Expanded(child: _reportScreen(views)),
              if (views.isDefectScreen) Expanded(child: _defectScreen(views)),
              if (views.isScheduleScreen)
                Expanded(child: _scheduleScreen(views))
            ],
          ),
        ),
      );

  _defectScreen(
    InlineViewModal views,
  ) {
    return InlineDefectScreen(
      viewsData: views,
    );
  }

  _reportScreen(
    InlineViewModal views,
  ) {
    return InlineReport(
      viewsData: views,
    );
  }

  _scheduleScreen(
    InlineViewModal views,
  ) {
    return InlineSchedules(
      viewsData: views,
    );
  }

  _buildAppBar(
    InlineViewModal views,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 92,
      borderRadius: 0,
      blur: 10,
      alignment: Alignment.bottomCenter,
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
                      (styleData.auditType == "IL")
                          ? "In-Line"
                          : (styleData.auditType == "EL")
                              ? "End-Line"
                              : (styleData.auditType == "FG")
                                  ? "Finishing"
                                  : (styleData.auditType == "FG-I")
                                      ? "Finishing Inside"
                                      : (styleData.auditType == "FG-O")
                                          ? "Finishing Outside"
                                          : "NA",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quality Check",
                      style: TextStyle(
                        color: context.res.color.textGray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
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

                            // Navigator.pushNamed(
                            //     context, Constants.profileRoute);
                            // refreshPartOperation
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

  _buildSecondRow(BuildContext context, InlineViewModal views,
          DashboardViewModel dashboardViews, StyleAuditData styleAuditdata) =>
      GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoCard(
                  views: views,
                  dashBoardViews: dashboardViews,
                  styleAuditdata: styleAuditdata),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 100,
                child: _buildChart(views.totalCompleted, views.pass,
                    views.alter, views.reject, views),
              ),
              Column(
                children: [
                  _ChartDescription("Total", (views.totalCompleted).toString(),
                      Colors.grey, true),
                  const SizedBox(
                    height: 5,
                  ),
                  _ChartDescription(
                      "Pass", (views.pass).toString(), Colors.green, false),
                  const SizedBox(
                    height: 5,
                  ),
                  _ChartDescription(
                      "Alter", (views.alter).toString(), Colors.yellow, false),
                  const SizedBox(
                    height: 5,
                  ),
                  _ChartDescription(
                      "Reject", (views.reject).toString(), Colors.red, false),
                ],
              )
              //_buildChart()
              // chartData()
            ],
          ));

  _ChartDescription(
          String title, String optCnt, Color colorCode, bool isFirst) =>
      SizedBox(
          width: 140,
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: colorCode,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Text(optCnt,
                      style: TextStyle(
                          color: isFirst ? Colors.black : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600))),
              const SizedBox(
                width: 10,
              ),
              Text(title)
            ],
          ));

  _buildChart(
          int optCnt, int pass, int yellow, int fail, InlineViewModal views) =>
      BarChart(BarChartData(
          borderData: FlBorderData(
              border: const Border(
            top: BorderSide(width: 0),
            left: BorderSide(width: 1),
            right: BorderSide(width: 0),
            bottom: BorderSide(width: 1),
          )),
          gridData: null,
          groupsSpace: 5,
          barGroups: [
            BarChartGroupData(x: views.totalCompleted, barRods: [
              BarChartRodData(
                  toY: optCnt.toDouble(),
                  width: 15,
                  color: Colors.grey.withOpacity(0.5))
            ]),
            BarChartGroupData(x: views.pass, barRods: [
              BarChartRodData(
                  toY: pass.toDouble(), width: 15, color: Colors.green)
            ]),
            BarChartGroupData(x: views.alter, barRods: [
              BarChartRodData(
                  toY: yellow.toDouble(), width: 15, color: Colors.yellow)
            ]),
            BarChartGroupData(x: views.reject, barRods: [
              BarChartRodData(
                  toY: fail.toDouble(), width: 15, color: Colors.red)
            ])
          ]));

  _buildThirdRow(
    BuildContext context,
    InlineViewModal views,
  ) =>
      Opacity(
        opacity: 1.0,
        child: AbsorbPointer(
          absorbing: false,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SecondCard(
                  auditStep: views.auditStep,
                  views: views,
                  styleInfo: styleData,
                ),
                // OptionCard(), ActionCard()
              ],
            ),
          ),
        ),
      );
  _buildFourthRow(
    BuildContext context,
    InlineViewModal views,
    AuditViewModal auditview,
    StyleAuditData styleAuditData,
  ) =>
      Opacity(
        opacity: 1.0,
        child: AbsorbPointer(
          absorbing: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // if (views.sleeveAttachmentValue != null &&
              //     views.sleeveValue != null &&
              //     views.tagNumber != null &&
              //     views.garSize != null)
              OptionCard(views: views),
              // if (views.sleeveValue != null && views.tagNumber != null)
              MenuCard(
                views: views,
                auditView: auditview,
              ),

              Opacity(
                opacity: views.scoreCardData.partCode != "" ? 1.0 : 0.5,
                child: AbsorbPointer(
                    absorbing:
                        views.scoreCardData.partCode != "" ? false : true,
                    child: ActionCard(
                        views: views, styleAuditData: styleAuditData)),
              )
              // OptionCard(), ActionCard()
            ],
          ),
        ),
      );
}

class ApprovalScreen extends StatelessWidget {
  final InlineViewModal view;
  const ApprovalScreen(
    this.view, {
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
                          view.setSelectedSession(newValue.toString());
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
                    enabled: !(view
                            .GetLineQCApprovalByParamsApproverTypeUserCodeData
                            .isSuccess ??
                        false),
                    maxLength: 100,
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
                  if (view.GetLineQCApprovalByParamsApproverTypeUserCodeData
                          .isSuccess ??
                      false) {
                  } else if (view.selectedSession == null) {
                    view.showErrorAlert('Select Session');
                  } else {
                    view.postSaveLineQCApproval(context);
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
