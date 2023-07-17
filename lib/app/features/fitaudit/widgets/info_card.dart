import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/FlagInfoModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_view_model.dart';

class InfoCard extends StatefulWidget {
  final FitAuditViewModal views;
  final FitDashboardViewModel dashBoardViews;
  final StyleAuditData styleAuditdata;
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
      List myList = widget.views.defectPart.data ?? [];

      myList.sort((a, b) => b.defectCount.compareTo(a.defectCount));
      if (myList.isNotEmpty) {
        myList = myList.length == 1
            ? myList.sublist(0, 1)
            : myList.length == 2
                ? myList.sublist(0, 2)
                : myList.sublist(0, 3);
      }
      List myList2 = myList;

      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    'Top 3 Defects ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (myList2.isEmpty)
                    const Text(
                      'No Data ',
                    ),
                  if (myList2.isNotEmpty)
                    for (int i = 0; i < myList2.length; i++)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(myList2[i].defectName.toString()),
                              const SizedBox(
                                width: 40,
                              ),
                              const Spacer(),
                              Text(myList2[i].defectCount.toString())
                            ],
                          )
                        ],
                      ),
                  const SizedBox(
                    height: 20,
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

  void flagPopup(BuildContext context) {
    exceptionDialog() {
      var tagName = widget.views.scoreCardData.garFitAuditDetlModels ?? [];

      Widget flagListGenerate() {
        var flagList = widget.views.flagInfoData.data ?? [];
        var sessionName = widget.styleAuditdata.sessionName ?? "";

        List<FlagInfoData> search(String sessionN) {
          return flagList
              .where((e) => e.sessionName!.contains(sessionN))
              .toList();
        }

        var newList = search(sessionName);

        List<FlagInfoData> searchFlag(String color) {
          return newList.where((e) => e.flagColor!.contains(color)).toList();
        }

        var flagsData = searchFlag('R');

        return (flagsData.isEmpty)
            ? const Center(
                child: Text('No Data'),
              )
            : Wrap(
                runSpacing: 5.0,
                spacing: 5.0,
                children: flagsData.map((item) {
                  // var selected = widget.views.selectFavorite.indexWhere(
                  //     (element) =>
                  //         element.toString() == item.auditorName.toString());

                  return Container(
                    // width: 300,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(item.operatorName.toString()),
                        const SizedBox(
                          width: 10,
                        ),
                        const Spacer(),
                        Text(item.defectPcs.toString())
                      ],
                    ),
                  );
                }).toList());
      }

      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.5,
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Flags ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
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
      var tagName = widget.views.scoreCardData.garFitAuditDetlModels ?? [];
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
                      const Text('Unit Code:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.unitCode.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Order No:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.orderNo.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Audit Type:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.auditType.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Auditor Name:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.auditorName.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Buyer Code:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.buyerCode.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Line Number:'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(widget.styleAuditdata.lineName.toString()),
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

  @override
  Widget build(BuildContext context) {
    var defectpr = widget.views.optData.data?.defectper ?? [];
    var defectCount = (defectpr.length == 1) ? defectpr[0].tagidcnt ?? 0 : 0;

    var checkpc = widget.views.optData.data?.checkedpsc ?? 0;

    num defectper = defectCount == 0 ? 0.00 : ((defectCount / checkpc) * 100);
    return Expanded(
      // width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                GestureDetector(
                  onTap: () {
                    defectListPopou(context);
                  },
                  child: Container(child: const Icon(Icons.info_outline)),
                ),
                const SizedBox(width: 10),
                const Text('Top 3 Defects'),
              ]),
              const SizedBox(
                width: 30,
              ),
              // Row(children: [
              //   GestureDetector(
              //     onTap: () {
              //       flagPopup(context);
              //     },
              //     child: Container(child: const Icon(Icons.info_outline)),
              //   ),
              //   const SizedBox(width: 10),
              //   const Text('Flags'),
              // ]),
              // const SizedBox(
              //   width: 30,
              // ),
              Row(
                children: [
                  const Text('Defects Per Hundred : '),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${widget.views.DHU.toStringAsFixed(2)}%",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: const Color(0xFFf6f8fa),
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: DropdownButton<String>(
                      value: widget.views.scoreCardData.auditType,
                      isExpanded: true,
                      hint: Text(widget.views.scoreCardData.auditType ?? ''),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      underline: Container(),
                      onChanged: (String? newValue) {
                        widget.views.typeOnchange(newValue.toString());
                      },
                      items: (widget.views.getUDMasterByTypeResponse.data ?? [])
                          .map((item) {
                        return DropdownMenuItem(
                          value: item.code,
                          child: Text(item.codeDesc ?? ''),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: DropdownButton<String>(
                      value: null,
                      isExpanded: true,
                      hint: Text(
                        widget.views.scoreCardData.sessionName ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      underline: Container(),
                      onChanged: (String? newValue) {
                        widget.views
                            .defectCategoryOnChange(newValue.toString());
                      },
                      items: [].map((item) {
                        return DropdownMenuItem(
                          value: item.toString(),
                          child: Text(item.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: AbsorbPointer(
                  absorbing: widget.views.scoreCardData.auditType != 'FAG' &&
                      widget.views.auditStarted,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Operators'),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          // width: 40,
                          // height: 40,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            maxLength: 4,
                            textAlign: TextAlign.center,
                            enabled:
                                widget.views.scoreCardData.auditType == 'FAG'
                                    ? false
                                    : true,

                            controller: widget.views.operatorsCntController,
                            onChanged: (value) {
                              widget.views.operatorsCntOnChange(value);
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only num
                            maxLines: null,
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              hintText: '0',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: AbsorbPointer(
                  absorbing: widget.views.auditStarted,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: DropdownButton<String>(
                      value: widget.views.auditPcs == 0
                          ? null
                          : (widget.views.auditPcs).toString(),
                      isExpanded: true,
                      hint: const Text('Audit Pcs'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      underline: Container(),
                      onChanged: (String? newValue) {
                        widget.views.auditPcsCntOnChange(newValue.toString());
                      },
                      items: (widget.views.getUDMasterByTypeResponseAuditPcs
                                  .data ??
                              [])
                          .map((item) {
                        return DropdownMenuItem(
                          value: item.code.toString(),
                          child: Text(item.code.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                      cursorColor: Colors.black,
                      enabled: widget.views.scoreCardData.auditType == 'FAG'
                          ? false
                          : true,
                      controller: widget.views.operatorSearch,
                      onChanged: (empCode) {
                        widget.views.onEmpCodeChange(empCode);
                      },
                      // keyboardType: TextInputType.number,
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.digitsOnly
                      // ], //

                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Emp Code',
                      )),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.views.scoreCardData.auditType != 'FAG') {
                    if (widget.views.operatorsCntController.text.isNotEmpty &&
                        (int.parse(widget.views.operatorsCntController.text) >
                            0) &&
                        widget.views.operatorSearch.text.isNotEmpty &&
                        widget.views.auditPcs > 0 &&
                        widget.views.scoreCardData.auditType != null) {
                      widget.views.getEmpCode(context, widget.styleAuditdata);
                    } else {
                      widget.views.showErrorAlert(
                          "Enter valid operator counts/code/audit pcs/ type");
                    }
                  }
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
            ]),
          ),
        ],
      ),
    );
  }
}
