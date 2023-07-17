import 'package:flutter/material.dart';
import 'package:qapp/app/features/dashboard/dashboard_view_model.dart';
import 'package:qapp/app/features/dashboard/data/audit_card_title_item.dart';
import 'package:qapp/app/res/app_extensions.dart';

import '../../../res/styles.dart';

class FinalAuditCard extends StatefulWidget {
  final DashboardViewModel viewModel;
  final DashboardViewModel viewsData;

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
                const Text(
                  'Round Wise Operator Detail',
                  style: Styles.headingStyle,
                ),
                widget.viewsData.filterKeys.isEmpty
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (int index = 0;
                              index < widget.viewsData.filterKeys.length;
                              index++)
                            Center(
                              child: GestureDetector(
                                  onTap: () {
                                    if (widget.viewsData.finalAuditRound !=
                                        widget.viewsData.filterKeys[index]
                                            .toString()) {
                                      widget.viewsData
                                          .finalAuditRoundOnChange(index);
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: widget.viewsData.finalAuditRound ==
                                              widget.viewsData.filterKeys[index]
                                                  .toString()
                                          ? context.res.color.bgColorBlue
                                          : Colors.white,
                                      border: Border.all(
                                          color: widget.viewsData
                                                      .finalAuditRound ==
                                                  widget.viewsData
                                                      .filterKeys[index]
                                                      .toString()
                                              ? Colors.white
                                              : Colors.black),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.viewsData.filterKeys[index]
                                          .toString(),
                                      style: Styles.headingStyle.copyWith(
                                          color: widget.viewsData
                                                      .finalAuditRound ==
                                                  widget.viewsData
                                                      .filterKeys[index]
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
                SizedBox(
                  width: 50,
                  child: Text(
                    'Flag',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: Text(
                    'Operator Name',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    'Line',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Defects',
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
          (widget.viewsData.finalAudit.data?.length ?? 0) == 0
              ? const Expanded(
                  child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                  itemCount: widget.viewsData.finalAudit.data?.length ?? 0,
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
        SizedBox(
            width: 50,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.viewsData.finalAudit.data?[index].flagColor ==
                          "R"
                      ? Colors.red
                      : widget.viewsData.finalAudit.data?[index].flagColor ==
                              "G"
                          ? Colors.green
                          : Colors.yellow,
                ),
              ),
            )),
        SizedBox(
          width: 240,
          child: Text(
            widget.viewsData.finalAudit.data?[index].operatorName.toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            widget.viewsData.finalAudit.data?[index].sewLine.toString() ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.viewsData.finalAudit.data?[index].defectPcs.toString() ?? "",
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
            color: context.res.color.textColorGreen,
          ),
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              'COMPLETED',
              style: TextStyle(fontSize: 12, color: context.res.color.white),
            ),
          ),
        )),
      ],
    );
  }
}
