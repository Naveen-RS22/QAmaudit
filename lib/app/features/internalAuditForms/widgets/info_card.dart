import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/GetAuditStyleDataModel.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/features/dashboard/dashboard_view_model.dart';

class InfoCard extends StatefulWidget {
  final InternalAuditViewModal views;
  final DashboardViewModel dashBoardViews;
  final AuditStyleList styleAuditdata;
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
  void defectListPopou(BuildContext context) {
    exceptionDialog() {
      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              height: 500,
              width: 600,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Defect List',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (widget.views.visDefectFinal.isNotEmpty)
                      const Text(
                        'Visual Defect',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (var item in widget.views.visDefectFinal)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              // const Text('Tag ID :'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item['name'].toString().length > 40
                                  ? "${item['name'].toString().characters.take(40)}..."
                                  : item['name'].toString()),
                              const SizedBox(
                                width: 20,
                              ),
                              const Spacer(),
                              Text(item['count'].toString())
                            ],
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (widget.views.mesDefectFinal.isNotEmpty)
                      const Text(
                        'Measurement Defect',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (var item in widget.views.mesDefectFinal)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              // const Text('Tag ID :'),
                              const SizedBox(
                                width: 10,
                              ),
                              if (item['name'].toString().contains('/'))
                                Text("${item['name']} INCH"),
                              if (!item['name'].toString().contains('/'))
                                Text("${item['name']} CM"),
                              const SizedBox(
                                width: 20,
                              ),
                              const Spacer(),
                              Text(item['count'].toString())
                            ],
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (widget.views.packDefectFinal.isNotEmpty)
                      const Text(
                        'Pack Defect',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (var item in widget.views.packDefectFinal)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              // const Text('Tag ID :'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item['name'].toString().length > 40
                                  ? "${item['name'].toString().characters.take(40)}..."
                                  : item['name'].toString()),
                              const Spacer(),
                              const SizedBox(
                                width: 20,
                              ),

                              Text(item['count'].toString())
                            ],
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (widget.views.visDefectFinal.isNotEmpty)
                      Center(
                          child: GestureDetector(
                        onTap: () {
                          // widget.views.clearDefectsList();
                        },
                        child: const Text(
                          "",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.orange),
                        ),
                      ))
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

  void defectPop(BuildContext context) {
    exceptionDialog() {
      var tagName = widget.views.saveAuditData.auditQcDetlModels ?? [];
      Widget defectListGenerate() {
        var defectList = widget.views.selectDefect;
        var sessionName = widget.styleAuditdata.buycode ?? "";

        return Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            children: defectList.map((item) {
              return Container(
                // width: 300,
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.toString()),
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
                    const Text('Defect List'),
                    defectListGenerate(),
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

  void colorPop(BuildContext context) {
    exceptionDialog() {
      Widget flagListGenerate() {
        var fgData = widget.views.styleAuditData.color ?? [];

        return Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            children: fgData.map((item) {
              // var selected = widget.views.selectDefect.indexWhere((element) =>
              //     element.toString() == item.auditorName.toString());

              return Container(
                // width: 300,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(item.buyerPoNo.toString().length > 30
                        ? item.buyerPoNo
                            .toString()
                            .characters
                            .take(30)
                            .toString()
                        : item.buyerPoNo.toString()),
                    const Spacer(),
                    Text(item.color.toString().length > 30
                        ? item.color.toString().characters.take(30).toString()
                        : item.color.toString()),
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
              width: 600,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Color',
                      style: TextStyle(fontWeight: FontWeight.w600),
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

  void styleAuditInfoPop(BuildContext context) {
    exceptionDialog() {
      var tagName = widget.views.saveAuditData.auditQcDetlModels ?? [];
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
                      const Text('Buyer Code:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.buycode.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Style No:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.styleno.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Order No:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.orderno.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Buyer Po:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.buyerpono.toString().length >
                              40
                          ? "${widget.styleAuditdata.buyerpono.toString().characters.take(40)}..."
                          : widget.styleAuditdata.buyerpono.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Po Order:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.poOrderQty.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Order Qty:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.orderQty.toString()),
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

  void poNumberPop(BuildContext context) {
    exceptionDialog() {
      List poNumbers =
          widget.views.styleAuditData.buyerpono.toString().split(",");
      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    'PO Number',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      for (int i = 0; i < poNumbers.length; i++)
                        Column(
                          children: [Text(poNumbers[i])],
                        )
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

  @override
  Widget build(BuildContext context) {
    var scheduleData = widget.dashBoardViews.scheduleList.data ?? [];
    // var defectpr = widget.views.optData.data?.defectper ?? [];
    var defectpr = [];
    var defectCount = defectpr.isNotEmpty ? defectpr[0].tagidcnt ?? 0 : 0;

    // var checkpc = widget.views.optData.data?.checkedpsc ?? 0;
    var checkpc = 0;

    var defectper = checkpc / defectCount;
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                            onTap: () {
                              poNumberPop(context);
                            },
                            child: const Icon(Icons.info_outline))),
                    const SizedBox(width: 10),
                    const Text('PO. Numbers'),
                  ]),
                  const SizedBox(
                    width: 30,
                  ),
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        colorPop(context);
                      },
                      child: Container(child: const Icon(Icons.info_outline)),
                    ),
                    const SizedBox(width: 10),
                    const Text('Color'),
                  ]),
                  const SizedBox(
                    width: 30,
                  ),
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        widget.views.setIsReportScreen();
                      },
                      child: Container(child: const Icon(Icons.info_outline)),
                    ),
                    const SizedBox(width: 10),
                    const Text('Defect Summary'),
                  ]),
                  const SizedBox(
                    width: 30,
                  ),
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        widget.views.setIsStatusReportScreen();
                      },
                      child: Container(child: const Icon(Icons.info_outline)),
                    ),
                    const SizedBox(width: 10),
                    const Text('Status Report'),
                  ]),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (widget.views.visCom &&
                                (widget.views.saveAuditData.visualResult ??
                                        '') ==
                                    'P')
                            ? Colors.green
                            : (widget.views.visCom &&
                                    (widget.views.saveAuditData.visualResult ??
                                            '') ==
                                        'F')
                                ? Colors.red
                                : (!widget.views.visCom &&
                                        (widget.views.saveAuditData
                                                    .vInspectedPcs ??
                                                0) >
                                            0)
                                    ? Colors.amber
                                    : Colors.grey.shade200
                        // color:  ((widget.views.saveAuditData.vInspectedPcs ?? 0) == 0 && (widget.views.saveAuditData.visualResult ?? '') == 'P')   ? Colors.grey.shade300 :
                        ),
                    child: const Text('V'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (widget.views.mesCom &&
                                (widget.views.saveAuditData.measurementResult ??
                                        '') ==
                                    'P')
                            ? Colors.green
                            : (widget.views.mesCom &&
                                    (widget.views.saveAuditData
                                                .measurementResult ??
                                            '') ==
                                        'F')
                                ? Colors.red
                                : (!widget.views.mesCom &&
                                        (widget.views.saveAuditData
                                                    .mInspectedPcs ??
                                                0) >
                                            0)
                                    ? Colors.amber
                                    : Colors.grey.shade200
                        // color:  ((widget.views.saveAuditData.vInspectedPcs ?? 0) == 0 && (widget.views.saveAuditData.visualResult ?? '') == 'P')   ? Colors.grey.shade300 :
                        ),
                    child: const Text('M'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (widget.views.saveAuditData.insType == 'F' ||
                      widget.views.saveAuditData.insType == 'PF')
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (widget.views.packCom &&
                                  (widget.views.saveAuditData.caaResult ??
                                          '') ==
                                      'P')
                              ? Colors.green
                              : (widget.views.packCom &&
                                      (widget.views.saveAuditData.caaResult ??
                                              '') ==
                                          'F')
                                  ? Colors.red
                                  : (!widget.views.packCom &&
                                          (widget.views.saveAuditData
                                                      .pInspectedPcs ??
                                                  0) >
                                              0)
                                      ? Colors.amber
                                      : Colors.grey.shade200
                          // color:  ((widget.views.saveAuditData.vInspectedPcs ?? 0) == 0 && (widget.views.saveAuditData.visualResult ?? '') == 'P')   ? Colors.grey.shade300 :
                          ),
                      child: const Text('P'),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        defectListPopou(context);
                        // defectPop(context);
                      },
                      child: Container(child: const Icon(Icons.info_outline)),
                    ),
                    const SizedBox(width: 10),
                    const Text('Defect Details'),
                  ]),
                  const SizedBox(
                    width: 30,
                  ),
                  Row(
                    children: [
                      const Text('Audit Status : '),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.views.saveAuditData.finalResult == "P"
                            ? "PASS"
                            : widget.views.saveAuditData.finalResult == "F"
                                ? "FAIL"
                                : "In Progress",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
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
                      Text(widget.views
                          .auditStateData[widget.views.auditState]['auditType']
                          .toString()),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.views.auditStateRem();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: widget.views.auditState != 0
                                    ? Colors.black
                                    : const Color(0xfff6f8fa),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 12,
                                color: widget.views.auditState != 0
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.views.auditStateAdd();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: widget.views.auditState !=
                                        (widget.views.packEnable ? 1 : 2)
                                    ? Colors.black
                                    : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: widget.views.auditState !=
                                        (widget.views.packEnable ? 1 : 2)
                                    ? Colors.white
                                    : Colors.black,
                                size: 12,
                              ),
                            ),
                          )
                        ],
                      )
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
                      const Text('Order Quantity'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.styleAuditdata.orderQty.toString()),
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
                      if (widget.views.auditState != 2)
                        GestureDetector(
                            onTap: () {}, child: const Text('Sample Size')),
                      if (widget.views.auditState == 2)
                        GestureDetector(
                            onTap: () {}, child: const Text('Carton Sample')),
                      const SizedBox(
                        width: 10,
                      ),
                      // if (widget.views.auditState == 0)
                      //   GestureDetector(
                      //     onTap: () {
                      //       print(widget
                      //           .views.auditStateData[widget.views.auditState]);
                      //       widget.views.showErrorAlert(widget
                      //           .views.auditStateData[widget.views.auditState]
                      //           .toString());
                      //     },
                      //     child: Text(widget.views
                      //         .auditStateData[widget.views.auditState]['size']
                      //         .toString()),
                      //   ),
                      // if (widget.views.auditState != 0)
                      SizedBox(
                        width: 20,
                        // height: 30,
                        child: TextFormField(
                          // initialValue: widget.views
                          //     .auditStateData[widget.views.auditState]['size']
                          //     .toString(),
                          cursorColor: Colors.black,
                          enabled: widget.views.auditStarted
                              ? false
                              : widget.views.auditState != 0
                                  ? true
                                  : false,
                          keyboardType: TextInputType.number,
                          controller: widget.views.sampleSize,
                          maxLength: 8,
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.black),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          // focusNode: widget.views.samplesizeFocus,
                          onChanged: (String value) {
                            widget.views.sampleSizeChange(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Packed Qty',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        width: 60,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          enabled: widget.views.auditState != 2
                              ? !widget.views.baseRound
                              : !widget.views.cartonRound,
                          keyboardType: TextInputType.number,
                          controller: widget.views.packQty,
                          // initialValue: widget.views.auditState == 2
                          //     ? widget.views.packQtynoofcartonsString
                          //     : widget.views.packQtyString,
                          onChanged: (e) {
                            widget.views.packQtyChange(e);
                          },
                          maxLength: 8,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          decoration: const InputDecoration(
                            counterText: '',
                            hintText: "Enter Qty",
                            border: InputBorder.none,
                          ),
                        )),
                    if (widget.views.auditState == 2)
                      Row(
                        children: [
                          const Text(
                            'No of Cartons',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 60,
                            child: TextField(
                              cursorColor: Colors.black,
                              // enabled: !widget.views.enableRound,
                              enabled: widget.views.auditState != 2
                                  ? !widget.views.baseRound
                                  : !widget.views.cartonRound,
                              keyboardType: TextInputType.number,
                              controller: widget.views.noofcartons,
                              maxLength: 8,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]")),
                              ],
                              decoration: const InputDecoration(
                                counterText: '',
                                hintText: "Enter Qty",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    GestureDetector(
                      onTap: () {
                        // widget.views.getAqlBaseInfo(context);
                        widget.views.getAqlBaseInfoBase(context);
                        // widget.views.getVisualAllDefect(context);
                        // widget.views.defectCalculation();
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff1fb146),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'Start',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 20,
              ),
              // Expanded(
              //   child:
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('AQL'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.views.styleAuditData.aqltype.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order NO'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.styleAuditdata.orderno.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // ),
              const SizedBox(
                width: 20,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
