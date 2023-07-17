import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';

class ActionCard extends StatefulWidget {
  final InlineViewModal views;
  final StyleAuditData styleAuditData;
  const ActionCard(
      {Key? key, required this.views, required this.styleAuditData})
      : super(key: key);

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  void approvalPopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                  height: 300,
                  width: 600,
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  // margin: const EdgeInsets.all(10),

                  child: MyWidget(views: widget.views)),
            );
          },
        );
      },
    );
  }

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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        children: [
          Opacity(
              opacity: 1.0,
              child: AbsorbPointer(
                  absorbing: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // widget.views
                            //     .saveFunction(context, widget.styleAuditData);
                            if (widget.views.selectFavorite.isNotEmpty) {
                              widget.views.saveFunction(context);
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            decoration: BoxDecoration(
                                color: widget.views.auditStep > 1
                                    ? widget.views.selectFavorite.isNotEmpty
                                        ? Colors.black
                                        : const Color(0xffffffff)
                                    : const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: widget.views.auditStep > 1
                                        ? widget.views.selectFavorite.isNotEmpty
                                            ? Colors.white
                                            : Colors.black
                                        : Colors.black,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.views.currentAuditCancel();
                          // if (widget.views.auditStep > 1) {
                          //   widget.views.resetAuditStep();
                          // }
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFf6f8fa),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(child: Icon(Icons.close)),
                        ),
                      ),
                    ],
                  ))),
          const SizedBox(
            height: 15,
          ),
          Opacity(
              opacity: 1.0,
              child: AbsorbPointer(
                absorbing: widget.views.tagName.text.isNotEmpty &&
                        widget.views.scoreCardData.operationCode != "NA"
                    ? false
                    : true,
                child: AbsorbPointer(
                    absorbing: widget.views.currentAudit == "reject" ||
                            widget.views.currentAudit == ""
                        ? false
                        : true,
                    child: GestureDetector(
                      onTap: () {
                        widget.views.rejectFunction();
                        widget.views.getFreqUsedDefectsByParams(
                            context,
                            widget.views.scoreCardData.unitCode.toString(),
                            widget.views.scoreCardData.auditType.toString(),
                            widget.views.scoreCardData.checkerName.toString());
                      },
                      child: Opacity(
                        opacity: widget.views.currentAudit == "reject" ||
                                widget.views.currentAudit == ""
                            ? 1.0
                            : 0.5,
                        child: Opacity(
                          opacity: widget.views.tagName.text.isNotEmpty &&
                                  widget.views.scoreCardData.operationCode !=
                                      "NA"
                              ? 1.0
                              : 0.5,
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            decoration: BoxDecoration(
                              color: const Color(0xffff4343),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Reject',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(width: 10),
                              ],
                            )),
                          ),
                        ),
                      ),
                    )),
              )),
          const SizedBox(
            height: 15,
          ),
          Opacity(
              opacity: 1.0,
              child: AbsorbPointer(
                absorbing: widget.views.tagName.text.isNotEmpty &&
                        widget.views.scoreCardData.operationCode != "NA"
                    ? false
                    : true,
                child: AbsorbPointer(
                    absorbing: widget.views.currentAudit == "alter" ||
                            widget.views.currentAudit == "reAlter" ||
                            widget.views.currentAudit == ""
                        ? false
                        : true,
                    child: GestureDetector(
                        onTap: () {
                          widget.views.alterFunction();
                          widget.views.getFreqUsedDefectsByParams(
                              context,
                              widget.views.scoreCardData.unitCode.toString(),
                              widget.views.scoreCardData.auditType.toString(),
                              widget.views.scoreCardData.checkerName
                                  .toString());
                        },
                        child: Opacity(
                          opacity: widget.views.currentAudit == "alter" ||
                                  widget.views.currentAudit == "reAlter" ||
                                  widget.views.currentAudit == ""
                              ? 1.0
                              : 0.5,
                          child: Opacity(
                            opacity: widget.views.tagName.text.isNotEmpty &&
                                    widget.views.scoreCardData.operationCode !=
                                        "NA"
                                ? 1.0
                                : 0.5,
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              decoration: BoxDecoration(
                                color: const Color(0xffffc502),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Alter',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              )),
                            ),
                          ),
                        ))),
              )),
          const SizedBox(
            height: 15,
          ),
          AbsorbPointer(
              absorbing: widget.views.currentAudit == "pass" ||
                      widget.views.currentAudit == ""
                  ? false
                  : true,
              child: GestureDetector(
                onTap: () {
                  widget.views.passFunction(context, widget.styleAuditData);
                },
                child: Opacity(
                  opacity: widget.views.currentAudit == "pass" ||
                          widget.views.currentAudit == ""
                      ? 1.0
                      : 0.5,
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1fb146),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Pass',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(width: 10),
                      ],
                    )),
                  ),
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              DateTime now = DateTime.now();
              widget.views.setcurrentApprovalUserDefault();
              widget.views.getAppDetlList(context);
              widget.views
                  .GetSessionCodeDataAPI(context, '${now.hour}:${now.minute}');
              widget.views.getAllSessionMasterbyunitcode(context);

              approvalPopup(context);
            },
            child: Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Approval',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(width: 10),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final InlineViewModal views;
  const MyWidget({Key? key, required this.views}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int i = 0;
  String currentApprovalUser = 'SUP';
  String? currentApprovalUserName;
  // OtpFieldController pinController = OtpFieldController();
  TextEditingController pinController = TextEditingController();

  String currentPasscode = '';

  void setcurrentApprovalUser(String user) {
    currentApprovalUser = user;
    setState(() {});
  }

  void setcurrentApprovalUserName(String user) {
    currentApprovalUserName = user;
    setState(() {});
  }

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

  void pinCompleted(String pin) {
    if (pin == currentPasscode) {
      widget.views.setIsApprovalScreen(true);
      Navigator.pop(context);
    } else {
      print('Invalid Passcode');
      pinController.clear();
      widget.views.showErrorAlert('Invalid Passcode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.views.setcurrentApprovalUser('SUP');
                setcurrentApprovalUser('SUP');
                currentApprovalUserName = null;
                widget.views.getAppDetlList(context);
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: currentApprovalUser == 'SUP'
                        ? Colors.white
                        : Colors.grey.shade300,
                  ),
                  color:
                      currentApprovalUser == 'SUP' ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Supervisor',
                    style: TextStyle(
                        color: currentApprovalUser == 'SUP'
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.views.setcurrentApprovalUser('QA');
                setcurrentApprovalUser('QA');
                currentApprovalUserName = null;
                widget.views.getAppDetlList(context);
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: currentApprovalUser == 'QA'
                        ? Colors.white
                        : Colors.grey.shade300,
                  ),
                  color:
                      currentApprovalUser == 'QA' ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Line QC',
                    style: TextStyle(
                        color: currentApprovalUser == 'QA'
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.views.setcurrentApprovalUser('QCM');
                setcurrentApprovalUser('QCM');
                currentApprovalUserName = null;
                widget.views.getAppDetlList(context);
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: currentApprovalUser == 'QCM'
                        ? Colors.white
                        : Colors.grey.shade300,
                  ),
                  color:
                      currentApprovalUser == 'QCM' ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'QCM',
                    style: TextStyle(
                        color: currentApprovalUser == 'QCM'
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 320,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300)),
          child: DropdownButton<String>(
            value: currentApprovalUserName,
            isExpanded: true,
            hint: const Text("Select User"),
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 16,
            underline: Container(),
            onChanged: (String? newValue) {
              setcurrentApprovalUserName(newValue.toString());
              widget.views.setcurrentApprovalUserName(newValue.toString());
            },
            items: (widget.views.getAppDetlListData.data ?? []).map((item) {
              return DropdownMenuItem(
                onTap: () {
                  currentPasscode = item.passcode ?? '';
                },
                value: item.approver.toString(),
                child: Text(item.approver.toString()),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
            padding: const EdgeInsets.all(10),
            height: 80,
            width: 320,
            child: TextFormField(
                controller: pinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Pin',
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.grey.shade200, //<-- SEE HERE
                ),
                cursorColor: Colors.black,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: (String val) {
                  if (val.length == 4) {
                    print(val);
                    pinCompleted(val);
                  }
                })),
        // Container(
        //   padding: const EdgeInsets.all(10),
        //   height: 40,
        //   width: 320,
        //   child: TextFormField(
        //     // controller: widget.views.currentCommentController,
        //     inputFormatters: [
        //       LengthLimitingTextInputFormatter(4),
        //     ],
        //     onChanged: (String val) {
        //       // widget.views.currentCommentControllerOnChange(val, context);
        //     },
        //     style: const TextStyle(fontSize: 20, color: Colors.black),
        //     cursorColor: Colors.black,
        //     keyboardType: TextInputType.number,
        //     maxLines: null,

        //     decoration: InputDecoration(
        //       border: InputBorder.none,
        //       hintText: 'Pin',
        //       filled: true, //<-- SEE HERE
        //       fillColor: Colors.grey.shade200, //<-- SEE HERE
        //     ),
        //   ),
        // ),
        // OTPTextField(
        //   length: 4,
        //   width: 320,
        //   fieldWidth: 60,
        //   obscureText: true,
        //   otpFieldStyle: OtpFieldStyle(
        //     backgroundColor: Colors.grey.shade100,
        //   ),
        //   style: const TextStyle(
        //     fontSize: 16,
        //   ),
        //   textFieldAlignment: MainAxisAlignment.spaceBetween,
        //   fieldStyle: FieldStyle.box,
        //   outlineBorderRadius: 4,
        //   controller: pinController,
        //   onCompleted: (pin) {
        //     pinCompleted(pin);
        //     // widget.views.setIsApprovalScreen(true);
        //     // Navigator.pop(context);

        //     // print("Completed: " + pin);
        //   },
        // ),
      ],
    );
  }
}
