import 'package:flutter/material.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/res/constants.dart';

class OptionCard extends StatelessWidget {
  final InternalAuditViewModal views;
  const OptionCard({
    Key? key,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (views.auditState != 2)
              GestureDetector(
                onTap: () async {
                  String unitcode =
                      await SharedPreferenceHelper.getString('unitCode');
                  print('step 2');
                  views.defectStateUpdate(2);
                  views.getLineQCFrequentUsedOperationsandPartsData(
                      context,
                      views.saveAuditData.unitCode.toString(),
                      '7',
                      views.saveAuditData.auditType.toString(),
                      views.saveAuditData.auditorName.toString(),
                      views.saveAuditData.orderNo.toString(),
                      views.auditState == 0
                          ? 'V'
                          : views.auditState == 1
                              ? 'M'
                              : 'P');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                      color: views.defectState == 2
                          ? const Color.fromARGB(255, 237, 238, 240)
                          : Colors.white,
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border_outlined,
                        color: views.defectState == 2
                            ? const Color(0xffF7931C)
                            : Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Operation')
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            Opacity(
              opacity: views.auidtFail ? 1.0 : 0.5,
              // opacity: views.auidtFail ? 1.0 : 1.0,
              child: AbsorbPointer(
                absorbing: !views.auidtFail,
                // absorbing: false,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (views.auditState == 0 || views.auditState == 2) {
                          views.defectStateUpdate(3);
                          String userN = await SharedPreferenceHelper.getString(
                              Constants.userDisplayName);
                          String unitCode =
                              await SharedPreferenceHelper.getString(
                                  'unitCode');

                          views.getFreqUsedDefectsByParamswithChkType(
                              context,
                              views.saveAuditData.unitCode.toString(),
                              views.saveAuditData.auditType.toString(),
                              views.saveAuditData.auditorName.toString(),
                              views.auditState == 0
                                  ? 'V'
                                  : views.auditState == 1
                                      ? 'M'
                                      : views.auditState == 2
                                          ? 'P'
                                          : '');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: views.defectState == 3
                                ? const Color.fromARGB(255, 237, 238, 240)
                                : Colors.white,
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_border_outlined,
                              color: views.defectState == 3
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
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        views.defectStateUpdate(4);
                        views
                            .getAllDefectswithFreqUsedDefectsByParamswithChkType(
                                context,
                                views.saveAuditData.unitCode.toString(),
                                views.saveAuditData.auditType.toString(),
                                views.saveAuditData.auditorName.toString(),
                                views.auditState == 0
                                    ? 'V'
                                    : views.auditState == 1
                                        ? 'M'
                                        : views.auditState == 2
                                            ? 'P'
                                            : '');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: views.defectState == 4
                                ? const Color.fromARGB(255, 237, 238, 240)
                                : Colors.white,
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_border_outlined,
                              color: views.defectState == 4
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
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        views.defectStateUpdate(5);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: views.defectState == 5
                                ? const Color.fromARGB(255, 237, 238, 240)
                                : Colors.white,
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.message_outlined,
                              color: views.defectState == 5
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
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        views.defectStateUpdate(6);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: views.defectState == 6
                                ? const Color.fromARGB(255, 237, 238, 240)
                                : Colors.white,
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: views.defectState == 6
                                  ? const Color(0xffF7931C)
                                  : Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Take Camera')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
