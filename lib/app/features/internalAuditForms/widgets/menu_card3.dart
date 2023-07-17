import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';

class MenuCards extends StatefulWidget {
  final InternalAuditViewModal views;
  const MenuCards({Key? key, required this.views}) : super(key: key);

  @override
  _MenuCardsState createState() => _MenuCardsState();
}

class _MenuCardsState extends State<MenuCards> {
  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    String partCode = widget.views.saveAuditData.partCode ?? "";
    return BootstrapContainer(
      fluid: true,
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(color: Colors.white),
      children: <Widget>[
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-3',
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: widget.views.auditState == 2
                    ? TextField(
                        cursorColor: Colors.black,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: widget.views.packIdController,
                        onChanged: (value) {
                          widget.views.packIdChange(value);
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Pack ID',
                        ),
                      )
                    : widget.views.sleevesData.data == null
                        ? DropdownButton<String>(
                            value: "",
                            isExpanded: true,
                            hint: const Text("Select Part"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            underline: Container(),
                            items: [].map((item) {
                              return const DropdownMenuItem(
                                value: "",
                                child: Text(""),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {},
                          )
                        : DropdownButton<String>(
                            value: widget.views.saveAuditData.partCode == ""
                                ? null
                                : widget.views.saveAuditData.partCode,
                            isExpanded: true,
                            hint: const Text("Select Part"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            underline: Container(),
                            items: widget.views.sleevesData.data?.map((item) {
                              return DropdownMenuItem(
                                value: item.partCode.toString(),
                                onTap: () {
                                  widget.views.sleeveValueOnchange(context,
                                      item.partCode.toString(), item.id);
                                },
                                child: Text(item.translation.toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // widget.views.partOnchange(newValue.toString());
                            },
                          ),
              ),
            ),
            if (widget.views.auditState != 2)
              BootstrapCol(
                sizes: 'col-3',
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300)),
                  child: widget.views.sleevesAttachmentData.data == null
                      ? DropdownButton<String>(
                          value: "",
                          isExpanded: true,
                          hint: const Text("Select Operation"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          items: [].map((item) {
                            return const DropdownMenuItem(
                              value: "",
                              child: Text(""),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        )
                      : DropdownButton<String>(
                          isExpanded: true,
                          value: widget.views.saveAuditData.operationCode == ""
                              ? null
                              : widget.views.saveAuditData.operationCode,
                          hint: const Text("Select Operation"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          onChanged: (String? newValue) {
                            widget.views.sleeveAttachmentValueOnchange(
                                newValue.toString(), '');
                          },
                          items: widget.views.sleevesAttachmentData.data
                              ?.map((item) {
                            return DropdownMenuItem(
                              value: item.operCode.toString(),
                              child: Text(item.translation.toString()),
                            );
                          }).toList(),
                        ),
                ),
              ),
            if (widget.views.auditState == 0 || widget.views.auditState == 1)
              BootstrapCol(
                sizes: (widget.views.auditState == 0 ||
                        widget.views.auditState == 1)
                    ? 'col-2'
                    : 'col-3',
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300)),
                  child: widget.views.getDsData.data?.sizelist == null
                      ? DropdownButton<String>(
                          value: "",
                          isExpanded: true,
                          hint: const Text("Select Size"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          items: [].map((item) {
                            return const DropdownMenuItem(
                              value: "",
                              child: Text(""),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        )
                      : DropdownButton<String>(
                          isExpanded: true,
                          value: widget.views.garSize == ""
                              ? null
                              : widget.views.garSize,
                          hint: const Text("Select Size"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          onChanged: (String? newValue) {
                            widget.views.sizeOnchange(newValue.toString());
                          },
                          items: widget.views.getDsData.data?.sizelist
                              ?.map((item) {
                            return DropdownMenuItem(
                              value: item.toString(),
                              child: Text(item.toString()),
                            );
                          }).toList(),
                        ),
                ),
              ),
            BootstrapCol(
                sizes: (widget.views.auditState == 0 ||
                        widget.views.auditState == 1)
                    ? 'col-2'
                    : 'col-3',
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Inspected'),
                      Text(
                        widget.views
                            .auditStateData[widget.views.auditState]['total']
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      )
                    ],
                  ),
                )),
            BootstrapCol(
                sizes: (widget.views.auditState == 0 ||
                        widget.views.auditState == 1)
                    ? 'col-2'
                    : 'col-3',
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Failed Pieces'),
                      Text(
                        widget
                            .views
                            .auditStateData[widget.views.auditState]
                                ['failCount']
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ],
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: color,
      child: Text(text),
    );
  }
}
