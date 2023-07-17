import 'package:flutter/material.dart';

import '../cutinspection_view_model.dart';

class InfoCard extends StatefulWidget {
  final CutInspectionViewModel views;
  const InfoCard({required this.views, Key? key}) : super(key: key);

  @override
  State<InfoCard> createState() => InfoCardState();
}

class InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            child: SizedBox(
      height: 550,
      width: MediaQuery.of(context).size.width,
      child: Column(children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Unit Code'),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xfff6fafd),
                      child: DropdownButton<String>(
                        value: widget.views.savecutInspection.unitCode,
                        isExpanded: true,
                        hint: const Text("Select "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        items: (widget.views.GetAllActiveFactoryData.data ?? [])
                            .map((item) {
                          return DropdownMenuItem(
                            value: item.uCode.toString(),
                            onTap: () {},
                            child: Text(item.uCode.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          widget.views
                              .unitCodeOnchange(context, newValue ?? '');
                        },
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              widget.views.showDate(context, true);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(right: 20),
                                color: const Color(0xfff6fafd),
                                child: Row(
                                  children: [
                                    Text((widget.views.savecutInspection
                                                    .transDate ??
                                                '')
                                            .isNotEmpty
                                        ? (widget.views.savecutInspection
                                                .transDate ??
                                            '')
                                        : 'Select'),
                                    const Spacer(),
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey.shade600,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Buyer Division'),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: widget.views.getBuyerFromOrderRegDetail.data ==
                              null
                          ? DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text("Select Division"),
                              icon: const Icon(Icons.keyboard_arrow_down),
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
                              isExpanded: true,
                              value: (widget.views.savecutInspection
                                              .buyerCode ??
                                          '')
                                      .isEmpty
                                  ? null
                                  : (widget.views.savecutInspection.buyerCode ??
                                          '')
                                      .toString(),
                              hint: const Text("Select Division"),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              elevation: 16,
                              underline: Container(),
                              onChanged: (String? val) {
                                widget.views.getOrderRegWithbuyer(
                                    val.toString(), context);
                              },
                              items: widget
                                  .views.getBuyerFromOrderRegDetail.data
                                  ?.map((item) {
                                return DropdownMenuItem(
                                  value: item.buyDivCode.toString(),
                                  child: Text(item.buyDivCode.toString()),
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Style No / Order No'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: (widget.views.savecutInspection.styleNo ?? '')
                                .isEmpty
                            ? null
                            : (widget.views.savecutInspection.styleNo ?? '')
                                .toString(),
                        hint: const Text("Select Style "),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        underline: Container(),
                        onChanged: (String? val) {},
                        items: widget.views.getOrderRegWithbuyerDetail.data
                            ?.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              widget.views.getDsList(
                                context,
                                item.orderno,
                              );

                              widget.views.getOrderRegWithbuyerOnchange(
                                  item.styleNo.toString(),
                                  item.orderno.toString(),
                                  context);
                            },
                            value: (item.styleNo ?? '').toString(),
                            child: Text(
                                '${item.styleNo ?? ''} / ${item.orderno ?? 0}'),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
        const Text(''),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Color'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color(0xfff6fafd),
                  child: widget.views.getDsData.data?.colorlist == null
                      ? DropdownButton<String>(
                          value: "",
                          isExpanded: true,
                          hint: const Text("Select Color"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          items: [].map((item) {
                            return const DropdownMenuItem(
                              value: "",
                              child: Text(""),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        )
                      : DropdownButton<String>(
                          isExpanded: true,
                          value: (widget.views.savecutInspection.color ?? '')
                                  .isEmpty
                              ? null
                              : (widget.views.savecutInspection.color ?? '')
                                  .toString(),
                          hint: const Text("Select Color"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          onChanged: (String? newValue) {
                            widget.views.colorValueOnchange(
                                context, newValue.toString());
                          },
                          items: widget.views.getDsData.data?.colorlist
                              ?.map((item) {
                            return DropdownMenuItem(
                              value: item.toString(),
                              child: Text(item.toString()),
                            );
                          }).toList(),
                        ),
                ),
              ],
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fit'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color(0xfff6fafd),
                  child: widget.views.getDsData.data?.fitlist == null
                      ? DropdownButton<String>(
                          value: "",
                          isExpanded: true,
                          hint: const Text("Select Fit"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          items: [].map((item) {
                            return const DropdownMenuItem(
                              value: "",
                              child: Text(""),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        )
                      : DropdownButton<String>(
                          isExpanded: true,
                          value:
                              (widget.views.savecutInspection.fit ?? '').isEmpty
                                  ? null
                                  : (widget.views.savecutInspection.fit ?? '')
                                      .toString(),
                          hint: const Text("Select Fit"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          underline: Container(),
                          onChanged: (String? newValue) {
                            widget.views
                                .fitOnchange(context, newValue.toString());
                          },
                          items:
                              widget.views.getDsData.data?.fitlist?.map((item) {
                            return DropdownMenuItem(
                              value: item.toString(),
                              child: Text(item.toString()),
                            );
                          }).toList(),
                        ),
                ),
              ],
            )),
            const SizedBox(
              width: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Major Parts'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 200,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          controller: widget.views.majorparts,
                          onChanged: (value) {
                            widget.views
                                .majorpartsonChange(context, int.parse(value));
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true, //<-- SEE HERE
                            fillColor: Color(0xfff6fafd), //<-- SEE HERE
                          ),
                        ))
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Marker'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 200,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          controller: widget.views.marker,
                          onChanged: (value) {
                            widget.views
                                .markeronChange(context, int.parse(value));
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true, //<-- SEE HERE
                            fillColor: Color(0xfff6fafd), //<-- SEE HERE
                          ),
                        ))
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('NCR %'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 200,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          controller: widget.views.ncrper,
                          cursorColor: Colors.black,
                          onChanged: (value) {
                            widget.views.ncronChange(context, int.parse(value));
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true, //<-- SEE HERE
                            fillColor: Color(0xfff6fafd), //<-- SEE HERE
                          ),
                        ))
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const Text(''),
        const Row(
          children: [
            Text(
              'Panel Replacement',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Spacer(),
          ],
        ),
        const Text(''),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cut No'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    // width: 200,
                    child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  controller: widget.views.cutno,
                  onChanged: (value) {
                    widget.views.cutonChange(context, int.parse(value));
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true, //<-- SEE HERE
                    fillColor: Color(0xfff6fafd), //<-- SEE HERE
                  ),
                ))
              ],
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Inspected Panels'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    // width: 200,
                    child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  controller: widget.views.totalpanels,
                  onChanged: (value) {
                    widget.views.totalonChange(context, int.parse(value));
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true, //<-- SEE HERE
                    fillColor: Color(0xfff6fafd), //<-- SEE HERE
                  ),
                ))
              ],
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Defective Panels'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    // width: 200,
                    child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  controller: widget.views.defectivepanels,
                  onChanged: (value) {
                    widget.views.defectonChange(context, int.parse(value));
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true, //<-- SEE HERE
                    fillColor: Color(0xfff6fafd), //<-- SEE HERE
                  ),
                ))
              ],
            )),
            const SizedBox(
              width: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                _listItem1(context, () {} as int);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color(0xffF06434),
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        const Text(''),
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // ignore: prefer_const_constructors
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Style No',
                      // style: TextStyle(color: Color(0xffffffff)),
                    )),
                    Expanded(
                        child: Text(
                      'Color',
                      //  style: TextStyle(color: Color(0xffffffff)),
                    )),
                    Expanded(
                        child: Text(
                      'Fit',
                      // style: TextStyle(color: Color(0xffffffff)),
                    )),
                    Expanded(
                        child: Text(
                      'Cut No',
                      //  style: TextStyle(color: Color(0xffffffff)),
                    )),
                    Expanded(
                        child: Text(
                      'Ins Panels',
                      //  style: TextStyle(color: Color(0xffffffff)),
                    )),
                    Expanded(
                        child: Text(
                      'Defective Panels',
                      //  style: TextStyle(color: Color(0xffffffff)),
                    )),
                    Expanded(
                        child: Text('Date'
                            //  style: TextStyle(color: Color(0xffffffff)),
                            )),
                    Expanded(
                        child: Text(
                      'Action',
                      //  style: TextStyle(color: Color(0xffffffff)),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        (widget.views.getProdSamCutInspectionByparams.data?.length ?? 0) == 0
            ? const Expanded(
                child: Center(
                child: Text(
                  "No Data",
                  style: TextStyle(color: Colors.black),
                ),
              ))
            : SizedBox(
                height: MediaQuery.of(context).size.height / 9,
                child: Expanded(
                    child: ListView.builder(
                  itemCount: widget
                          .views.getProdSamCutInspectionByparams.data?.length ??
                      0,
                  itemBuilder: (BuildContext context, int index) {
                    return _listItem(context, index);
                  },
                )),
              ),
        const Spacer(),
        Container(
            alignment: Alignment.centerRight,
            child: Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.views.postSaveCutInspection(context, () {});
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xffF06434),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ))
      ]),
    )));
  }

  _listItem(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.views.getProdSamCutInspectionByparams.data?[index].styleNo
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.getProdSamCutInspectionByparams.data?[index].color
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.getProdSamCutInspectionByparams.data?[index].fit
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.getProdSamCutInspectionByparams.data?[index].cutNo
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.getProdSamCutInspectionByparams.data?[index]
                    .totalInsPanels
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.getProdSamCutInspectionByparams.data?[index]
                    .defectivePanels
                    .toString() ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.getProdSamCutInspectionByparams.data?[index].transDate
                    .toString()
                    .substring(0, 10) ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.views.getCutById(
                      widget.views.getProdSamCutInspectionByparams.data?[index]
                          .id as int,
                      'ProdSamCutInspection/GetProdSamCutInspectionByIdNew/',
                      context);
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const InlineScreen(),
                          settings: RouteSettings(
                              arguments:
                              (views.scheduleList.data ??
                                  [])[index])));*/
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    // color: context.res.color.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      // color: context.res.color.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _listItem1(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.views.savecutInspection.styleNo.toString() ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.savecutInspection.color.toString() ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.savecutInspection.fit.toString() ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.savecutInspection.cutNo.toString() ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.savecutInspection.totalInsPanels.toString() ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.savecutInspection.defectivePanels.toString() ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.views.savecutInspection.transDate
                    .toString()
                    .substring(0, 10) ??
                "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.views.getCutById(
                      widget.views.savecutInspection.id as int,
                      'ProdSamCutInspection/GetProdSamCutInspectionByIdNew/',
                      context);
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const InlineScreen(),
                          settings: RouteSettings(
                              arguments:
                              (views.scheduleList.data ??
                                  [])[index])));*/
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    // color: context.res.color.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      // color: context.res.color.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
