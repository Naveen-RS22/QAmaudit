import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qapp/app/features/BeforeWash/beforewash_view_model.dart';

class MenuCardPack extends StatefulWidget {
  final BeforewashViewModal views;
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
    return Container(
        // margin: const EdgeInsets.only(right: 20),
        // padding: const EdgeInsets.all(20),
        // color: const Color(0xfff6f8fa),
        // // height: 320,
        // child: Column(
        //   children: [
        //     if (widget.views.saveWashData.wType != 'A')
        //       widget.views.currentImage != null
        //           ? Column(
        //               children: [
        //                 Stack(
        //                   children: [
        //                     Image.file(
        //                       widget.views.currentImage!,
        //                       height: 150,
        //                     ),
        //                     // Container(
        //                     //   margin: const EdgeInsets.only(top: 20, left: 20),
        //                     //   decoration: BoxDecoration(
        //                     //     color: Colors.white,
        //                     //     border: Border.all(color: Colors.black),
        //                     //     borderRadius: BorderRadius.circular(50.0),
        //                     //   ),
        //                     //   child: IconButton(
        //                     //       onPressed: () {
        //                     //         // widget.views.clearCurrentImage();
        //                     //       },
        //                     //       icon: const Icon(
        //                     //         Icons.close,
        //                     //         color: Colors.black,
        //                     //       )),
        //                     // ),
        //                   ],
        //                 ),
        //               ],
        //             )
        //           : InkWell(
        //               onTap: () {
        //                 widget.views.getImage(context);
        //               },
        //               child: Container(
        //                 width: 500,
        //                 margin: const EdgeInsets.only(right: 0),
        //                 padding: const EdgeInsets.symmetric(
        //                     vertical: 60.0, horizontal: 0.0),
        //                 decoration: BoxDecoration(
        //                     color: Colors.white,
        //                     border: Border.all(color: Colors.grey.shade300)),
        //                 child: const Column(
        //                   children: [
        //                     Icon(Icons.camera_alt_outlined),
        //                     SizedBox(
        //                       height: 20,
        //                     ),
        //                     Text('Open Camera')
        //                   ],
        //                 ),
        //               )),
        //     if (widget.views.saveWashData.wType != 'A')
        //       const SizedBox(height: 20),
        //     if (widget.views.saveWashData.wType != 'A')
        //       Container(
        //         padding: const EdgeInsets.all(10),
        //         height: 140,
        //         width: 500,
        //         color: Colors.white,
        //         child: TextFormField(
        //           controller: widget.views.currentCommentController,
        //           inputFormatters: [
        //             LengthLimitingTextInputFormatter(100),
        //           ],
        //           onChanged: (String val) {
        //             widget.views.currentCommentControllerOnChange(val, context);
        //           },
        //           cursorColor: Colors.black,
        //           keyboardType: TextInputType.multiline,
        //           maxLines: null,
        //           decoration: const InputDecoration(
        //             border: InputBorder.none,
        //             hintText: 'Type your comments and feedback here',
        //           ),
        //         ),
        //       ),
        //     if (widget.views.saveWashData.wType == 'A')
        //       Container(
        //         padding: const EdgeInsets.all(10),
        //         height: 300,
        //         width: 500,
        //         color: Colors.white,
        //         child: TextFormField(
        //           controller: widget.views.currentCommentController,
        //           inputFormatters: [
        //             LengthLimitingTextInputFormatter(100),
        //           ],
        //           onChanged: (String val) {
        //             widget.views.currentCommentControllerOnChange(val, context);
        //           },
        //           cursorColor: Colors.black,
        //           keyboardType: TextInputType.multiline,
        //           maxLines: null,
        //           decoration: const InputDecoration(
        //             border: InputBorder.none,
        //             hintText: 'Type your comments and feedback here',
        //           ),
        //         ),
        //       ),
        //   ],
        // )
    );
  }
}
