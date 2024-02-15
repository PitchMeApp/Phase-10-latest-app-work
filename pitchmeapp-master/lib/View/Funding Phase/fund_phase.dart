import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Funding%20Phase/fund_phase_cntroller.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/offer_page/offer_page.dart';
import 'package:pitch_me_app/View/what%20need/who_need_page_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/strings/images.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';
import '../Need page/need_page.dart';

class FundsPhasePage extends StatefulWidget {
  const FundsPhasePage({super.key});

  @override
  State<FundsPhasePage> createState() => _FundsPhasePageState();
}

class _FundsPhasePageState extends State<FundsPhasePage> {
  final FundingPhaseController fundingPhaseController =
      Get.put(FundingPhaseController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  final WhoNeedController _whoNeedController = Get.put(WhoNeedController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    TextStrings.textKey['fund_phase']!,
                    style: textColor22,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.getSize10(context: context),
                          ),
                          child: customBox(
                              fundingPhaseController.fundingFaseList[0]
                                  ['value'],
                              1,
                              onPressad: () => setState(() {
                                    if (fundingPhaseController
                                            .isChecked.value ==
                                        1) {
                                      fundingPhaseController.isChecked.value =
                                          0;
                                      fundingPhaseController
                                          .isSelectedFundingPhaseItem
                                          .value = '';
                                    } else {
                                      fundingPhaseController.isChecked.value =
                                          1;
                                      fundingPhaseController
                                              .isSelectedFundingPhaseItem
                                              .value =
                                          fundingPhaseController
                                              .fundingFaseList[0]['value'];
                                    }
                                  })),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.getSize10(context: context),
                          ),
                          child: customBox(
                              fundingPhaseController.fundingFaseList[1]
                                  ['value'],
                              2,
                              onPressad: () => setState(() {
                                    if (fundingPhaseController
                                            .isChecked.value ==
                                        2) {
                                      fundingPhaseController.isChecked.value =
                                          0;
                                      fundingPhaseController
                                          .isSelectedFundingPhaseItem
                                          .value = '';
                                    } else {
                                      fundingPhaseController.isChecked.value =
                                          2;
                                      fundingPhaseController
                                              .isSelectedFundingPhaseItem
                                              .value =
                                          fundingPhaseController
                                              .fundingFaseList[1]['value'];
                                    }
                                  })),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.getSize10(context: context),
                          ),
                          child: customBox(
                              fundingPhaseController.fundingFaseList[2]
                                  ['value'],
                              3,
                              onPressad: () => setState(() {
                                    if (fundingPhaseController
                                            .isChecked.value ==
                                        3) {
                                      fundingPhaseController.isChecked.value =
                                          0;
                                      fundingPhaseController
                                          .isSelectedFundingPhaseItem
                                          .value = '';
                                    } else {
                                      fundingPhaseController.isChecked.value =
                                          3;
                                      fundingPhaseController
                                              .isSelectedFundingPhaseItem
                                              .value =
                                          fundingPhaseController
                                              .fundingFaseList[2]['value'];
                                    }
                                  })),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.getSize10(context: context),
                          ),
                          child: customBox(
                              fundingPhaseController.fundingFaseList[3]
                                  ['value'],
                              4,
                              onPressad: () => setState(() {
                                    if (fundingPhaseController
                                            .isChecked.value ==
                                        4) {
                                      fundingPhaseController.isChecked.value =
                                          0;
                                      fundingPhaseController
                                          .isSelectedFundingPhaseItem
                                          .value = '';
                                    } else {
                                      fundingPhaseController.isChecked.value =
                                          4;
                                      fundingPhaseController
                                              .isSelectedFundingPhaseItem
                                              .value =
                                          fundingPhaseController
                                              .fundingFaseList[3]['value'];
                                    }
                                  })),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.getSize10(context: context),
                          ),
                          child: customBox(
                              fundingPhaseController.fundingFaseList[4]
                                  ['value'],
                              5,
                              onPressad: () => setState(() {
                                    if (fundingPhaseController
                                            .isChecked.value ==
                                        5) {
                                      fundingPhaseController.isChecked.value =
                                          0;
                                      fundingPhaseController
                                          .isSelectedFundingPhaseItem
                                          .value = '';
                                    } else {
                                      fundingPhaseController.isChecked.value =
                                          5;
                                      fundingPhaseController
                                              .isSelectedFundingPhaseItem
                                              .value =
                                          fundingPhaseController
                                              .fundingFaseList[4]['value'];
                                    }
                                  })),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.getSize10(context: context),
                          ),
                          child: customBox(
                              fundingPhaseController.fundingFaseList[5]
                                  ['value'],
                              6,
                              onPressad: () => setState(() {
                                    if (fundingPhaseController
                                            .isChecked.value ==
                                        6) {
                                      fundingPhaseController.isChecked.value =
                                          0;
                                      fundingPhaseController
                                          .isSelectedFundingPhaseItem
                                          .value = '';
                                    } else {
                                      fundingPhaseController.isChecked.value =
                                          6;
                                      fundingPhaseController
                                              .isSelectedFundingPhaseItem
                                              .value =
                                          fundingPhaseController
                                              .fundingFaseList[5]['value'];
                                    }
                                  })),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.getSize50(context: context),
                      left: SizeConfig.getFontSize25(context: context),
                      right: SizeConfig.getFontSize25(context: context)),
                  child: customBox('Click here to Understand yours', 7,
                      onPressad: () {
                    setState(() {
                      fundingPhaseController.isChecked.value = 7;
                    });

                    launchUrl(
                        Uri.parse(
                            'https://www.thepitchmeapp.com/post/the-8-stages-of-startup-funding'
                            //'https://www.indeed.com/career-advice/career-development/startup-funding-stages'
                            ),
                        mode: LaunchMode.externalApplication);
                  }),
                )
              ],
            ),
            CustomHeaderView(
              progressPersent: 0.45,
              checkNext: fundingPhaseController
                      .isSelectedFundingPhaseItem.value.isNotEmpty
                  ? 'next'
                  : null,
              nextOnTap: () {
                try {
                  if (_navigationController.navigationType.value == 'Post') {
                    if (_whoNeedController.checkColor2 == 2) {
                      PageNavigateScreen().push(
                          context,
                          NeedPage(
                            key: abcKey,
                          ));
                    } else if (_whoNeedController.checkColor == 1) {
                      PageNavigateScreen().push(
                          context,
                          OfferPage(
                            key: abcKey,
                          ));
                    } else {
                      PageNavigateScreen().push(
                          context,
                          NeedPage(
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

  Widget customBox(String string, int isSelected,
      {required VoidCallback onPressad}) {
    return InkWell(
      onTap: onPressad,
      child: Card(
        elevation:
            isSelected == fundingPhaseController.isChecked.value ? 0 : 10,
        child: Container(
          height: 5.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: DynamicColor.white,
              border: isSelected == fundingPhaseController.isChecked.value
                  ? Border.all(color: DynamicColor.gredient2)
                  : null),
          child: Text(
            string,
            style: TextStyle(
              fontSize: 15.0,
              color: isSelected == fundingPhaseController.isChecked.value
                  ? DynamicColor.gredient2
                  : DynamicColor.black,
              fontWeight: isSelected == fundingPhaseController.isChecked.value
                  ? FontWeight.bold
                  : FontWeight.normal,
              //fontFamily: poppies,
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
