import 'package:flutter/material.dart';
import 'package:qapp/app/features/ImageGallery/imagegallery_view_model.dart';

class InfoCard extends StatefulWidget {
  final ImageGalleryViewModal views;
  const InfoCard({required this.views, Key? key}) : super(key: key);

  @override
  State<InfoCard> createState() => InfoCardState();
}

class InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Text('Type')),
            if ((widget.views.getGalleryListData.audittype ?? '') == 'IA')
              const Expanded(child: Text('Ins Type')),
            const Expanded(child: Text('Buyer Division')),
            const Expanded(child: Text('Order / Style No')),
            const Expanded(child: Text('Line')),
            const Expanded(child: Text('Defect')),
            const Expanded(child: Text('From Date')),
            const Expanded(child: Text('To Date')),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(right: 20),
                color: const Color(0xfff6fafd),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value:
                      (widget.views.getGalleryListData.audittype ?? '').isEmpty
                          ? null
                          : (widget.views.getGalleryListData.audittype ?? '')
                              .toString(),
                  hint: const Text("Select"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(),
                  onChanged: (String? val) {
                    widget.views.changeAuditType(val.toString());
                  },
                  items:
                      (widget.views.getAllAuditTypeData.data ?? []).map((item) {
                    return DropdownMenuItem(
                      value: item.auditCode.toString(),
                      child: Text(item.auditName.toString()),
                    );
                  }).toList(),
                ),
              ),
            ),
            if ((widget.views.getGalleryListData.audittype ?? '') == 'IA')
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(right: 20),
                  color: const Color(0xfff6fafd),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value:
                        (widget.views.getGalleryListData.instype ?? '').isEmpty
                            ? null
                            : (widget.views.getGalleryListData.instype ?? '')
                                .toString(),
                    hint: const Text("Select"),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? val) {
                      widget.views.changeInsType(val.toString());
                    },
                    items: (widget.views.insType).map((item) {
                      return DropdownMenuItem(
                        value: item.key.toString(),
                        child: Text(item.value.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(right: 20),
                color: const Color(0xfff6fafd),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: (widget.views.getGalleryListData.buyerdivision ?? '')
                          .isEmpty
                      ? null
                      : (widget.views.getGalleryListData.buyerdivision ?? '')
                          .toString(),
                  hint: const Text("Select"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(),
                  onChanged: (String? val) {
                    widget.views.changeBuyerDiv(context, val.toString());
                  },
                  items: (widget.views.getAllBuyerDivInfoData.data ?? [])
                      .map((item) {
                    return DropdownMenuItem(
                      value: item.buyerCode.toString(),
                      child: Text(item.buyerCode.toString()),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(right: 20),
                color: const Color(0xfff6fafd),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: (widget.views.getGalleryListData.orderno ?? '').isEmpty
                      ? null
                      : (widget.views.getGalleryListData.orderno ?? '')
                          .toString(),
                  hint: const Text("Select"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(),
                  onChanged: (String? val) {
                    widget.views.changeOrderNo(val.toString());
                  },
                  items: (widget.views.getOrderRegWithbuyerData.data ?? [])
                      .map((item) {
                    return DropdownMenuItem(
                      value: item.orderno.toString(),
                      child: Text('${item.styleNo} / ${item.orderno}'),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(right: 20),
                color: const Color(0xfff6fafd),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: (widget.views.getGalleryListData.sewline ?? '').isEmpty
                      ? null
                      : (widget.views.getGalleryListData.sewline ?? '')
                          .toString(),
                  hint: const Text("Select"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(),
                  onChanged: (String? val) {
                    widget.views.changeLine((val ?? 0).toString());
                  },
                  items:
                      (widget.views.getSewLineInfoData.data ?? []).map((item) {
                    return DropdownMenuItem(
                      value: item.lineCode.toString(),
                      onTap: () {
                        widget.views
                            .changeLine((item.lineCode ?? 0).toString());
                      },
                      child: Text('${item.lineName}'),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(right: 20),
                color: const Color(0xfff6fafd),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value:
                      (widget.views.getGalleryListData.defectCode ?? '').isEmpty
                          ? null
                          : (widget.views.getGalleryListData.defectCode ?? '')
                              .toString(),
                  hint: const Text("Select "),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(),
                  onChanged: (String? val) {
                    widget.views.changeDefectCode(val.toString());
                  },
                  items: (widget.views.getAllDefectMasterData.data ?? [])
                      .map((item) {
                    return DropdownMenuItem(
                      value: item.defectCode.toString(),
                      child: Text(item.defectName.toString()),
                    );
                  }).toList(),
                ),
              ),
            ),
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
                        Text((widget.views.getGalleryListData.fromDate ?? '')
                                .isNotEmpty
                            ? (widget.views.getGalleryListData.fromDate ?? '')
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
            Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.views.showDate(context, false);
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 20),
                    color: const Color(0xfff6fafd),
                    child: Row(
                      children: [
                        Text((widget.views.getGalleryListData.toDate ?? '')
                                .isNotEmpty
                            ? (widget.views.getGalleryListData.toDate ?? '')
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
            SizedBox(
              width: 70,
              child: GestureDetector(
                  onTap: () {
                    widget.views.GetGalleryListAPIConfirm(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade300),
                    child: const Text(
                      'View',
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
