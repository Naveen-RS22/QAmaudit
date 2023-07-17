import 'package:flutter/material.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

import '../../../data/network/dto/TimeSpendModel.dart';

class PiecesStatusCard extends StatelessWidget {
  final String pieceCount;
  final String totalCount;
  final String percentage;
  final bool isPassCard;
  final FitDashboardViewModel views;

  const PiecesStatusCard(this.pieceCount, this.totalCount, this.percentage,
      this.isPassCard, this.views,
      {Key? key, required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Defectpscdetail? viewData =
        views.timeSpent.data?.defectpscdetail?.length == 1
            ? views.timeSpent.data?.defectpscdetail![0]
            : null;
    num checkedPcs = viewData != null ? viewData.checkps ?? 0 : 0;
    num passPcs = viewData != null ? viewData.passpcs ?? 0 : 0;

    //List defectPeices = views.timeSpent.data?.defectpscdetail ?? [];
    // int defectPcs = views.timeSpent.data?.defectpscdetail?[0].defectpsc ?? 1;
    num defectPcs = viewData != null ? viewData.defectpsc ?? 0 : 0;
    var passPercent = passPcs == 0 ? 0 : (passPcs / checkedPcs) * 100;
    var defectPercent = defectPcs == 0 ? 0 : (defectPcs / checkedPcs) * 100;
    // views.timeSpent.data!.defectpscdetail?[0].checkps ?? 0;
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
                      isPassCard ? 'Pass Pieces' : 'Defect Pieces',
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
                        isPassCard
                            ? Text(
                                passPcs.abs().toString(),
                                style: TextStyle(
                                  fontSize: 40,
                                  color: context.res.color.black,
                                ),
                              )
                            : Text(
                                defectPcs.abs().toString(),
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
                            checkedPcs.abs().toString(),
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
                      isPassCard
                          ? "${(!passPercent.isInfinite && !passPercent.isNaN) ? passPercent.round().abs() : 0}%"
                          : "${(!defectPercent.isInfinite && !defectPercent.isNaN) ? defectPercent.round().abs() : 0}%",
                      style: TextStyle(
                          color: isPassCard
                              ? context.res.color.textColorGreen
                              : context.res.color.textColorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
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
