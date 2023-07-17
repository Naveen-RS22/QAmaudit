import 'package:flutter/material.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

import '../../../res/styles.dart';

class InlineSchedules extends StatefulWidget {
  final InlineViewModal viewsData;

  const InlineSchedules({Key? key, required this.viewsData}) : super(key: key);

  @override
  _InlineSchedulesState createState() => _InlineSchedulesState();
}

class _InlineSchedulesState extends State<InlineSchedules> {
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
            Container(
              color: const Color(0xfff6fafd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.bookmark_border_outlined,
                        color: Color(0xfff57234),
                      ),
                      Text(
                        'Style Information',
                        style: Styles.headingStyle,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.viewsData.setIsScheduleScreen();
                    },
                    child: const Icon(Icons.close),
                  )
                ],
              ),
            ),
            Expanded(
              child: _buildContentList(context),
            )
          ],
        ),
      );

  _buildContentList(BuildContext context) => Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  // width: 100,
                  child: Text(
                    'Audit Type',
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
                        'Buyer Code',
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
                      widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Style No',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_up_outlined,
                                color: widget.viewsData.currentSort == 'opASC'
                                    ? Colors.black
                                    : Colors.grey.shade300,
                                size: 20,
                              ),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_down_outlined,
                                color: widget.viewsData.currentSort == 'opDSC'
                                    ? Colors.black
                                    : Colors.grey.shade300,
                                size: 20,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // width: 120,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'Line Name',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_up_outlined,
                                color: widget.viewsData.currentSort == 'defASC'
                                    ? Colors.black
                                    : Colors.grey.shade300,
                                size: 20,
                              ),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_down_outlined,
                                color: widget.viewsData.currentSort == 'defDSC'
                                    ? Colors.black
                                    : Colors.grey.shade300,
                                size: 20,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
          (widget.viewsData.scheduleList.data?.length ?? 0) == 0
              ? const Expanded(
                  child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                  itemCount:
                      widget.viewsData.scheduleList.data?.length ?? [].length,
                  itemBuilder: (BuildContext context, int index) {
                    return _listItem(context, index);
                  },
                )),
        ],
      );

  _listItem(BuildContext context, int index) {
    return Container(
      color: widget.viewsData.styleAuditData?.id ==
              widget.viewsData.scheduleList.data?[index].id
          ? Colors.grey.shade300
          : Colors.transparent,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            // width: 100,
            child: Text(
              widget.viewsData.scheduleList.data?[index].auditType.toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 150,
            child: Text(
              widget.viewsData.scheduleList.data?[index].buyerCode.toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              widget.viewsData.scheduleList.data?[index].styleNo.toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            // width: 200,
            child: Text(
              widget.viewsData.scheduleList.data?[index].lineName.toString() ??
                  "",
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
                GestureDetector(
                  onTap: () {
                    // changeNewStyleFunction
                    widget.viewsData.changeNewStyleFunction(
                        context,
                        StyleAuditData(
                          auditScheduleDetlModel: [],
                          auditStatus: widget.viewsData.scheduleList
                                  .data?[index].auditStatus ??
                              "",
                          auditType: widget.viewsData.scheduleList.data?[index]
                                  .auditType ??
                              "",
                          auditorName1: widget.viewsData.scheduleList
                                  .data?[index].auditorName1 ??
                              "",
                          auditorName2: widget.viewsData.scheduleList
                                  .data?[index].auditorName2 ??
                              "",
                          auditorName3: widget.viewsData.scheduleList
                                  .data?[index].auditorName3 ??
                              "",
                          auditorName4: widget.viewsData.scheduleList
                                  .data?[index].auditorName4 ??
                              "",
                          auditorName: widget.viewsData.scheduleList
                                  .data?[index].auditorName ??
                              "",
                          buyerCode: widget.viewsData.scheduleList.data?[index]
                                  .buyerCode ??
                              "",
                          comments: widget.viewsData.scheduleList.data?[index]
                                  .comments ??
                              "",
                          completedDate: widget.viewsData.scheduleList
                                  .data?[index].completedDate ??
                              "",
                          createdBy: widget.viewsData.scheduleList.data?[index]
                                  .createdBy ??
                              "",
                          createdDate: widget.viewsData.scheduleList
                                  .data?[index].createdDate ??
                              "",
                          entityID: widget.viewsData.scheduleList.data?[index]
                                  .entityID ??
                              "",
                          hostName: widget.viewsData.scheduleList.data?[index]
                                  .hostName ??
                              "",
                          id: widget.viewsData.scheduleList.data?[index].id ??
                              0,
                          insType: widget.viewsData.scheduleList.data?[index]
                                  .insType ??
                              "",
                          isActive: widget.viewsData.scheduleList.data?[index]
                                  .isActive ??
                              false,
                          isScheduled: widget.viewsData.scheduleList
                                  .data?[index].isScheduled ??
                              "",
                          lineName: widget.viewsData.scheduleList.data?[index]
                                  .lineName ??
                              "",
                          modifiedBy: widget.viewsData.scheduleList.data?[index]
                                  .modifiedBy ??
                              "",
                          modifiedDate: widget.viewsData.scheduleList
                                  .data?[index].modifiedDate ??
                              "",
                          orderNo: widget.viewsData.scheduleList.data?[index]
                                  .orderNo ??
                              0,
                          orderQty: widget.viewsData.scheduleList.data?[index]
                                  .orderQty ??
                              0,
                          orderSchID: widget.viewsData.scheduleList.data?[index]
                                  .orderSchID ??
                              0,
                          preID: widget
                                  .viewsData.scheduleList.data?[index].preID ??
                              0,
                          productType: widget.viewsData.scheduleList
                                  .data?[index].productType ??
                              "",
                          schDate: widget.viewsData.scheduleList.data?[index]
                                  .schDate ??
                              "",
                          schTime: widget.viewsData.scheduleList.data?[index]
                                  .schTime ??
                              "",
                          sessionName: widget.viewsData.scheduleList
                                  .data?[index].sessionName ??
                              "",
                          sewLine: widget.viewsData.scheduleList.data?[index]
                                  .sewLine ??
                              "",
                          ssFlag: widget
                                  .viewsData.scheduleList.data?[index].ssFlag ??
                              "",
                          styleNo: widget.viewsData.scheduleList.data?[index]
                                  .styleNo ??
                              "",
                          totOperators: widget.viewsData.scheduleList
                                  .data?[index].totOperators ??
                              0,
                          unitCode: widget.viewsData.scheduleList.data?[index]
                                  .unitCode ??
                              "",
                        ));
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
