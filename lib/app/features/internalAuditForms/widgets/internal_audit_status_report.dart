import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'dart:math' as math;

import 'package:qapp/app/res/images.dart';

class InternalAuditStatusReport extends StatefulWidget {
  final InternalAuditViewModal viewsData;

  const InternalAuditStatusReport({Key? key, required this.viewsData})
      : super(key: key);

  @override
  _InternalAuditStatusReportState createState() =>
      _InternalAuditStatusReportState();
}

enum LegendShape { circle, rectangle }

class _InternalAuditStatusReportState extends State<InternalAuditStatusReport> {
  @override
  Widget build(BuildContext context) {
    final legendLabels = <String, String>{
      "Flutter": "Flutter legend",
      "React": "React legend",
    };

    final colorList = <Color>[
      const Color(0xff0984e3),
      const Color(0xffe17055),
      const Color(0xfffdcb6e),
      const Color(0xfffd79a8),
      const Color(0xff6c5ce7),
    ];

    final gradientList = <List<Color>>[
      [
        const Color.fromRGBO(223, 250, 92, 1),
        const Color.fromRGBO(129, 250, 112, 1),
      ],
      [
        const Color.fromRGBO(129, 182, 205, 1),
        const Color.fromRGBO(91, 253, 199, 1),
      ],
      [
        const Color.fromRGBO(175, 63, 62, 1.0),
        const Color.fromRGBO(254, 154, 92, 1),
      ]
    ];
    ChartType? chartType = ChartType.disc;
    bool showCenterText = false;
    double? ringStrokeWidth = 32;
    double? chartLegendSpacing = 32;

    bool showLegendsInRow = true;
    bool showLegends = true;
    bool showLegendLabel = true;

    bool showChartValueBackground = true;
    bool showChartValues = true;
    bool showChartValuesInPercentage = false;
    bool showChartValuesOutside = false;

    bool showGradientColors = false;

    LegendShape? legendShape = LegendShape.circle;
    LegendPosition? legendPosition = LegendPosition.bottom;

    int visualKey = 0;
    int measurementKey = 1;
    int packKey = 2;
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  widget.viewsData.setIsStatusReportScreen();
                },
                child: const Icon(Icons.close),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.viewsData.chkTypeSetter('V');
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: widget.viewsData.currentChkType == 'V'
                      ? Colors.grey.shade300
                      : Colors.transparent,
                  child: Column(
                    children: [
                      const Text('Visual'),
                      PieChart(
                        key: ValueKey(visualKey),
                        dataMap: widget.viewsData.statusReportPieDataVisual,
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: chartLegendSpacing,
                        chartRadius: math.min(
                            MediaQuery.of(context).size.width / 3.2, 170),
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: chartType,
                        centerText: showCenterText ? "HYBRID" : null,
                        legendLabels: showLegendLabel ? legendLabels : {},
                        legendOptions: LegendOptions(
                          showLegendsInRow: showLegendsInRow,
                          legendPosition: legendPosition,
                          showLegends: showLegends,
                          legendShape: legendShape == LegendShape.circle
                              ? BoxShape.circle
                              : BoxShape.rectangle,
                          legendTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: showChartValueBackground,
                          showChartValues: showChartValues,
                          showChartValuesInPercentage:
                              showChartValuesInPercentage,
                          showChartValuesOutside: showChartValuesOutside,
                        ),
                        ringStrokeWidth: ringStrokeWidth,
                        emptyColor: Colors.grey,
                        gradientList: showGradientColors ? gradientList : null,
                        emptyColorGradient: const [
                          Color(0xff6c5ce7),
                          Colors.blue,
                        ],
                        baseChartColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  widget.viewsData.chkTypeSetter('M');
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: widget.viewsData.currentChkType == 'M'
                      ? Colors.grey.shade300
                      : Colors.transparent,
                  child: Column(
                    children: [
                      const Text('Measurement'),
                      PieChart(
                        key: ValueKey(measurementKey),
                        dataMap:
                            widget.viewsData.statusReportPieDataMeasurement,
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: chartLegendSpacing,
                        chartRadius: math.min(
                            MediaQuery.of(context).size.width / 3.2, 170),
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: chartType,
                        centerText: showCenterText ? "HYBRID" : null,
                        legendLabels: showLegendLabel ? legendLabels : {},
                        legendOptions: LegendOptions(
                          showLegendsInRow: showLegendsInRow,
                          legendPosition: legendPosition,
                          showLegends: showLegends,
                          legendShape: legendShape == LegendShape.circle
                              ? BoxShape.circle
                              : BoxShape.rectangle,
                          legendTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: showChartValueBackground,
                          showChartValues: showChartValues,
                          showChartValuesInPercentage:
                              showChartValuesInPercentage,
                          showChartValuesOutside: showChartValuesOutside,
                        ),
                        ringStrokeWidth: ringStrokeWidth,
                        emptyColor: Colors.grey,
                        gradientList: showGradientColors ? gradientList : null,
                        emptyColorGradient: const [
                          Color(0xff6c5ce7),
                          Colors.blue,
                        ],
                        baseChartColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              if (!widget.viewsData.packEnable)
                GestureDetector(
                  onTap: () {
                    widget.viewsData.chkTypeSetter('P');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: widget.viewsData.currentChkType == 'P'
                        ? Colors.grey.shade300
                        : Colors.transparent,
                    child: Column(
                      children: [
                        const Text('Pack'),
                        PieChart(
                          key: ValueKey(packKey),
                          dataMap: widget.viewsData.statusReportPieDataPack,
                          animationDuration: const Duration(milliseconds: 800),
                          chartLegendSpacing: chartLegendSpacing,
                          chartRadius: math.min(
                              MediaQuery.of(context).size.width / 3.2, 170),
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: chartType,
                          centerText: showCenterText ? "HYBRID" : null,
                          legendLabels: showLegendLabel ? legendLabels : {},
                          legendOptions: LegendOptions(
                            showLegendsInRow: showLegendsInRow,
                            legendPosition: legendPosition,
                            showLegends: showLegends,
                            legendShape: legendShape == LegendShape.circle
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            legendTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: showChartValueBackground,
                            showChartValues: showChartValues,
                            showChartValuesInPercentage:
                                showChartValuesInPercentage,
                            showChartValuesOutside: showChartValuesOutside,
                          ),
                          ringStrokeWidth: ringStrokeWidth,
                          emptyColor: Colors.grey,
                          gradientList:
                              showGradientColors ? gradientList : null,
                          emptyColorGradient: const [
                            Color(0xff6c5ce7),
                            Colors.blue,
                          ],
                          baseChartColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                width: 40,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 400,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                              'AQL Standard: ${widget.viewsData.getAqlBaseInfoDetail.data?.aqlType ?? ''}'),
                        ),
                        Expanded(
                          child: Text(
                              'Sample Size: ${widget.viewsData.GetAuditHeadDataByIdNewData.data?.sampleSize ?? ''}'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                              'Max Defects Allowed: ${widget.viewsData.getAqlBaseInfoDetail.data?.aqlvmDetlModels?[0].maxAllowOthDefects ?? ''}'),
                        ),
                        // Expanded(
                        //   child: Text(
                        //       'Major Defects Allowed: ${widget.viewsData.getAqlBaseInfoDetail.data?.aqlvmDetlModels?[0].maxAllowOthDefects ?? ''}'),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // if (widget.viewsData.currentChkType != '')
                  Row(
                    children: [
                      Container(
                          width: 400,
                          height: 170,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i <
                                        widget.viewsData
                                            .auditImagesEntityModelsNew.length;
                                    i++)
                                  if (widget
                                          .viewsData
                                          .auditImagesEntityModelsNew[i]
                                          .hostName ==
                                      widget.viewsData.currentChkType)
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Image.network(
                                        (widget
                                                .viewsData
                                                .auditImagesEntityModelsNew[i]
                                                .filePath ??
                                            ''),
                                        height: 110,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            ImagePath.imgThumbnail,
                                            height: 110,
                                          );
                                        },
                                      ),
                                    ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
          if (widget.viewsData.currentChkType == 'V')
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          // width: 100,
                          child: Text(
                            'Defect Description',
                            style: TextStyle(
                                fontSize: 14,
                                color: context.res.color.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          // width: 150,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Critical',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.res.color.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Major',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Minor',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 10),
                  ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                      ?.auditQcDetlModels ??
                                  [])
                              .length) ==
                          0
                      ? const Expanded(
                          child: Center(
                          child: Text(
                            "No Data",
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: (widget
                                      .viewsData
                                      .GetAuditHeadDataByIdNewData
                                      .data
                                      ?.auditQcDetlModels ??
                                  [])
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            if ((widget.viewsData.GetAuditHeadDataByIdNewData
                                            .data?.auditQcDetlModels ??
                                        [])[index]
                                    .chkType ==
                                widget.viewsData.currentChkType) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      // width: 100,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .defectName
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // width: 150,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .critical
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // width: 200,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .major
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // width: 200,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .minor
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )),
                  SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          // width: 100,
                          child: Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 14,
                                color: context.res.color.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          // width: 150,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.viewsData.vCritical.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.res.color.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  widget.viewsData.vMajor.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  widget.viewsData.vMinor.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (widget.viewsData.currentChkType == 'M')
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          // width: 100,
                          child: Text(
                            'Part',
                            style: TextStyle(
                                fontSize: 14,
                                color: context.res.color.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          // width: 150,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Operation',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.res.color.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Deviation',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 10),
                  ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                      ?.auditQcDetlModels ??
                                  [])
                              .length) ==
                          0
                      ? const Expanded(
                          child: Center(
                          child: Text(
                            "No Data",
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: (widget
                                      .viewsData
                                      .GetAuditHeadDataByIdNewData
                                      .data
                                      ?.auditQcDetlModels ??
                                  [])
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            if ((widget.viewsData.GetAuditHeadDataByIdNewData
                                            .data?.auditQcDetlModels ??
                                        [])[index]
                                    .chkType ==
                                widget.viewsData.currentChkType) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      // width: 100,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .partName
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // width: 150,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .operationName
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // width: 200,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .deviation
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )),
                ],
              ),
            ),
          if (widget.viewsData.currentChkType == 'P')
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          // width: 100,
                          child: Text(
                            'Defect Description',
                            style: TextStyle(
                                fontSize: 14,
                                color: context.res.color.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          // width: 150,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Critical',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.res.color.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Major',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Minor',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 10),
                  ((widget.viewsData.GetAuditHeadDataByIdNewData.data
                                      ?.auditQcDetlModels ??
                                  [])
                              .length) ==
                          0
                      ? const Expanded(
                          child: Center(
                          child: Text(
                            "No Data",
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: (widget
                                      .viewsData
                                      .GetAuditHeadDataByIdNewData
                                      .data
                                      ?.auditQcDetlModels ??
                                  [])
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            if ((widget.viewsData.GetAuditHeadDataByIdNewData
                                            .data?.auditQcDetlModels ??
                                        [])[index]
                                    .chkType ==
                                widget.viewsData.currentChkType) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      // width: 100,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .defectName
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // width: 150,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .critical
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // width: 200,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .major
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // width: 200,
                                      child: Text(
                                        (widget
                                                    .viewsData
                                                    .GetAuditHeadDataByIdNewData
                                                    .data
                                                    ?.auditQcDetlModels ??
                                                [])[index]
                                            .minor
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )),
                  SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          // width: 100,
                          child: Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 14,
                                color: context.res.color.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          // width: 150,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.viewsData.pCritical.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.res.color.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  widget.viewsData.pMajor.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          // width: 200,
                          child: GestureDetector(
                            onTap: () {
                              // widget.viewsData.changeInlineSortOP();
                            },
                            child: Row(
                              children: [
                                Text(
                                  widget.viewsData.pMinor.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context.res.color.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
