import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:qapp/app/data/network/dto/GetLineQCDefectLevelReportModel.dart';
import 'package:qapp/app/features/userboard/userboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

import '../../../data/network/dto/GetDefectLevelListModel.dart';
import '../../../res/styles.dart';

class DefectFinalAudit {
  String? sessionHours;
  int? inspectedPcs;
  int? defectPcs;
  int? criticalPcs;
  int? majorPcs;
  num? dhu;
}

class FinalAuditCard extends StatefulWidget {
  final UserboardViewModel views;

  const FinalAuditCard({Key? key, required this.views}) : super(key: key);

  @override
  _FinalAuditCardState createState() => _FinalAuditCardState();
}

class _FinalAuditCardState extends State<FinalAuditCard> {
  List<DefectFinalAudit> items = [];
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var napo = widget.views.getLineQCDefectLevelReportData.data ?? [];
    List<LineQCDefectLevel> ite = [];
    if (napo.isNotEmpty) {
      ite = napo[0].lineQCDefectLevel ?? [];
    }
    if (widget.views.getDefectLevel.data?.isEmpty ?? true) {
      setState(() {
        items = [];
      });
    }
    if (widget.views.getDefectLevel.data?.isNotEmpty ?? false) {
      var newMap = groupBy(widget.views.getDefectLevel.data!,
          (DefectLevelData obj) => obj.sessioncode);

      List<DefectFinalAudit> listData = [];
      newMap.forEach((keys, value) {
        DefectFinalAudit datas = DefectFinalAudit();
        if ((keys ?? "").isNotEmpty) {
          datas.sessionHours = keys ?? "";
          for (DefectLevelData item in value) {
            datas.inspectedPcs = datas.inspectedPcs == null
                ? (item.inspec ?? 0)
                : ((datas.inspectedPcs ?? 0) + (item.inspec ?? 0));
            datas.criticalPcs =
                (datas.criticalPcs == null && item.defectLevel == "Critical")
                    ? (item.defpcs ?? 0)
                    : datas.criticalPcs;
            datas.majorPcs =
                (datas.majorPcs == null && item.defectLevel == "Major")
                    ? (item.defpcs ?? 0)
                    : datas.majorPcs;
            datas.dhu = datas.dhu == null
                ? (item.dhu ?? 0)
                : ((datas.dhu ?? 0) + (item.dhu ?? 0));
          }
          datas.defectPcs = (datas.criticalPcs ?? 0) + (datas.majorPcs ?? 0);
          listData.add(datas);
        }
      });
      setState(() {
        items = listData;
      });
    }
    return GestureDetector(
        onTap: () {}, child: _finalAuditWidget(context, ite));
  }

  _finalAuditWidget(BuildContext context, List<LineQCDefectLevel> ite) =>
      Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: context.res.color.textGray),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '',
                  style: Styles.headingStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          widget.views.finalAuditRoundOnChange(context, "IL");
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: widget.views.finalAuditRound == "IL"
                                ? context.res.color.bgColorBlue
                                : Colors.white,
                            border: Border.all(
                                color: widget.views.finalAuditRound == "IL"
                                    ? Colors.white
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'In Line',
                            style: Styles.headingStyle.copyWith(
                                color: widget.views.finalAuditRound == "IL"
                                    ? context.res.color.white
                                    : Colors.black,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          widget.views.finalAuditRoundOnChange(context, "EL");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: widget.views.finalAuditRound == "EL"
                                ? context.res.color.bgColorBlue
                                : Colors.white,
                            border: Border.all(
                                color: widget.views.finalAuditRound == "EL"
                                    ? Colors.white
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'End Line',
                            style: Styles.headingStyle.copyWith(
                                color: widget.views.finalAuditRound == "EL"
                                    ? context.res.color.white
                                    : Colors.black,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          widget.views.finalAuditRoundOnChange(context, "FG");
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: widget.views.finalAuditRound == "FG"
                                ? context.res.color.bgColorBlue
                                : Colors.white,
                            border: Border.all(
                                color: widget.views.finalAuditRound == "FG"
                                    ? Colors.white
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Finishing',
                            style: Styles.headingStyle.copyWith(
                                color: widget.views.finalAuditRound == "FG"
                                    ? context.res.color.white
                                    : Colors.black,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: _buildContentList(context, ite),
            )
          ],
        ),
      );

  _buildContentList(BuildContext context, List<LineQCDefectLevel> ite) =>
      Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Hour',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Inspected',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Defects',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Critical',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Major',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
                Expanded(
                  child: Text(
                    'DHU',
                    style:
                        TextStyle(fontSize: 14, color: context.res.color.black),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: context.res.color.black,
          ),
          const SizedBox(height: 10),
          ite.isEmpty
              ? const Expanded(
                  child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                  itemCount: ite.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _listItem(context, index, ite);
                  },
                )),
        ],
      );

  _listItem(BuildContext context, int index, List<LineQCDefectLevel> ite) {
    double dhu = (ite[index].defectPcs! / ite[index].inspectedPcs!) * 100;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              (ite[index].sessionCode ?? '-').toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (ite[index].inspectedPcs ?? "-").toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (ite[index].defectPcs ?? "-").toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (ite[index].critical ?? "-").toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (ite[index].major ?? '-').toString(),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              dhu.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
