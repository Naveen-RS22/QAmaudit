import 'package:flutter/material.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_view_model.dart';

class OptionCard extends StatelessWidget {
  final BeforewashViewModal views;
  const OptionCard({
    Key? key,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < views.washApprovalArray.length; i++)
              GestureDetector(
                onTap: () {
                  views.currentOptionSelectOnChange(
                      views.washApprovalArray[i].title ?? '', i, context);
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          color:
                              (views.washApprovalArray[i].isSelected ?? false)
                                  ? const Color(0xfff6f8fa)
                                  : Colors.white,
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            views.washApprovalArray[i].title.toString(),
                            style: TextStyle(
                              color: (views.washApprovalArray[i].isSelected ??
                                      false)
                                  ? Colors.black
                                  : const Color(0xff676767),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: views.washApprovalArray[i].status == 'F'
                                    ? Colors.red.shade300
                                    : views.washApprovalArray[i].status == 'P'
                                        ? Colors.green.shade300
                                        : Colors.grey.shade300),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
