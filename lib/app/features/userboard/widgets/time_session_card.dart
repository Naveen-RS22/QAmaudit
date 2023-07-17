import 'package:flutter/material.dart';
import 'package:qapp/app/features/userboard/userboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

class TopThreeDefects extends StatefulWidget {
  final UserboardViewModel views;
  const TopThreeDefects({Key? key, required this.views}) : super(key: key);
  @override
  State<TopThreeDefects> createState() => _TopThreeDefectsState();
}

class _TopThreeDefectsState extends State<TopThreeDefects> {
  @override
  Widget build(BuildContext context) {
    List myList = widget.views.getDefectCount.data ?? [];
    myList.sort((a, b) => b.defectCount.compareTo(a.defectCount));
    if (myList.isNotEmpty && myList.length > 3) {
      myList = myList.sublist(0, 3);
    }
    List myList2 = myList;

    return Expanded(
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
                  (myList.isEmpty)
                      ? const Expanded(
                          child: Center(
                          child: Text(
                            "No Data",
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: widget.views.getDefectCount.data?[0]
                                    .lineQCTop3detailReportModels?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (widget
                                                            .views
                                                            .getDefectCount
                                                            .data?[0]
                                                            .lineQCTop3detailReportModels?[
                                                                index]
                                                            .defectName ??
                                                        '')
                                                    .length >
                                                20
                                            ? (widget
                                                        .views
                                                        .getDefectCount
                                                        .data?[0]
                                                        .lineQCTop3detailReportModels?[
                                                            index]
                                                        .defectName ??
                                                    '')
                                                .characters
                                                .take(20)
                                                .toString()
                                            : (widget
                                                    .views
                                                    .getDefectCount
                                                    .data?[0]
                                                    .lineQCTop3detailReportModels?[
                                                        index]
                                                    .defectName ??
                                                ''),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: context.res.color.black,
                                        ),
                                      ),
                                      Text(
                                        widget
                                                .views
                                                .getDefectCount
                                                .data?[0]
                                                .lineQCTop3detailReportModels?[
                                                    index]
                                                .defectPercent ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 16,
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
}
