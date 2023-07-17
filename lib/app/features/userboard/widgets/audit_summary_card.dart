import 'package:flutter/material.dart';
import 'package:qapp/app/features/dashboard/dashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

class AuditSummaryCard extends StatelessWidget {
  final DashboardViewModel views;
  const AuditSummaryCard({Key? key, required this.views}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double summaryPercent = (views.auditSummary.data?.completed ?? 0) +
                (views.auditSummary.data?.pending ?? 0) ==
            0
        ? 0.0
        : ((views.auditSummary.data?.completed ?? 0) /
                (views.auditSummary.data?.completed ?? 0) +
            (views.auditSummary.data?.pending ?? 0));

    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: context.res.color.cardBg1,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0)),
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Audit Summary',
                        style: TextStyle(
                          fontSize: 20,
                          color: context.res.color.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              views.auditSummary.data?.completed.toString() ??
                                  "0",
                              style: TextStyle(
                                fontSize: 40,
                                color: context.res.color.textOrange,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 16,
                                color: context.res.color.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '--',
                          style: TextStyle(
                            fontSize: 16,
                            color: context.res.color.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              views.auditSummary.data?.pending.toString() ??
                                  "0",
                              style: TextStyle(
                                fontSize: 40,
                                color: context.res.color.white,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Pending',
                              style: TextStyle(
                                fontSize: 16,
                                color: context.res.color.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    value: summaryPercent.isNaN ? 0.0 : summaryPercent,
                    color: context.res.color.textOrange,
                    strokeWidth: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
