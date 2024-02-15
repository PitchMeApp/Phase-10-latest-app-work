import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/signupController.dart';
import 'package:pitch_me_app/screens/auth/signUpScreen.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:sizer/sizer.dart';

import '../../../screens/businessIdeas/BottomNavigation.dart';
import '../../../utils/extras/extras.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';

class UserTypeLimitationPage extends StatefulWidget {
  String title1;
  String title2;
  String title3;
  UserTypeLimitationPage(
      {super.key,
      required this.title1,
      required this.title2,
      required this.title3});

  @override
  State<UserTypeLimitationPage> createState() => _UserTypeLimitationPageState();
}

class _UserTypeLimitationPageState extends State<UserTypeLimitationPage> {
  int isCheck = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
        //
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
            padding:
                EdgeInsets.only(left: SizeConfig.getSize15(context: context)),
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
            padding:
                EdgeInsets.only(left: SizeConfig.getSize15(context: context)),
            child: Image.asset(
              'assets/imagess/YOU CANT.png',
              height: SizeConfig.getSizeHeightBy(context: context, by: 0.14),
            ),
          ),
          //spaceHeight(SizeConfig.getSize30(context: context)),
          SizedBox(
            child: Text(
              widget.title1,
              style: TextStyle(
                fontSize: sizeH * 0.027,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: DynamicColor.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            child: Text(
              widget.title2,
              style: TextStyle(
                fontSize: sizeH * 0.027,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: DynamicColor.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            child: Text(
              widget.title3,
              style: TextStyle(
                fontSize: sizeH * 0.027,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: DynamicColor.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: sizeH * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isCheck = 1;
                    });
                    Get.offAll(() => Floatbar(0));
                  },
                  child: Container(
                    height: 5.h,
                    width: MediaQuery.of(context).size.width * 0.35,
                    alignment: Alignment.center,
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
                    child: Text(
                      "Return",
                      style: isCheck == 1 ? gredient216bold : white16bold,
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.zero,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isCheck = 2;
                    });
                    Get.to(() => SignUpScreen(), binding: SignUpBinding());
                  },
                  child: Container(
                    height: 5.h,
                    width: MediaQuery.of(context).size.width * 0.35,
                    alignment: Alignment.center,
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
                    child: Text("Sign Out",
                        style: isCheck == 2 ? gredient216bold : white16bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
