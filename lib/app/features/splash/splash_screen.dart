import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:qapp/app/features/splash/splash_view_model.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qapp/app/res/images.dart';
import 'package:qapp/app/res/strings.dart';

class SplashScreen extends StatefulWidget {
  static const String path = "splashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashViewModel splashViewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
    clearCacheFiles();
    Timer(const Duration(seconds: Constants.splashDuration), () {
      splashViewModel.checkAndNavigate(context);
    });
  }

  clearCacheFiles() {
    _deleteCacheDir();
    _deleteAppDir();
  }

  Future<void> _deleteCacheDir() async {
    if (Platform.isAndroid) {
      var tempDir = await getTemporaryDirectory();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    }
  }

  Future<void> _deleteAppDir() async {
    if (Platform.isAndroid) {
      var appDocDir = await getApplicationDocumentsDirectory();

      if (appDocDir.existsSync()) {
        appDocDir.deleteSync(recursive: true);
      }
    }
  }

  _profileWidget() => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [_buildSplash(context)],
                ),
              ),
            ),
          ],
        ),
      );

  _buildSplash(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.60,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 30,
        blur: 90,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFe6e6e6).withOpacity(0.1),
              const Color(0xFFe6e6e6).withOpacity(0.05),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFe6e6e6).withOpacity(0.5),
            const Color((0xFFe6e6e6)).withOpacity(0.5),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(ImagePath.appBarLogo),
                    height: 100,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Quality App',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'About iTHRED | Qapp ${Strings.appVersion}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'iTHRED|QApp ${Strings.appVersion} is a quality application that expedites the inspection process and allows to quickly visualize production quality on the floor. Qapp renders a digitized platform that captures live data, defects and images, and analytics to predict unknown outcomes. Provides a user board that enables faster, data-directed decision-making, and enriches the whole process from cutting to final auditing. Imparts a task board for each individual to view day-to-day schedules and pending schedules.',
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _profileWidget(),
    );
  }
}
