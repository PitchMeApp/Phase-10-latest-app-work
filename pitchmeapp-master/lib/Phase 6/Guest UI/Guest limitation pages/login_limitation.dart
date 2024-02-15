import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/signupController.dart';
import 'package:pitch_me_app/screens/auth/signUpScreen.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth/loginController.dart';
import '../../../screens/auth/loginScreen.dart';
import '../../../utils/extras/extras.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/styles/styles.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';

class LoginLimitationPage extends StatefulWidget {
  LoginLimitationPage({super.key});

  @override
  State<LoginLimitationPage> createState() => _LoginLimitationPageState();
}

class _LoginLimitationPageState extends State<LoginLimitationPage> {
  int isCheck = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        bottomNavigationBar: BannerWidget(
          onPressad: () {},
        ),
        body: BackGroundWidget(
          bannerRequired: false,
          backgroundImage: Assets.backgroundImage,
          fit: BoxFit.cover,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: DynamicColor.gradientColorChange),
                      height: MediaQuery.of(context).size.height * 0.27,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.getSizeHeightBy(
                            context: context, by: 0.07),
                        left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/imagess/back.png',
                          height: 55,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text(
                          'GUEST',
                          style: white21wBold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'LIMITATION',
                          style: white21wBold,
                        ),
                      ),
                      whiteBorderContainer(
                          child: Image.asset(Assets.handshakeImage),
                          color: Colors.transparent,
                          height: SizeConfig.getSizeHeightBy(
                              context: context, by: 0.12),
                          width: SizeConfig.getSizeHeightBy(
                              context: context, by: 0.12),
                          cornerRadius: 25),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  spaceHeight(SizeConfig.getSize80(context: context)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.getSize15(context: context)),
                    child: Image.asset(
                      'assets/imagess/YOU CANT.png',
                      height: SizeConfig.getSizeHeightBy(
                          context: context, by: 0.14),
                    ),
                  ),
                  // spaceHeight(SizeConfig.getSize30(context: context)),
                  Text("This page is only for",
                      style: TextStyle(
                        fontSize: sizeH * 0.025,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6,
                        color: DynamicColor.black,
                      )),
                  Text(
                    'Logged In Users',
                    style: TextStyle(
                      fontSize: sizeH * 0.025,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                      color: DynamicColor.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizeH * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCheck = 1;
                            });
                            Get.offAll(() => LoginScreen(),
                                binding: LoginBinding());
                          },
                          child: Container(
                            height: 5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: isCheck == 1 ? DynamicColor.white : null,
                                border: isCheck == 1
                                    ? Border.all(color: DynamicColor.gredient2)
                                    : null,
                                gradient: isCheck == 1
                                    ? null
                                    : DynamicColor.gradientColorChange),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Login",
                                  style: isCheck == 1
                                      ? gredient216bold
                                      : white16bold,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.zero,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCheck = 2;
                            });
                            Get.to(() => SignUpScreen(),
                                binding: SignUpBinding());
                          },
                          child: Container(
                            height: 5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: isCheck == 2 ? DynamicColor.white : null,
                                border: isCheck == 2
                                    ? Border.all(color: DynamicColor.gredient2)
                                    : null,
                                gradient: isCheck == 2
                                    ? null
                                    : DynamicColor.gradientColorChange),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign Up",
                                  style: isCheck == 2
                                      ? gredient216bold
                                      : white16bold,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
