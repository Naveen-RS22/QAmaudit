import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:qapp/app/features/iaDashboard/ia_dashboard_view_model.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_screen.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/images.dart';

class StyleInfoCard extends StatefulWidget {
  final IADashboardViewModel views;
  final InlineViewModal inlineViewData;
  final InternalAuditViewModal iaViewData;
  const StyleInfoCard(
      {Key? key,
      required this.views,
      required this.inlineViewData,
      required this.iaViewData})
      : super(key: key);

  @override
  State<StyleInfoCard> createState() => _StyleInfoCardState();
}

class _StyleInfoCardState extends State<StyleInfoCard> {
  final pageController = PageController(keepPage: true);
  var currentPageNotifier = ValueNotifier<int>(0);
  var roundName = '';

  @override
  Widget build(BuildContext context) {
    var styleInfo = widget.views.getAuditStyleDetail.data ?? [];

    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 150.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                colors: [
                  context.res.color.cardGradStart,
                  context.res.color.cardGradEnd
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (styleInfo.isNotEmpty)
                    ? dataIfPresent()
                    : dataIfNotPresent()),
          ),
        ),
      ),
    );
  }

  dataIfNotPresent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Style Information',
              style: TextStyle(
                fontSize: 20,
                color: context.res.color.white,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                widget.views.setStyleInfoExpanded();
              },
              child: SvgPicture.asset(ImagePath.expandIcon),
            )
          ],
        ),
        const SizedBox(height: 10),
        Divider(
          height: 1,
          color: context.res.color.white,
        ),
        const SizedBox(height: 10),
        Expanded(
            child: Center(
          child: GestureDetector(
            onTap: () {
              // widget.views.getAuditStyle(context, "2022-04-27", "MATHAN");
            },
            child: const Text(
              "No Data",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )),
      ],
    );
  }

  dataIfPresent() {
    DateTime dateToday = DateTime.now();
    String currentDate = dateToday.toString().substring(0, 10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Style Information',
              style: TextStyle(
                fontSize: 20,
                color: context.res.color.white,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                widget.views.setStyleInfoExpanded();
              },
              child: SvgPicture.asset(ImagePath.expandIcon),
            )
          ],
        ),
        const SizedBox(height: 5),
        Divider(
          height: 1,
          color: context.res.color.white,
        ),
        const SizedBox(height: 5),
        Expanded(
            child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.views.getAuditStyleDetail.data?.length ?? 0,
                controller: pageController,
                itemBuilder: (BuildContext context, int index) {
                  var po = widget
                      .views.getAuditStyleDetail.data?[index].buyerpono
                      .toString();
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.views.getAuditStyleDetail.data?[index]
                                    .schDate
                                    .toString()
                                    .substring(0, 10) ??
                                (index == 0 ? "-" : "-"),
                            style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            // widget.views.getAuditStyleDetail.data?[index]
                            //             .insType
                            //             .toString() ==
                            //         "F"
                            //     ? "Final"
                            //     : widget.views.getAuditStyleDetail.data?[index]
                            //                 .insType
                            //                 .toString() ==
                            //             "PF"
                            //         ? "Prefinal"
                            //         : widget.views.getAuditStyleDetail
                            //                     .data?[index].insType
                            //                     .toString() ==
                            //                 "I"
                            //             ? "interim"
                            //             : widget.views.getAuditStyleDetail
                            //                         .data?[index].insType
                            //                         .toString() ==
                            //                     "HF"
                            //                 ? "100 pcs"
                            //                 : "pilot run",

                            widget.views.getAuditStyleDetail.data?[index]
                                        .insType
                                        .toString() ==
                                    "F"
                                ? "Final"
                                : widget.views.getAuditStyleDetail.data?[index]
                                            .insType
                                            .toString() ==
                                        "PF"
                                    ? "Pre final"
                                    : widget.views.getAuditStyleDetail
                                                .data?[index].insType
                                                .toString() ==
                                            "I"
                                        ? "Interim"
                                        : widget.views.getAuditStyleDetail
                                                    .data?[index].insType
                                                    .toString() ==
                                                "HP"
                                            ? "100 pcs"
                                            : widget.views.getAuditStyleDetail
                                                        .data?[index].insType
                                                        .toString() ==
                                                    "PR"
                                                ? "Pilor run"
                                                : "",
                            style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.views.getAuditStyleDetail.data?[index]
                                    .buycode
                                    .toString() ??
                                (index == 0 ? "-" : "-"),
                            style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${widget.views.getAuditStyleDetail.data?[index].styleno} / ${widget.views.getAuditStyleDetail.data?[index].orderno}",
                            style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            po.toString().length > 24
                                ? "${po.toString().characters.take(25)}..."
                                : po.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: context.res.color.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
                },
                onPageChanged: (int index) {
                  setState(() {
                    roundName = widget
                            .views.getAuditStyleDetail.data?[index].styleno
                            .toString() ??
                        '';
                  });
                  currentPageNotifier.value = index;
                }),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CirclePageIndicator(
                  itemCount: widget.views.getAuditStyleDetail.data?.length ?? 0,
                  dotColor: Colors.white.withOpacity(0.1),
                  selectedDotColor: Colors.white,
                  currentPageNotifier: currentPageNotifier,
                ),
              ),
            ),
          ],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ((widget.views.getAuditStyleDetail
                                  .data?[currentPageNotifier.value].styleno
                                  .toString() ??
                              '-'))
                          .length >
                      15
                  ? '${((widget.views.getAuditStyleDetail.data?[currentPageNotifier.value].styleno.toString() ?? '-')).characters.take(15)}...'
                  : ((widget.views.getAuditStyleDetail
                          .data?[currentPageNotifier.value].styleno
                          .toString() ??
                      '-')),
              style: TextStyle(
                fontSize: 20,
                color: context.res.color.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                // widget.views.getSchduleList(context);
                // if (styleInfo.isNotEmpty) {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InternalAuditScreen(),
                      settings: RouteSettings(
                          arguments:
                              widget.views.getAuditStyleDetail.data?[3])),
                ).then((value) {
                  widget.views.refreshData(context);
                });

                // }
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: context.res.color.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: context.res.color.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
