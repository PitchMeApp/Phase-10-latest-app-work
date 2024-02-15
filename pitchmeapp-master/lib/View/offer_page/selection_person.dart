import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Add%20Image%20Page/addImage_page.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/custom_header_view.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/offer_page/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../utils/strings/images.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';

class SelectionPersonPage extends StatefulWidget {
  const SelectionPersonPage({super.key});

  @override
  State<SelectionPersonPage> createState() => _SelectionPersonPageState();
}

class _SelectionPersonPageState extends State<SelectionPersonPage> {
  OfferPageController controller = Get.put(OfferPageController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  final NavigationController _navigationController =
      Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: SizeConfig.getSize100(context: context) +
                      SizeConfig.getSize60(context: context) +
                      SizeConfig.getSize20(context: context),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: DynamicColor.black))),
                  child: Text(
                    TextStrings.textKey['who_can']!,
                    style: textColor22,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                customBox(controller.data[0]['value'],
                    controller.data[0]['isSelected'], onPressad: () {
                  controller.selectedPerson.value = 'Anyone';
                  setState(() {
                    if (controller.selectedPersonType.value.isNotEmpty &&
                        controller.selectedPersonType.value[0]['value'] !=
                            'Anyone') {
                      for (var element in controller.selectedPersonType.value) {
                        element['isSelected'] = false;
                      }
                      controller.selectedPersonType.value.clear();
                    }

                    controller.onselectValue(0);
                  });
                }),
                SizedBox(height: 10),
                customBox(controller.data[1]['value'],
                    controller.data[1]['isSelected'], onPressad: () {
                  if (controller.selectedPerson.value != 'Anyone') {
                    controller.selectedPerson.value = 'Only Verified ID';
                    setState(() {
                      controller.onselectValue(1);
                    });
                  }
                }),
                SizedBox(height: 10),
                customBox(controller.data[2]['value'],
                    controller.data[2]['isSelected'], onPressad: () {
                  if (controller.selectedPerson.value != 'Anyone') {
                    controller.selectedPerson.value = 'Only Verified Funds';
                    setState(() {
                      controller.onselectValue(2);
                    });
                  }
                }),
                SizedBox(height: 10),
                customBox(controller.data[3]['value'],
                    controller.data[3]['isSelected'], onPressad: () {
                  if (controller.selectedPerson.value != 'Anyone') {
                    controller.selectedPerson.value =
                        'Only Verified Experience';
                    setState(() {
                      controller.onselectValue(3);
                    });
                  }
                }),
                SizedBox(height: 10),
                customBox(controller.data[4]['value'],
                    controller.data[4]['isSelected'], onPressad: () {
                  if (controller.selectedPerson.value != 'Anyone') {
                    controller.selectedPerson.value = 'Only with NDA';
                    setState(() {
                      controller.onselectValue(4);
                    });
                  }
                }),
              ],
            ),
            CustomHeaderView(
              progressPersent: 0.7,
              checkNext: controller.selectedPersonType.value.isNotEmpty
                  ? 'next'
                  : null,
              nextOnTap: () {
                try {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_navigationController.navigationType.value == 'Post') {
                    PageNavigateScreen().push(
                        context,
                        AddImagePage(
                          key: abcKey,
                        ));
                  } else {
                    Navigator.of(context).pop();
                  }
                } catch (e) {}
              },
            ),
            NewCustomBottomBar(
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget customBox(String string, bool isSelected,
      {required VoidCallback onPressad}) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getSize40(context: context),
          right: SizeConfig.getSize40(context: context)),
      child: Card(
        elevation: isSelected ? 0 : 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: onPressad,
          child: Container(
            height: 6.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: isSelected ? null : DynamicColor.gradientColorChange,
                color: isSelected ? DynamicColor.white : null,
                borderRadius: BorderRadius.circular(10),
                border: isSelected
                    ? Border.all(color: DynamicColor.gredient2)
                    : null),
            child: Text(
              string,
              style: isSelected ? gredient116bold : white16bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
