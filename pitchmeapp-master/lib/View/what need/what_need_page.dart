import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Need%20page/need_page.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/what%20need/who_need_page_controller.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors/colors.dart';
import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../Fund Page/funds_page.dart';

class WhatNeedPage extends StatefulWidget {
  const WhatNeedPage({super.key});

  @override
  State<WhatNeedPage> createState() => _WhatNeedPageState();
}

class _WhatNeedPageState extends State<WhatNeedPage> {
  final WhoNeedController _whoNeedController = Get.put(WhoNeedController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.getSize100(context: context) +
                        SizeConfig.getSize55(context: context),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: DynamicColor.black))),
                    child: Text(
                      TextStrings.textKey['what_need']!,
                      style: textColor22,
                    ),
                  ),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.05)),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customBox(
                          _whoNeedController.data[0]['value'],
                          _whoNeedController.data[0]['isSelected'],
                          onPressad: () {
                            setState(() {});
                            _whoNeedController
                                .onselectItem(_whoNeedController.data[0]);
                          },
                        ),
                        Container(
                          width: 2,
                        ),
                        customBox(
                          _whoNeedController.data[1]['value'],
                          _whoNeedController.data[1]['isSelected'],
                          onPressad: () {
                            setState(() {
                              _whoNeedController
                                  .onselectItem(_whoNeedController.data[1]);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.04)),
                  _footerHint()
                ],
              ),
            ),
            CustomHeaderView(
              progressPersent: 0.3,
              checkNext: _whoNeedController.isSelectedItem.value.isNotEmpty
                  ? 'next'
                  : null,
              nextOnTap: () {
                try {
                  if (_navigationController.navigationType.value == 'Post') {
                    if (_whoNeedController.checkColor == 1) {
                      PageNavigateScreen().push(
                          context,
                          FundsPage(
                            key: abcKey,
                          ));
                    } else if (_whoNeedController.checkColor2 == 2) {
                      PageNavigateScreen().push(
                          context,
                          NeedPage(
                            key: abcKey,
                          ));
                    } else {
                      PageNavigateScreen().push(
                          context,
                          FundsPage(
                            key: abcKey,
                          ));
                    }
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

  Widget _footerHint() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: DynamicColor.textColor))),
          child: Text(
            TextStrings.textKey['sub_what_need']!,
            style: textColor15,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: DynamicColor.textColor))),
          child: Text(
            TextStrings.textKey['sub_what_need2']!,
            style: textColor15,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget customBox(String string, isCheck, {required VoidCallback onPressad}) {
    return GestureDetector(
      onTap: onPressad,
      child: Card(
        elevation: isCheck ? 0 : 10,
        child: Container(
          height: 5.h,
          width: MediaQuery.of(context).size.width * 0.35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: DynamicColor.white,
            border: isCheck ? Border.all(color: DynamicColor.gredient2) : null,
          ),
          child: Text(
            string,
            style: TextStyle(
              fontSize: 15.0,
              color: isCheck ? DynamicColor.gredient2 : DynamicColor.black,
              fontWeight: isCheck ? FontWeight.bold : FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
