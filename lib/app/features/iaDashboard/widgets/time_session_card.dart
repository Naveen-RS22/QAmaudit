import 'package:flutter/material.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

class TimeSessionCard extends StatelessWidget {
  final IADashboardViewModel views;

  const TimeSessionCard({Key? key, required this.views}) : super(key: key);

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
                    Text(
                      'Top 3 Defects',
                      style: TextStyle(
                        fontSize: 20,
                        color: context.res.color.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      height: 2,
                      color: context.res.color.black,
                    ),
                    const SizedBox(height: 10),
                    (views.getAuidtDefectByCountDetail.data?.length ?? 0) == 0
                        ? const Expanded(
                            child: Center(
                            child: Text(
                              "No Data",
                              style: TextStyle(color: Colors.black),
                            ),
                          ))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: views.getAuidtDefectByCountDetail.data
                                      ?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                String defectName = views
                                        .getAuidtDefectByCountDetail
                                        .data?[index]
                                        .defectName
                                        .toString() ??
                                    "";
                                return Column(
                                  children: [
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          defectName.length > 20
                                              ? defectName.characters
                                                      .take(20)
                                                      .toString() +
                                                  "..."
                                              : defectName,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: context.res.color.black,
                                          ),
                                        ),
                                        Text(
                                          views.getAuidtDefectByCountDetail
                                                  .data?[index].defectpcs
                                                  .toString() ??
                                              "",
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
