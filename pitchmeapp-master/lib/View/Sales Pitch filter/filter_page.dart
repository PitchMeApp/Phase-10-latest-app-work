import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/Controller/filter_controller.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/industry_filter.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/location_filter.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/need_filter.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/clear_filter_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors/colors.dart';
import '../../utils/extras/extras.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../../utils/widgets/containers/containers.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/appbar_with_white_bg.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../Manu/manu.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final SalesPitchFilterController controller =
      Get.put(SalesPitchFilterController());
  int isSelect = 0;
  @override
  void initState() {
    super.initState();
    getFilterData();
  }

  void getFilterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var industry = jsonDecode(prefs.getString('industry').toString());
    var location = prefs.getString('location').toString();
    var needs = jsonDecode(prefs.getString('needs').toString());

    setState(() {
      controller.finalSelectedData['industry'] = industry;
      if (location.isNotEmpty && location != 'null') {
        controller.finalSelectedData['location'] = location;
      }
      controller.finalSelectedData['needs'] = needs;
    });
  }

  @override
  Widget build(BuildContext context) {
    // log('ddd = ' + controller.finalSelectedData['needs'].toString());
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Stack(
          children: [
            Column(
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
                        height: SizeConfig.getSizeHeightBy(
                            context: context, by: 0.12),
                        width: SizeConfig.getSizeHeightBy(
                            context: context, by: 0.12),
                        cornerRadius: 25)
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: DynamicColor.black))),
                  child: Text(
                    'Choose what type of Pitches you want to see',
                    style: textColor12,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                customBox(TextStrings.textKey['industry']!, 1, onPressad: () {
                  setState(
                    () {
                      isSelect = 1;
                    },
                  );
                  PageNavigateScreen()
                      .push(context, IndustryFilterPage())
                      .then((value) {
                    setState(() {
                      //  getFilterData();
                    });
                  });
                },
                    showRightIcon:
                        controller.finalSelectedData['industry'] != null),
                SizedBox(height: 10),
                customBox(TextStrings.textKey['location']!, 2, onPressad: () {
                  setState(() {
                    isSelect = 2;
                  });
                  PageNavigateScreen()
                      .push(context, LocationFilterPage())
                      .then((value) {
                    setState(() {
                      //  getFilterData();
                    });
                  });
                },
                    showRightIcon:
                        controller.finalSelectedData['location'] != null),
                SizedBox(height: 10),
                customBox(TextStrings.textKey['needs']!, 3, onPressad: () {
                  setState(
                    () {
                      isSelect = 3;
                    },
                  );
                  PageNavigateScreen()
                      .push(context, NeedFilterPage())
                      .then((value) {
                    setState(() {
                      //  getFilterData();
                    });
                  });
                },
                    showRightIcon:
                        controller.finalSelectedData['needs'] != null),
                SizedBox(
                    height: SizeConfig.getSize60(context: context) +
                        SizeConfig.getSize10(context: context)),
                customBox(TextStrings.textKey['clear_filter']!, 4,
                    onPressad: () {
                  setState(
                    () {
                      isSelect = 4;
                    },
                  );
                  showDialog(
                      context: context,
                      builder: (context) => ClearFilterPopUp()).then((value) {
                    setState(() {
                      getFilterData();
                      PageNavigateScreen()
                          .normalpushReplesh(context, Floatbar(1));
                    });
                  });
                }, showRightIcon: false),
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: TextStrings.textKey['filter_pitch']!,
              backCheckBio: 'back',
              backOnTap: () {
                PageNavigateScreen().normalpushReplesh(context, Floatbar(1));
                // Navigator.of(context).pop();
              },
              onPressad: () {
                PageNavigateScreen().push(
                    context,
                    ManuPage(
                      title: TextStrings.textKey['filter_pitch']!,
                      pageIndex: 1,
                      isManu: 'Manu',
                    ));
              },
            ),
            ComanFilterIcon(),
            controller.finalSelectedData['industry'] != null ||
                    controller.finalSelectedData['location'] != null ||
                    controller.finalSelectedData['needs'] != null
                ? doneButton()
                : Container(),
            NewCustomBottomBar(
              index: 1,
              isBack: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget doneButton() {
    return Padding(
      padding: EdgeInsets.only(
          bottom: SizeConfig.getSize30(context: context) +
              SizeConfig.getSize55(context: context) +
              SizeConfig.getSize5(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: Align(
          alignment: Alignment.bottomRight,
          child: AppBarIconContainer(
            height: SizeConfig.getSize38(context: context),
            width: SizeConfig.getSize38(context: context),
            color: DynamicColor.green,
            child: Icon(
              Icons.check,
              color: DynamicColor.white,
              size: 30,
            ),
            onTap: () {
              Get.delete<SalesPitchFilterController>(force: true);
              PageNavigateScreen().pushRemovUntil(context, Floatbar(1));
            },
          )),
    );
  }

  Widget customBox(String string, int isSelected,
      {required VoidCallback onPressad, required bool showRightIcon}) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getSize40(context: context),
          right: SizeConfig.getSize40(context: context)),
      child: Card(
        elevation: isSelected == isSelect ? 0 : 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: onPressad,
          child: Container(
            height: 6.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: isSelected == isSelect
                    ? null
                    : DynamicColor.gradientColorChange,
                color: isSelected == isSelect ? DynamicColor.white : null,
                borderRadius: BorderRadius.circular(10),
                border: isSelected == isSelect
                    ? Border.all(color: DynamicColor.gredient2)
                    : null),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  string == 'Clear Filter'
                      ? Container(
                          height: 30,
                          width: 30,
                        )
                      : Icon(Icons.add,
                          size: 30,
                          color: isSelected == isSelect
                              ? DynamicColor.gredient1
                              : DynamicColor.white),
                  Text(
                    string.toUpperCase(),
                    style:
                        isSelected == isSelect ? gredient116bold : white16bold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  showRightIcon
                      ? Icon(Icons.check,
                          size: 30,
                          color: isSelected == isSelect
                              ? DynamicColor.gredient1
                              : DynamicColor.white)
                      : Container(
                          height: 30,
                          width: 30,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ComanFilterIcon extends StatelessWidget {
  const ComanFilterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.getSize30(context: context) +
              SizeConfig.getSize55(context: context) +
              SizeConfig.getSize5(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: Align(
          alignment: Alignment.topRight,
          child: AppBarIconContainer(
            height: SizeConfig.getSize38(context: context),
            width: SizeConfig.getSize38(context: context),
            color: DynamicColor.white,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: loadSvg(
                    image: 'assets/image/setting.svg',
                    color: DynamicColor.darkBlue)),
            onTap: () {},
          )),
    );
  }
}
