import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/extras/extras.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/styles/styles.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';
import '../../../utils/widgets/extras/banner.dart';

class UnderDevLimitationPage extends StatefulWidget {
  UnderDevLimitationPage({
    super.key,
  });

  @override
  State<UnderDevLimitationPage> createState() => _UnderDevLimitationPageState();
}

class _UnderDevLimitationPageState extends State<UnderDevLimitationPage> {
  int isCheck = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
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
                //spaceHeight(SizeConfig.getSize30(context: context)),
                SizedBox(
                  child: Text(
                    'This page is currently under Development',
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

                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isCheck = 1;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 5.h,
                      width: MediaQuery.of(context).size.width * 0.35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isCheck == 1 ? DynamicColor.white : null,
                          border: isCheck == 1
                              ? Border.all(color: DynamicColor.gredient2)
                              : null,
                          gradient: isCheck == 1
                              ? null
                              : DynamicColor.gradientColorChange),
                      child: Text(
                        "Ok",
                        style: isCheck == 1 ? gredient216bold : white16bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
