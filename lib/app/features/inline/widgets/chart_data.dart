import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class chartData extends StatefulWidget {
  const chartData({Key? key}) : super(key: key);

  @override
  State<chartData> createState() => _chartDataState();
}

class _chartDataState extends State<chartData> {
  List<productDefultPcsData> data = [
    productDefultPcsData('Remaining', 35, Colors.grey.withOpacity(0.5)),
    productDefultPcsData('Green', 28, Colors.green),
    productDefultPcsData('Yellow', 34, Colors.yellow),
    productDefultPcsData('Red', 32, Colors.red),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 100,
      child: Column(children: [
        //Initialize the chart widget
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: ''),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<productDefultPcsData, String>>[
              BarSeries<productDefultPcsData, String>(
                  dataSource: data,
                  width: 0.1,
                  color: Colors.red,
                  xValueMapper: (productDefultPcsData sales, _) => sales.title,
                  yValueMapper: (productDefultPcsData sales, _) => sales.defCnt,
                  name: '',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     //Initialize the spark charts widget
        //     child: SfSparkLineChart.custom(
        //       //Enable the trackball
        //       trackball: SparkChartTrackball(
        //           activationMode: SparkChartActivationMode.tap),
        //       //Enable marker
        //       marker: SparkChartMarker(
        //           displayMode: SparkChartMarkerDisplayMode.all),
        //       //Enable data label
        //       labelDisplayMode: SparkChartLabelDisplayMode.all,
        //       xValueMapper: (int index) => data[index].year,
        //       yValueMapper: (int index) => data[index].sales,
        //       dataCount: 5,
        //     ),
        //   ),
        // )
      ]),
    );
  }
}

class productDefultPcsData {
  productDefultPcsData(this.title, this.defCnt, this.color);

  final String title;
  final double defCnt;
  final Color color;
}
