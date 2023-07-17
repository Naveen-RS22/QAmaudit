import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/FlagInfoModel.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/audit/audit_view_model.dart';
import 'package:qapp/app/features/dashboard/dashboard_view_model.dart';

class InfoCard extends StatefulWidget {
  final AuditViewModal views;
  final DashboardViewModel dashBoardViews;
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
      List myList = widget.views.defectsCntData.data ?? [];

      // List myList3 = widget.views.defectPart.data ?? [];
      // // myList.sort((a, b) => b.cnt.compareTo(a.cnt));
      // List search(String input) {
      //   return (myList3)
      //       .where((e) =>
      //           e.s!.toLowerCase().contains(input.toLowerCase()))
      //       .toList();
      // }

      // var newList = search(widget.views.scoreCardData.sessionName ?? '');
      // List myList = newList;
      myList.sort((a, b) => b.defectcnt.compareTo(a.defectcnt));
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
                              Text(myList2[i].defectcnt.toString())
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
      var tagName = widget.views.scoreCardData.scoreCardDetlModels ?? [];

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
      var tagName = widget.views.scoreCardData.scoreCardDetlModels ?? [];
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(children: [
                GestureDetector(
                  onTap: () {
                    flagPopup(context);
                  },
                  child: Container(child: const Icon(Icons.info_outline)),
                ),
                const SizedBox(width: 10),
                const Text('Flags'),
              ]),
              const SizedBox(
                width: 30,
              ),
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
                      Text(widget.styleAuditdata.sessionName.toString()),
                      const SizedBox(
                        width: 10,
                      ),
                      FlutterSwitch(
                          value: widget.views.enableRound,
                          width: 40,
                          height: 25,
                          activeColor: Colors.green,
                          onToggle: (value) {
                            widget.views.roundChange(value);
                            // widget.views.operatorFoundChange();
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Operators'),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          maxLength: 4,
                          enabled: widget.views.enableRound &&
                              widget.views.operatorEditable,
                          controller: widget.views.operatorsCntController,
                          onChanged: (value) {
                            widget.views.operatorsCntOnChange(
                                value, context, widget.styleAuditdata);
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
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                      cursorColor: Colors.black,
                      enabled: !widget.views.sessionCompleted,
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
              Opacity(
                opacity: widget.views.enableRound ? 1.00 : 0.45,
                child: AbsorbPointer(
                  absorbing: widget.views.enableRound ? false : true,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.views.operatorsCntController.text.isNotEmpty &&
                          (int.parse(widget.views.operatorsCntController.text) >
                              0) &&
                          widget.views.operatorSearch.text.isNotEmpty) {
                        widget.views.getEmpCode(context, widget.styleAuditdata);
                      } else {
                        widget.views
                            .showErrorAlert("Enter valid operator counts/code");
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
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
