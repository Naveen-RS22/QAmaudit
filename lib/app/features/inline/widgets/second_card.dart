import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/data/network/dto/scheduleModel.dart';
import 'package:qapp/app/res/constants.dart';

import '../inline_view_model.dart';

class SecondCard extends StatefulWidget {
  final int auditStep;
  final InlineViewModal views;
  final StyleAuditData styleInfo;
  const SecondCard(
      {Key? key,
      required this.auditStep,
      required this.views,
      required this.styleInfo
      // List<Data>? sleeveList,
      // required this.sleeveList,
      })
      : super(key: key);

  @override
  State<SecondCard> createState() => _SecondCardState();
}

class _SecondCardState extends State<SecondCard> {
  void tagPop(BuildContext context) async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    // widget.views.getTagInfo(
    //     context,
    //     unitCode,
    //     currentDate,
    //     widget.views.styleAuditData?.auditType,
    //     widget.views.styleAuditData?.sewLine,
    //     widget.views.styleAuditData?.orderNo,
    //     widget.views.styleAuditData?.auditorName4,
    //     userN);
    exceptionDialog() {
      Widget tagListGenerate() {
        var data = widget.views.getTagInfoDetail;

        return (data.isEmpty)
            ? Column(
                children: const [
                  Center(
                    child: Text(
                      'Tag ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text('No Data'),
                  ),
                ],
              )
            : Column(
                children: [
                  const Center(
                    child: Text(
                      'Tag ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Wrap(
                      runSpacing: 5.0,
                      spacing: 5.0,
                      children: data.map((item) {
                        return InkWell(
                          onTap: () {
                            // widget.views
                            //     .tagIdsetter(context, item.tagId.toString(), item.id);
                            widget.views.tagIdsetter2(context, item);
                          },
                          child: Center(
                            child: Container(
                              // width: 300,
                              padding: const EdgeInsets.all(10),
                              // child: Text(item.tagId.toString()),
                              child: Text(item.toString()),
                            ),
                          ),
                        );
                      }).toList()),
                ],
              );
      }

      return Get.defaultDialog(
          content: Container(
              height: 400,
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              child: SingleChildScrollView(child: tagListGenerate())),
          title: "",
          confirmTextColor: const Color(0xffffffff),
          cancelTextColor: const Color(0xffF7931C),
          buttonColor: const Color(0xffF7931C));
    }

    exceptionDialog();
  }

  void tagPop2(BuildContext context) async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');

    // widget.views.getTagInfo(
    //     context,
    //     unitCode,
    //     currentDate,
    //     widget.views.styleAuditData?.auditType,
    //     widget.views.styleAuditData?.sewLine,
    //     widget.views.styleAuditData?.orderNo,
    //     widget.views.styleAuditData?.auditorName4,
    //     userN);

    return showDialog(
      context: context,
      builder: (context) {
        String contentText = "Content of Dialog";
        String count = '0';

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                  height: 400,
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                      child: MyWidget(views: widget.views))),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            padding: const EdgeInsets.all(5),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
            child: DropdownButton<String>(
              value: widget.views.scoreCardData.partCode == ""
                  ? null
                  : widget.views.scoreCardData.partCode,
              isExpanded: true,
              hint: const Text("Select Part"),
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              underline: Container(),
              items: (widget.views.sleevesData.data ?? []).map((item) {
                return DropdownMenuItem(
                  value: item.partCode.toString(),
                  onTap: () {
                    widget.views.sleeveValueOnchange(
                        context, item.partCode.toString(), item.id);
                  },
                  child: Text(item.translation.toString()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // widget.views
                //     .sleeveValueOnchange(context, newValue.toString());
              },
              // value: widget.views.sleeveValue.toString(),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.2,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
            child: DropdownButton<String>(
              isExpanded: true,
              value: widget.views.scoreCardData.operationCode == "" ||
                      widget.views.scoreCardData.operationCode == "NA"
                  ? null
                  : widget.views.scoreCardData.operationCode,
              hint: Text(
                widget.views.currentoperationName.toString().isEmpty
                    ? "Select Operation"
                    : widget.views.currentoperationName.length > 25
                        ? widget.views.currentoperationName.substring(0, 25)
                        : widget.views.currentoperationName,
                style: TextStyle(
                    color: widget.views.currentoperationName.toString().isEmpty
                        ? Colors.grey
                        : Colors.black),
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              underline: Container(),
              onChanged: (String? newValue) {
                widget.views
                    .sleeveAttachmentValueOnchange(newValue.toString(), '');
              },
              items:
                  (widget.views.sleevesAttachmentData.data ?? []).map((item) {
                return DropdownMenuItem(
                  value: item.operCode.toString(),
                  child: Text(item.translation.toString()),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Form(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                width: 150,
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: widget.views.tagName,
                  enabled: !widget.views.tagDisable,
                  // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Tag Number',
                    border: InputBorder.none,
                  ),
                  onChanged: (String val) {
                    widget.views.tagNumberChange(val);
                  },
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Opacity(
            opacity: 1.00,
            child: AbsorbPointer(
              absorbing: false,
              child: GestureDetector(
                onTap: () {
                  if (widget.views.tagName.text.isEmpty) {
                    tagPop2(context);
                  } else {
                    widget.views.tagIdClear();
                  }
                  // if (widget.views.tagName.text.isNotEmpty) {
                  //   FocusScope.of(context).requestFocus(FocusNode());
                  //   widget.views.getDefectCodeByTagId(
                  //       widget.views.tagName.text, widget.views.styleAuditData);
                  // }
                  //widget.views.getEmpCode(context, widget.styleAuditdata);
                },
                child: Container(
                  height: 62,
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Icon(
                    widget.views.tagName.text.isEmpty
                        ? Icons.arrow_drop_down
                        : Icons.close,
                    size: 40,
                  )),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () async {
              DateTime dateToday = DateTime.now();
              String currentDate = dateToday.toString().substring(0, 10);
              String userN = await SharedPreferenceHelper.getString(
                  Constants.userDisplayName);
              String unitCode =
                  await SharedPreferenceHelper.getString('unitCode');
              widget.views.getTagInfo(
                  context,
                  unitCode,
                  currentDate,
                  widget.views.styleAuditData?.auditType,
                  widget.views.styleAuditData?.sewLine,
                  widget.views.styleAuditData?.orderNo,
                  widget.views.styleAuditData?.auditorName4,
                  userN);

              widget.views.enableCameraFunction(true);
            },
            child: Container(
              height: 62,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                  child: Icon(
                Icons.qr_code,
                size: 40,
              )),
            ),
          ),
          if (widget.styleInfo.auditType == "FG" ||
              widget.styleInfo.auditType == "FG-I" ||
              widget.styleInfo.auditType == "FG-O")
            const SizedBox(
              width: 20,
            ),
          if (widget.styleInfo.auditType == "FG" ||
              widget.styleInfo.auditType == "FG-I" ||
              widget.styleInfo.auditType == "FG-O")
            AbsorbPointer(
              absorbing: true,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: widget.views.scoreCardData.auditType,
                  hint: const Text("Select finishing"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    widget.views
                        .finishValueOnchange(context, newValue.toString());
                  },
                  items: widget.views.finishDropDownList2.map((item) {
                    return DropdownMenuItem(
                      value: item['id'].toString(),
                      child: Text(item['text'].toString()),
                    );
                  }).toList(),
                ),
              ),
            ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)),
              child: widget.views.getDsData.data?.sizelist == null
                  ? DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("Size"),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      underline: Container(),
                      items: [].map((item) {
                        return const DropdownMenuItem(
                          value: "",
                          child: Text(""),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        widget.views.sizeValueOnchange(newValue.toString());
                      },
                    )
                  : DropdownButton<String>(
                      value: widget.views.garSize,
                      isExpanded: true,
                      hint: const Text("Size"),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      underline: Container(),
                      items: widget.views.getDsData.data?.sizelist?.map((item) {
                        return DropdownMenuItem(
                          value: item.toString(),
                          child: Text(item.toString()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        widget.views.sizeValueOnchange(newValue.toString());
                      },
                    ),
            ),
          )
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
  void newFunction() async {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');

    widget.views.getTagInfo(
        context,
        unitCode,
        currentDate,
        widget.views.styleAuditData?.auditType,
        widget.views.styleAuditData?.sewLine,
        widget.views.styleAuditData?.orderNo,
        widget.views.styleAuditData?.auditorName4,
        userN);

    String count = '0';
    Timer.periodic(const Duration(seconds: 0), (timer) {
      if (mounted) {
        setState(() {
          count = timer.tick.toString();
        });
      }
    });
  }

  @override
  void initState() {
    newFunction();
    super.initState();
  }

  Widget tagListGenerate2() {
    var data = widget.views.getTagInfoDetail;

    return (data.isEmpty)
        ? Column(
            children: const [
              Center(
                child: Text(
                  'Tag ID',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text('No Data'),
              ),
            ],
          )
        : Column(
            children: [
              Row(
                children: [
                  const Text(
                    ('Tag IDs'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      DateTime dateToday = DateTime.now();
                      String currentDate =
                          dateToday.toString().substring(0, 10);
                      String userN = await SharedPreferenceHelper.getString(
                          Constants.userDisplayName);
                      String unitCode =
                          await SharedPreferenceHelper.getString('unitCode');
                      widget.views.getTagInfo(
                          context,
                          unitCode,
                          currentDate,
                          widget.views.styleAuditData?.auditType,
                          widget.views.styleAuditData?.sewLine,
                          widget.views.styleAuditData?.orderNo,
                          widget.views.styleAuditData?.auditorName4,
                          userN);

                      Navigator.pop(context);
                      widget.views.enableCameraFunction(false);
                    },
                    child: Container(
                      height: 62,
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.qr_code,
                        size: 40,
                      )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: data.map((item) {
                    return InkWell(
                      onTap: () {
                        // widget.views
                        //     .tagIdsetter(context, item.tagId.toString(), item.id);
                        widget.views.tagIdsetter2(context, item);
                      },
                      child: Center(
                        child: Container(
                          // width: 300,
                          padding: const EdgeInsets.all(10),
                          // child: Text(item.tagId.toString()),
                          child: Text(item.toString()),
                        ),
                      ),
                    );
                  }).toList()),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: tagListGenerate2(),
    );
  }
}
