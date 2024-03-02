import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Add%20Image%20Page/addImage_page.dart';
import 'package:pitch_me_app/View/Add%20Image%20Page/controller.dart';
import 'package:pitch_me_app/View/Fund%20Page/fund_neccessar_controller.dart';
import 'package:pitch_me_app/View/Fund%20Page/funds_page_edit.dart';
import 'package:pitch_me_app/View/Funding%20Phase/fund_phase.dart';
import 'package:pitch_me_app/View/Need%20page/need_page_controller.dart';
import 'package:pitch_me_app/View/Need%20page/need_page_edit.dart';
import 'package:pitch_me_app/View/Select%20industry/industry_controller.dart';
import 'package:pitch_me_app/View/Select%20industry/select_industry.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/offer_page/controller.dart';
import 'package:pitch_me_app/View/offer_page/offer_page.dart';
import 'package:pitch_me_app/View/offer_page/selection_person.dart';
import 'package:pitch_me_app/View/what%20need/what_need_page_edit.dart';
import 'package:pitch_me_app/View/what%20need/who_need_page_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../../utils/strings/images.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Funding Phase/fund_phase_cntroller.dart';

class SelectedPage extends StatefulWidget {
  int showIcon;
  PageController pageController;
  SelectedPage(
      {super.key, required this.showIcon, required this.pageController});

  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  final InsdustryController insdustryController =
      Get.put(InsdustryController());

  final WhoNeedController _whoNeedController = Get.put(WhoNeedController());
  final FundNacessaryController _fundNacessaryController =
      Get.put(FundNacessaryController());
  final NeedPageController _needPageController = Get.put(NeedPageController());
  final OfferPageController _offerPageController =
      Get.put(OfferPageController());
  final AddImageController _addImageController = Get.put(AddImageController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  final FundingPhaseController fundingPhaseController =
      Get.put(FundingPhaseController());

  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    _whoNeedController.checkType.value = '';
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            Column(
              children: [
                spaceHeight(SizeConfig.getSize40(context: context)),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text('Details Editing', style: gredient116bold),
                          GestureDetector(
                            onTap: () {
                              widget.pageController.previousPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.linear);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 10, right: 7),
                                child: /* SvgPicture.asset(Assets.tiktokPreviousIco),*/
                                    RotatedBox(
                                  quarterTurns: 6,
                                  child: Image.asset(
                                    "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                    height:
                                        SizeConfig.getSize35(context: context),
                                    width:
                                        SizeConfig.getSize35(context: context),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Expanded(child: appStatistics(context: context)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appStatistics({required BuildContext context}) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          customWidget(
              "What Industry", insdustryController.selectedIndustry.value, 1,
              onPressad: () {
            setState(() {
              isSelect = 1;
            });
            _navigationController.navigationType.value = 'Edit';
            PageNavigateScreen()
                .push(
                    context,
                    SelectIndustryPage(
                      bottombarCheck: true,
                    ))
                .then((value) {
              setState(() {});
            });
          }),
          // customWidget(
          //     "",
          //     _locationPageController.selectedType.value == 'Place'
          //         ? _locationPageController.searchController.text
          //         : _locationPageController.selectedType.value, onPressad: () {
          //   _navigationController.navigationType.value = 'Edit';
          //   PageNavigateScreen().push(context, LocationPage()).then((value) {
          //     setState(() {});
          //   });
          // }),
          _whoNeedController.checkColor == 1
              ? customWidget("Who is Needed", "Investor", 2, onPressad: () {
                  setState(() {
                    isSelect = 2;
                  });
                  _navigationController.navigationType.value = 'Edit';
                  PageNavigateScreen()
                      .push(context, WhatNeedPageEdit())
                      .then((value) {
                    setState(() {});
                  });
                })
              : Container(),
          _fundNacessaryController.selectedValue.value.isNotEmpty
              ? Obx(() {
                  return customWidget(
                      "How much",
                      'USD ${_fundNacessaryController.selectedValue.value}',
                      3, onPressad: () {
                    setState(() {
                      isSelect = 3;
                    });
                    _navigationController.navigationType.value = 'Edit';
                    PageNavigateScreen()
                        .push(
                            context,
                            FundsPageEdit(
                              isCheck: false,
                              length: const [],
                            ))
                        .then((value) {
                      setState(() {});
                    });
                  });
                })
              : Container(),
          fundingPhaseController.isSelectedFundingPhaseItem.value.isNotEmpty
              ? Obx(() {
                  return customWidget(
                      "Funding Phase",
                      fundingPhaseController.isSelectedFundingPhaseItem.value,
                      5, onPressad: () {
                    setState(() {
                      isSelect = 5;
                    });
                    _navigationController.navigationType.value = 'Edit';
                    PageNavigateScreen()
                        .push(context, FundsPhasePage())
                        .then((value) {
                      setState(() {});
                    });
                  });
                })
              : Container(),
          _whoNeedController.checkColor2 == 2
              ? customWidget("Who is Needed", "Service Provider", 4,
                  onPressad: () {
                  setState(() {
                    isSelect = 4;
                  });
                  _navigationController.navigationType.value = 'Edit';
                  PageNavigateScreen()
                      .push(context, WhatNeedPageEdit())
                      .then((value) {
                    setState(() {});
                  });
                })
              : Container(),
          _needPageController.itemType.value.isNotEmpty ||
                  (_needPageController.data2[0]['isSelected'] == true ||
                      _needPageController.data2[1]['isSelected'] == true)
              ? Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount:
                          _needPageController.selectedNeedType.value.length,
                      itemBuilder: (context, index) {
                        return customWidget(
                            "What is Needed",
                            _needPageController.selectedNeedType.value[index]
                                ['value'],
                            5, onPressad: () {
                          setState(() {
                            isSelect = 5;
                          });
                          _navigationController.navigationType.value = 'Edit';
                          PageNavigateScreen()
                              .push(context,
                                  NeedPageEdit(isCheck: false, length: []))
                              .then((value) {
                            setState(() {});
                          });
                        });
                      });
                })
              : Container(),

          _needPageController.itemType.value.isNotEmpty
              ? Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount: _needPageController
                          .searchingSelectedItems.value.length,
                      itemBuilder: (context, index) {
                        return customWidget(
                            "What is Needed",
                            _needPageController
                                .searchingSelectedItems.value[index],
                            6, onPressad: () {
                          setState(() {
                            isSelect = 6;
                          });
                          _navigationController.navigationType.value = 'Edit';
                          PageNavigateScreen()
                              .push(context,
                                  NeedPageEdit(isCheck: false, length: []))
                              .then((value) {
                            setState(() {});
                          });
                        });
                      });
                })
              : Container(),
          offerDetailWidget("Initial Offer",
              _offerPageController.offrerTextController.text, 7, onPressad: () {
            setState(() {
              isSelect = 7;
            });
            _navigationController.navigationType.value = 'Edit';
            PageNavigateScreen().push(context, OfferPage()).then((value) {
              setState(() {});
            });
          }),
          _offerPageController.selectedPersonType.value.isNotEmpty
              ? Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount:
                          _offerPageController.selectedPersonType.value.length,
                      itemBuilder: (context, index) {
                        // log(_offerPageController.selectedPersonType.value
                        //     .toString());
                        return customWidget(
                            "Who can see",
                            _offerPageController.selectedPersonType.value[index]
                                ['value'],
                            8, onPressad: () {
                          setState(() {
                            isSelect = 8;
                          });
                          _navigationController.navigationType.value = 'Edit';
                          PageNavigateScreen()
                              .push(context, SelectionPersonPage())
                              .then((value) {
                            setState(() {});
                          });
                        });
                      });
                })
              : Container(),
          spaceHeight(SizeConfig.getSize20(context: context)),
          _imagesGridView(),
          spaceHeight(SizeConfig.getSize100(context: context)),
        ],
      )),
    );
  }

  Widget _imagesGridView() {
    return _addImageController.listImagePaths.isEmpty &&
            _addImageController.filePath.isEmpty
        ? Container()
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            shrinkWrap: true,
            itemCount: _addImageController.listImagePaths.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                mainAxisExtent: 130),
            itemBuilder: (context, index) {
              if (index == _addImageController.listImagePaths.length) {
                return _addImageController.filePath.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _navigationController.navigationType.value = 'Edit';
                          PageNavigateScreen()
                              .push(context, AddImagePage())
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: const [
                                Color(0xff5388C0),
                                Color(0xff67C8B5)
                              ]),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/pdf.png'))),
                        ),
                      )
                    : Container();
              }
              return InkWell(
                onTap: () {
                  _navigationController.navigationType.value = 'Edit';
                  PageNavigateScreen()
                      .push(context, AddImagePage())
                      .then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(_addImageController
                              .listImagePaths[index]
                              .toString())))),
                ),
              );
            },
          );
  }

  Widget customWidget(title, name, int selected,
      {required VoidCallback onPressad}) {
    final sizeH = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onPressad,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title, style: black14w5),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context),
            ),
            child: Card(
              elevation: isSelect == selected ? 0 : 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  height: sizeH * 0.068,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                      gradient: isSelect == selected
                          ? null
                          : DynamicColor.gradientColorChange,
                      color: isSelect == selected ? DynamicColor.white : null,
                      borderRadius: BorderRadius.circular(10),
                      border: isSelect == selected
                          ? Border.all(color: DynamicColor.gredient2)
                          : null),
                  child: Text(
                    name,
                    style: TextStyle(
                        color: isSelect == selected
                            ? DynamicColor.gredient1
                            : DynamicColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget offerDetailWidget(title, name, int selected,
      {required VoidCallback onPressad}) {
    final sizeH = MediaQuery.of(context).size.height;

    int wordscount = RegExp.escape(name).length;

    return InkWell(
      onTap: onPressad,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title, style: black14w5),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context),
            ),
            child: Card(
              elevation: isSelect == selected ? 0 : 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  height: wordscount > 70 ? null : sizeH * 0.068,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      gradient: isSelect == selected
                          ? null
                          : DynamicColor.gradientColorChange,
                      color: isSelect == selected ? DynamicColor.white : null,
                      borderRadius: BorderRadius.circular(10),
                      border: isSelect == selected
                          ? Border.all(color: DynamicColor.gredient2)
                          : null),
                  child: Text(
                    name,
                    style: TextStyle(
                        color: isSelect == selected
                            ? DynamicColor.gredient1
                            : DynamicColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
