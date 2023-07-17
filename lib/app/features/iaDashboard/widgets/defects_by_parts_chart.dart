import 'package:flutter/material.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/strings.dart';
import 'package:qapp/app/res/styles.dart';

import '../data/chart_data.dart';

class DefectsByPartsWidgets extends StatefulWidget {
  final IADashboardViewModel views;
  const DefectsByPartsWidgets({Key? key, required this.views})
      : super(key: key);

  @override
  State<DefectsByPartsWidgets> createState() => _DefectsByPartsWidgetsState();
}

class _DefectsByPartsWidgetsState extends State<DefectsByPartsWidgets> {
  final List<ChartData> chartData = <ChartData>[
    ChartData('Low', 3500, const Color.fromRGBO(235, 97, 143, 1)),
    ChartData('Average', 7200, const Color.fromRGBO(145, 132, 202, 1)),
    ChartData('High', 10500, const Color.fromRGBO(69, 187, 161, 1)),
  ];

  @override
  Widget build(BuildContext context) {
    List defectList = widget.views.getAuidtDefectByPartsData.data ?? [];
    List<Color> circleColors = [
      context.res.color.textColorRed,
      context.res.color.textOrange,
      context.res.color.textColorGreen,
    ];
    defectList.sort((a, b) => b.defectpcs.compareTo(a.defectpcs));
    if (defectList.isNotEmpty) {
      if (defectList.length > 2) {
        defectList = defectList.sublist(0, 3);
      } else {
        defectList = defectList;
      }
    }

    List defectList2 = defectList;
    num totalCounts = 0;
    for (int i = 0; i < defectList2.length; i++) {
      totalCounts = totalCounts + defectList2[i].defectpcs;
    }

    List myList = widget.views.defectPart.data ?? [];

    myList.sort((a, b) => b.cnt.compareTo(a.cnt));
    if (myList.isNotEmpty && myList.length > 3) {
      myList = myList.sublist(0, 3);
    }
    List myList2 = myList;

    num totalCount = 0;
    for (int i = 0; i < myList2.length; i++) {
      totalCount = totalCount + myList2[i].cnt;
    }

    List<Color> defectColors = [
      context.res.color.textColorGreen,
      context.res.color.progressOrange,
      context.res.color.textColorRed
    ];
    return _defectsByPartsWidget(
        context, myList2, totalCounts, defectColors, defectList2);
  }

  Widget _defectsByPartsWidget(
    BuildContext context,
    List myList2,
    num totalCounts,
    List<Color> defectColors,
    List defectList2,
  ) {
    return Card(
      color: context.res.color.cardBg2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.defectsByParts,
                  style: Styles.headingStyle,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: context.res.color.bgColorBlue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Strings.topThree,
                      style: Styles.headingStyle.copyWith(
                          color: context.res.color.white, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            _progressChart(
                context, totalCounts, myList2, defectList2, defectColors),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (defectList2.isNotEmpty)
                  for (int i = 0; i < defectList2.length; i++)
                    _defectsCountWidget(
                      context,
                      defectList2[i].partName.toString(),
                      defectList2[i].defectpcs.toString(),
                      defectColors[i],
                    ),
                // _defectsCountWidget(
                //     context,
                //     "COLLAR",
                //     "19",

                //     // myList2[1].partName,
                //     // myList2[1].cnt.toString(),
                //     context.res.color.progressOrange),
                // _defectsCountWidget(
                //     context,
                //     "FRONT",
                //     "14",
                //     // myList2[2].partName.toString(),
                //     // myList2[2].cnt.toString(),
                //     context.res.color.textColorRed),
              ],
            )
          ],
        ),
      ),
    );
  }

  _progressChart(BuildContext context, num totalCounts, List myList2,
      List defectList2, List<Color> defectColors) {
    return Expanded(
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            for (int i = 0; i < defectList2.length; i++)
              SizedBox(
                height: (i * 50 + 80),
                width: (i * 50 + 80),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  value: (defectList2[i].defectpcs / totalCounts),
                  color: defectColors[i],
                  strokeWidth: 8,
                ),
              ),
            Text(
              totalCounts.toString(),
              style: Styles.headingStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _defectsCountWidget(
    BuildContext context,
    String title,
    String count,
    Color textColor,
  ) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: textColor,
              // _getColorBasedOnTitle(context, title),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              count,
              style: TextStyle(color: context.res.color.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(color: context.res.color.black, fontSize: 14),
          ),
        ],
      );

  _getColorBasedOnTitle(BuildContext context, String title) {
    switch (title) {
      case Constants.collar:
        return context.res.color.textColorGreen;
      case Constants.cuff:
        return context.res.color.progressOrange;
      default:
        return context.res.color.textColorRed;
    }
  }
}
