import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_view_model.dart';

class ApprovalActionCard extends StatefulWidget {
  final BeforewashViewModal views;

  const ApprovalActionCard({
    Key? key,
    required this.views,
  }) : super(key: key);

  @override
  State<ApprovalActionCard> createState() => _ApprovalActionCardState();
}

class _ApprovalActionCardState extends State<ApprovalActionCard> {
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
          Column(
            children: [
              Row(
                children: [
                  Text(
                      'Status : ${widget.views.currentPassFailType == 'P' ? 'Pass' : widget.views.currentPassFailType == 'F' ? 'Fail' : widget.views.currentPassFailType == 'CA' ? 'Conditionally Approved' : ''}'),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Opacity(
                        opacity: (widget.views.currentCommentController.text
                                    .isNotEmpty &&
                                widget.views.currentPassFailType.isNotEmpty)
                            ? 1.0
                            : 0.4,
                        child: AbsorbPointer(
                          absorbing: (widget.views.currentCommentController.text
                                      .isNotEmpty &&
                                  widget.views.currentPassFailType.isNotEmpty)
                              ? false
                              : true,
                          child: GestureDetector(
                            onTap: () {
                              // if (widget.views.saveWashData.wType == 'A') {
                              //   widget.views.postSaveWashApproval(context);
                              // } else {
                              widget.views.postSaveCQCTaskStatus(context);
                              widget.views.postSaveWash(context);
                              // }
                            },
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black)),
                              child: const Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.views.clearButton(context);
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
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  widget.views.curretPassFailOnChange('CA', context);
                },
                child: Opacity(
                  opacity: widget.views.currentPassFailType == 'CA' ? 1.0 : 0.5,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                        child: Text(
                      'Conditionally Approved',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  widget.views.curretPassFailOnChange('F', context);
                },
                child: Opacity(
                  opacity: widget.views.currentPassFailType == 'F' ? 1.0 : 0.5,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffff4343),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                        child: Text(
                      'Fail',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              widget.views.curretPassFailOnChange('P', context);
            },
            child: Opacity(
              opacity: widget.views.currentPassFailType == 'P' ? 1.0 : 0.5,
              child: Container(
                height: 160,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: BoxDecoration(
                  color: const Color(0xff1fb146),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    widget.views.saveWashData.wType != 'A'
                        ? 'Pass'
                        : 'Approve  ',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
