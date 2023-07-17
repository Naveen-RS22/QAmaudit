import 'package:flutter/material.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

import '../../../res/styles.dart';

class InlineReport extends StatefulWidget {
  final InlineViewModal viewsData;

  const InlineReport({Key? key, required this.viewsData}) : super(key: key);

  @override
  _InlineReportState createState() => _InlineReportState();
}

class _InlineReportState extends State<InlineReport> {
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
                        'Report',
                        style: Styles.headingStyle,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.viewsData.setIsReportScreen();
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
                    'Sessoion',
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
                        'Part Name',
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
                          'Operations Name',
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
                    onTap: () {
                      widget.viewsData.changeInlineSortDEF();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Defect Name',
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
                  child: Text(
                    'Count',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  // width: 100,
                  child: Text(
                    'Overall',
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
          (widget.viewsData.lineQCDefectsCountandoverallReportModel.data
                          ?.length ??
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
                          .lineQCDefectsCountandoverallReportModel
                          .data
                          ?.length ??
                      [].length,
                  itemBuilder: (BuildContext context, int index) {
                    return _listItem(context, index);
                  },
                )),
        ],
      );

  _listItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            // width: 100,
            child: Text(
              widget.viewsData.lineQCDefectsCountandoverallReportModel
                      .data?[index].sessionCode
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
              widget.viewsData.lineQCDefectsCountandoverallReportModel
                      .data?[index].partName
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
              widget.viewsData.lineQCDefectsCountandoverallReportModel
                      .data?[index].operationName
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
              widget.viewsData.lineQCDefectsCountandoverallReportModel
                      .data?[index].defectName
                      .toString() ??
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
                  width: 10,
                ),
                Text(
                  widget.viewsData.lineQCDefectsCountandoverallReportModel
                          .data?[index].defectCount
                          .toString() ??
                      "",
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
                  width: 20,
                ),
                Text(
                  widget.viewsData.lineQCDefectsCountandoverallReportModel
                          .data?[index].overAllDefectCount
                          .toString() ??
                      "",
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
}
