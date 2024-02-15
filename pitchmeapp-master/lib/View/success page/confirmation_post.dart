import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/success%20page/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../utils/extras/extras.dart';
import '../../utils/strings/images.dart';
import '../../utils/styles/styles.dart';

class ConfirmationPost extends StatefulWidget {
  const ConfirmationPost({super.key});

  @override
  State<ConfirmationPost> createState() => _ConfirmationPostState();
}

class _ConfirmationPostState extends State<ConfirmationPost> {
  final SuccessPageController _controller = Get.put(SuccessPageController());
  int isCheck = 0;
  void removePromt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      if (prefs.getString("prompt") != null) {
        prefs.remove("prompt").toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BannerWidget(onPressad: () {
        print('object');
      }),
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeH * 0.08,
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
                'assets/imagess/Are you.png',
                height: SizeConfig.getSizeHeightBy(context: context, by: 0.14),
              ),
            ),
            //spaceHeight(SizeConfig.getSize30(context: context)),
            SizedBox(
                child: Column(children: [
              Text(
                'You want to send this',
                style: TextStyle(
                  fontSize: sizeH * 0.025,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  color: DynamicColor.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Pitch for Approval?',
                style: TextStyle(
                  fontSize: sizeH * 0.025,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  color: DynamicColor.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              // Text(
              //   'Approval?',
              //   style: TextStyle(
              //     fontSize: sizeH * 0.025,
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 0.6,
              //     color: DynamicColor.textColor,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
            ])),
            Container(
              height: sizeH * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: isCheck == 1 ? 0 : 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isCheck = 1;
                      });
                      removePromt();
                      _controller.postPitchApi(context);
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
                        "Yes",
                        style: isCheck == 1 ? gredient216bold : white16bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: isCheck == 2 ? 0 : 10,
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
                        "Return",
                        style: isCheck == 2 ? gredient216bold : white16bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Obx(() {
                  return _controller.isLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                              color: DynamicColor.gredient1),
                        )
                      : Container(
                          height: 36,
                        );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//Color.fromARGB(255, 177, 206, 229)