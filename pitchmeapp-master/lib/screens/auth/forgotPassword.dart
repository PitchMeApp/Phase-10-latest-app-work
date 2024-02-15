import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/forgotpasswordController.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
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

import '../../utils/styles/styles.dart';
import 'loginScreen.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BannerWidget(onPressad: () {
        print('object');
      }),
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        bannerRequired: false,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            SingleChildScrollView(
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
                              FORGOTPASSWORD.replaceAll('?', ''),
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
                        spaceHeight(20),
                        CustomTextField(
                          controller: controller.txtEmail,
                          lableText: EMAIL,
                          context: context,
                          keyboardType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          focusNode: controller.emailNode,
                          nextFocusNode: controller.userNameNode,
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
                                    color: isSelect == 1
                                        ? DynamicColor.gredient1
                                        : DynamicColor.white,
                                    size: 20,
                                    text: RESET_PASSWORD)
                              ],
                            )),
                        spaceHeight(SizeConfig.getSize20(context: context)),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: DynamicColor.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.getFontSize14(
                                      context: context),
                                ),
                                children: [
                              const TextSpan(
                                text: ALREADYREGISTERED,
                              ),
                              TextSpan(
                                text: LOGIN,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
//                                  AppRoutes.navigateOffLoign();
                                    Get.offAll(() => LoginScreen(),
                                        binding: LoginBinding());
                                  },
                                style: const TextStyle(
                                    color: DynamicColor.black,
                                    fontWeight: FontWeight.w800),
                              ),
                            ])),
                        spaceHeight(SizeConfig.getSize20(context: context)),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom == 0
                              ? 0
                              : SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.27)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
