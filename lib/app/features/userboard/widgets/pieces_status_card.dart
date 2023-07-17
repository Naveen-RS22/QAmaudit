import 'package:flutter/material.dart';
import 'package:qapp/app/data/network/dto/GetQcWidgetInfoModel.dart';
import 'package:qapp/app/features/userboard/userboard_view_model.dart';
import 'package:qapp/app/res/app_extensions.dart';

class PiecesStatusCard extends StatefulWidget {
  final UserboardViewModel views;
  final String s;
  final double percent;
  final bool status;
  final int total;
  final int current;
  final bool checkerPercent;
  final bool DHUCheckerPercent;

  const PiecesStatusCard(this.views, this.s, this.total, this.current,
      this.percent, this.status, this.checkerPercent, this.DHUCheckerPercent,
      {Key? key, required})
      : super(key: key);

  @override
  State<PiecesStatusCard> createState() => _PiecesStatusCardState();
}

class _PiecesStatusCardState extends State<PiecesStatusCard> {
  @override
  Widget build(BuildContext context) {
    List<InspectedInfo> inspectModelList =
        widget.views.getQcData.data?.inspectedInfo ?? [];

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
                      widget.s,
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
                          widget.s != "DHU %"
                              ? widget.current.toString()
                              : widget.percent.round().abs().toString() + "%",
                          style: TextStyle(
                            fontSize: 30,
                            color: context.res.color.black,
                          ),
                        ),
                        Text(
                          widget.s != "DHU %" ? '/' : '',
                          style: TextStyle(
                            fontSize: 18,
                            color: context.res.color.textGray,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            widget.s != "DHU %" ? widget.total.toString() : '',
                            style: TextStyle(
                              fontSize: 20,
                              color: context.res.color.textGray,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: context.res.color.white),
                    child: Center(
                      child: inspectModelList.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.s != "DHU %")
                                  if (widget.s != "Defect Pcs")
                                    Text(
                                      !widget.checkerPercent
                                          ? '-'
                                          : widget.percent
                                                  .abs()
                                                  .toString()
                                                  .characters
                                                  .take(5)
                                                  .toString() +
                                              "%",
                                      style: TextStyle(
                                          color: widget.percent > 0
                                              ? context.res.color.textColorGreen
                                              : context.res.color.textColorRed,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                if (widget.s == "DHU %")
                                  Text(
                                    !widget.DHUCheckerPercent
                                        ? '-'
                                        : widget.total
                                                .abs()
                                                .toString()
                                                .characters
                                                .take(5)
                                                .toString() +
                                            "%",
                                    style: TextStyle(
                                        color: !widget.status
                                            ? context.res.color.textColorGreen
                                            : context.res.color.textColorRed,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                if (widget.s == "Defect Pcs")
                                  Text(
                                    !widget.checkerPercent
                                        ? '-'
                                        : widget.percent
                                                .abs()
                                                .toString()
                                                .characters
                                                .take(5)
                                                .toString() +
                                            "%",
                                    style: TextStyle(
                                        color: widget.percent > 0
                                            ? context.res.color.textColorRed
                                            : context.res.color.textColorGreen,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                if (widget.s != "DHU %")
                                  if (widget.s != "Defect Pcs")
                                    if (widget.percent != 0)
                                      widget.percent > 0
                                          ? const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.green,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.arrow_downward,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                if (widget.s != "DHU %")
                                  if (widget.s == "Defect Pcs")
                                    if (widget.percent != 0)
                                      widget.percent > 0
                                          ? const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.red,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.arrow_downward,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                if (widget.s == "DHU %")
                                  if (widget.DHUCheckerPercent)
                                    if (widget.percent != 0)
                                      widget.status
                                          ? const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.red,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.arrow_downward,
                                              color: Colors.green,
                                              size: 20,
                                            )
                              ],
                            )
                          : const Text("-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
