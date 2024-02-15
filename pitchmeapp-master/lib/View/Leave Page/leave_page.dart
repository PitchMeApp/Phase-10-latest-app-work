import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Add%20Image%20Page/controller.dart';
import 'package:pitch_me_app/View/Fund%20Page/fund_neccessar_controller.dart';
import 'package:pitch_me_app/View/Funding%20Phase/fund_phase_cntroller.dart';
import 'package:pitch_me_app/View/Location%20Page/location_page_con.dart';
import 'package:pitch_me_app/View/Need%20page/need_page_controller.dart';
import 'package:pitch_me_app/View/Select%20industry/industry_controller.dart';
import 'package:pitch_me_app/View/offer_page/controller.dart';
import 'package:pitch_me_app/View/video%20page/Controller/controller.dart';
import 'package:pitch_me_app/View/what%20need/who_need_page_controller.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors/colors.dart';
import '../../utils/extras/extras.dart';
import '../../utils/strings/images.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../navigation_controller.dart';

class LeavePage extends StatefulWidget {
  int index;
  LeavePage({super.key, required this.index});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  final HomePageController controller = Get.put(HomePageController());

  int isCheck = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        BackGroundWidget(
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
                  'assets/imagess/Are you.png',
                  height:
                      SizeConfig.getSizeHeightBy(context: context, by: 0.14),
                ),
              ),
              //spaceHeight(SizeConfig.getSize30(context: context)),
              SizedBox(
                child: Text(
                  'You want to exit and',
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
                  'loose all the progress?',
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
                        Get.delete<InsdustryController>(force: true);
                        Get.delete<LocationPageController>(force: true);
                        Get.delete<WhoNeedController>(force: true);
                        Get.delete<FundNacessaryController>(force: true);
                        Get.delete<NeedPageController>(force: true);
                        Get.delete<OfferPageController>(force: true);
                        Get.delete<AddImageController>(force: true);
                        Get.delete<VideoFirstPageController>(force: true);
                        Get.delete<NavigationController>(force: true);
                        Get.delete<FundingPhaseController>(force: true);
                        setState(() {
                          isCheck = 1;
                        });
                        controller.PageIndexData.value = 0;
                        // PageNavigateScreen().normalpushReplesh(context, Floatbar(0));
                        PageNavigateScreen()
                            .pushRemovUntil(context, Floatbar(0));
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
                          "Exit",
                          style: isCheck == 1 ? gredient216bold : white16bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.zero,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isCheck = 2;
                        });
                        Navigator.of(context).pop();
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
                        child: Text(
                          "Cancel",
                          style: isCheck == 2 ? gredient216bold : white16bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        NewCustomBottomBar(
          index: widget.index,
        ),
      ],
    ));
  }
}
