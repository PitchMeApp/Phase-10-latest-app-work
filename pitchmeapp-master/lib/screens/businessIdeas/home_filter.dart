import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/controller/businessIdeas/home_filter_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';

import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/widgets/containers/containers.dart';

class HomePageFilter extends StatefulWidget {
  const HomePageFilter({super.key});

  @override
  State<HomePageFilter> createState() => _HomePageFilterState();
}

class _HomePageFilterState extends State<HomePageFilter> {
  HomeFilterController controller = Get.put(HomeFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Column(
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
                whiteBorderContainer(
                    child: Image.asset(Assets.handshakeImage),
                    color: Colors.transparent,
                    height:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                    width:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                    cornerRadius: 25)
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Choose what type of Posts you want to see',
                      style: textColor12,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) {
                        dynamic data = controller.data[index];
                        return CustomListBox(
                            title: data['value'],
                            titleColor: data['isSelected'],
                            onPressad: () {
                              setState(() {
                                controller.onselectValue(index);
                              });
                            });
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
