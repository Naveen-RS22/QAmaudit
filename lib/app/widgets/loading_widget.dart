import 'package:flutter/material.dart';
import 'package:qapp/app/res/app_extensions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        SizedBox(
          height: context.res.dimension.margin50,
        ),
        const Text(
          'Loading...',
        ),
      ],
    ));
  }
}
