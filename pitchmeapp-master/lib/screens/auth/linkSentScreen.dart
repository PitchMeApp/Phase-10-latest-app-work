import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
import 'package:pitch_me_app/screens/auth/loginScreen.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';

import '../../utils/colors/colors.dart';
import '../../utils/extras/extras.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/containers/containers.dart';
import '../../utils/widgets/extras/banner.dart';
import '../../utils/widgets/text/text.dart';

class LinkSentScreen extends StatefulWidget {
  const LinkSentScreen({super.key});

  @override
  State<LinkSentScreen> createState() => _LinkSentScreenState();
}

class _LinkSentScreenState extends State<LinkSentScreen> {
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
        bottomNavigationBar: BannerWidget(onPressad: () {}),
        body: BackGroundWidget(
          backgroundImage: Assets.backgroundImage,
          bannerRequired: false,
          fit: BoxFit.fill,
          child: SingleChildScrollView(
            child: Column(children: [
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
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text(
                          EMAIL.toUpperCase(),
                          style: white21wBold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          CONFIRMATION,
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
              spaceHeight(SizeConfig.getSize50(context: context)),
              Image.asset(
                'assets/imagess/Pitch me Logo.png',
                height: SizeConfig.getSizeHeightBy(context: context, by: 0.18),
              ),
              spaceHeight(SizeConfig.getSize50(context: context)),
              Text(
                "Please Confirm your email by",
                style: TextStyle(
                    fontSize: sizeH * 0.027,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: DynamicColor.black),
              ),
              Text(
                "Clicking the link sent from us",
                style: TextStyle(
                    fontSize: sizeH * 0.027,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: DynamicColor.black),
              ),
              SizedBox(
                height: sizeH * 0.05,
              ),
              Text(
                "*Might be in Junk or Spam Box",
                style: TextStyle(
                    fontSize: sizeH * 0.017,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: DynamicColor.black),
              ),
              spaceHeight(SizeConfig.getSize50(context: context)),
              buttonContainer(
                  height: 48,
                  width: MediaQuery.of(context).size.width * 0.7,
                  fromAppBar: true,
                  //controller.txtEmail.text.isNotEmpty,
                  singleSelectColor: isSelect,
                  isSingleSelect: 1,
                  onTap: () {
                    setState(() {
                      isSelect = 1;
                    });
                    Get.offAll(() => LoginScreen(), binding: LoginBinding());
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
            ]),
          ),
        ));
  }
}
