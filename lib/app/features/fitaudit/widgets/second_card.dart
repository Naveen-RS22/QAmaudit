import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';

class SecondCard extends StatefulWidget {
  final int auditStep;
  final FitAuditViewModal views;
  const SecondCard({
    Key? key,
    required this.auditStep,
    required this.views,
    // List<Data>? sleeveList,
    // required this.sleeveList,
  }) : super(key: key);

  @override
  State<SecondCard> createState() => _SecondCardState();
}

class _SecondCardState extends State<SecondCard> {
  void defectListPopou(BuildContext context) {
    exceptionDialog() {
      return Get.defaultDialog(
          content: Container(
              // width: 600,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    'Defect List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // for (var item in widget.views.top3DefectsKeys)
                  Container(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 235,
                          child: Text(
                            'Defect Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 135,
                          child: Text(
                            ' Count',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: const Text(
                            'Tag ID',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  for (int i = 0; i < widget.views.top3Final.length; i++)
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(widget
                                              .views.top3Final[i]['defectName']
                                              .toString()
                                              .length >
                                          25
                                      ? widget.views.top3Final[i]
                                              ['defectName'] +
                                          '...'
                                      : widget.views.top3Final[i]
                                          ['defectName']),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                SizedBox(
                                    width: 50,
                                    child: Text(widget
                                        .views.top3Final[i]['count']
                                        .toString())),
                                const SizedBox(
                                  width: 85,
                                ),
                                for (int j = 0;
                                    j < widget.views.top3Final[i]['tag'].length;
                                    j++)
                                  Text(widget.views.top3Final[i]['tag'][j].tagId
                                              .toString() !=
                                          ''
                                      ? ('${widget.views.top3Final[i]['tag'][j].tagId},')
                                      : ''),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  // if (widget.views.top3DefectArray.isNotEmpty)
                  //   Center(
                  //       child: GestureDetector(
                  //     onTap: () {
                  //       widget.views.clearDefectsList();
                  //     },
                  //     child: const Text(
                  //       "Clear All",
                  //       style: TextStyle(
                  //           decoration: TextDecoration.underline,
                  //           color: Colors.orange),
                  //     ),
                  //   ))
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
    return Container(
      child: Row(
        children: [
          AbsorbPointer(
            absorbing: widget.views.scoreCardData.auditType == 'FAG',
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)),
              child: DropdownButton<String>(
                value: (widget.views.scoreCardData.partCode == 'NA' ||
                        widget.views.scoreCardData.partCode == '')
                    ? null
                    : widget.views.scoreCardData.partCode,
                isExpanded: true,
                hint: const Text("Select Part"),
                icon: const Icon(Icons.keyboard_arrow_down),
                elevation: 16,

                underline: Container(),
                items:
                    // widget.views.sleevesData.data == null
                    // ? []
                    // :
                    (widget.views.sleevesData.data ?? []).map((item) {
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
              value: (widget.views.scoreCardData.operationCode == 'NA' ||
                      widget.views.scoreCardData.operationCode == '')
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
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              // _buildPopupDialog(context);
              // defectListPopou(context);
              widget.views.setDefectList(true);
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 19, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                width: MediaQuery.of(context).size.width * 0.2,
                child: Container(
                  child: const Row(
                    children: [Text("List View"), Spacer(), Icon(Icons.menu)],
                  ),
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Text('Remaining Operator : ${widget.views.remaning.toString()}')
        ],
      ),
    );
  }
}
