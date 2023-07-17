import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:qapp/app/data/local/shared_prefs_helper.dart';
import 'package:qapp/app/features/onboarding/on_boarding_view_model.dart';
import 'package:qapp/app/res/constants.dart';
import 'package:qapp/app/res/images.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  OnBoardingViewModel viewModel = OnBoardingViewModel();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final view = Provider.of<OnBoardingViewModel>(context, listen: false);
      if (Platform.isAndroid) {
        view.dbInit();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<OnBoardingViewModel>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _onBoardingWidget(),
    );
  }

  _onBoardingWidget() => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.loginBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Image.asset(
                          ImagePath.appLogo,
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'iTHRED',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            String userK = SharedPreferenceHelper.getString(
                                    Constants.currentRole)
                                .toString();

                            viewModel.showErrorAlert(userK.toString());
                          },
                          child: const Text(
                            'Quality App',
                            style: TextStyle(fontSize: 17, color: Colors.blue),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: viewModel.boxHeight,
                                    child: PageView.builder(
                                        itemCount: viewModel.items.length,
                                        controller: viewModel.pageController,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Center(
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    viewModel.items[index]
                                                        .description,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black38),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        onPageChanged: (int index) {
                                          viewModel.currentPageNotifier.value =
                                              index;
                                        }),
                                  ),
                                  Positioned(
                                    left: 0.0,
                                    right: 0.0,
                                    bottom: 0.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CirclePageIndicator(
                                        itemCount: viewModel.items.length,
                                        currentPageNotifier:
                                            viewModel.currentPageNotifier,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                '\u00a9 iTHRED, 2022',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                !viewModel.isForgotPassword
                    ? _buildLogin(context)
                    : _buildForgotPassword(context)
              ],
            ),
          ),
        ),
      );

  _buildForgotPassword(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.75,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Request Password',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (email) {
                  viewModel.onForgotPasswordMailChanged(email);
                },
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  labelText: 'User Name',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.email,
                    color: Color(0xffF7931C),
                  ),
                ),
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Attention',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                viewModel.forgotPasswordContent,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.onRequestPasswordClick(context);
                      },
                      child: Center(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                            'Request Now',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.setForgotPassword(false);
                      },
                      child: const Text(
                        '< Back to Login',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildLogin(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.75,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Hello There',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  labelText: 'User Name',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.email,
                    color: Color(0xffF7931C),
                  ),
                ),
                style: const TextStyle(fontSize: 20, color: Colors.black),
                // initialValue: viewModel.userName,
                onChanged: (name) => {viewModel.userName = name},
                controller: viewModel.userNameController,
                autofillHints: const [AutofillHints.email],
                onTap: () {
                  viewModel.savedUserChecker(context);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                // initialValue: "password12",
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black45),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.lock,
                    color: Color(0xffF7931C),
                  ),
                ),
                style: const TextStyle(fontSize: 20, color: Colors.black),
                obscureText: true,
                // initialValue: viewModel.passWord,
                onChanged: (passWord) => {viewModel.passWord = passWord},
                controller: viewModel.passWordController,
                autofillHints: const [AutofillHints.password],
                onTap: () {
                  viewModel.savedUserChecker(context);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // viewModel.httpLoginAPI();
                        viewModel.proceedToLogin(context);
                      },
                      child: Center(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                            'Login Now',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.setForgotPassword(true);
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
