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
import '../../../utils/widgets/extras/backgroundWidget.dart';

class SwipeLimitationPage extends StatefulWidget {
  SwipeLimitationPage({super.key});

  @override
  State<SwipeLimitationPage> createState() => _SwipeLimitationPageState();
}

class _SwipeLimitationPageState extends State<SwipeLimitationPage> {
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
              SizedBox(
                height: sizeH * 0.1,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.getSize15(context: context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/imagess/Group.png",
                      height: sizeH * 0.09,
                    ),
                    Image.asset(
                      "assets/imagess/Group 2.png",
                      height: sizeH * 0.09,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeH * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Image.asset(
                  "assets/imagess/Pitch me Logo.png",
                  height: sizeH * 0.17,
                ),
              ),
              spaceHeight(SizeConfig.getSize20(context: context)),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.getSize15(context: context)),
                child: Image.asset(
                  'assets/imagess/YOU CANT.png',
                  height:
                      SizeConfig.getSizeHeightBy(context: context, by: 0.14),
                ),
              ),
              Text("Only logged in Users can",
                  style: TextStyle(
                    fontSize: sizeH * 0.025,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6,
                    color: DynamicColor.black,
                  )),
              Text(
                'Watch more than',
                style: TextStyle(
                  fontSize: sizeH * 0.025,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6,
                  color: DynamicColor.black,
                ),
              ),
              Text(
                '20 Home Page Videos',
                style: TextStyle(
                  fontSize: sizeH * 0.025,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6,
                  color: DynamicColor.black,
                ),
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
