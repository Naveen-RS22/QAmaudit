import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';
import 'package:qapp/app/res/images.dart';
import '../../../res/styles.dart';

class InlineDefectScreen extends StatefulWidget {
  final InlineViewModal viewsData;

  const InlineDefectScreen({Key? key, required this.viewsData})
      : super(key: key);

  @override
  _InlineDefectScreenState createState() => _InlineDefectScreenState();
}

class _InlineDefectScreenState extends State<InlineDefectScreen> {
  void favPopupAllDefects(BuildContext context, String defectCode, bool isFav) {
    exceptionDialog() {
      return Get.defaultDialog(
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              // margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    isFav
                        ? 'Remove from frequent defects list?'
                        : 'Add to frequent defects list?',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.viewsData.showorHideIsFavAPI(
                              context, defectCode, isFav ? 'N' : 'Y');
                        },
                        child: Center(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffF7931C),
                                  Color(0xffF57234),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Confirm',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          title: "",
          confirmTextColor: const Color(0xffffffff),
          cancelTextColor: const Color(0xffF7931C),
          buttonColor: const Color(0xffF7931C));
    }

    exceptionDialog();
  }

  @override
  Widget build(BuildContext context) {
    return _finalAuditWidget(context);
  }

  _finalAuditWidget(BuildContext context) => Container(
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
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setCurrentDefectScreen(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: widget.viewsData.currentDefectScreen == 1
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'Frequently Used Defects',
                      style: widget.viewsData.currentDefectScreen == 1
                          ? Styles.headingStyle
                          : Styles.paragraphStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setCurrentDefectScreen(2);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: widget.viewsData.currentDefectScreen == 2
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'All Defects',
                      style: widget.viewsData.currentDefectScreen == 2
                          ? Styles.headingStyle
                          : Styles.paragraphStyle,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 200,
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                      cursorColor: Colors.black,
                      controller: widget.viewsData.defectsSearchController,
                      onChanged: (search) {
                        widget.viewsData
                            .getAllDefectswithFreqUsedDefectsByParamsSearch(
                                search);
                        widget.viewsData
                            .GetFreqUsedDefectsByParamsDetailSearxh(search);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setisDefectScreen();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            Expanded(
              child: widget.viewsData.currentDefectScreen == 1
                  ? freqDefectsWidget(context)
                  : widget.viewsData.currentDefectScreen == 2
                      ? allDefectsWidget(context)
                      : Container(),
            )
          ],
        ),
      );

  freqDefectsWidget(BuildContext context) => Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  for (int i = 0;
                      i <
                          (widget.viewsData
                                  .GetFreqUsedDefectsByParamsDetailFiltered)
                              .length;
                      i++)
                    GestureDetector(
                      onLongPress: () {
                        favPopupAllDefects(
                            context,
                            ((widget.viewsData
                                        .GetFreqUsedDefectsByParamsDetailFiltered)[i]
                                    .defectCode ??
                                ''),
                            true);
                      },
                      onTap: () {
                        if (widget.viewsData.tagName.text.isEmpty) {
                          // views.selectAllDefectFunction(item.id.toString());
                          widget.viewsData
                              .showErrorAlert("Please enter Tag ID");
                        } else if (widget
                                .viewsData.scoreCardData.partCode?.isEmpty ??
                            false) {
                          widget.viewsData
                              .showErrorAlert("Please select a part");
                        } else {
                          widget.viewsData.selectFavoriteFunction(((widget
                                      .viewsData
                                      .GetFreqUsedDefectsByParamsDetailFiltered)[i]
                                  .defectCode ??
                              ''));
                        }
                      },
                      child: Container(
                        height: 175,
                        width: 220,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: ((widget.viewsData
                                                      .GetFreqUsedDefectsByParamsDetailFiltered)[i]
                                                  .filePath ??
                                              '')
                                          .isEmpty
                                      ? Image.asset(
                                          ImagePath.imgThumbnail,
                                          height: 110,
                                        )
                                      :
                                      // Image.network(
                                      //     ((widget.viewsData
                                      //                 .GetFreqUsedDefectsByParamsDetailFiltered)[i]
                                      //             .filePath ??
                                      //         ''),
                                      //     // 'https://assets-in.bmscdn.com/discovery-catalog/events/et00348725-bewjegqfhz-landscape.jpg',
                                      //     height: 110,
                                      //     // fit: BoxFit.contain,
                                      //   )
                                      Image.network(
                                          ((widget.viewsData
                                                      .GetFreqUsedDefectsByParamsDetailFiltered)[i]
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
                                // Align(
                                //   alignment: Alignment.topRight,
                                //   child: Container(
                                //     padding: const EdgeInsets.all(10),
                                //     child: Image.asset(
                                //         ((widget.viewsData.GetFreqUsedDefectsByParamsDetail
                                //                                     .data ??
                                //                                 [])[i]
                                //                             .defectCategory ??
                                //                         '')
                                //                     .toUpperCase() ==
                                //                 'Y'
                                //             ? ImagePath.defectisFav
                                //             : ImagePath.defectNotFav),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(((widget.viewsData
                                                                .GetFreqUsedDefectsByParamsDetailFiltered)[
                                                            i]
                                                        .defectName ??
                                                    '')
                                                .length >
                                            25
                                        ? '${((widget.viewsData.GetFreqUsedDefectsByParamsDetailFiltered)[i].defectName ?? '').characters.take(20)}...'
                                        : (widget.viewsData
                                                    .GetFreqUsedDefectsByParamsDetailFiltered)[i]
                                                .defectName ??
                                            ''),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  if (widget.viewsData.selectFavorite
                                          .indexWhere((element) =>
                                              element.toString() ==
                                              (widget.viewsData
                                                      .GetFreqUsedDefectsByParamsDetailFiltered)[i]
                                                  .defectCode) !=
                                      -1)
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green,
                                    ),
                                  if (widget.viewsData.selectFavorite
                                          .indexWhere((element) =>
                                              element.toString() ==
                                              (widget.viewsData
                                                      .GetFreqUsedDefectsByParamsDetailFiltered)[i]
                                                  .defectCode) ==
                                      -1)
                                    Icon(
                                      Icons.circle,
                                      color: Colors.grey.shade300,
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 25,
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      (widget.viewsData.selectFavorite.length).toString(),
                      style: const TextStyle(
                          fontSize: 32, color: Color(0xffF06434)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'No of Defects Selected',
                          style: TextStyle(color: Color(0xff919191)),
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.cancelDefectScreenAndClearDefects();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1)),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setisDefectScreen();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xffF06434),
                        border: Border.all(
                            color: const Color(0xffF06434), width: 1)),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );

  allDefectsWidget(BuildContext context) => Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  for (int i = 0;
                      i <
                          (widget.viewsData
                                  .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)
                              .length;
                      i++)
                    GestureDetector(
                      onLongPress: () {
                        favPopupAllDefects(
                            context,
                            ((widget.viewsData
                                            .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[
                                        i]
                                    .defectCode ??
                                ''),
                            ((widget.viewsData.getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[
                                                    i]
                                                .isFav ??
                                            '')
                                        .toUpperCase() ==
                                    'Y'
                                ? true
                                : false);
                      },
                      onTap: () {
                        if (widget.viewsData.tagName.text.isEmpty) {
                          // views.selectAllDefectFunction(item.id.toString());
                          widget.viewsData
                              .showErrorAlert("Please enter Tag ID");
                        } else if (widget
                                .viewsData.scoreCardData.partCode?.isEmpty ??
                            false) {
                          widget.viewsData
                              .showErrorAlert("Please select a part");
                        } else {
                          widget.viewsData.selectFavoriteFunction(((widget
                                      .viewsData
                                      .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[i]
                                  .defectCode ??
                              ''));
                        }
                      },
                      child: Container(
                        height: 175,
                        width: 220,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: ((widget.viewsData
                                                      .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[i]
                                                  .filePath ??
                                              '')
                                          .isEmpty
                                      ? Image.asset(
                                          ImagePath.imgThumbnail,
                                          height: 110,
                                        )
                                      :
                                      // Image.network(
                                      //     ((widget.viewsData
                                      //                 .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[i]
                                      //             .filePath ??
                                      //         ''),
                                      //     // 'https://assets-in.bmscdn.com/discovery-catalog/events/et00348725-bewjegqfhz-landscape.jpg',
                                      //     height: 110,
                                      //     // fit: BoxFit.contain,
                                      //   ),
                                      Image.network(
                                          ((widget.viewsData
                                                      .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[i]
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
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                        ((widget.viewsData.getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[
                                                                i]
                                                            .isFav ??
                                                        '')
                                                    .toUpperCase() ==
                                                'Y'
                                            ? ImagePath.defectisFav
                                            : ImagePath.defectNotFav),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(((widget.viewsData
                                                                .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[
                                                            i]
                                                        .defectName ??
                                                    '')
                                                .length >
                                            25
                                        ? '${((widget.viewsData.getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[i].defectName ?? '').characters.take(20)}...'
                                        : (widget.viewsData
                                                    .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[i]
                                                .defectName ??
                                            ''),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  if (widget.viewsData.selectFavorite
                                          .indexWhere((element) =>
                                              element.toString() ==
                                              (widget.viewsData
                                                      .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[i]
                                                  .defectCode) !=
                                      -1)
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green,
                                    ),
                                  if (widget.viewsData.selectFavorite
                                          .indexWhere((element) =>
                                              element.toString() ==
                                              (widget.viewsData
                                                      .getAllDefectswithFreqUsedDefectsByParamsDetailFiltered)[i]
                                                  .defectCode) ==
                                      -1)
                                    Icon(
                                      Icons.circle,
                                      color: Colors.grey.shade300,
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 25,
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      (widget.viewsData.selectFavorite.length).toString(),
                      style: const TextStyle(
                          fontSize: 32, color: Color(0xffF06434)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'No of Defects Selected',
                          style: TextStyle(color: Color(0xff919191)),
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.cancelDefectScreenAndClearDefects();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1)),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    widget.viewsData.setisDefectScreen();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xffF06434),
                        border: Border.all(
                            color: const Color(0xffF06434), width: 1)),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
