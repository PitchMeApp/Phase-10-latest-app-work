import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/Controller/filter_controller.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/filter_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../models/industry_model.dart';
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

class IndustryFilterPage extends StatefulWidget {
  const IndustryFilterPage({super.key});

  @override
  State<IndustryFilterPage> createState() => _IndustryFilterPageState();
}

class _IndustryFilterPageState extends State<IndustryFilterPage> {
  SalesPitchFilterController controller = Get.put(SalesPitchFilterController());
  @override
  void initState() {
    super.initState();
    getFilterData();
  }

  void getFilterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var industry = jsonDecode(prefs.getString('industry').toString());

    setState(() {
      controller.selectedIndustrys.value = industry;
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
                          title: TextStrings.textKey['industry']!,
                        ),
                        searchBar(),
                        searchItemList(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3),
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
                controller.finalSelectedData['industry'] = null;
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
            controller.selectedIndustrys.value.isNotEmpty
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
            onTap: () async {
              var s = [];
              for (var element in controller.selectedIndustrys.value) {
                s.add(element);
              }
              controller.finalSelectedData['industry'] = s;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('industry', jsonEncode(s));
              PageNavigateScreen().back(context);
            },
          )),
    );
  }

  Widget searchBar() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Column(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width - 95,
                child: TextFormField(
                  cursorHeight: 22,
                  controller: controller.industryTextController,
                  style: gredient116bold,
                  onTap: () {},
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onChanged: (value) {
                    setState(() {
                      controller.hideList.value = false;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Type',
                    hintStyle:
                        TextStyle(fontSize: 15, color: DynamicColor.lightGrey),
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
                      controller.selectedIndustrys.value.length, (index) {
                    dynamic data = controller.selectedIndustrys.value[index];
                    return Container(
                      height: 45,
                      //  padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(right: 5, left: 15),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          //margin: EdgeInsets.only(right: 5, left: 15),
                          decoration: BoxDecoration(
                            gradient: DynamicColor.gradientColorChange,
                          ),
                          child: Wrap(
                            // alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
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
                                    controller.selectedIndustrys.value
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
                //_needPageController.searchingSelectedItems.isEmpty &&
                controller.industryTextController.text.isEmpty) ||
            controller.hideList.value == true
        ? Container()
        : Container(
            // height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.15),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: GetBuilder<SalesPitchFilterController>(
                  builder: (filterController) {
                return ListView.builder(
                    itemCount: filterController.industryList.result.docs.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    //separatorBuilder: (context, index) =>
                    itemBuilder: (context, index) {
                      Doc data =
                          filterController.industryList.result.docs[index];

                      if (listFlitter(data.name)) {
                        return Visibility(
                          visible: !filterController.selectedIndustrys.value
                              .contains(data.name),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ChoiceChip(
                              label: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  data.name,
                                  style: filterController
                                          .selectedIndustrys.value
                                          .contains(data.name)
                                      ? white13TextStyle
                                      : null,
                                ),
                              ),
                              selected: filterController.selectedIndustrys.value
                                  .contains(data.name),
                              selectedColor: DynamicColor.gredient1,
                              backgroundColor: DynamicColor.white,
                              onSelected: (value) {
                                filterController.industryTextController.text =
                                    '';
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (value == true) {
                                  setState(() {
                                    //  isKeyboardOpen = false;
                                    filterController.selectedIndustrys.value
                                        .add(data.name);
                                    filterController.hideList.value = true;
                                  });
                                } else {
                                  setState(() {
                                    filterController.selectedIndustrys.value
                                        .remove(data.name);
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
        .contains(controller.industryTextController.text.toLowerCase())) {
      return true;
    }
    return false;
  }
}

class FilterTitleComanWidget extends StatelessWidget {
  FilterTitleComanWidget({
    super.key,
    required this.context,
    required this.title,
  });

  final BuildContext context;
  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getSize40(context: context),
          right: SizeConfig.getSize40(context: context)),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 6.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: DynamicColor.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: DynamicColor.gredient1)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.remove, size: 30, color: DynamicColor.redColor),
                  Text(
                    title.toUpperCase(),
                    style: gredient116bold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 40, width: 40)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
