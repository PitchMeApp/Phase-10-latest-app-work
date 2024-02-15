import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
import 'package:pitch_me_app/controller/auth/signupController.dart';
import 'package:pitch_me_app/screens/auth/loginScreen.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:pitch_me_app/utils/widgets/text/text.dart';
import 'package:pitch_me_app/utils/widgets/textFields/textField.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/styles/styles.dart';
import '../../utils/widgets/extras/checkBox.dart';

class SignUpScreen extends GetView<SignupController> {
  SignUpScreen({Key? key}) : super(key: key);

  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BannerWidget(onPressad: () {}),
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        bannerRequired: false,
        fit: BoxFit.fill,
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.zero,
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
                          SIGNUP,
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
              Padding(
                padding: SizeConfig.leftRightPadding(context),
                child: Column(
                  children: [
                    spaceHeight(10),
                    CustomTextField(
                      lableText: USERNAME,
                      context: context,
                      controller: controller.txtUserName,
                      inputAction: TextInputAction.next,
                      focusNode: controller.userNameNode,
                      nextFocusNode: controller.passwordNode,
                    ),
                    spaceHeight(SizeConfig.getSize20(context: context)),
                    CustomTextField(
                      controller: controller.txtEmail,
                      lableText: EMAIL,
                      context: context,
                      keyboardType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      focusNode: controller.emailNode,
                      nextFocusNode: controller.userNameNode,
                    ),
                    spaceHeight(SizeConfig.getSize20(context: context)),
                    CustomTextField(
                      lableText: PASSWORD,
                      obscure: true,
                      context: context,
                      controller: controller.txtPassword,
                      inputAction: TextInputAction.next,
                      focusNode: controller.passwordNode,
                      nextFocusNode: controller.confirmPasswordNode,
                    ),
                    spaceHeight(SizeConfig.getSize20(context: context)),
                    CustomTextField(
                      lableText: CONFIRMPASSWORD,
                      obscure: true,
                      context: context,
                      controller: controller.txtConfirmPassword,
                      inputAction: TextInputAction.done,
                      onFieldSubmit: () {
                        controller.submit(context);
                      },
                      focusNode: controller.confirmPasswordNode,
                    ),
                    spaceHeight(SizeConfig.getSize30(context: context)),
                    buttonContainer(
                        height: 48,
                        singleSelectColor: isSelect,
                        isSingleSelect: 1,
                        onTap: () {
                          isSelect = 1;
                          controller.submit(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            roboto(
                                size: 20,
                                text: SIGNUP,
                                color: isSelect == 1
                                    ? DynamicColor.gredient1
                                    : DynamicColor.white)
                          ],
                        )),
                    spaceHeight(SizeConfig.getSize30(context: context)),
                    Text(
                      ALREADYREGISTERED,
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
                            Get.offAll(() => LoginScreen(),
                                binding: LoginBinding());
                          },
                          child: Image.asset(
                            'assets/imagess/login.png',
                            height: 40,
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.agree.value = !controller.agree.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Obx(() => myCheckBox(controller.agree.value)),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: DynamicColor.textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.getFontSize14(context: context),
                        ),
                        children: <TextSpan>[
                          TextSpan(text: AGREE_TO),
                          TextSpan(
                              text: TERMS_CONDITIONS,
                              style: TextStyle(
                                  color: DynamicColor.textColor,
                                  fontSize: SizeConfig.getFontSize14(
                                      context: context),
                                  fontWeight: FontWeight.w800),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(
                                      Uri.parse(
                                          'https://www.thepitchmeapp.com/terms-and-conditions'),
                                      mode: LaunchMode.externalApplication);
                                }),
                          TextSpan(text: ' and '),
                          TextSpan(
                              text: COOKIES_USE,
                              style: TextStyle(
                                  color: DynamicColor.textColor,
                                  fontSize: SizeConfig.getFontSize14(
                                      context: context),
                                  fontWeight: FontWeight.w800),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Privacy Policy"');
                                }),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
