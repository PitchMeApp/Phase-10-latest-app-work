import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:sizer/sizer.dart';

import '../../../screens/businessIdeas/BottomNavigation.dart';
import '../../../utils/extras/extras.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/styles/styles.dart';
import '../../../utils/widgets/Navigation/custom_navigation.dart';
import 'controller/benefits_controller.dart';

class BenefitsConfirmationPage extends StatefulWidget {
  int pageIndex;
  int? onBack = 0;
  BenefitsConfirmationPage({super.key, required this.pageIndex, this.onBack});

  @override
  State<BenefitsConfirmationPage> createState() =>
      _BenefitsConfirmationPageState();
}

class _BenefitsConfirmationPageState extends State<BenefitsConfirmationPage> {
  BenefitsController controller = Get.put(BenefitsController());
  int isCheck = 0;

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
                'You don’t want',
                style: TextStyle(
                  fontSize: sizeH * 0.025,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  color: DynamicColor.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'to have access',
                style: TextStyle(
                  fontSize: sizeH * 0.025,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  color: DynamicColor.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'to all Features?',
                style: TextStyle(
                  fontSize: sizeH * 0.025,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  color: DynamicColor.textColor,
                ),
                textAlign: TextAlign.center,
              ),
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
                      if (widget.onBack == 0) {
                        Navigator.of(context).pop();
                      } else if ((widget.onBack == 1)) {
                        PageNavigateScreen()
                            .pushRemovUntil(context, Floatbar(0));
                      } else if ((widget.onBack == 2)) {
                        PageNavigateScreen()
                            .pushRemovUntil(context, Floatbar(1));
                      } else if ((widget.onBack == 3)) {
                        PageNavigateScreen()
                            .pushRemovUntil(context, Floatbar(2));
                      } else {
                        Navigator.of(context).pop();
                      }
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
                        "Not now",
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
                      controller.generatepaymentApi(context);
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
                        "I want",
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
                  return controller.isLoading.value
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