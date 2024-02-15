import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Fund%20Page/fund_neccessar_controller.dart';
import 'package:pitch_me_app/View/Need%20page/need_page_edit.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/what%20need/who_need_page_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';

class FundsPageEdit extends StatefulWidget {
  bool isCheck;
  List length;
  FundsPageEdit({super.key, required this.isCheck, required this.length});

  @override
  State<FundsPageEdit> createState() => _FundsPageEditState();
}

class _FundsPageEditState extends State<FundsPageEdit> {
  final FundNacessaryController _fundNacessaryController =
      Get.put(FundNacessaryController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  final WhoNeedController _whoNeedController = Get.put(WhoNeedController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();

  int isIndex = 0;
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
                      SizeConfig.getSize55(context: context),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: DynamicColor.black))),
                  child: Text(
                    TextStrings.textKey['funds']!,
                    style: textColor22,
                  ),
                ),
                const SizedBox(height: 10),
                GridView(
                  padding: EdgeInsets.only(
                      left: SizeConfig.getFontSize25(context: context),
                      right: SizeConfig.getFontSize25(context: context)),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 9.0,
                      mainAxisExtent: 40),
                  children: List.generate(_fundNacessaryController.data.length,
                      (index) {
                    return customBox(
                        10.0,
                        10.0,
                        10.0,
                        10.0,
                        _fundNacessaryController.data[index]['value'],
                        _fundNacessaryController.data[index]['isSelected'],
                        onPressad: () => setState(() {
                              isIndex = index;
                              _fundNacessaryController.onselectAmount(
                                  _fundNacessaryController.data[index], index);
                            }));
                  }),
                ),
                _amountList(),
              ],
            ),
            CustomHeaderView(
              progressPersent: 0.4,
              checkNext: _fundNacessaryController.getValueList.value.isNotEmpty
                  ? 'next'
                  : null,
              nextOnTap: () {
                try {
                  if (_whoNeedController.checkType.value == 'Investor') {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    if (widget.length.length > 1) {
                      PageNavigateScreen().push(
                          context,
                          NeedPageEdit(
                            key: abcKey,
                            isCheck: true,
                            length: widget.length,
                          ));
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

  Widget _amountList() {
    return Obx(() {
      return _fundNacessaryController.getValueList.value.isEmpty
          ? Container()
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ClickableListWheelScrollView(
                  scrollController: _fundNacessaryController.scrollController,
                  itemHeight: 10,
                  itemCount: _fundNacessaryController.getValueList.value.length,
                  child: ListWheelScrollView.useDelegate(
                    controller: _fundNacessaryController.scrollController,
                    itemExtent: 30,
                    diameterRatio: 1.5,
                    physics: const FixedExtentScrollPhysics(),
                    overAndUnderCenterOpacity: 0.8,
                    perspective: 0.004,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _fundNacessaryController.chengeIndexColor.value = index;
                        _fundNacessaryController.selectedValue.value =
                            _fundNacessaryController
                                .getValueList.value[index]['range']
                                .toString();
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount:
                          _fundNacessaryController.getValueList.value.length,
                      builder: (context, index) {
                        if (_fundNacessaryController.chengeIndexColor.value ==
                            3) {
                          _fundNacessaryController.selectedValue.value =
                              _fundNacessaryController.getValueList[3]['range']
                                  .toString();
                        }

                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                                border: _fundNacessaryController
                                            .chengeIndexColor.value ==
                                        index
                                    ? Border(
                                        top: BorderSide(
                                            color: DynamicColor.gredient1),
                                        bottom: BorderSide(
                                            color: DynamicColor.gredient1))
                                    : null),
                            child: Text(
                              '${_fundNacessaryController.getValueList.value[index]['range']}',
                              style: _fundNacessaryController
                                          .chengeIndexColor.value ==
                                      index
                                  ? gredient122bold
                                  : textColor15,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
    });
  }

  Widget customBox(topLeft, bottomLeft, topRight, bottomRight, String string, i,
      {required VoidCallback onPressad}) {
    return InkWell(
      onTap: onPressad,
      child: Card(
        elevation: i ? 0 : 10,
        child: Container(
          height: 35.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: DynamicColor.white,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(topLeft),
              //   bottomLeft: Radius.circular(bottomLeft),
              //   topRight: Radius.circular(topRight),
              //   bottomRight: Radius.circular(bottomRight),
              // )
              border: i ? Border.all(color: DynamicColor.gredient2) : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imagess/Path 486.png',
                width: 15,
              ),
              const SizedBox(width: 3),
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

  @override
  void dispose() {
    super.dispose();
  }
}
