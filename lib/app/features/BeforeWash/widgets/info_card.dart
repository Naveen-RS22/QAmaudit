import 'package:flutter/material.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_view_model.dart';

class InfoCard extends StatefulWidget {
  final BeforewashViewModal views;




  const InfoCard({ Key? key,required this.views,}) : super(key: key);


  @override
  State<InfoCard> createState() => InfoCardState();
}

class InfoCardState extends State<InfoCard> {
   String ?selectedStage;
   String ?selectedType;
   String ?selectedStandard;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Doc no:",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Buyer Division',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
          Container(

            child: widget.views.getBuyerFromOrderRegDetail.data == null
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
                    value: (widget.views.saveWashData.buyerCode ?? '').isEmpty
                        ? null
                        : (widget.views.saveWashData.buyerCode ?? '').toString(),
                    hint: const Text("Select Division"),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? val) {
                      widget.views.getOrderRegWithbuyer(val.toString(), context);
                    },
                    items:
                        widget.views.getBuyerFromOrderRegDetail.data?.map((item) {
                      return DropdownMenuItem(
                        value: item.buyDivCode.toString(),
                        child: Text(item.buyDivCode.toString()),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Style No',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
          Container(
            child: widget.views.getOrderRegWithbuyerDetail.data == null
                ? DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Select Style "),
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
                    value: widget.views.saveWashData.styleNo,
                    hint: const Text("Select Style "),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? val) {},
                    items:
                        widget.views.getOrderRegWithbuyerDetail.data?.map((item) {
                      return DropdownMenuItem(
                        onTap: () {
                          widget.views.getOrderRegWithbuyerOnchange(
                              item.styleNo.toString(),
                              item.orderno.toString(),
                              context);
                        },
                        value: (item.styleNo ?? '').toString(),
                        child:
                            Text('${item.styleNo ?? ''} / ${item.orderno ?? 0}'),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          // Text(
          //   'Measure Stage',
          //   style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          // ),
          // SizedBox(
          //   child: DropdownButton<String>(
          //     isExpanded: true,
          //     value: selectedStage,
          //     hint: const Text('Select Stage'),
          //     icon: const Icon(Icons.keyboard_arrow_down),
          //     underline:  Container(),// Placeholder text
          //     onChanged: (newValue) {
          //       setState(() {
          //         selectedStage = newValue;
          //       });
          //     },
          //     items: ['Stage 1','Stage 21','Stage 3','Stage 4'].map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // Text(
          //   'Type',
          //   style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          // ),
          // SizedBox(
          //   child: DropdownButton<String>(
          //     isExpanded: true,
          //     value: selectedType,
          //     hint: const Text('Select Type'),
          //     icon: const Icon(Icons.keyboard_arrow_down),
          //     underline:  Container(),// Placeholder text
          //     onChanged: (newValue) {
          //       setState(() {
          //         selectedType = newValue;
          //       });
          //     },
          //     items: ['Type 1','Type 2','Type 3','Type 4'].map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),
          //
          // const SizedBox(
          //   height: 15,
          // ),
          // Text(
          //   'AQL Standard',
          //   style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          // ),
          // SizedBox(
          //   child: DropdownButton<String>(
          //     isExpanded: true,
          //     value: selectedStandard,
          //     hint: const Text('Select Standard'),
          //     icon: const Icon(Icons.keyboard_arrow_down),
          //     underline:  Container(),// Placeholder text
          //     onChanged: (newValue) {
          //       setState(() {
          //         selectedStandard = newValue;
          //       });
          //     },
          //     items: ['Standard 1','Standard 21','Standard 3','Standard 4'].map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),







        ],
      )),
    );
  }
}
