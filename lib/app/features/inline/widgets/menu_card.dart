import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/features/audit/audit_view_model.dart';
import 'package:qapp/app/features/inline/inline_view_model.dart';

class MenuCard extends StatefulWidget {
  final InlineViewModal views;
  final AuditViewModal auditView;
  const MenuCard({
    Key? key,
    required this.views,
    required this.auditView,
  }) : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  void initState() {
    widget.views.getLang();
  }

  @override
  Widget build(BuildContext context) {
    Widget operationWidget() {
      var opData =
          widget.views.getLineQCFrequentUsedOperationsandPartsModel.data ?? [];

      return Container(
          child: !widget.views.isFavLoading
              ? Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: opData.map((item) {
                    // var selected = widget.views.selectFavorite.indexWhere((element) =>
                    //     element.toString() == item.operationCode.toString());
                    // ignore: unrelated_type_equality_checks
                    bool select =
                        widget.views.scoreCardData.operationCode.toString() ==
                                item.operationCode.toString()
                            ? false
                            : true;

                    return GestureDetector(
                      onTap: () {
                        // widget.views.scoreCardData.operationCode
                        // widget.views.selectFavoriteFunction(item.defectCode.toString());
                        widget.views.sleeveValueOnchange(
                            context, item.partCode.toString(), 0);

                        widget.views.sleeveAttachmentValueOnchange(
                            item.operationCode.toString(),
                            item.operationName.toString());
                        widget.views.getOperCodeByPartId(context, item.partId);
                        // widget.views.auditStepUpdate(3);
                      },
                      child: Container(
                        width: 300,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: select ? Colors.white : Colors.grey.shade100,
                            border: Border.all(
                                color: select
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade600)

                            // border: Border.all(color: Colors.grey.shade300)
                            ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xffF7931C),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(item.operationName.toString().length > 35
                                ? '${item.operationName.toString().substring(0, 35)}...'
                                : item.operationName.toString()),
                          ],
                        ),
                      ),
                    );
                  }).toList())
              : Column(
                  children: [
                    const SizedBox(
                      height: 125,
                    ),
                    Container(
                      child: const CircularProgressIndicator(
                        color: Color(0xfff6802a),
                      ),
                    ),
                  ],
                ));
    }

    Widget favWidget() {
      // var favData = widget.views.favoriteData.data ?? [];
      var favData = widget.views.GetFreqUsedDefectsByParamsDetail.data ?? [];
      void favPopup(BuildContext context, String defectCode, bool isFav) {
        exceptionDialog() {
          return Get.defaultDialog(
              content: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.views.showorHideIsFavAPI(
                                  context, defectCode, isFav ? 'N' : 'Y');
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
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

      return Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    widget.views.setisDefectScreen();
                  },
                  child: const Icon(
                    Icons.menu,
                    size: 30,
                  )),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              child: !widget.views.isFavLoading
                  ? Wrap(
                      runSpacing: 5.0,
                      spacing: 5.0,
                      children: favData.map((item) {
                        var selected = widget.views.selectFavorite.indexWhere(
                            (element) =>
                                element.toString() ==
                                item.defectCode.toString());

                        return GestureDetector(
                          onLongPress: () {
                            favPopup(context, item.defectCode.toString(), true);
                          },
                          onTap: () {
                            if (widget.views.tagName.text.isEmpty) {
                              // views.selectAllDefectFunction(item.id.toString());
                              widget.views
                                  .showErrorAlert("Please enter Tag ID");
                            } else if (widget
                                    .views.scoreCardData.partCode?.isEmpty ??
                                false) {
                              widget.views
                                  .showErrorAlert("Please select a part");
                            } else {
                              widget.views.selectFavoriteFunction(
                                  item.defectCode.toString());
                            }
                          },
                          child: Container(
                            width: 300,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: selected == -1
                                    ? Colors.white
                                    : Colors.grey.shade100,
                                border: Border.all(
                                    color: selected == -1
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade600)),
                            child: Row(
                              children: [
                                // const Icon(
                                //   Icons.star,
                                //   color: Color(0xffF7931C),
                                // ),
                                // const SizedBox(
                                //   width: 10,
                                // ),
                                Text(item.translation.toString()),
                              ],
                            ),
                          ),
                        );
                      }).toList())
                  : Column(
                      children: [
                        const SizedBox(
                          height: 125,
                        ),
                        Container(
                          child: const CircularProgressIndicator(
                            color: Color(0xfff6802a),
                          ),
                        ),
                      ],
                    )),
        ],
      );
    }

    Widget allDefWidget() {
      // var allDefData = widget.views.allDefectData.data?.allDefects ?? [];
      var allDefData =
          widget.views.getAllDefectswithFreqUsedDefectsByParamsDetail.data ??
              [];
      // getDefectTranslation
      void favPopup(BuildContext context, String defectCode, bool isFav) {
        exceptionDialog() {
          return Get.defaultDialog(
              content: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.views.showorHideIsFavAPI(
                                  context, defectCode, isFav ? 'N' : 'Y');
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
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

      return Column(
        children: [
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    widget.views.setisDefectScreen();
                  },
                  child: const Icon(
                    Icons.menu,
                    size: 30,
                  )),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              child: !widget.views.isFavLoading
                  ? Wrap(
                      runSpacing: 5.0,
                      spacing: 5.0,
                      children: allDefData.map((item) {
                        var selected = widget.views.selectFavorite.indexWhere(
                            (element) =>
                                element.toString() ==
                                item.defectCode.toString());
                        bool isFav = item.isFav == "Y" ? true : false;
                        return GestureDetector(
                          onLongPress: () {
                            favPopup(
                                context, item.defectCode.toString(), isFav);
                          },
                          onTap: () {
                            if (widget.views.tagName.text.isEmpty) {
                              // views.selectAllDefectFunction(item.id.toString());
                              widget.views
                                  .showErrorAlert("Please enter Tag ID");
                            } else if (widget
                                    .views.scoreCardData.partCode?.isEmpty ??
                                false) {
                              widget.views
                                  .showErrorAlert("Please select a part");
                            } else {
                              widget.views.selectFavoriteFunction(
                                  item.defectCode.toString());
                            }
                          },
                          child: Container(
                            width: 300,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: selected == -1
                                    ? Colors.white
                                    : Colors.grey.shade100,
                                border: Border.all(
                                    color: selected == -1
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade600)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: isFav
                                      ? const Color(0xffF7931C)
                                      : Colors.grey.shade300,
                                  // color: Colors.grey.shade300,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(item.translation.toString()),
                              ],
                            ),
                          ),
                        );
                      }).toList())
                  : Column(
                      children: [
                        const SizedBox(
                          height: 125,
                        ),
                        Container(
                          child: const CircularProgressIndicator(
                            color: Color(0xfff6802a),
                          ),
                        ),
                      ],
                    )),
        ],
      );
    }

    Widget allDefWidgetForEN() {
      var allDefData = widget.views.allDefectData.data?.allDefects ?? [];

      // var allDefData = widget.views.getDefectTranslation.data ?? [];

      return Container(
          child: !!widget.views.isFavLoading
              ? Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: allDefData.map((item) {
                    var selected = widget.views.selectFavorite.indexWhere(
                        (element) =>
                            element.toString() == item.defectCode.toString());
                    var isFav = item.isFav == "Y" ? true : false;
                    return GestureDetector(
                      onTap: () {
                        if (widget.views.tagName.text.isEmpty) {
                          // views.selectAllDefectFunction(item.id.toString());
                          widget.views.showErrorAlert("Please enter Tag ID");
                        } else if (widget
                                .views.scoreCardData.partCode?.isEmpty ??
                            false) {
                          widget.views.showErrorAlert("Please select a part");
                        } else {
                          widget.views.selectFavoriteFunction(
                              item.defectCode.toString());
                        }
                        // views.selectAllDefectFunction(item.id.toString());
                      },
                      child: Container(
                        width: 300,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: selected == -1
                                ? Colors.white
                                : Colors.grey.shade100,
                            border: Border.all(
                                color: selected == -1
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade600)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: isFav
                                  ? const Color(0xffF7931C)
                                  : Colors.grey.shade300,
                              // color: Colors.grey.shade300,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(item.defectName.toString()),
                          ],
                        ),
                      ),
                    );
                  }).toList())
              : Column(
                  children: [
                    const SizedBox(
                      height: 125,
                    ),
                    Container(
                      child: const CircularProgressIndicator(
                        color: Color(0xfff6802a),
                      ),
                    ),
                  ],
                ));
    }

    return Container(
        width: MediaQuery.of(context).size.width * 0.50,
        // color: Color(0xfff6f8fa),
        padding: const EdgeInsets.all(10),
        child: widget.views.auditStep == 2
            ? SizedBox(
                height: 350,
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: operationWidget(),
                  ),
                ),
              )
            : widget.views.auditStep == 3
                ? SizedBox(
                    height: 350,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: favWidget(),
                      // // for (int i = 0; i < favoriteData; i++)
                      //   GestureDetector(
                      //     onTap: () {
                      //       views.selectFavoriteFunction(
                      //           views.favoriteData.data![i].id.toString());
                      //     },
                      //     child: Container(
                      //       width: 300,
                      //       padding: EdgeInsets.all(20),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(
                      //               color: true
                      //                   ? Colors.grey.shade300
                      //                   : Colors.white)),
                      //       child: Row(
                      //         children: [
                      //           Icon(
                      //             Icons.star,
                      //             color: Color(0xffF7931C),
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Text(views.favoriteData.data![i].defectName
                      //               .toString()),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                    ),
                  )
                : widget.views.auditStep == 4
                    ? Column(
                        children: [
                          Visibility(
                            // visible: widget.views.lang == "EN" ? true : false,
                            visible: false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      controller:
                                          widget.views.defectSearchController,
                                      onChanged: (value) {
                                        widget.views
                                            .defectSearchFunction(value);
                                      },
                                      decoration: const InputDecoration(
                                        suffixIcon: Icon(Icons.search),
                                        labelText: 'Defect search',
                                        border: InputBorder.none,
                                      ),
                                    )),
                                const SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  child: widget.views.allDefectData.data
                                              ?.categories ==
                                          null
                                      ? DropdownButton<String>(
                                          isExpanded: true,
                                          hint: const Text("Defect Category"),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          elevation: 16,
                                          underline: Container(),
                                          onChanged: (String? newValue) {},
                                          items: [].map((item) {
                                            return const DropdownMenuItem(
                                              value: "",
                                              child: Text(""),
                                            );
                                          }).toList(),
                                        )
                                      : DropdownButton<String>(
                                          value: widget.views.defaultCategory,
                                          isExpanded: true,
                                          hint: const Text("Defect Category"),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          elevation: 16,
                                          underline: Container(),
                                          onChanged: (String? newValue) {
                                            widget.views.defectCategoryOnChange(
                                                newValue.toString());
                                          },
                                          items: widget.views.allDefectData.data
                                              ?.categories!
                                              .map((item) {
                                            return DropdownMenuItem(
                                              value: item.toString(),
                                              child: Text(item.toString()),
                                            );
                                          }).toList(),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 320,
                            child: SingleChildScrollView(
                                child: Column(
                              children: [
                                allDefWidget(),
                                // Visibility(
                                //   visible: widget.views.lang == "EN" ? false : true,
                                //   child: allDefWidget(),
                                // ),
                                // Visibility(
                                //   visible: widget.views.lang == "EN" ? true : false,
                                //   child: allDefWidgetForEN(),
                                // ),
                              ],
                            )),
                          )
                        ],
                      )
                    : widget.views.auditStep == 5
                        ? TextField(
                            cursorColor: Colors.black,
                            controller: widget.views.remarkController,
                            onChanged: (value) {
                              widget.views.remarksOnChange(value);
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your comments and feedback here',
                            ),
                          )
                        : widget.views.auditStep == 6
                            ? widget.views.defectImage != null
                                ? Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Image.file(
                                            widget.views.defectImage!,
                                            height: 300,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 20, left: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                            child: IconButton(
                                                onPressed: () {
                                                  widget.views
                                                      .clearDefectImage();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : InkWell(
                                    onTap: () {
                                      widget.views.getImage(context);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 25),
                                      padding: const EdgeInsets.all(110.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Column(
                                        children: const [
                                          Icon(Icons.camera_alt_outlined),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text('Open Camera')
                                        ],
                                      ),
                                    ))
                            : const Text('')
        // : Column(
        //     children: [
        //       Container(
        //         color: Color(0xfff6f8fa),
        //         child: TextField(
        // cursorColor: Colors.black,
        //           keyboardType: TextInputType.multiline,
        //           maxLines: null,
        //         ),
        //       )
        //     ],
        //   )

        );
  }
}
