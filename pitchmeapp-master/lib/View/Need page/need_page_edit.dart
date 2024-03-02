import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Need%20page/need_page_controller.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors/colors.dart';
import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';

class NeedPageEdit extends StatefulWidget {
  bool isCheck;
  List length;
  NeedPageEdit({super.key, required this.isCheck, required this.length});

  @override
  State<NeedPageEdit> createState() => _NeedPageEditState();
}

class _NeedPageEditState extends State<NeedPageEdit> {
  final NeedPageController _needPageController = Get.put(NeedPageController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isKeyboardOpen = false;
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
              child: Form(
                key: formKey,
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
                        TextStrings.textKey['needs']!,
                        style: textColor22,
                      ),
                    ),
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
                              child: customBox(
                                  10.0,
                                  10.0,
                                  0.0,
                                  0.0,
                                  Icons.list_alt,
                                  _needPageController.data[0]['value'],
                                  _needPageController.data[0]['isSelected'],
                                  onPressad: () {
                            setState(() {
                              _needPageController.checkColor.value = 1;
                              _needPageController.onselectValue(0);
                              if (_needPageController.data[0]['isSelected'] ==
                                  true) {
                                _needPageController.itemType.value = 'Skill';
                              }
                            });
                          })),
                          Expanded(
                              child: customBox(
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            Icons.settings_suggest,
                            _needPageController.data[1]['value'],
                            _needPageController.data[1]['isSelected'],
                            onPressad: () {
                              setState(() {
                                _needPageController.checkColor.value = 1;
                                _needPageController.onselectValue(1);
                                if (_needPageController.data[1]['isSelected'] ==
                                    true) {
                                  _needPageController.itemType.value =
                                      'Service';
                                }
                              });
                            },
                          )),
                          Expanded(
                              child: customBox(
                            0.0,
                            0.0,
                            10.0,
                            10.0,
                            Icons.group,
                            _needPageController.data[2]['value'],
                            _needPageController.data[2]['isSelected'],
                            onPressad: () {
                              setState(() {
                                _needPageController.checkColor.value = 1;
                                _needPageController.onselectValue(2);
                                if (_needPageController.data[2]['isSelected'] ==
                                    true) {
                                  _needPageController.itemType.value =
                                      'Connection';
                                }
                              });
                            },
                          )),
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
                              child: customBox(
                                  10.0,
                                  10.0,
                                  0.0,
                                  0.0,
                                  Icons.chair_alt,
                                  _needPageController.data2[0]['value'],
                                  _needPageController.data2[0]['isSelected'],
                                  onPressad: () {
                            setState(() {
                              _needPageController.checkColor.value = 1;
                              _needPageController.onselectValue2(0, 1);

                              _needPageController.searchingSelectedItems.value =
                                  [];
                              _needPageController.textController.text = '';
                              _needPageController.searchingItems.value = [];
                            });
                          })),
                          Expanded(child: Container()),
                          Expanded(
                              child: customBox(
                            0.0,
                            0.0,
                            10.0,
                            10.0,
                            Icons.local_atm,
                            _needPageController.data2[1]['value'],
                            _needPageController.data2[1]['isSelected'],
                            onPressad: () {
                              setState(() {
                                _needPageController.checkColor.value = 1;
                                _needPageController.onselectValue2(1, 0);

                                _needPageController
                                    .searchingSelectedItems.value = [];
                                _needPageController.textController.text = '';
                                _needPageController.searchingItems.value = [];
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                    _needPageController.selectedNeedType.value.isEmpty
                        ? Container()
                        : _footerHint(),
                    _searchBar(),
                    searchItemList(),
                    isKeyboardOpen == true
                        ? SizedBox(
                            height: SizeConfig.getSize100(context: context) +
                                SizeConfig.getSize100(context: context) +
                                SizeConfig.getSize40(context: context),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            CustomHeaderView(
              progressPersent: 0.5,
              checkNext: _needPageController
                          .searchingSelectedItems.isNotEmpty ||
                      (_needPageController.data2[0]['isSelected'] == true ||
                          _needPageController.data2[1]['isSelected'] == true)
                  ? 'next'
                  : null,
              nextOnTap: () {
                try {
                  if (formKey.currentState!.validate() == true) {
                    setState(() {});
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (widget.length.length > 1) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      if (widget.isCheck == true) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                      }
                    }
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
    return Obx(() {
      return ListView.builder(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.only(top: 5, bottom: 5),
          itemCount: _needPageController.selectedNeedType.value.length,
          itemBuilder: (context, index) {
            return Center(
              child: Text(
                _needPageController.selectedNeedType.value[index]['msg'],
                style: textColor12,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          });
    });
  }

  Widget _searchBar() {
    return (_needPageController.data2[0]['isSelected'] == true ||
            _needPageController.data2[1]['isSelected'] == true)
        ? Container()
        : Obx(() {
            return _needPageController.selectedNeedType.value.isEmpty
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
                            width: MediaQuery.of(context).size.width - 95,
                            child: TextFormField(
                              cursorHeight: 22,
                              controller: _needPageController.textController,
                              style: gredient116bold,
                              onTap: () {
                                setState(() {
                                  isKeyboardOpen = true;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _needPageController.hideList.value = false;
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
                                  hintText: 'Search options or add Yours',
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: DynamicColor.lightGrey),
                                  contentPadding: const EdgeInsets.only(
                                    //bottom: 10,
                                    left: 10,
                                    right: 10,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: outlineInputBorderBlue,
                                  focusedBorder: outlineInputBorderBlue,
                                  errorBorder: outlineInputBorderBlue,
                                  focusedErrorBorder: outlineInputBorderBlue,
                                  suffixIcon: _needPageController
                                          .textController.text.isEmpty
                                      ? null
                                      : InkWell(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            setState(() {
                                              var postData = {
                                                "type": _needPageController
                                                    .selectedNeedType
                                                    .value[_needPageController
                                                        .selectedNeedType
                                                        .value
                                                        .length -
                                                    1]['value'],
                                                "name": _needPageController
                                                    .textController.text,
                                              };

                                              if (_needPageController
                                                  .textController
                                                  .text
                                                  .isNotEmpty) {
                                                var check = '';
                                                var s = _needPageController
                                                    .textController.text
                                                    .trim();
                                                for (var item
                                                    in _needPageController
                                                        .searchingItems.value) {
                                                  if (item == s) {
                                                    check = 'yes';
                                                  }
                                                }
                                                if (check.isEmpty) {
                                                  _needPageController
                                                      .postServiceApiCall(
                                                          context,
                                                          postData['type'],
                                                          postData);
                                                  _needPageController
                                                      .searchingSelectedItems
                                                      .value
                                                      .add(_needPageController
                                                          .textController.text
                                                          .trim());
                                                  _needPageController
                                                      .textController.text = '';
                                                  isKeyboardOpen = false;
                                                } else {
                                                  myToast(context,
                                                      msg: 'Already available');
                                                }
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: DynamicColor.green,
                                            size: 45,
                                          ),
                                        )),
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
                                  _needPageController.searchingSelectedItems
                                      .value.length, (index) {
                                dynamic data = _needPageController
                                    .searchingSelectedItems.value[index];
                                return Container(
                                  height: 45,
                                  //  padding: EdgeInsets.only(left: 10, right: 10),
                                  margin: EdgeInsets.only(right: 5, left: 15),
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient:
                                            DynamicColor.gradientColorChange,
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
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
                                                _needPageController
                                                    .searchingSelectedItems
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
                //_needPageController.searchingSelectedItems.isEmpty &&
                _needPageController.textController.text.isEmpty) ||
            _needPageController.hideList.value == true
        ? Container()
        : Container(
            //height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.15),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: GetBuilder<NeedPageController>(
                  builder: (_needPageController) {
                return ListView.builder(
                    itemCount: _needPageController.searchingItems.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      dynamic data = _needPageController.searchingItems[index];

                      if (listFlitter(data)) {
                        return Visibility(
                          visible: !_needPageController
                              .searchingSelectedItems.value
                              .contains(data),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ChoiceChip(
                              side: BorderSide(color: DynamicColor.white),
                              label: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  data,
                                  style: _needPageController
                                          .searchingSelectedItems.value
                                          .contains(data)
                                      ? white13TextStyle
                                      : null,
                                ),
                              ),
                              selected: _needPageController
                                  .searchingSelectedItems.value
                                  .contains(data),
                              selectedColor: DynamicColor.gredient1,
                              backgroundColor: DynamicColor.white,
                              onSelected: (value) {
                                _needPageController.textController.text = '';
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (value == true) {
                                  setState(() {
                                    isKeyboardOpen = false;
                                    _needPageController
                                        .searchingSelectedItems.value
                                        .add(data);
                                    _needPageController.hideList.value = true;
                                  });
                                } else {
                                  setState(() {
                                    _needPageController
                                        .searchingSelectedItems.value
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

  Widget customBox(topLeft, bottomLeft, topRight, bottomRight,
      IconData iconData, String string, isSelected,
      {required VoidCallback onPressad}) {
    return InkWell(
      onTap: onPressad,
      child: Card(
        elevation: isSelected ? 0 : 10,
        child: Container(
          height: 5.h,
          // padding: const EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: DynamicColor.white,
              border:
                  isSelected ? Border.all(color: DynamicColor.gredient2) : null
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(topLeft),
              //   bottomLeft: Radius.circular(bottomLeft),
              //   topRight: Radius.circular(topRight),
              //   bottomRight: Radius.circular(bottomRight),
              // )
              ),
          child: Text(
            string,
            style: TextStyle(
              fontSize: 15.0,
              color: isSelected ? DynamicColor.gredient2 : DynamicColor.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              //fontFamily: poppies,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  bool listFlitter(String name) {
    if (name
        .toLowerCase()
        .contains(_needPageController.textController.text.toLowerCase())) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
