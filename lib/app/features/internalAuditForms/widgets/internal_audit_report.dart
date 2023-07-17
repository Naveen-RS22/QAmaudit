import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/images.dart';

class InternalAuditReport extends StatefulWidget {
  final InternalAuditViewModal viewsData;

  const InternalAuditReport({Key? key, required this.viewsData})
      : super(key: key);

  @override
  _InternalAuditReportState createState() => _InternalAuditReportState();
}

class _InternalAuditReportState extends State<InternalAuditReport> {
  void deletePopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                  height: 150,
                  width: 300,
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  // margin: const EdgeInsets.all(10),

                  child: MyWidget(views: widget.viewsData)),
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
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setIsReportScreen();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            Expanded(child: hourlyDefects(context))
          ],
        ),
      );

  hourlyDefects(BuildContext context) => Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  // width: 100,
                  child: Text(
                    'Date',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                // Expanded(
                //   // width: 150,
                //   child: Row(
                //     children: [
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       Text(
                //         'Time',
                //         style: TextStyle(
                //             fontSize: 14,
                //             color: context.res.color.black,
                //             fontWeight: FontWeight.w600),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  // width: 200,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortOP();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Pass / Fail',
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
                          'Defect Type ',
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
                          'Part ',
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
                          'Defect ',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   // width: 120,
                //   child: GestureDetector(
                //     onTap: () {
                //       // widget.viewsData.changeInlineSortDEF();
                //     },
                //     child: Row(
                //       children: [
                //         Text(
                //           'Defect Level ',
                //           style: TextStyle(
                //               fontSize: 14,
                //               color: context.res.color.black,
                //               fontWeight: FontWeight.w600),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  // width: 120,
                  child: GestureDetector(
                    onTap: () {
                      // widget.viewsData.changeInlineSortDEF();
                    },
                    child: Row(
                      children: [
                        Text(
                          'Pack ID ',
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
                          'Comment ',
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
                          'Image ',
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
          // if (widget.viewsData.isDefectSummaryList)
          Divider(
            height: 1,
            color: Colors.grey.shade300,
          ),

          // if (widget.viewsData.isDefectSummaryList) const SizedBox(height: 10),
          // if (widget.viewsData.isDefectSummaryList)
          ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                              ?.auditQcDetlModels ??
                          [])
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
                  itemCount: (widget.viewsData.GetAuditHeadDataByIdNewData.data
                              ?.auditQcDetlModels ??
                          [])
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return hourlyDefectsListItem2(context, index);
                  },
                )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.viewsData.isDeleteSelected) {
                    deletePopup(context);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: widget.viewsData.isDeleteSelected
                        ? Colors.blue
                        : Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      );

  hourlyDefectsListItem2(
    BuildContext context,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        widget.viewsData.setDefectSelection(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                ?.auditQcDetlModels ??
                            [])[index]
                        .isSelected ??
                    false)
                ? Colors.grey.shade300
                : Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              // width: 100,
              child: Text(
                (widget.viewsData.GetAuditHeadDataByIdNewData.data
                            ?.auditQcDetlModels ??
                        [])[index]
                    .createdDate
                    .toString()
                    .characters
                    .take(10)
                    .toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            // Expanded(
            //   // width: 100,
            //   child: Text(
            //     (widget.viewsData.GetAuditHeadDataByIdNewData.data
            //                 ?.auditQcDetlModels ??
            //             [])[index]
            //         .createdDate
            //         .toString()
            //         .substring(((widget.viewsData.GetAuditHeadDataByIdNewData
            //                         .data?.auditQcDetlModels ??
            //                     [])[index]
            //                 .createdDate
            //                 .toString()
            //                 .length -
            //             8)),
            //     style: const TextStyle(
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
            Expanded(
              // width: 100,
              child: Text(
                (widget.viewsData.GetAuditHeadDataByIdNewData.data
                            ?.auditQcDetlModels ??
                        [])[index]
                    .chkType
                    .toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              // width: 100,
              child: Text(
                (widget.viewsData.GetAuditHeadDataByIdNewData.data
                            ?.auditQcDetlModels ??
                        [])[index]
                    .chkType
                    .toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              // width: 100,
              child: Text(
                (widget.viewsData.GetAuditHeadDataByIdNewData.data
                            ?.auditQcDetlModels ??
                        [])[index]
                    .partName
                    .toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              // width: 100,
              child: Text(
                (widget.viewsData.GetAuditHeadDataByIdNewData.data
                            ?.auditQcDetlModels ??
                        [])[index]
                    .defectName
                    .toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            // Expanded(
            //   // width: 100,
            //   child: Text(
            //     (widget.viewsData.GetAuditHeadDataByIdNewData.data
            //                 ?.auditQcDetlModels ??
            //             [])[index]
            //         .defectCode
            //         .toString(),
            //     style: const TextStyle(
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
            Expanded(
              // width: 100,
              child: Text(
                (widget.viewsData.GetAuditHeadDataByIdNewData.data
                                ?.auditQcDetlModels ??
                            [])[index]
                        .packID ??
                    '',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              // width: 100,
              child: Text(
                ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                        ?.auditQcDetlModels ??
                                    [])[index]
                                .comments ??
                            '')
                        .isEmpty
                    ? '-'
                    : ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                    ?.auditQcDetlModels ??
                                [])[index]
                            .comments ??
                        ''),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
                // width: 100,
                child: ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                        ?.auditQcDetlModels ??
                                    [])[index]
                                .auditImagesEntityModels ??
                            [])
                        .isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => showDialog(
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        title: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                            ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                                                    ?.auditQcDetlModels ??
                                                                [])[index]
                                                            .auditImagesEntityModels ??
                                                        [])[0]
                                                    .filePath ??
                                                '',
                                            height: 500,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                ImagePath.imgThumbnail,
                                                height: 500,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                  context: context),
                              child: Column(
                                children: [
                                  Image.network(
                                    ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                                            ?.auditQcDetlModels ??
                                                        [])[index]
                                                    .auditImagesEntityModels ??
                                                [])[0]
                                            .filePath ??
                                        '',
                                    height: 50,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        ImagePath.imgThumbnail,
                                        height: 110,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const Text('-')),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final InternalAuditViewModal views;
  const MyWidget({Key? key, required this.views}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int i = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 0), ((Timer timer) {
      if (mounted) {
        setState(() {
          i = i + 1;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Are you sure'),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                widget.views.deleteDefects(context);
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
