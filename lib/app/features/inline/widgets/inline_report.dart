import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../res/styles.dart';

class InlineReport extends StatefulWidget {
  final InlineViewModal viewsData;

  const InlineReport({Key? key, required this.viewsData}) : super(key: key);

  @override
  _InlineReportState createState() => _InlineReportState();
}

class _InlineReportState extends State<InlineReport> {
  void deletePopup(
      BuildContext context, InlineViewModal views, int index) async {
    views.resetIsRemove(index);
    return showDialog(
      context: context,
      builder: (context) {
        String contentText = "Content of Dialog";
        String count = '0';

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                  // height: 175,
                  width: 650,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(child: MyWidget(views: views))),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _finalAuditWidget(context);
  }

  _finalAuditWidget(BuildContext context) => Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setCurrentReportScreen(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: widget.viewsData.currentReportScreen == 1
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'Hourly Defects',
                      style: widget.viewsData.currentReportScreen == 1
                          ? Styles.headingStyle
                          : Styles.paragraphStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setCurrentReportScreen(2);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: widget.viewsData.currentReportScreen == 2
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'Day Wise Defects',
                      style: widget.viewsData.currentReportScreen == 2
                          ? Styles.headingStyle
                          : Styles.paragraphStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setCurrentReportScreen(3);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: widget.viewsData.currentReportScreen == 3
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'Hourly Summary',
                      style: widget.viewsData.currentReportScreen == 3
                          ? Styles.headingStyle
                          : Styles.paragraphStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setCurrentReportScreen(4);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: widget.viewsData.currentReportScreen == 4
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'Defect List',
                      style: widget.viewsData.currentReportScreen == 4
                          ? Styles.headingStyle
                          : Styles.paragraphStyle,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setIsReportScreen();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            Expanded(
              child: widget.viewsData.currentReportScreen == 1
                  ? hourlyDefects(context)
                  : widget.viewsData.currentReportScreen == 2
                      ? dayWiseDefects(context)
                      : widget.viewsData.currentReportScreen == 3
                          ? hourlySummary(context)
                          : widget.viewsData.currentReportScreen == 4
                              ? defectList(context)
                              : Container(),
            )
          ],
        ),
      );

  hourlyDefects(BuildContext context) => Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                width: 200,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: DropdownButton<String>(
                  value: widget.viewsData
                      .GetAllLineQCsDefectdetailsByRangeHourlyDefectsSession,
                  isExpanded: true,
                  hint: const Text("Select Session"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    widget.viewsData
                        .GetAllLineQCsDefectdetailsByRangeHourlyDefectsSessionOnchange(
                            newValue.toString());
                  },
                  items: (widget.viewsData.getAllSessionMasterbyunitcodeData
                              .data ??
                          [])
                      .map((item) {
                    return DropdownMenuItem(
                      onTap: () {
                        // widget.viewsData.selectedSessionValidation(item.id);
                      },
                      value: item.sessionCode.toString(),
                      child: Text(item.sessionName.toString()),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Spacer(),
              if (widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData
                  .isEmpty)
                const Text('Re Inspected Pcs : 0   '),
              if (widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData
                  .isEmpty)
                const Text('Inspected Pcs : 0   '),
              if (widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData
                  .isNotEmpty)
                Text(
                    'Re Inspected Pcs : ${(widget.viewsData.GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData[0].totalRecheckededPcs ?? 0).toString()}   '),
              if (widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData
                  .isNotEmpty)
                Text(
                    'Inspected Pcs : ${(widget.viewsData.GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData[0].totalInspectedPcs ?? 0).toString()}   '),
              Container(
                width: 200,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                    cursorColor: Colors.black,
                    controller: widget.viewsData
                        .GetAllLineQCsDefectdetailsByRangeHourlyDefectsController,
                    onChanged: (search) {
                      widget.viewsData
                          .GetAllLineQCsDefectdetailsByRangeHourlyDefectsControllerOnChange(
                              search);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    )),
              ),
              // SizedBox(
              //   width: 200,
              //   child: GestureDetector(
              //     onTap: () {
              //       widget.viewsData
              //           .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDatePicker(
              //               context);
              //     },
              //     child: Container(
              //         padding: const EdgeInsets.all(10),
              //         color: Colors.grey.shade200,
              //         child: Row(
              //           children: [
              //             Text((widget.viewsData
              //                             .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDate ??
              //                         '')
              //                     .isNotEmpty
              //                 ? (widget.viewsData
              //                         .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDate ??
              //                     '')
              //                 : 'Select'),
              //             const Spacer(),
              //             const Icon(
              //               Icons.calendar_month,
              //               color: Colors.orange,
              //             )
              //           ],
              //         )),
              //   ),
              // )
            ],
          ),
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  // width: 100,
                  child: Text(
                    'Defect Code',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  // width: 150,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Defect Name',
                        style: TextStyle(
                            fontSize: 14,
                            color: context.res.color.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // width: 200,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Defect Count',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // width: 200,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Reject Count',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Defect DHU Percent',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          (widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData
                      .length) ==
                  0
              ? const Expanded(
                  child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                  itemCount: widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget
                            .viewsData
                            .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData[
                                index]
                            .defectCount ==
                        0) {
                      return hourlyDefectsListItem(context, index);
                    } else {
                      return Container();
                    }
                  },
                )),
        ],
      );

  hourlyDefectsListItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            // width: 100,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData[
                      index]
                  .defectCode
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 150,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData[
                      index]
                  .defectName
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData[
                      index]
                  .defectsplitCount
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData[
                      index]
                  .rejectsplitCount
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeHourlyDefectsDataFilteredData[
                          index]
                      .defectDHUPercent
                      .toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  dayWiseDefects(BuildContext context) => Column(
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 200,
                child: GestureDetector(
                  onTap: () {
                    widget.viewsData
                        .GetAllLineQCsDefectdetailsByRangeDaysummaryDatePicker(
                            context);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Text((widget.viewsData
                                          .GetAllLineQCsDefectdetailsByRangeDaysummaryDate ??
                                      '')
                                  .isNotEmpty
                              ? (widget.viewsData
                                      .GetAllLineQCsDefectdetailsByRangeDaysummaryDate ??
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
              const Spacer(),
              if (widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData
                  .isEmpty)
                const Text('Re Inspected Pcs : 0   '),
              if (widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData
                  .isEmpty)
                const Text('Inspected Pcs : 0   '),
              if (widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData
                  .isNotEmpty)
                Text(
                    'Re Inspected Pcs : ${(widget.viewsData.GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData[0].totalRecheckededPcs ?? 0).toString()}   '),
              if (widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData
                  .isNotEmpty)
                Text(
                    'Inspected Pcs : ${(widget.viewsData.GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData[0].totalInspectedPcs ?? 0).toString()}   '),
              Container(
                width: 200,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                    cursorColor: Colors.black,
                    controller: widget.viewsData
                        .GetAllLineQCsDefectdetailsByRangeDaysummaryDataController,
                    onChanged: (search) {
                      widget.viewsData
                          .GetAllLineQCsDefectdetailsByRangeDaysummaryControllerOnChange(
                              search);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  // width: 100,
                  child: Text(
                    'Defect Code',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  // width: 150,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Defect Name',
                        style: TextStyle(
                            fontSize: 14,
                            color: context.res.color.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // width: 200,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Defect Pieces',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // width: 200,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Reject Pieces',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // width: 100,
                  child: Text(
                    'DHU%',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          (widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData
                      .length) ==
                  0
              ? const Expanded(
                  child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                  itemCount: widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return dayWiseDefectsListItem(context, index);
                  },
                )),
        ],
      );

  dayWiseDefectsListItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            // width: 100,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData[
                      index]
                  .defectCode
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 150,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData[
                      index]
                  .defectName
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              (widget
                          .viewsData
                          .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData[
                              index]
                          .defectsplitCount ??
                      0)
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              (widget
                          .viewsData
                          .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData[
                              index]
                          .rejectsplitCount ??
                      0)
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeDaysummaryDataFilteredData[
                          index]
                      .defectDHUPercent
                      .toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  hourlySummary(BuildContext context) => Column(
        children: <Widget>[
          Row(
            children: [
              const Spacer(),
              if ((widget
                          .viewsData
                          .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                          .data ??
                      [])
                  .isEmpty)
                const Text('Re Inspected Pcs : 0   '),
              if ((widget
                          .viewsData
                          .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                          .data ??
                      [])
                  .isEmpty)
                const Text('Inspected Pcs : 0   '),
              if ((widget
                          .viewsData
                          .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                          .data ??
                      [])
                  .isNotEmpty)
                Text(
                    'Re Inspected Pcs : ${widget.viewsData.getAllLineQCsDefectdetailsByRangeHourlysummaryDataReInspectedPcs}   '),
              if ((widget
                          .viewsData
                          .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                          .data ??
                      [])
                  .isNotEmpty)
                Text(
                    'Inspected Pcs : ${widget.viewsData.getAllLineQCsDefectdetailsByRangeHourlysummaryDataInspectedPcs}   '),
            ],
          ),
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  // width: 100,
                  child: Text(
                    'Hour',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  // width: 150,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Inspected Pieces',
                        style: TextStyle(
                            fontSize: 14,
                            color: context.res.color.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // width: 200,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Defect Pieces',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // width: 200,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Reject Pieces',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          (widget.viewsData.getAllLineQCsDefectdetailsByRangeHourlysummaryData
                          .data?.length ??
                      0) ==
                  0
              ? const Expanded(
                  child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                  itemCount: widget
                          .viewsData
                          .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                          .data
                          ?.length ??
                      [].length,
                  itemBuilder: (BuildContext context, int index) {
                    return hourlySummaryListItem(context, index);
                  },
                )),
        ],
      );

  hourlySummaryListItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            // width: 100,
            child: Text(
              widget
                      .viewsData
                      .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                      .data?[index]
                      .sessionName
                      .toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 150,
            child: Text(
              widget
                      .viewsData
                      .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                      .data?[index]
                      .inspectedPcs
                      .toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              widget
                      .viewsData
                      .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                      .data?[index]
                      .defectPcs
                      .toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              widget
                      .viewsData
                      .getAllLineQCsDefectdetailsByRangeHourlysummaryData
                      .data?[index]
                      .rejectedPcs
                      .toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  defectList(BuildContext context) => Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                width: 200,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: DropdownButton<String>(
                  value: widget.viewsData
                      .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDatasession,
                  isExpanded: true,
                  hint: const Text("Select Session"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    widget.viewsData
                        .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDatasessionOnchange(
                            newValue.toString());
                  },
                  items: (widget.viewsData.getAllSessionMasterbyunitcodeData
                              .data ??
                          [])
                      .map((item) {
                    return DropdownMenuItem(
                      onTap: () {
                        // widget.viewsData.selectedSessionValidation(item.id);
                      },
                      value: item.sessionCode.toString(),
                      child: Text(item.sessionName.toString()),
                    );
                  }).toList(),
                ),
              ),
              const Spacer(),
              Container(
                width: 200,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                    cursorColor: Colors.black,
                    controller: widget.viewsData
                        .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListController,
                    onChanged: (search) {
                      widget.viewsData
                          .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListControllerOnChange(
                              search);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    'Time',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Status',
                        style: TextStyle(
                            fontSize: 14,
                            color: context.res.color.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Part',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // width: 120,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortDEF();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Operations ',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Defect',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  // width: 100,
                  child: Text(
                    'Size',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  // width: 100,
                  child: Text(
                    'Tag',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  // width: 100,
                  child: Text(
                    'Action',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          (widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData
                      .length) ==
                  0
              ? const Expanded(
                  child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                  itemCount: widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return defectListListItem(context, index);
                  },
                )),
        ],
      );

  defectListListItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                      index]
                  .fromTime
                  .toString()
                  .trim(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 95,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              color: (widget
                              .viewsData
                              .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                                  index]
                              .isClosed ??
                          "") ==
                      'Y'
                  ? Colors.green
                  : Colors.orange,
              child: Text(
                (widget
                                .viewsData
                                .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                                    index]
                                .isClosed ??
                            "") ==
                        'Y'
                    ? 'Completed'
                    : 'Inprocess',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                      index]
                  .partName
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              widget
                  .viewsData
                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                      index]
                  .operationName
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  (widget
                                  .viewsData
                                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                                      index]
                                  .defectName
                                  .toString())
                              .length >
                          20
                      ? '${(widget.viewsData.GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[index].defectName.toString()).characters.take(20)}...'
                      : widget
                          .viewsData
                          .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                              index]
                          .defectName
                          .toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   // width: 200,
          //   child: Row(
          //     children: [
          //       const SizedBox(
          //         width: 20,
          //       ),
          //       Text(
          //         (widget
          //                         .viewsData
          //                         .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListData
          //                         .data?[index]
          //                         .garSize ??
          //                     '')
          //                 .trim()
          //                 .isEmpty
          //             ? 'NA'
          //             : widget
          //                     .viewsData
          //                     .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListData
          //                     .data?[index]
          //                     .garSize ??
          //                 '',
          //         style: const TextStyle(
          //           fontSize: 14,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            // width: 200,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  (widget
                                  .viewsData
                                  .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                                      index]
                                  .garSize ??
                              '')
                          .isEmpty
                      ? '-'
                      : (widget
                              .viewsData
                              .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                                  index]
                              .garSize ??
                          ''),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            // width: 200,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget
                      .viewsData
                      .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                          index]
                      .tagId
                      .toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            // width: 200,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      deletePopup(context, widget.viewsData, index);
                      // widget.viewsData.RemoveDefectsByIDAPI(
                      //   context,
                      //   widget
                      //       .viewsData
                      //       .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                      //           index]
                      //       .lineQCDetailID,
                      //   widget.viewsData.isremoveinspectedPcscount,
                      //   widget.viewsData.isremoveAlteredPcscount,
                      //   widget.viewsData.isremoveDefectedPcscount,
                      //   widget.viewsData.isremoveRejectedPcscount,
                      // );
                    },
                    child: SvgPicture.asset(ImagePath.deleteIcon)),
              ],
            ),
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
  @override
  void initState() {
    newFunction();
    super.initState();
  }

  void newFunction() async {
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
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: const [
              Text('Select '),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Checkbox(
                    value: widget.views.isremoveinspectedPcscount,
                    onChanged: (val) {
                      widget.views.setIsremoveinspectedPcscount();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Inspected Pcs')
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Checkbox(
                    value: widget.views.isremoveAlteredPcscount,
                    onChanged: (val) {
                      widget.views.setIsremoveAlteredPcscount();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Altered Pcs')
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Checkbox(
                    value: widget.views.isremoveDefectedPcscount,
                    onChanged: (val) {
                      widget.views.setIsremoveDefectedPcscount();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Defected Pcs')
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Checkbox(
                    value: widget.views.isremoveRejectedPcscount,
                    onChanged: (val) {
                      widget.views.setIsremoveRejectedPcscount();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Rejected Pcs')
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  widget.views.RemoveDefectsByIDAPI(
                    context,
                    widget
                        .views
                        .GetAllLineQCsDefectdetailsByRangeHourlyDefectsListDataFilteredData[
                            widget.views.deleteIndex]
                        .lineQCDetailID,
                    widget.views.isremoveinspectedPcscount,
                    widget.views.isremoveAlteredPcscount,
                    widget.views.isremoveDefectedPcscount,
                    widget.views.isremoveRejectedPcscount,
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
