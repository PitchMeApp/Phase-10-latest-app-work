import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/biography.dart';
import 'package:pitch_me_app/controller/businessIdeas/postPageController.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:sizer/sizer.dart';

import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/images.dart';

class interestedSwipe extends StatefulWidget {
  String userID;
  interestedSwipe({super.key, required this.userID});

  @override
  State<interestedSwipe> createState() => _interestedSwipeState();
}

class _interestedSwipeState extends State<interestedSwipe> {
  bool selectbutton = false;
  bool selectbutton_Two = false;

  PostPageController _pageController = Get.put(PostPageController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    _pageController.notVideo = true;
    TextStyle textStyle = TextStyle(
        fontSize: sizeH * 0.025,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
        color: DynamicColor.lightBlack);

    return Scaffold(
        bottomNavigationBar: BannerWidget(onPressad: () {}),
        body: BackGroundWidget(
          backgroundImage: Assets.backgroundImage,
          bannerRequired: false,
          fit: BoxFit.fill,
          child: Column(
            children: [
              SizedBox(
                height: sizeH * 0.1,
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
              SizedBox(
                height: sizeH * 0.03,
              ),
              Container(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.getSize15(context: context)),
                child: Image.asset(
                  "assets/imagess/SC1.png",
                  height: sizeH * 0.13,
                ),
              )),
              Text(
                "The Pitch Owner will",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                "receive a notification of",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                "your interest. If they like",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                "your Biography they will",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                "Contact you.",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: sizeH * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => BiographyPage(
                              type: 'Bio',
                              notifyID: '',
                            ));
                      },
                      child: Container(
                        height: 6.h,
                        width: MediaQuery.of(context).size.width * 0.35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            gradient: DynamicColor.gradientColorChange),
                        child: Text(
                          "Biography",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 6.h,
                      color: DynamicColor.white,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pop();

                          _pageController.right.value = false;
                        });
                      },
                      child: Container(
                        height: 6.h,
                        width: MediaQuery.of(context).size.width * 0.35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            gradient: DynamicColor.gradientColorChange),
                        child: Text(
                          "More Pitches",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
