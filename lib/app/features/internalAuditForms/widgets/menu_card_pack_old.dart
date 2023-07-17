import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/app/features/internalAuditForms/internal_audit_view_model.dart';

class MenuCardPack extends StatefulWidget {
  final InternalAuditViewModal views;
  const MenuCardPack({
    Key? key,
    required this.views,
  }) : super(key: key);

  @override
  State<MenuCardPack> createState() => _MenuCardPackState();
}

class _MenuCardPackState extends State<MenuCardPack> {
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
                        widget.views.saveAuditData.operationCode.toString() ==
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

                        // widget.views.getOperCodeByPartId(context, item.partId);
                        // widget.views.auditStepUpdate(3);
                      },
                      child: Container(
                        width: 265,
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
      var favData = widget.views.packingDefectFav;
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

      return Container(
          child: !widget.views.isFavLoading
              ? Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: favData.map((item) {
                    var selected = widget.views.selectDefect.indexWhere(
                        (element) =>
                            element.toString() == item.defectCode.toString());
                    var title = item.translation.toString().characters.take(20);
                    // bool isFav = item.isFav == "Y" ? true : false;
                    if (item.isFav == 'Y') {
                      return GestureDetector(
                        // onLongPress: (() {
                        //   favPopup(context, item.defectCode.toString(),
                        //       item.isFav == 'Y' ? true : false);
                        // }),
                        onLongPress: (() {
                          favPopup(context, item.defectCode.toString(), true);
                        }),
                        onTap: () {
                          widget.views.selectPackDefectFunction(
                              item.defectCode.toString(),
                              item.defectLevel.toString(),
                              item.defectCategory.toString(),
                              context);
                        },
                        child: Container(
                          width: 265,
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
                              Text(title.toString()),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
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

    Widget allDefWidget() {
      var allDefData = widget.views.packingDefect;
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

      return Container(
          child: !widget.views.isFavLoading
              ? Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: allDefData.map((item) {
                    var selected = widget.views.selectDefect.indexWhere(
                        (element) =>
                            element.toString() == item.defectCode.toString());
                    var title = item.translation.toString().characters.take(20);
                    bool isFav = item.isFav == "Y" ? true : false;

                    return GestureDetector(
                      onLongPress: (() {
                        favPopup(context, item.defectCode.toString(), isFav);
                      }),
                      onTap: () {
                        print(item.isFav);
                        widget.views.selectPackDefectFunction(
                            item.defectCode.toString(),
                            item.defectLevel.toString(),
                            item.defectCategory.toString(),
                            context);
                        // views.selectAllDefectFunction(item.id.toString());
                      },
                      child: Container(
                        width: 250,
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
                                  : Colors.grey.shade400,
                              // color: Colors.grey.shade400,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(title.toString()),
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
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(20),
        color: const Color(0xfff6f8fa),
        height: 320,
        child: widget.views.defectState == 2
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: operationWidget(),
              )
            : widget.views.defectState == 3
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: favWidget(),
                  )
                : widget.views.defectState == 4
                    ? Column(
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Container(
                          //         width: 500,
                          //         padding:
                          //             const EdgeInsets.symmetric(horizontal: 10),
                          //         decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             border:
                          //                 Border.all(color: Colors.grey.shade300)),
                          //         child: TextField(
                          //           cursorColor: Colors.black,
                          //           controller: widget.views.defectSearchController,
                          //           onChanged: (value) {
                          //             widget.views
                          //                 .packingDefectSearchFunction(value);
                          //           },
                          //           decoration: const InputDecoration(
                          //             suffixIcon: Icon(Icons.search),
                          //             labelText: 'Defect search',
                          //             border: InputBorder.none,
                          //           ),
                          //         )),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          SizedBox(
                            height: 255,
                            child: SingleChildScrollView(
                              child: allDefWidget(),
                            ),
                          )
                        ],
                      )
                    : widget.views.defectState == 4
                        ? TextField(
                            cursorColor: Colors.black,
                            controller: widget.views.comment,
                            onChanged: (value) {
                              widget.views.commentChange(value);
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your comments and feedback here',
                            ),
                          )
                        : widget.views.defectState == 5
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
                                      padding: const EdgeInsets.all(100.0),
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
                            : const Text(''));
  }
}
