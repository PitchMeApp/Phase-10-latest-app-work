import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/forgotpasswordController.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
import 'package:pitch_me_app/controller/auth/signupController.dart';
import 'package:pitch_me_app/screens/auth/forgotPassword.dart';
import 'package:pitch_me_app/screens/auth/signUpScreen.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:pitch_me_app/utils/widgets/text/text.dart';
import 'package:pitch_me_app/utils/widgets/textFields/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends GetResponsiveView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
  bool emailFocus = false;
  int isSelect = 0;
  void clearStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BannerWidget(onPressad: () {
        print('object');
      }),
      body: BackGroundWidget(
        bannerRequired: false,
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
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
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        LOGIN,
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
            //spaceHeight(SizeConfig.getSize5(context: context)),

            Padding(
              padding: SizeConfig.leftRightPadding(context),
              child: Column(
                children: [
                  spaceHeight(20),
                  CustomTextField(
                    controller: controller.txtEmail,
                    lableText: EMAIL,
                    context: context,
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    focusNode: controller.emailFocusNode,
                    nextFocusNode: controller.pwdFocusNode,
                  ),
                  spaceHeight(SizeConfig.getSize20(context: context)),
                  CustomTextField(
                    lableText: PASSWORD,
                    obscure: true,
                    context: context,
                    controller: controller.txtPassword,
                    inputAction: TextInputAction.done,
                    focusNode: controller.pwdFocusNode,
                    onFieldSubmit: () {
                      clearStorage();
                      controller.submit(context);
                    },
                  ),
                  spaceHeight(SizeConfig.getSize20(context: context)),
                  buttonContainer(
                      height: 48,
                      fromAppBar: true,
                      singleSelectColor: isSelect,
                      isSingleSelect: 1,
                      //controller.txtEmail.text.isNotEmpty,
                      onTap: () {
                        clearStorage();
                        isSelect = 1;

                        controller.submit(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          roboto(
                              size: SizeConfig.getFontSize20(context: context),
                              text: 'Log In',
                              color: isSelect == 1
                                  ? DynamicColor.gredient1
                                  : DynamicColor.white)
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: inter(
                            size: SizeConfig.getFontSize14(context: context),
                            text: FORGOTPASSWORD,
                            color: DynamicColor.black,
                            fontWeight: FontWeight.w500),
                        onPressed: () {
                          Get.to(() => ForgotPasswordScreen(),
                              binding: ForgotPasswordBinding());
                        },
                      ),
                    ],
                  ),
                  Text(
                    DONTHAVEACC,
                    style: TextStyle(
                      color: DynamicColor.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.getFontSize14(context: context),
                    ),
                  ),
                  spaceHeight(SizeConfig.getSize20(context: context)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.getSize20(context: context)),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => SignUpScreen(),
                              binding: SignUpBinding());
                        },
                        child: Image.asset(
                          'assets/imagess/sign up.png',
                          height: 40,
                        )),
                  ),
                  spaceHeight(SizeConfig.getSize15(context: context)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.getSize5(context: context),
                        right: SizeConfig.getSize5(context: context)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              controller.socialLogin(context, 3);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                'assets/imagess/fb.png',
                              ),
                            )),
                        spaceHeight(SizeConfig.getSize15(context: context)),
                        InkWell(
                            onTap: () {
                              controller.socialLogin(context, 2);
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 100,

                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 8, right: 5, top: 5, bottom: 5),
                                    // height: 35,
                                    width: 40,
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Image.asset(
                                        'assets/imagess/google icon.png'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: DynamicColor.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),

                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(5),
                              //   child: Image.asset(
                              //     'assets/imagess/google.png',
                              //   ),
                            )),
                        spaceHeight(SizeConfig.getSize15(context: context)),
                        if (Platform.isIOS)
                          InkWell(
                              onTap: () {
                                controller.socialLogin(context, 1);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'assets/imagess/apple.png',
                                ),
                              )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // spaceHeight(SizeConfig.getSize30(context: context))
          ],
        ),
      ),
    );
  }
}
