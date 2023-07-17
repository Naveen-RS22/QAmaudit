import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/dto/FinalAuditModel.dart';
import 'package:qapp/app/data/network/dto/GetLineQCTop3DefectModel.dart';
import 'package:qapp/app/data/network/dto/QCSummaryModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/dashboard/dashboard_view_model.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';

class InfoCard extends StatefulWidget {
  final InlineViewModal views;
  final DashboardViewModel dashBoardViews;
  final StyleAuditData styleAuditdata;
  const InfoCard(
      {Key? key,
      required this.views,
      required this.dashBoardViews,
      required this.styleAuditdata})
      : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  void flagPopup(BuildContext context) {
    exceptionDialog() {
      var tagName = widget.views.scoreCardData.lineQcDetlModels ?? [];

      Widget flagListGenerate() {
        var flagList = widget.views.finalAudit.data ?? [];
        var sessionName = widget.styleAuditdata.sessionName ?? "";

        List<AuditData> search(String input) {
          return flagList.where((e) => e.sessionName!.contains(input)).toList();
        }

        var newList = search(sessionName);

        List<AuditData> searchFlag(String input) {
          return newList.where((e) => e.flagColor!.contains("RED")).toList();
        }

        var flagsData = searchFlag(sessionName);

        return Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            children: flagsData.map((item) {
              var selected = widget.views.selectFavorite.indexWhere((element) =>
                  element.toString() == item.auditorName.toString());

              return Container(
                // width: 300,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(item.operatorName.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.circle,
                      color: Colors.red,
                    )
                  ],
                ),
              );
            }).toList());
      }

      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.5,
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    flagListGenerate(),
                  ],
                ),
              )),
          title: "",
          confirmTextColor: const Color(0xffffffff),
          cancelTextColor: const Color(0xffF7931C),
          buttonColor: const Color(0xffF7931C));
    }

    exceptionDialog();
  }

  void defectListPopou(BuildContext context) {
    exceptionDialog() {
      List<LineQCTop3Defects> myList =
          widget.views.getLineQCTop3DefectDetail.data ?? [];
      List<LineQCTop3detailReportModels> newList = [];
      if (myList.isNotEmpty) {
        newList = myList[0].lineQCTop3detailReportModels ?? [];
      }

      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Total Defects ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (newList.isNotEmpty)
                    for (int i = 0; i < newList.length; i++)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                newList[i].defectName ?? "",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: context.res.color.black,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${newList[i].defectPercent} %",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: context.res.color.textOrange,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                  if (newList.isEmpty) const Text('No data found'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
          title: "",
          confirmTextColor: const Color(0xffffffff),
          cancelTextColor: const Color(0xffF7931C),
          buttonColor: const Color(0xffF7931C));
    }

    exceptionDialog();
  }

  void top3DefectPopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                  height: 400,
                  width: 600,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                      child: MyWidget(views: widget.views))),
            );
          },
        );
      },
    );
  }

  void styleAuditInfoPop(BuildContext context) {
    exceptionDialog() {
      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    'Style Audit Info',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text('Unit Code:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.unitCode.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Audit Type:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.auditType.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Order No:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.orderNo.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Auditor Name:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.auditorName.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Buyer Code:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.buyerCode.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Line Number:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.lineName.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text('Color:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.auditorName4.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
          title: "",
          confirmTextColor: const Color(0xffffffff),
          cancelTextColor: const Color(0xffF7931C),
          buttonColor: const Color(0xffF7931C));
    }

    exceptionDialog();
  }

  @override
  Widget build(BuildContext context) {
    // var scheduleData = widget.dashBoardViews.scheduleList.data ?? [];
    // var defectpr = widget.views.optData.data?.defectper ?? [];
    // var defectCount = defectpr.isNotEmpty ? defectpr[0].tagidcnt ?? 0 : 0;

    // var checkpc = widget.views.optData.data?.checkedpsc ?? 0;

    var defectper = (widget.views.getQCSummary.data?.length == 1)
        ? (widget.views.getQCSummary.data![0].defectPcs ?? 0) == 0
            ? 0
            : ((widget.views.getQCSummary.data![0].defectPcs ?? 0) /
                    (widget.views.getQCSummary.data![0].inspectedPcs ?? 0)) *
                100
        : 0;
    var defects = widget.views.getQCSummary.data ?? [];

    var defData = defects.isEmpty ? QCSummaryData() : defects[0];
    var rejectedPcs = defData.rejectedPcs ?? 0;
    var defectPcs = defData.defectPcs ?? 0;
    var inspectedPcs = defData.inspectedPcs ?? 0;

    var dhupercent = ((rejectedPcs + defectPcs) / inspectedPcs) * 100;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      child: GestureDetector(
                          onTap: () {
                            styleAuditInfoPop(context);
                          },
                          child: const Icon(Icons.info_outline))),
                  const SizedBox(width: 10),
                  const Text('Style Audit Info'),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Row(children: [
                Container(
                    child: GestureDetector(
                        onTap: () async {
                          // String unitCode =
                          //     await SharedPreferenceHelper.getString(
                          //         'unitCode');

                          // DateTime dateToday = DateTime.now();
                          // String currentDate2 =
                          //     dateToday.toString().substring(0, 10);
                          // String userN = await SharedPreferenceHelper.getString(
                          //     Constants.userDisplayName);

                          // widget.views.getLineQCTop3Defect(
                          //   context,
                          //   unitCode,
                          //   currentDate2,
                          //   widget.views.scoreCardData.auditType ?? "",
                          //   widget.views.scoreCardData.sewLine ?? '',
                          //   userN,
                          //   widget.views.scoreCardData.orderNo ?? 0,
                          // );
                          top3DefectPopup(context);
                          // defectListPopou(context);
                        },
                        child: const Icon(Icons.info_outline))),
                const SizedBox(width: 10),
                const Text('Total Defects'),
              ]),
              const SizedBox(
                width: 30,
              ),
              Row(children: [
                Container(
                    child: GestureDetector(
                        onTap: () async {
                          // widget.views.getGetLineQCDefectsCountandoverallReport(
                          //     context,
                          //     widget.views.styleAuditData?.unitCode,
                          //     widget.views.styleAuditData?.schDate,
                          //     widget.views.styleAuditData?.auditType,
                          //     widget.views.styleAuditData?.createdBy,
                          //     widget.views.styleAuditData?.orderNo,
                          //     widget.views.styleAuditData?.sewLine);
                          await widget.views
                              .getAllSessionMasterbyunitcode(context);
                          widget.views
                              .getAllLineQCsDefectdetailsByRangeHourlysummaryAPI(
                                  context,
                                  widget.views.styleAuditData?.unitCode,
                                  widget.views.styleAuditData?.schDate,
                                  widget.views.styleAuditData?.auditType,
                                  widget.views.styleAuditData?.createdBy,
                                  widget.views.styleAuditData?.orderNo,
                                  widget.views.styleAuditData?.sewLine,
                                  widget.views.scoreCardData.sessionCode);
                          widget.views
                              .GetAllLineQCsDefectdetailsByRangeDaysummaryAPI(
                                  context,
                                  widget.views.styleAuditData?.unitCode,
                                  widget.views.styleAuditData?.schDate,
                                  widget.views.styleAuditData?.auditType,
                                  widget.views.styleAuditData?.createdBy,
                                  widget.views.styleAuditData?.orderNo,
                                  widget.views.styleAuditData?.sewLine,
                                  widget.views.scoreCardData.sessionCode);
                          widget.views
                              .GetAllLineQCsDefectdetailsByRangeHourlyDefectsAPI(
                                  context,
                                  widget.views.styleAuditData?.unitCode,
                                  widget.views.styleAuditData?.schDate,
                                  widget.views.styleAuditData?.auditType,
                                  widget.views.styleAuditData?.createdBy,
                                  widget.views.styleAuditData?.orderNo,
                                  widget.views.styleAuditData?.sewLine,
                                  widget.views.scoreCardData.sessionCode);
                          widget.views
                              .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListAPI(
                                  context,
                                  widget.views.styleAuditData?.unitCode,
                                  widget.views.styleAuditData?.schDate,
                                  widget.views.styleAuditData?.auditType,
                                  widget.views.styleAuditData?.createdBy,
                                  widget.views.styleAuditData?.orderNo,
                                  widget.views.styleAuditData?.sewLine,
                                  widget.views.scoreCardData.sessionCode);

                          widget.views.setIsReportScreen();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const InlineReport()),
                          // );
                        },
                        child: const Icon(Icons.info_outline))),
                const SizedBox(width: 10),
                const Text('Defect Summary'),
              ]),
              const SizedBox(
                width: 15,
              ),
              Container(
                  child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        DateTime dateToday = DateTime.now();
                        String currentDate =
                            dateToday.toString().substring(0, 10);
                        widget.views.getSchduleList(
                            context,
                            widget.views.styleAuditData?.unitCode ?? '',
                            currentDate);
                        widget.views.setIsScheduleScreen();
                      },
                      child: const Icon(Icons.info_outline)),
                  const SizedBox(width: 10),
                  const Text('Style'),
                ],
              )),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    const Text('DHU : '),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      dhupercent.isNaN
                          ? "0.00" " %"
                          : "${dhupercent.toStringAsFixed(2)}%",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: const Color(0xFFf6f8fa),
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Target'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.styleAuditdata.totOperators.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Completed'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.views.totalCompleted.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Alter Status'),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            color: Colors.orange,
                          ),
                          Text(widget.views.alter.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          const Icon(Icons.arrow_downward, color: Colors.green),
                          Text(widget.views.reAlter.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final InlineViewModal views;
  const MyWidget({Key? key, required this.views}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  void newFunction() async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String currentDate2 = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');

    widget.views.getLineQCTop3Defect(
      context,
      unitCode,
      currentDate2,
      widget.views.scoreCardData.auditType ?? "",
      widget.views.scoreCardData.sewLine ?? '',
      userN,
      widget.views.scoreCardData.orderNo ?? 0,
    );

    String count = '0';
    Timer.periodic(const Duration(seconds: 0), (timer) {
      if (mounted) {
        setState(() {
          count = timer.tick.toString();
        });
      }
    });
  }

  @override
  void initState() {
    newFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<LineQCTop3Defects> myList =
        widget.views.getLineQCTop3DefectDetail.data ?? [];
    List<LineQCTop3detailReportModels> newList = [];
    if (myList.isNotEmpty) {
      newList = myList[0].lineQCTop3detailReportModels ?? [];
    }

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        margin: const EdgeInsets.all(10),
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Total Defects ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (newList.isNotEmpty)
                  for (int i = 0; i < newList.length; i++)
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              newList[i].defectName ?? "",
                              style: TextStyle(
                                fontSize: 18,
                                color: context.res.color.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${newList[i].defectPercent} %",
                              style: TextStyle(
                                fontSize: 18,
                                color: context.res.color.textOrange,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${newList[i].defectCount} pcs",
                              style: TextStyle(
                                fontSize: 18,
                                color: context.res.color.textOrange,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                if (newList.isEmpty) const Text('No data found'),
                const SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
