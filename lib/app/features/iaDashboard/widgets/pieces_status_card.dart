import 'package:flutter/material.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

class PiecesStatusCard extends StatelessWidget {
  final String titleText;
  final String pieceCount;
  final String totalCount;
  final String percentage;

  final bool isPassCard;
  final IADashboardViewModel views;

  const PiecesStatusCard(this.titleText, this.pieceCount, this.totalCount,
      this.percentage, this.isPassCard, this.views,
      {Key? key, required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: context.res.color.cardBg2,
        child: SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titleText,
                      style: TextStyle(
                        fontSize: 20,
                        color: context.res.color.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          pieceCount,
                          style: TextStyle(
                            fontSize: 40,
                            color: context.res.color.black,
                          ),
                        ),
                        Text(
                          '/',
                          style: TextStyle(
                            fontSize: 16,
                            color: context.res.color.textGray,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            totalCount.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: context.res.color.textGray,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: context.res.color.white),
                  child: Center(
                    child: Text(
                      percentage.characters.take(4).toString() + "%",
                      style: TextStyle(
                          color: isPassCard
                              ? context.res.color.textColorGreen
                              : context.res.color.textColorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
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
