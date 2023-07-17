import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/GetListGarFitAuditDataByParamsResponseModel.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/images.dart';

class FinalAuditCard extends StatefulWidget {
  final FitAuditViewModal viewsData;

  const FinalAuditCard({Key? key, required this.viewsData}) : super(key: key);

  @override
  _FinalAuditCardState createState() => _FinalAuditCardState();
}

class _FinalAuditCardState extends State<FinalAuditCard> {
  void imageListPopup(BuildContext context, int index) {
    List<GetListGarFitAuditDataByParamsResponseModelAuditImagesModels> imgList =
        [];
    for (int i = 0;
        i <
            ((widget.viewsData.GetListGarFitAuditDataByParamsResponsData.data ??
                            [])[index]
                        .garFitAuditDetlModels ??
                    [])
                .length;
        i++) {
      if ((((widget.viewsData.GetListGarFitAuditDataByParamsResponsData.data ??
                              [])[index]
                          .garFitAuditDetlModels ??
                      [])[i]
                  .garFitAuditImagesModels ??
              [])
          .isNotEmpty) {
        inspect((((widget.viewsData.GetListGarFitAuditDataByParamsResponsData
                                .data ??
                            [])[index]
                        .garFitAuditDetlModels ??
                    [])[i]
                .garFitAuditImagesModels ??
            []));
        imgList.addAll((((widget
                                .viewsData
                                .GetListGarFitAuditDataByParamsResponsData
                                .data ??
                            [])[index]
                        .garFitAuditDetlModels ??
                    [])[i]
                .garFitAuditImagesModels ??
            []));
      }
    }

    exceptionDialog() {
      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    'Images',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 700,
                      height: 400,
                      child: imgList.isNotEmpty
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0; i < imgList.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Image.network(
                                        imgList[i].filePath ?? '',
                                        height: 300,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            ImagePath.imgThumbnail,
                                            height: 300,
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('No Data'),
                                  ],
                                ),
                              ],
                            ))
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
              // color: const Color(0xfff6fafd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // const Row(
                  //   children: [
                  //     Icon(
                  //       Icons.bookmark_border_outlined,
                  //       color: Color(0xfff57234),
                  //     ),
                  //     Text(
                  //       'Defect List',
                  //       style: Styles.headingStyle,
                  //     ),
                  //   ],
                  // ),
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
                  width: 100,
                  child: Text(
                    'Remove',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Round',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Operator',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Operations',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Pass',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Fail',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Date',
                    style: TextStyle(
                        fontSize: 14,
                        color: context.res.color.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Image',
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
          ((widget.viewsData.GetListGarFitAuditDataByParamsResponsData.data ??
                      [])
                  .isEmpty)
              ? const Expanded(
                  child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                  itemCount: (widget.viewsData
                              .GetListGarFitAuditDataByParamsResponsData.data ??
                          [])
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget
                            .viewsData
                            .GetListGarFitAuditDataByParamsResponsData
                            .data?[index]
                            .delete ??
                        false) {
                      return _listDelItem(context, index);
                    } else if (widget
                            .viewsData
                            .GetListGarFitAuditDataByParamsResponsData
                            .data?[index]
                            .edit ??
                        false) {
                      return _listEditItem(context, index);
                    } else {
                      return _listItem(context, index);
                    }
                  },
                )),
          // Container()
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
            'Do you really want to delete?, please confirm.',
            style: TextStyle(color: Colors.white),
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.viewsData.deleteItem(
                      widget.viewsData.GetListGarFitAuditDataByParamsResponsData
                              .data?[index].id ??
                          0,
                      (widget
                              .viewsData
                              .GetListGarFitAuditDataByParamsResponsData
                              .data?[index]
                              .operatorCode ??
                          ''),
                      context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.selectDeleteItem(index);
                  },
                  child: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              (widget.viewsData.GetListGarFitAuditDataByParamsResponsData
                      .data?[index].sessionName ??
                  ''),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.viewsData.GetListGarFitAuditDataByParamsResponsData
                      .data?[index].operatorName ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.viewsData.GetListGarFitAuditDataByParamsResponsData
                      .data?[index].operationName ??
                  "",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (widget.viewsData.GetListGarFitAuditDataByParamsResponsData
                          .data?[index].passedPcs ??
                      "")
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (widget.viewsData.GetListGarFitAuditDataByParamsResponsData
                          .data?[index].defectPcs ??
                      "")
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              ((widget.viewsData.GetListGarFitAuditDataByParamsResponsData
                              .data?[index].createdDate ??
                          "")
                      .characters
                      .take(10))
                  .toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: GestureDetector(
              onTap: () {
                imageListPopup(context, index);
              },
              child: const Text(
                "view",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
