import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_view_model.dart';

class StepCard extends StatefulWidget {
  final BeforewashViewModal views;
  const StepCard({required this.views, Key? key}) : super(key: key);

  @override
  State<StepCard> createState() => StepCardState();
}

class StepCardState extends State<StepCard> {
  final int _index = 0;
  @override
  Widget build(BuildContext context) {
    return (
        BootstrapContainer(
        fluid: true,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(color: Colors.white),
        children: <Widget>[
          BootstrapRow(
            height: 100,
            children: <BootstrapCol>[
              BootstrapCol(
                  sizes: 'col-3',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: (() =>
                              {widget.views.changeWashType('BW', context)}),
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    (widget.views.saveWashData.wType ?? '') ==
                                            'BW'
                                        ? Colors.green.shade300
                                        : Colors.grey.shade200,
                              ),
                              child: const Text(
                                'Before Wash',
                                style: TextStyle(),
                              ))),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )),
              BootstrapCol(
                  sizes: 'col-3',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: (() =>
                              {widget.views.changeWashType('AW', context)}),
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    (widget.views.saveWashData.wType ?? '') ==
                                            'AW'
                                        ? Colors.green.shade300
                                        : Colors.grey.shade200,
                              ),
                              child: const Text(
                                'After Wash  Check',
                                style: TextStyle(),
                              ))),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )),
              BootstrapCol(
                  sizes: 'col-3',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: (() =>
                              {widget.views.changeWashType('AP', context)}),
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    (widget.views.saveWashData.wType ?? '') ==
                                            'AP'
                                        ? Colors.green.shade300
                                        : Colors.grey.shade200,
                              ),
                              child: const Text(
                                'After Press Check',
                                style: TextStyle(),
                              ))),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )),
              BootstrapCol(
                  sizes: 'col-3',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: (() =>
                              {widget.views.changeWashType('A', context)}),
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    (widget.views.saveWashData.wType ?? '') ==
                                            'A'
                                        ? Colors.green.shade300
                                        : Colors.grey.shade200,
                              ),
                              child: const Text(
                                'Approval',
                                style: TextStyle(),
                              ))),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )),
            ],
          ),
        ]));
  }
}
