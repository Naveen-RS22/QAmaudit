import 'package:flutter/material.dart';
import 'package:qapp/app/features/userboard/userboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/strings.dart';
import 'package:qapp/app/res/styles.dart';

import '../data/chart_data.dart';

class DefectsByPartsWidgets extends StatefulWidget {
  final UserboardViewModel views;
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
    List defectLs = widget.views.getLineQcdefectbypartsDetail.data ?? [];

    List myList = widget.views.getLineQcdefectbypartsDetail.data ?? [];
    myList.sort((a, b) => b.defectpcs.compareTo(a.defectpcs));
    if (myList.isNotEmpty) {
      myList = myList.length == 1
          ? myList.sublist(0, 1)
          : myList.length == 2
              ? myList.sublist(0, 2)
              : myList.sublist(0, 3);
    }
    List myList2 = myList;

    num totalCount = 0;
    for (int i = 0; i < myList2.length; i++) {
      totalCount = totalCount + myList2[i].defectpcs;
    }

    List<Color> defectColors = [
      context.res.color.textColorGreen,
      context.res.color.progressOrange,
      context.res.color.textColorRed
    ];
    return _defectsByPartsWidget(
        context, myList2, totalCount, defectColors, defectLs);
  }

  Widget _defectsByPartsWidget(
    BuildContext context,
    List myList2,
    num totalCount,
    List<Color> defectColors,
    List defectLs,
  ) =>
      Card(
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
                  context, totalCount, myList2, defectLs, defectColors),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (myList2.isNotEmpty)
                    for (int i = 0; i < myList2.length; i++)
                      _defectsCountWidget(
                        context,
                        myList2[i].partName.toString(),
                        myList2[i].defectpcs.toString(),
                        defectColors[i],
                      ),
                ],
              )
            ],
          ),
        ),
      );

  _progressChart2(
    BuildContext context,
    num totalCount,
    int counts,
    List defectLs,
  ) {
    double listOne = counts >= 3 ? (defectLs[2].defectPercent / 10) : 0.0;
    double listTwo = counts >= 2 ? (defectLs[1].defectPercent / 10) : 0.0;
    double listThree = counts >= 1 ? (defectLs[0].defectPercent / 10) : 0.0;

    return Expanded(
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: 80.0,
              width: 80.0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                value: listOne.isNaN ? 0.0 : listOne,
                color: context.res.color.textColorRed,
                strokeWidth: 8,
              ),
            ),
            SizedBox(
              height: 130.0,
              width: 130.0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                value: listTwo.isNaN ? 0.0 : listTwo,
                color: context.res.color.progressOrange,
                strokeWidth: 8,
              ),
            ),
            SizedBox(
              height: 180.0,
              width: 180.0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                value: listThree.isNaN ? 0.0 : listThree,
                color: context.res.color.textColorGreen,
                strokeWidth: 8,
              ),
            ),
            Text(
              totalCount.toString(),
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
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              count,
              style: TextStyle(color: context.res.color.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title.characters.take(10).toString(),
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
