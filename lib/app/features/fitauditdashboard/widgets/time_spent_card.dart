import 'package:flutter/material.dart';
import 'package:qapp/app/features/fitauditdashboard/fitauditdashboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

class TimeSpentCard extends StatelessWidget {
  final FitDashboardViewModel views;
  const TimeSpentCard({
    Key? key,
    required this.views,
  }) : super(key: key);

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    int spentminutess = views.timeSpent.data?.totalMins ?? 0;

    double hours = spentminutess / 60;
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
                      'Time Spent',
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
                          durationToString(spentminutess),
                          style: TextStyle(
                            fontSize: 40,
                            color: context.res.color.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Hrs',
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
                const SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: Image(
                    image: AssetImage("assets/dashboard/timespend.png"),
                    fit: BoxFit.cover,
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
