import 'package:flutter/material.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/features/fitaudit/fit_audit_view_model.dart';

class OptionCard extends StatelessWidget {
  final FitAuditViewModal views;
  const OptionCard({
    Key? key,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 330,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (views.auditStep > 0)
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // GestureDetector(
                        //   onTap: () async {
                        //     String unitcode =
                        //         await SharedPreferenceHelper.getString(
                        //             'unitCode');

                        //     views.auditStepUpdate(2);
                        //     // views.getFavoriteDefect(context);
                        //     // views.favDefectDataWithLanguage(context);
                        //     views.getLineQCFrequentUsedOperationsandPartsData(
                        //         context,
                        //         views.scoreCardData.unitCode.toString(),
                        //         '7',
                        //         views.scoreCardData.auditType.toString(),
                        //         views.scoreCardData.auditorName.toString(),
                        //         views.scoreCardData.orderNo.toString());
                        //   },
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width * 0.2,
                        //     padding: const EdgeInsets.symmetric(
                        //         vertical: 15, horizontal: 10),
                        //     decoration: BoxDecoration(
                        //         color: views.auditStep == 2
                        //             ? const Color.fromARGB(255, 237, 238, 240)
                        //             : Colors.white,
                        //         border:
                        //             Border.all(color: Colors.grey.shade300)),
                        //     child: Row(
                        //       children: [
                        //         Icon(
                        //           Icons.star_border_outlined,
                        //           color: views.auditStep == 2
                        //               ? const Color(0xffF7931C)
                        //               : Colors.grey,
                        //         ),
                        //         const SizedBox(
                        //           width: 10,
                        //         ),
                        //         const Text('Operation')
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        GestureDetector(
                          onTap: () async {
                            String unitcode =
                                await SharedPreferenceHelper.getString(
                                    'unitCode');
                            if (views.auditCurrentCheck == 'fail') {
                              views.auditStepUpdate(3);
                              views.getFreqUsedDefectsByParams(
                                  context,
                                  unitcode,
                                  views.styleAuditData.auditType ?? '',
                                  views.styleAuditData.auditorName ?? '');
                            }
                            // views.getFavoriteDefect(context);
                            // views.favDefectDataWithLanguage(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                color: views.auditStep == 3
                                    ? const Color.fromARGB(255, 237, 238, 240)
                                    : Colors.white,
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_border_outlined,
                                  color: views.auditStep == 3
                                      ? const Color(0xffF7931C)
                                      : Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('Freq. Used Defects')
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            String unitcode =
                                await SharedPreferenceHelper.getString(
                                    'unitCode');
                            if (views.auditCurrentCheck == 'fail') {
                              views.auditStepUpdate(4);
                              // views.getFavoriteDefect(context);
                              // views.favDefectDataWithLanguage(context);
                              views.getAllDefectswithFreqUsedDefectsByParams(
                                  context,
                                  unitcode,
                                  views.styleAuditData.auditType ?? '',
                                  views.styleAuditData.auditorName ?? '');
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                color: views.auditStep == 4
                                    ? const Color.fromARGB(255, 237, 238, 240)
                                    : Colors.white,
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_border_outlined,
                                  color: views.auditStep == 4
                                      ? const Color(0xffF7931C)
                                      : Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('All Defects')
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (views.auditCurrentCheck == 'fail' ||
                                views.auditCurrentCheck == 'pass') {
                              views.auditStepUpdate(5);
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                color: views.auditStep == 5
                                    ? const Color.fromARGB(255, 237, 238, 240)
                                    : Colors.white,
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.message_outlined,
                                  color: views.auditStep == 5
                                      ? const Color(0xffF7931C)
                                      : Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('Comment')
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (views.auditCurrentCheck == 'fail' ||
                                views.auditCurrentCheck == 'pass') {
                              views.auditStepUpdate(6);
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                color: views.auditStep == 6
                                    ? const Color.fromARGB(255, 237, 238, 240)
                                    : Colors.white,
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: views.auditStep == 6
                                      ? const Color(0xffF7931C)
                                      : Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('Take Photo')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
