import 'package:flutter/material.dart';
import 'package:qapp/app/features/audit/audit_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

import '../../../res/styles.dart';

class FinalAuditCard extends StatefulWidget {
  final AuditViewModal viewsData;

  const FinalAuditCard({Key? key, required this.viewsData}) : super(key: key);

  @override
  _FinalAuditCardState createState() => _FinalAuditCardState();
}

class _FinalAuditCardState extends State<FinalAuditCard> {
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
                  const Row(
                    children: [
                      Icon(
                        Icons.bookmark_border_outlined,
                        color: Color(0xfff57234),
                      ),
                      Text(
                        'Defect List',
                        style: Styles.headingStyle,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.viewsData.setDefectList(false);
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
                SizedBox(
                  width: 120,
                  child: Text(
                    'Operator ID',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    'Operator Name',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'Operations',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    'No. of Defects',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Defects Lists',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 100,
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
          (widget.viewsData.getScoreCardEntryListDetail.data?.length ?? 0) == 0
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
                          .viewsData.getScoreCardEntryListDetail.data?.length ??
                      [].length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.viewsData.getScoreCardEntryListDetail
                            .data?[index].delete ??
                        false) {
                      return _listDelItem(context, index);
                    } else if (widget.viewsData.getScoreCardEntryListDetail
                            .data?[index].edit ??
                        false) {
                      return _listEditItem(context, index);
                    } else {
                      return _listItem(context, index);
                    }
                  },
                )),
        ],
      );

  _listEditItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Tag Number',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              if (widget.viewsData.editList.data?.scoreCardDetlModels
                          ?.isNotEmpty ??
                      false
                  ? true
                  : false)
                Row(
                  children: [
                    for (int i = 0;
                        i <
                            widget.viewsData.editList.data!.scoreCardDetlModels!
                                .length;
                        i++)
                      Container(
                        // margin: EdgeInsets.only(right: 10),
                        // padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.viewsData.editList.data!
                                  .scoreCardDetlModels![i].tagId
                                  .toString(),
                              style: const TextStyle(color: Color(0xff707070)),
                            )
                          ],
                        ),
                      )
                  ],
                )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Defects',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.viewsData.editList.data?.scoreCardDetlModels
                            ?.isNotEmpty ??
                        false
                    ? true
                    : false)
                  Row(
                    children: [
                      for (int i = 0;
                          i <
                              widget.viewsData.editList.data!
                                  .scoreCardDetlModels!.length;
                          i++)
                        Container(
                          color: const Color(0xfff6fafd),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.viewsData
                                      .deleteOneItem(context, index);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0xff707070),
                                  size: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.viewsData.editList.data!
                                    .scoreCardDetlModels![i].hostName
                                    .toString(),
                                style:
                                    const TextStyle(color: Color(0xff707070)),
                              )
                            ],
                          ),
                        )
                    ],
                  )

                // Text(
                //    widget.viewsData.editList.data!.orderNo.toString(),
                // ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.viewsData.cancelEditItem(index);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _listDelItem(BuildContext context, int index) {
    return Container(
      color: const Color(0xffb0adad),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Text(
            'Do you really want to delete this defect item? This cannot be undone later, please confirm.',
            style: TextStyle(color: Colors.white),
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.viewsData.deleteItem(
                      widget.viewsData.getScoreCardEntryListDetail.data?[index]
                              .id ??
                          0,
                      (widget.viewsData.getScoreCardEntryListDetail.data?[index]
                              .operatorCode ??
                          ''),
                      context);
                },
                child: const Text(
                  "Remove",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  widget.viewsData.cancelDeleteItem(index);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _listItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              widget.viewsData.getScoreCardEntryListDetail.data?[index]
                      .operatorCode
                      .toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              widget.viewsData.getScoreCardEntryListDetail.data?[index]
                      .operatorName
                      .toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              widget.viewsData.getScoreCardEntryListDetail.data?[index]
                      .operationName
                      .toString() ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Row(
              children: [
                Icon(Icons.circle,
                    color: widget.viewsData.getScoreCardEntryListDetail
                                .data?[index].defectPcs ==
                            1
                        ? Colors.yellow
                        : Colors.red),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.viewsData.getScoreCardEntryListDetail.data?[index]
                          .defectCount
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
            // child: Text(
            //   (widget.viewsData.getScoreCardEntryListDetail.data?[index]
            //                   .defectNames
            //                   .toString()
            //                   .length ??
            //               0) >
            //           60
            //       ? (widget.viewsData.getScoreCardEntryListDetail.data?[index]
            //                   .defectNames
            //                   .toString()
            //                   .characters
            //                   .take(60)
            //                   .toString())
            //               .toString() +
            //           '...'
            //       : (widget.viewsData.getScoreCardEntryListDetail.data?[index]
            //               .defectNames
            //               .toString())
            //           .toString(),
            //   style: const TextStyle(
            //     fontSize: 14,
            //   ),
            // ),
            child: Text(
              widget.viewsData.getScoreCardEntryListDetail.data?[index]
                      .defectNames
                      .toString() ??
                  '',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              children: [
                // GestureDetector(
                //   onTap: () {
                //     widget.viewsData.selectEditItem(
                //         index,
                //         widget.viewsData.getScoreCardEntryListDetail.data?[index]
                //                 .id ??
                //             0);
                //   },
                //   child: Text(
                //     "Edit",
                //     style: const TextStyle(
                //         fontSize: 14, fontWeight: FontWeight.w600),
                //   ),
                // ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.selectDeleteItem(index);
                  },
                  child: const Text(
                    "Remove",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
