import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/Controller/filter_controller.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/filter_page.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/industry_filter.dart';
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
import '../Fund Page/fund_neccessar_controller.dart';
import '../Manu/manu.dart';
import '../Need page/need_page_controller.dart';
import '../what need/who_need_page_controller.dart';

class NeedFilterPage extends StatefulWidget {
  const NeedFilterPage({super.key});

  @override
  State<NeedFilterPage> createState() => _NeedFilterPageState();
}

class _NeedFilterPageState extends State<NeedFilterPage> {
  SalesPitchFilterController controller = Get.put(SalesPitchFilterController());
  bool isKeyboardOpen = false;

  @override
  void initState() {
    super.initState();
    getFilterData();
  }

  void getFilterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var needs = jsonDecode(prefs.getString('needs').toString());
    log(needs.toString());
    setState(() {
      if (needs != null) {
        controller.investorAndSpItem.clear();
        controller.isSelectedNeeds.clear();
        controller.isSelecetRangList.clear();
        controller.isSelectedFundingPhaseItem.clear();
        controller.searchingSelectedItemsSP.clear();
        controller.searchingItemsSP.clear();
        controller.selectedNeedTypeSP.clear();
        // Investor
        for (var i = 0; i < needs['investor_sp'].length; i++) {
          for (var element in controller.investorAndSpList) {
            if (needs['investor_sp'][i] == element['value']) {
              controller.investorAndSpItem.add(element['value']);
              element['isSelected'] = true;
            }
          }
        }
        if (needs['investor_type'].length > 0) {
          for (var i = 0; i < needs['investor_type'].length; i++) {
            for (var element in controller.rangAndPhaseList) {
              if (needs['investor_type'][i] == element['value']) {
                controller.isSelectedNeeds.add(element['value']);
                element['isSelected'] = true;
              }
            }
          }
        }
        if (needs['fund_rang'].length > 0) {
          for (var i = 0; i < needs['fund_rang'].length; i++) {
            for (var element in controller.rangListdata) {
              if (needs['fund_rang'][i] == element['divide_by']) {
                controller.isSelecetRangList.add(element);
                element['isSelected'] = true;
              }
            }
          }
        }
        if (needs['fund_phase'].length > 0) {
          for (var i = 0; i < needs['fund_phase'].length; i++) {
            for (var element in controller.fundingFaseList) {
              if (needs['fund_phase'][i] == element['value']) {
                controller.isSelectedFundingPhaseItem.add(element['value']);
                element['isSelected'] = true;
              }
            }
          }
        }
        // Service Provider
        if (needs['service_provider_type'].length > 0) {
          for (var i = 0; i < needs['service_provider_type'].length; i++) {
            if (needs['service_provider_type'][i] == 'Take Over' ||
                needs['service_provider_type'][i] == 'Buy Out') {
              for (var element in controller.spListdata2) {
                if (needs['service_provider_type'][i] == element['value']) {
                  controller.selectedNeedTypeSP.add(element);
                  controller.spCustomText.value = element['value'];
                  element['isSelected'] = true;
                }
              }
            } else {
              for (var element in controller.spListdata) {
                if (needs['service_provider_type'][i] == element['value']) {
                  controller.selectedNeedTypeSP.add(element);
                  controller.spCustomText.value = element['value'];
                  element['isSelected'] = true;

                  controller.getServiceApiCall(element['value'], true);
                }
              }
            }
          }
          Timer(const Duration(seconds: 2), () {
            if (needs['service_provider_searched'].length > 0) {
              for (var i = 0; i < controller.searchingItemsSP.length; i++) {
                for (var element in needs['service_provider_searched']) {
                  if (controller.searchingItemsSP[i] == element) {
                    controller.searchingSelectedItemsSP
                        .add(controller.searchingItemsSP[i]);
                  }
                }
              }
            }
            setState(() {});
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          ClipPath(
                            clipper: CurveClipper(),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: DynamicColor.gradientColorChange),
                              height: MediaQuery.of(context).size.height * 0.27,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.getSizeHeightBy(
                                    context: context, by: 0.15)),
                            child: whiteBorderContainer(
                                child: Image.asset(Assets.handshakeImage),
                                color: Colors.transparent,
                                height: SizeConfig.getSizeHeightBy(
                                    context: context, by: 0.12),
                                width: SizeConfig.getSizeHeightBy(
                                    context: context, by: 0.12),
                                cornerRadius: 25),
                          ),
                          ComanFilterIcon(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: DynamicColor.black))),
                          child: Text(
                            'Choose what type of Pitches you want to see',
                            style: textColor12,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        FilterTitleComanWidget(
                          context: context,
                          title: TextStrings.textKey['needs']!,
                        ),
                        investorAndServicePrvider(),
                        // Investor
                        spaceHeight(SizeConfig.getSizeHeightBy(
                            context: context,
                            by: controller.investorAndSpItem.value.isEmpty
                                ? 0.03
                                : 0.01)),
                        controller.investorAndSpItem.value.isEmpty
                            ? footerHint()
                            : Container(),
                        controller.investorAndSpItem.value.contains('Investor')
                            ? fundAndFase()
                            : Container(),
                        spaceHeight(SizeConfig.getSizeHeightBy(
                            context: context,
                            by: controller.isSelectedNeeds.value
                                    .contains('Funds Range')
                                ? 0.01
                                : 0.0)),
                        controller.isSelectedNeeds.value.contains('Funds Range')
                            ? fundRangWidget()
                            : Container(),
                        controller.isSelectedNeeds.value
                                    .contains('Funds Range') &&
                                controller.isSelectedNeeds.value
                                    .contains('Funding Phase')
                            ? Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width - 60,
                                color: DynamicColor.black,
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                              )
                            : Container(),
                        controller.isSelectedNeeds.value
                                .contains('Funding Phase')
                            ? fundingPhaseWidget()
                            : Container(),
                        (controller.isSelectedNeeds.value
                                        .contains('Funds Range') ||
                                    controller.isSelectedNeeds.value
                                        .contains('Funding Phase')) &&
                                controller.investorAndSpItem.value
                                    .contains('Service Provider')
                            ? Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width - 60,
                                color: DynamicColor.black,
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                              )
                            : Container(),
                        // Service Provider
                        controller.investorAndSpItem.value
                                .contains('Service Provider')
                            ? serviceProviderWidget()
                            : Container(),
                        SizedBox(
                            height: SizeConfig.getSize80(context: context)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: TextStrings.textKey['filter_pitch']!,
              backCheckBio: 'back',
              backOnTap: () {
                controller.finalSelectedData['needs'] = null;
                Navigator.of(context).pop();
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
            (controller.isSelecetRangList.value.isNotEmpty ||
                        controller
                            .isSelectedFundingPhaseItem.value.isNotEmpty) ||
                    controller.searchingSelectedItemsSP.value.isNotEmpty ||
                    (controller.selectedNeedTypeSP.value.isNotEmpty &&
                            controller.selectedNeedTypeSP.value[0]['value'] ==
                                'Take Over' ||
                        controller.selectedNeedTypeSP.value.isNotEmpty &&
                            controller.selectedNeedTypeSP.value[0]['value'] ==
                                'Buy Out')
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

  Widget investorAndServicePrvider() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customBox(
            controller.investorAndSpList[0]['value'],
            controller.investorAndSpList[0]['isSelected'],
            onPressad: () {
              setState(() {});
              controller
                  .onselectinvestorAndSpItem(controller.investorAndSpList[0]);
              if (controller.investorAndSpList[0]['isSelected'] == false) {
                controller.isSelectedNeeds.value.clear();
                controller.rangAndPhaseList[0]['isSelected'] = false;
                controller.rangAndPhaseList[1]['isSelected'] = false;
                controller.isSelecetRangList.value.clear();
                controller.fundingFaseList[0]['isSelected'] = false;
                controller.fundingFaseList[1]['isSelected'] = false;
                controller.fundingFaseList[2]['isSelected'] = false;
                controller.fundingFaseList[3]['isSelected'] = false;
                controller.fundingFaseList[4]['isSelected'] = false;
                controller.fundingFaseList[5]['isSelected'] = false;
                controller.rangListdata[0]['isSelected'] = false;
                controller.rangListdata[1]['isSelected'] = false;
                controller.rangListdata[2]['isSelected'] = false;
                controller.rangListdata[3]['isSelected'] = false;
                controller.rangListdata[4]['isSelected'] = false;
                controller.rangListdata[5]['isSelected'] = false;
                controller.isSelectedFundingPhaseItem.value.clear();
              }
            },
          ),
          Container(
            width: 2,
          ),
          customBox(
            controller.investorAndSpList[1]['value'],
            controller.investorAndSpList[1]['isSelected'],
            onPressad: () {
              setState(() {
                controller
                    .onselectinvestorAndSpItem(controller.investorAndSpList[1]);
                if (controller.investorAndSpList[1]['isSelected'] == false) {
                  controller.searchingItemsSP.clear();
                  controller.searchingSelectedItemsSP.clear();
                  controller.selectedNeedTypeSP.clear();
                  controller.spListdata[0]['isSelected'] = false;
                  controller.spListdata[1]['isSelected'] = false;
                  controller.spListdata[2]['isSelected'] = false;
                  controller.spListdata2[0]['isSelected'] = false;
                  controller.spListdata2[1]['isSelected'] = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }

// Investor
  Widget fundAndFase() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customBox(
            controller.rangAndPhaseList[0]['value'],
            controller.rangAndPhaseList[0]['isSelected'],
            onPressad: () {
              setState(() {});
              controller
                  .onselectRangAndFundsItem(controller.rangAndPhaseList[0]);
              if (controller.rangAndPhaseList[0]['isSelected'] == false) {
                controller.isSelecetRangList.value.clear();
                controller.rangListdata[0]['isSelected'] = false;
                controller.rangListdata[1]['isSelected'] = false;
                controller.rangListdata[2]['isSelected'] = false;
                controller.rangListdata[3]['isSelected'] = false;
                controller.rangListdata[4]['isSelected'] = false;
                controller.rangListdata[5]['isSelected'] = false;
                controller.isSelectedFundingPhaseItem.value.clear();
              }
            },
          ),
          Container(
            width: 2,
          ),
          customBox(
            controller.rangAndPhaseList[1]['value'],
            controller.rangAndPhaseList[1]['isSelected'],
            onPressad: () {
              setState(() {
                controller
                    .onselectRangAndFundsItem(controller.rangAndPhaseList[1]);
                if (controller.rangAndPhaseList[1]['isSelected'] == false) {
                  controller.isSelecetRangList.value.clear();
                  controller.fundingFaseList[0]['isSelected'] = false;
                  controller.fundingFaseList[1]['isSelected'] = false;
                  controller.fundingFaseList[2]['isSelected'] = false;
                  controller.fundingFaseList[3]['isSelected'] = false;
                  controller.fundingFaseList[4]['isSelected'] = false;
                  controller.fundingFaseList[5]['isSelected'] = false;
                  controller.isSelectedFundingPhaseItem.value.clear();
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget fundRangWidget() {
    return GridView(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 9.0,
          mainAxisExtent: 50),
      children: List.generate(controller.rangListdata.length, (index) {
        return fundRangcustomBox(controller.rangListdata[index]['value'],
            controller.rangListdata[index]['isSelected'],
            onPressad: () => setState(() {
                  //  isIndex = index;
                  controller.onselectRangAmount(controller.rangListdata[index]);
                }),
            checkType: true);
      }),
    );
  }

  Widget fundingPhaseWidget() {
    return GridView(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 9.0,
          mainAxisExtent: 50),
      children: List.generate(controller.fundingFaseList.length, (index) {
        return fundRangcustomBox(controller.fundingFaseList[index]['value'],
            controller.fundingFaseList[index]['isSelected'],
            onPressad: () => setState(() {
                  controller.onselectNeedsFundingPhase(
                      controller.fundingFaseList[index]);
                }),
            checkType: false);
      }),
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

  Widget fundRangcustomBox(String string, i,
      {required VoidCallback onPressad, required bool checkType}) {
    return InkWell(
      onTap: onPressad,
      child: Card(
        elevation: i ? 0 : 10,
        child: Container(
          height: 5.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: DynamicColor.white,
              border: i ? Border.all(color: DynamicColor.gredient2) : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              checkType
                  ? Image.asset(
                      'assets/imagess/Path 486.png',
                      width: 15,
                    )
                  : Container(),
              checkType ? const SizedBox(width: 3) : Container(),
              Text(
                string,
                style: TextStyle(
                  fontSize: 15.0,
                  color: i ? DynamicColor.gredient2 : DynamicColor.black,
                  fontWeight: i ? FontWeight.bold : FontWeight.normal,
                  //fontFamily: poppies,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

// Service Provider
  Widget serviceProviderWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: fundRangcustomBox(controller.spListdata[0]['value'],
                      controller.spListdata[0]['isSelected'], onPressad: () {
                setState(() {
                  controller.spOnselectValue(0);
                  controller.spCustomText.value =
                      'E.g. Languages, Coding, Sales, etc';
                });
              }, checkType: false)),
              Expanded(
                  child: fundRangcustomBox(controller.spListdata[1]['value'],
                      controller.spListdata[1]['isSelected'], onPressad: () {
                setState(() {
                  controller.spOnselectValue(1);
                  controller.spCustomText.value =
                      'E.g. Lawyer, Marketing, Real Estate, etc';
                });
              }, checkType: false)),
              Expanded(
                  child: fundRangcustomBox(controller.spListdata[2]['value'],
                      controller.spListdata[2]['isSelected'], onPressad: () {
                setState(() {
                  controller.spOnselectValue(2);
                  controller.spCustomText.value =
                      'E.g. That ¨introduction¨ that makes all the Difference';
                });
              }, checkType: false)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: 10,
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: fundRangcustomBox(controller.spListdata2[0]['value'],
                      controller.spListdata2[0]['isSelected'], onPressad: () {
                setState(() {
                  controller.spOnselectValue2(0, 1);
                  controller.spCustomText.value =
                      'E.g. Professional to manage on your Behalf';

                  controller.searchingSelectedItemsSP.value = [];
                  controller.spTextController.text = '';
                  controller.searchingItemsSP.value = [];
                });
              }, checkType: false)),
              Expanded(child: Container()),
              Expanded(
                  child: fundRangcustomBox(controller.spListdata2[1]['value'],
                      controller.spListdata2[1]['isSelected'], onPressad: () {
                setState(() {
                  controller.spOnselectValue2(1, 0);
                  controller.spCustomText.value =
                      'E.g. Sell your Idea or Business';

                  controller.searchingSelectedItemsSP.value = [];
                  controller.spTextController.text = '';
                  controller.searchingItemsSP.value = [];
                });
              }, checkType: false)),
            ],
          ),
        ),
        controller.spCustomText.value.isNotEmpty ? _searchBar() : Container(),
        searchItemList(),
        isKeyboardOpen == true
            ? SizedBox(
                height: SizeConfig.getSize100(context: context) +
                    SizeConfig.getSize100(context: context) +
                    SizeConfig.getSize40(context: context),
              )
            : Container(),
      ],
    );
  }

  Widget _searchBar() {
    return (controller.spListdata2[0]['isSelected'] == true ||
            controller.spListdata2[1]['isSelected'] == true)
        ? Container()
        : Obx(() {
            return controller.selectedNeedTypeSP.value.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 10),
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              cursorHeight: 22,
                              controller: controller.spTextController,
                              style: gredient116bold,
                              onTap: () {
                                setState(() {
                                  isKeyboardOpen = true;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  controller.hideList.value = false;
                                });
                              },
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  isKeyboardOpen = false;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Type',
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: DynamicColor.lightGrey),
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                border: InputBorder.none,
                                enabledBorder: outlineInputBorderBlue,
                                focusedBorder: outlineInputBorderBlue,
                                errorBorder: outlineInputBorderBlue,
                                focusedErrorBorder: outlineInputBorderBlue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          // width: MediaQuery.of(context).size.width - 80,
                          // padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              runAlignment: WrapAlignment.start,
                              runSpacing: 5.0,
                              children: List.generate(
                                  controller.searchingSelectedItemsSP.value
                                      .length, (index) {
                                dynamic data = controller
                                    .searchingSelectedItemsSP.value[index];

                                return Container(
                                  height: 45,
                                  //  padding: EdgeInsets.only(left: 10, right: 10),
                                  margin: EdgeInsets.only(right: 5, left: 15),
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      //margin: EdgeInsets.only(right: 5, left: 15),
                                      decoration: BoxDecoration(
                                        gradient:
                                            DynamicColor.gradientColorChange,
                                      ),
                                      child: Wrap(
                                        // alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        runAlignment: WrapAlignment.center,
                                        children: [
                                          Text(
                                            data,
                                            style: white13TextStyle,
                                          ),
                                          SizedBox(width: 5),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                controller
                                                    .searchingSelectedItemsSP
                                                    .value
                                                    .remove(data);
                                              });
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: DynamicColor.white,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        )
                      ],
                    ),
                  );
          });
  }

  Widget searchItemList() {
    return (
                //controller.searchingSelectedItemsSP.isEmpty &&
                controller.spTextController.text.isEmpty) ||
            controller.hideList.value == true
        ? Container()
        : Container(
            //height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.15),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child:
                  GetBuilder<SalesPitchFilterController>(builder: (controller) {
                return ListView.builder(
                    itemCount: controller.searchingItemsSP.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    //separatorBuilder: (context, index) =>
                    itemBuilder: (context, index) {
                      dynamic data = controller.searchingItemsSP[index];

                      if (listFlitter(data)) {
                        return Visibility(
                          visible: !controller.searchingSelectedItemsSP.value
                              .contains(data),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ChoiceChip(
                              label: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  data,
                                  style: controller
                                          .searchingSelectedItemsSP.value
                                          .contains(data)
                                      ? white13TextStyle
                                      : null,
                                ),
                              ),
                              selected: controller
                                  .searchingSelectedItemsSP.value
                                  .contains(data),
                              selectedColor: DynamicColor.gredient1,
                              backgroundColor: DynamicColor.white,
                              onSelected: (value) {
                                controller.spTextController.text = '';
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (value == true) {
                                  setState(() {
                                    isKeyboardOpen = false;
                                    controller.searchingSelectedItemsSP.value
                                        .add(data);
                                    controller.hideList.value = true;
                                  });
                                } else {
                                  setState(() {
                                    controller.searchingSelectedItemsSP.value
                                        .remove(data);
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    });
              }),
            ),
          );
  }

  bool listFlitter(String name) {
    if (name
        .toLowerCase()
        .contains(controller.spTextController.text.toLowerCase())) {
      return true;
    }
    return false;
  }

  Widget footerHint() {
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
            onTap: () async {
              var s = [];
              var spType = [];

              for (var element in controller.isSelecetRangList.value) {
                s.add(element['divide_by']);
              }
              for (var element in controller.selectedNeedTypeSP.value) {
                spType.add(element['value']);
              }

              var d = {
                'investor_sp': controller.investorAndSpItem.value,
                'investor_type': controller.isSelectedNeeds.value,
                'fund_rang': s,
                'fund_phase': controller.isSelectedFundingPhaseItem.value,
                'service_provider_type': spType,
                'service_provider_searched':
                    controller.searchingSelectedItemsSP.value,
              };

              controller.finalSelectedData['needs'] = d;
              // log(controller.investorFundRangeController.selectRangeforFilter
              //     .toString());
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('needs', jsonEncode(d));
              PageNavigateScreen().back(context);
              Get.delete<WhoNeedController>(force: true);
              Get.delete<FundNacessaryController>(force: true);
              Get.delete<NeedPageController>(force: true);
            },
          )),
    );
  }
}
