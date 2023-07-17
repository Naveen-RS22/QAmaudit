import 'package:flutter/material.dart';
import 'package:qapp/app/res/images.dart';

class AppBackgroundWidget extends StatelessWidget {
  const AppBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.appBg),
            fit: BoxFit.cover,
          ),
        ),
      );
}
