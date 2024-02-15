import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';

import '../../../utils/extras/extras.dart';
import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/widgets/extras/banner.dart';

class SuccessBioPage extends StatefulWidget {
  const SuccessBioPage({
    super.key,
  });

  @override
  State<SuccessBioPage> createState() => _SuccessBioPageState();
}

class _SuccessBioPageState extends State<SuccessBioPage> {
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BannerWidget(onPressad: () {}),
      body: Container(
        decoration: BoxDecoration(
          gradient: DynamicColor.gradientColorChange,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: sizeH * 0.08,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.getSize15(context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/imagess/Group white.png",
                        height: sizeH * 0.09,
                      ),
                      Image.asset(
                        "assets/imagess/Group 2 white.png",
                        height: sizeH * 0.09,
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/imagess/bulb.png",
                  height: sizeH * 0.30,
                ),
                spaceHeight(SizeConfig.getSize20(context: context)),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.getSize15(context: context)),
                  child: Image.asset(
                    'assets/imagess/YOU HAVE 2.png',
                    height:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.14),
                  ),
                ),
                Text(
                  "sent your Biography for",
                  style: white21wBold,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Approval!!",
                  style: white21wBold,
                  textAlign: TextAlign.center,
                ),
                spaceHeight(SizeConfig.getSize40(context: context)),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      Get.delete<BiographyController>(force: true);
                      Get.offAll(() => Floatbar(0));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            color: DynamicColor.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Great!!!',
                          style: gredient122bold,
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
