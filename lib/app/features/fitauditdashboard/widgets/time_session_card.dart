import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_view_model.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

class TimeSessionCard extends StatelessWidget {
  final FitDashboardViewModel views;
  final FitAuditViewModal auditviews;
  final InlineViewModal inlineviews;

  const TimeSessionCard(
      {Key? key,
      required this.views,
      required this.auditviews,
      required this.inlineviews})
      : super(key: key);

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

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

                  child: MyWidget(views: inlineviews)),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: context.res.color.cardBg2,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 150.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Time Per Session',
                          style: TextStyle(
                            fontSize: 20,
                            color: context.res.color.black,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      height: 2,
                      color: context.res.color.black,
                    ),
                    const SizedBox(height: 10),
                    (views.timeSpent.data?.timespentdetail?.length ?? 0) == 0
                        ? const Expanded(
                            child: Center(
                            child: Text(
                              "No Data",
                              style: TextStyle(color: Colors.black),
                            ),
                          ))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: views.timeSpent.data?.timespentdetail
                                      ?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                int spentminutess = views.timeSpent.data
                                        ?.timespentdetail?[index].totalMins ??
                                    0;
                                double timeSpent = spentminutess / 60;
                                return Column(
                                  children: [
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          views
                                                  .timeSpent
                                                  .data
                                                  ?.timespentdetail?[index]
                                                  .sessionName
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: context.res.color.black,
                                          ),
                                        ),
                                        Text(
                                          views
                                                  .timeSpent
                                                  .data
                                                  ?.timespentdetail?[index]
                                                  .orderNo
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: context.res.color.textOrange,
                                          ),
                                        ),
                                        Text(
                                          "${durationToString(spentminutess)} Hrs",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: context.res.color.textOrange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
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
      widget.views.setIsApprovalScreen7audit(true, widget.views.styleAuditData);
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
                widget.views.getAppDetlList7audit(context);
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
                widget.views.getAppDetlList7audit(context);
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
                widget.views.getAppDetlList7audit(context);
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
