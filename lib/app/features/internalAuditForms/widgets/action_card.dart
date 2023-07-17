import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/GetAuditStyleDataModel.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';

class ActionCard extends StatefulWidget {
  final InternalAuditViewModal views;
  final AuditStyleList styleAuditData;
  final bool actionView;
  final bool menuSelectStatus;
  const ActionCard({
    Key? key,
    required this.views,
    required this.styleAuditData,
    required this.actionView,
    required this.menuSelectStatus,
  }) : super(key: key);

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  exceptionDialog(String? message) {
    return Get.defaultDialog(
        title: "Error",
        middleText: message ?? 'Some error occurred!',
        textCancel: "OK",
        confirmTextColor: const Color(0xffffffff),
        cancelTextColor: const Color(0xffF7931C),
        onCancel: () {},
        buttonColor: const Color(0xffF7931C));
  }

  @override
  Widget build(BuildContext context) {
    var saveAuditData = widget.views.saveAuditData.auditQcDetlModels ?? [];
    // int optCount = widget.views.optData.data?.totalcount ?? 1;
    int optCount = 1;
    // int nextoperatorCal = widget.styleAuditData.totOperators ?? 1;
    int nextoperatorCal = 1;
    final nextoptData = optCount - nextoperatorCal;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        children: [
          Opacity(
              opacity: widget.actionView ? 1.0 : 0.5,
              child: Opacity(
                opacity: widget.menuSelectStatus ? 1.0 : 0.5,
                child: AbsorbPointer(
                    absorbing: !widget.actionView,
                    child: AbsorbPointer(
                      absorbing: !widget.menuSelectStatus,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AbsorbPointer(
                                  absorbing: widget.views.auditState == 1
                                      ? !widget.views.singleMesDefect.isNotEmpty
                                      : !widget.views.selectDefect.isNotEmpty,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      widget.views
                                          .failSaveFunction(context, "");
                                    },
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 10, 30, 10),
                                      decoration: BoxDecoration(
                                          color: widget.views.auditState == 1
                                              ? widget.views.singleMesDefect
                                                      .isNotEmpty
                                                  ? Colors.black
                                                  : const Color(0xffffffff)
                                              : widget.views.selectDefect
                                                      .isNotEmpty
                                                  ? Colors.black
                                                  : const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Center(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                              color:
                                                  widget.views.auditState == 1
                                                      ? widget
                                                              .views
                                                              .singleMesDefect
                                                              .isNotEmpty
                                                          ? Colors.white
                                                          : Colors.black
                                                      : widget
                                                              .views
                                                              .selectDefect
                                                              .isNotEmpty
                                                          ? Colors.white
                                                          : Colors.black,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.views.failCancelFunction();
                                },
                                child: Container(
                                  height: 50,
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFf6f8fa),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(child: Icon(Icons.close)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: DropdownButton<String>(
                              value: widget.views.saveAuditData.auditCount,
                              isExpanded: true,
                              hint: const Text("Pass Type"),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              elevation: 16,
                              underline: Container(),
                              onChanged: (String? newValue) {
                                widget.views
                                    .passTypeChange(newValue.toString());
                              },
                              items: ["I", "II"].map((item) {
                                return DropdownMenuItem(
                                  value: item.toString(),
                                  child: Text(item.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Opacity(
                              opacity: (widget.views.auditState == 0 ||
                                      widget.views.auditState == 1)
                                  ? (widget.views.garSize == "" ||
                                          widget.views.saveAuditData.partCode ==
                                              "")
                                      ? 0.45
                                      : 1.0
                                  : widget.views.auditState == 2
                                      ? widget.views.packIdController.text
                                              .isEmpty
                                          ? 0.45
                                          : 1.0
                                      : widget.views.saveAuditData.partCode !=
                                              ""
                                          ? 1.0
                                          : 0.45,
                              child: AbsorbPointer(
                                absorbing: (widget.views.auditState == 0 ||
                                        widget.views.auditState == 1)
                                    ? (widget.views.garSize == "" ||
                                            widget.views.saveAuditData
                                                    .partCode ==
                                                "")
                                        ? true
                                        : false
                                    : widget.views.auditState == 2
                                        ? widget.views.packIdController.text
                                                .isEmpty
                                            ? true
                                            : false
                                        : widget.views.saveAuditData.partCode !=
                                                ""
                                            ? false
                                            : true,
                                child: Opacity(
                                  opacity:
                                      widget.views.saveAuditData.auditCount !=
                                              null
                                          ? 1.0
                                          : 1.0,
                                  child: AbsorbPointer(
                                    absorbing:
                                        widget.views.saveAuditData.auditCount !=
                                                null
                                            ? false
                                            : true,
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        widget.views.failFunction(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffff4343),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'Fail',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    )),
              )),
          Opacity(
            opacity: (int.parse(widget.views
                        .auditStateData[widget.views.auditState]['total']) ==
                    int.parse(widget
                        .views.auditStateData[widget.views.auditState]['size']
                        .toString()))
                ? 0.45
                : 1.0,
            child: Opacity(
              opacity: widget.views.auditState == 2 &&
                      widget.views.packIdController.text.isEmpty
                  ? 0.5
                  : widget.views.auditState != 2
                      ? 1.0
                      : 1.0,
              child: AbsorbPointer(
                absorbing: widget.views.auditState == 2 &&
                        widget.views.packIdController.text.isEmpty
                    ? true
                    : widget.views.auditState != 2
                        ? false
                        : false,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.views.passFunction(context);
                    // views.getAllDefect(context);

                    // widget.views.passFunction(context);
                    // if (!widget.views.auidtFail) {
                    //   if (widget.views.auditState == 2 &&
                    //       widget.views.packIdController.text.isNotEmpty) {
                    //     widget.views.passFunction(context);
                    //   } else if (widget.views.auditState != 2 &&
                    //       widget.views.saveAuditData.partCode != '') {
                    //     widget.views.passFunction(context);
                    //   }
                    // }
                  },
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1fb146),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Pass',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
