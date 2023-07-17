import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';

class MenuCardMeasurement extends StatefulWidget {
  final InternalAuditViewModal views;
  const MenuCardMeasurement({
    Key? key,
    required this.views,
  }) : super(key: key);

  @override
  State<MenuCardMeasurement> createState() => _MenuCardMeasurementState();
}

class _MenuCardMeasurementState extends State<MenuCardMeasurement> {
  @override
  Widget build(BuildContext context) {
    Widget operationWidget() {
      var opData =
          widget.views.getLineQCFrequentUsedOperationsandPartsModel.data ?? [];

      return Container(
          child: !widget.views.isFavLoading
              ? Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: opData.map((item) {
                    // var selected = widget.views.selectFavorite.indexWhere((element) =>
                    //     element.toString() == item.operationCode.toString());
                    // ignore: unrelated_type_equality_checks
                    bool select =
                        widget.views.saveAuditData.operationCode.toString() ==
                                item.operationCode.toString()
                            ? false
                            : true;

                    if ((item.operationCode ?? '').isNotEmpty) {
                      return GestureDetector(
                        onTap: () {
                          // widget.views.scoreCardData.operationCode
                          // widget.views.selectFavoriteFunction(item.defectCode.toString());
                          widget.views.sleeveValueOnchange(
                              context, item.partCode.toString(), 0);

                          widget.views.sleeveAttachmentValueOnchange(
                              item.operationCode.toString(),
                              item.operationName.toString());
                          widget.views
                              .getOperCodeByPartId(context, item.partId);

                          // widget.views.getOperCodeByPartId(context, item.partId);
                          // widget.views.auditStepUpdate(3);
                        },
                        child: Container(
                          width: 265,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color:
                                  select ? Colors.white : Colors.grey.shade100,
                              border: Border.all(
                                  color: select
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade600)

                              // border: Border.all(color: Colors.grey.shade300)
                              ),
                          child: Row(
                            children: [
                              Text((item.operationName ?? '').length > 35
                                  ? '${item.operationName.toString().substring(0, 35)}...'
                                  : item.operationName ?? ''),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }).toList())
              : Column(
                  children: [
                    const SizedBox(
                      height: 125,
                    ),
                    Container(
                      child: const CircularProgressIndicator(
                        color: Color(0xfff6802a),
                      ),
                    ),
                  ],
                ));
    }

    Widget favWidget(String mesType) {
      var favData = widget.views.getMesMentDefectsByUomDetailINCH.data ?? [];
      void favPopup(BuildContext context, String defectCode, bool isFav) {
        exceptionDialog() {
          return Get.defaultDialog(
              content: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  // margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        isFav
                            ? 'Remove from frequent defects list?'
                            : 'Add to frequent defects list?',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.views.showorHideIsFavAPI(
                                  context, defectCode, isFav ? 'N' : 'Y');
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffF7931C),
                                      Color(0xffF57234),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              title: "",
              confirmTextColor: const Color(0xffffffff),
              cancelTextColor: const Color(0xffF7931C),
              buttonColor: const Color(0xffF7931C));
        }

        exceptionDialog();
      }

      return Container(
          child: !widget.views.isFavLoading
              ? Wrap(
                  runSpacing: 15.0,
                  spacing: 15.0,
                  children: favData.map((item) {
                    var deviation = mesType == "P"
                        ? item.deviation.toString()
                        : "-${item.deviation}";
                    var selected = widget.views.singleMesDefect.indexWhere(
                        (element) => element.toString() == deviation);

                    return GestureDetector(
                      onTap: () {
                        widget.views.selectMeasureDefectFunction(mesType == "P"
                            ? item.deviation.toString()
                            : "-${item.deviation}");
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: selected == -1
                                ? Colors.white
                                : Colors.grey.shade100,
                            border: Border.all(
                                color: selected == -1
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade600)),
                        child: Row(
                          children: [
                            // const Icon(
                            //   Icons.star,
                            //   color: Color(0xffF7931C),
                            // ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Text(mesType == "P"
                                ? "+ ${item.deviation} INCH"
                                : "- ${item.deviation} INCH"),
                          ],
                        ),
                      ),
                    );
                  }).toList())
              : Column(
                  children: [
                    const SizedBox(
                      height: 125,
                    ),
                    Container(
                      child: const CircularProgressIndicator(
                        color: Color(0xfff6802a),
                      ),
                    ),
                  ],
                ));
    }

    Widget allDefWidget() {
      var allDefData = widget.views.getMesMentDefectsByUomDetail.data ?? [];
      void favPopup(BuildContext context, String defectCode, bool isFav) {
        exceptionDialog() {
          return Get.defaultDialog(
              content: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  // margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        isFav
                            ? 'Remove from frequent defects list?'
                            : 'Add to frequent defects list?',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.views.showorHideIsFavAPI(
                                  context, defectCode, isFav ? 'N' : 'Y');
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffF7931C),
                                      Color(0xffF57234),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              title: "",
              confirmTextColor: const Color(0xffffffff),
              cancelTextColor: const Color(0xffF7931C),
              buttonColor: const Color(0xffF7931C));
        }

        exceptionDialog();
      }

      return Container(
          child: !widget.views.isFavLoading
              ? Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: allDefData.map((item) {
                    var selected = widget.views.singleMesDefect.indexWhere(
                        (element) =>
                            element.toString().replaceAll("-", "") ==
                            item.deviation.toString());
                    var title = item.deviation.toString().characters.take(20);
                    bool isFav = item.isFav == "Y" ? true : false;

                    return GestureDetector(
                      onTap: () {
                        widget.views.selectMeasureDefectFunction(
                            widget.views.mesType == "P"
                                ? item.deviation.toString()
                                : "-${item.deviation}");
                        // views.selectAllDefectFunction(item.id.toString());
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: selected == -1
                                ? Colors.white
                                : Colors.grey.shade100,
                            border: Border.all(
                                color: selected == -1
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade600)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: isFav
                                  ? const Color(0xffF7931C)
                                  : Colors.grey.shade400,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.views.mesType == "P"
                                ? "+ $title${item.uom}"
                                : "- $title${item.uom}"),
                          ],
                        ),
                      ),
                    );
                  }).toList())
              : Column(
                  children: [
                    const SizedBox(
                      height: 125,
                    ),
                    Container(
                      child: const CircularProgressIndicator(
                        color: Color(0xfff6802a),
                      ),
                    ),
                  ],
                ));
    }

    return Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(10),
        color: const Color(0xfff6f8fa),
        height: 320,
        child: widget.views.defectState == 2
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: operationWidget(),
              )
            : widget.views.defectState == 3
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  widget.views
                                      .getMesMentDefectsByUom(context, "CM");
                                  widget.views.getAllGarPartDetailData(context,
                                      widget.views.styleAuditData.productType);
                                },
                                child:
                                    const Text("( + ) Measurement  Deviation")),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        favWidget("P"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("( - ) Measurement  Deviation"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        favWidget("M")
                      ],
                    ),
                  )
                : widget.views.defectState == 4
                    ? Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            widget.views.mesTypeChange("P");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              10.0)),
                                              color: widget.views.mesType == "P"
                                                  ? const Color(0xfff67c2d)
                                                  : const Color(0xffffffff),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            child: Center(
                                              child: Text(
                                                '( + ) Plus',
                                                style: TextStyle(
                                                    color:
                                                        widget.views.mesType ==
                                                                "P"
                                                            ? Colors.white
                                                            : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                      Expanded(
                                          child: Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            widget.views.mesTypeChange("M");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(
                                                              10.0)),
                                              color: widget.views.mesType == "M"
                                                  ? const Color(0xfff67c2d)
                                                  : const Color(0xffffffff),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            child: Center(
                                              child: Text(
                                                '( - ) Minus',
                                                style: TextStyle(
                                                    color:
                                                        widget.views.mesType ==
                                                                "M"
                                                            ? Colors.white
                                                            : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xfff67c2d),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            widget.views.mesSizeTypeChange(
                                                "INCH", context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              10.0)),
                                              color: widget.views.mesSizeType ==
                                                      "INCH"
                                                  ? const Color(0xfff67c2d)
                                                  : const Color(0xffffffff),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            child: Center(
                                              child: Text(
                                                'INCH',
                                                style: TextStyle(
                                                    color: widget.views
                                                                .mesSizeType ==
                                                            "INCH"
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                      Expanded(
                                          child: Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            widget.views.mesSizeTypeChange(
                                                "CM", context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(
                                                              10.0)),
                                              color: widget.views.mesSizeType ==
                                                      "CM"
                                                  ? const Color(0xfff67c2d)
                                                  : const Color(0xffffffff),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            child: Center(
                                              child: Text(
                                                'CM',
                                                style: TextStyle(
                                                    color: widget.views
                                                                .mesSizeType ==
                                                            "CM"
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 250,
                            child: SingleChildScrollView(
                              child: allDefWidget(),
                            ),
                          )
                        ],
                      )
                    : widget.views.defectState == 5
                        ? TextField(
                            cursorColor: Colors.black,
                            controller: widget.views.comment,
                            onChanged: (value) {
                              widget.views.commentChange(value);
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your comments and feedback here',
                            ),
                          )
                        : widget.views.defectState == 6
                            ? widget.views.defectImage != null
                                ? Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Image.file(
                                            widget.views.defectImage!,
                                            height: 300,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 20, left: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                            child: IconButton(
                                                onPressed: () {
                                                  widget.views
                                                      .clearDefectImage();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : InkWell(
                                    onTap: () {
                                      widget.views.getImage(context);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 25),
                                      padding: const EdgeInsets.all(100.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Column(
                                        children: const [
                                          Icon(Icons.camera_alt_outlined),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text('Open Camera')
                                        ],
                                      ),
                                    ))
                            : const Text(''));
  }
}
