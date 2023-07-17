import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:qapp/app/features/inline/inline_screen.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
// import 'package:qapp/app/features/inline/inline_screen.dart';
import 'package:qapp/app/features/userboard/userboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';
import 'package:qapp/app/res/images.dart';

class StyleInfoCard extends StatefulWidget {
  final UserboardViewModel views;
  final InlineViewModal inlineViewData;
  const StyleInfoCard(
      {Key? key, required this.views, required this.inlineViewData})
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
    var styleInfo = widget.views.scheduleList.data ?? [];

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
              child: (styleInfo.isEmpty)
                  ? dataIfNotPresent()
                  : Column(
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
                                itemCount:
                                    widget.views.scheduleList.data?.length ?? 0,
                                controller: pageController,
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.views.currentDates,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: context.res.color.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.views.scheduleList
                                                    .data?[index].lineName
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: context.res.color.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.views.scheduleList
                                                    .data?[index].orderNo
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: context.res.color.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.views.scheduleList
                                                    .data?[index].buyerCode
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: context.res.color.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.views.scheduleList
                                                    .data?[index].styleNo
                                                    .toString() ??
                                                '',
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
                                    roundName = widget.views.scheduleList
                                            .data?[index].auditType
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
                                  itemCount:
                                      widget.views.scheduleList.data?.length ??
                                          0,
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
                              widget
                                      .views
                                      .scheduleList
                                      .data?[currentPageNotifier.value]
                                      .auditType ??
                                  '',
                              style: TextStyle(
                                fontSize: 20,
                                color: context.res.color.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const InlineScreen(),
                                      settings: RouteSettings(
                                          arguments:
                                              widget.views.scheduleList.data?[
                                                  currentPageNotifier.value])),
                                ).then((value) {
                                  widget.views.refreshData(context);
                                });
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
                    ),
            ),
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
        const Expanded(
            child: Center(
          child: Text(
            "No Data",
            style: TextStyle(color: Colors.white),
          ),
        ))
      ],
    );
  }
}
