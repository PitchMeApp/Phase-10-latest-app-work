import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/Manu/benefits/benefits.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/extras/extras.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/styles/styles.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';
import '../../../utils/widgets/extras/banner.dart';

class ProUserLimitationPage extends StatefulWidget {
  int pageIndex;
  ProUserLimitationPage({
    super.key,
    required this.pageIndex,
  });

  @override
  State<ProUserLimitationPage> createState() => _ProUserLimitationPageState();
}

class _ProUserLimitationPageState extends State<ProUserLimitationPage> {
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
                  height: sizeH * 0.08,
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.getSize25(context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBarIconContainer(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        height: SizeConfig.getSize38(context: context),
                        width: SizeConfig.getSize38(context: context),
                        color: DynamicColor.gredient1,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Image.asset(
                                "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                height: 30,
                                width: 30,
                                color: DynamicColor.white),
                          ),
                        ),
                      ),
                      Row(
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
                      Container()
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
                    'assets/imagess/YOU CANT 2.png',
                    height:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.11),
                  ),
                ),
                //spaceHeight(SizeConfig.getSize30(context: context)),
                SizedBox(
                  child: Text(
                    'This Feature is only',
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
                    'for PRO users',
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
                      PageNavigateScreen().normalpushReplesh(
                          context, BenefitsPage(pageIndex: widget.pageIndex));
                    },
                    child: Container(
                      height: 5.h,
                      width: MediaQuery.of(context).size.width * 0.50,
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
                        "CHECK THE BENEFITS",
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
