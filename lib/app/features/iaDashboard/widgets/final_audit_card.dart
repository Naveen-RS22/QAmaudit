import 'package:flutter/material.dart';
import 'package:qapp/app/features/dashboard/data/audit_card_title_item.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

import '../../../res/styles.dart';

class FinalAuditCard extends StatefulWidget {
  final IADashboardViewModel viewModel;
  final IADashboardViewModel viewsData;

  const FinalAuditCard(
      {Key? key, required this.viewModel, required this.viewsData})
      : super(key: key);

  @override
  _FinalAuditCardState createState() => _FinalAuditCardState();
}

class _FinalAuditCardState extends State<FinalAuditCard> {
  final items = [];
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 4; i++) {
      items.add(AuditCardTitleItem("item $i", i.toString(), false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _finalAuditWidget(context);
  }

  _finalAuditWidget(BuildContext context) => Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: context.res.color.textGray),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Audit Summary',
                    style: Styles.headingStyle,
                  ),
                ),
                widget.viewsData.filterKeyss.isEmpty
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (int index = 0;
                              index < widget.viewsData.filterKeyss.length;
                              index++)
                            Center(
                              child: GestureDetector(
                                  onTap: () {
                                    widget.viewsData.finalAuditRoundOnChange(
                                        context,
                                        widget
                                            .viewsData.filterKeyss[index]['id']
                                            .toString());
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: widget.viewsData.finalAuditRound ==
                                              widget.viewsData
                                                  .filterKeyss[index]['id']
                                                  .toString()
                                          ? context.res.color.bgColorBlue
                                          : Colors.white,
                                      border: Border.all(
                                          color: widget.viewsData
                                                      .finalAuditRound ==
                                                  widget.viewsData
                                                      .filterKeyss[index]
                                                      .toString()
                                              ? Colors.white
                                              : Colors.black),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      widget
                                          .viewsData.filterKeyss[index]['text']
                                          .toString(),
                                      style: Styles.headingStyle.copyWith(
                                          color: widget.viewsData
                                                      .finalAuditRound ==
                                                  widget.viewsData
                                                      .filterKeyss[index]
                                                      .toString()
                                              ? context.res.color.white
                                              : Colors.black,
                                          fontSize: 14),
                                    ),
                                  )),
                            )
                        ],
                      )
              ],
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
                  child: Text(
                    'Buyer Code',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Style',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'PO Oty',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Fail Pcs',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Status',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: context.res.color.black,
          ),
          const SizedBox(height: 10),
          (widget.viewsData.getAuidtSummarylistData.data?.length ?? 0) == 0
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
                      widget.viewsData.getAuidtSummarylistData.data?.length ??
                          0,
                  itemBuilder: (BuildContext context, int index) {
                    return _listItem(context, index);
                  },
                )),
        ],
      );

  _listItem(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.viewsData.getAuidtSummarylistData.data?[index].buyerCode
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.viewsData.getAuidtSummarylistData.data?[index].styleNo
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.viewsData.getAuidtSummarylistData.data?[index].poQty
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.viewsData.getAuidtSummarylistData.data?[index].defectpcs
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.all(4),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: widget.viewsData.getAuidtSummarylistData.data?[index]
                        .finalResult ==
                    "F"
                ? context.res.color.textColorRed
                : context.res.color.textColorGreen,
          ),
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              widget.viewsData.getAuidtSummarylistData.data?[index]
                          .finalResult ==
                      "F"
                  ? "FAIL"
                  : "PASS",
              style: TextStyle(fontSize: 12, color: context.res.color.white),
            ),
          ),
        )),
      ],
    );
  }
}
