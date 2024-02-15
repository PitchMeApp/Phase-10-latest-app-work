import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/View/Manu/FAQ/faq.dart';
import 'package:pitch_me_app/View/Manu/Tutorials/tutorials.dart';
import 'package:pitch_me_app/View/Manu/benefits/benefits.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/normal_user_chat_list.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../devApi Service/get_api.dart';
import '../../screens/businessIdeas/home biography/Chat/Admin User/chat_list.dart';
import '../../utils/strings/images.dart';
import '../../utils/widgets/containers/containers.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import 'benefits/controller/benefits_controller.dart';

class ManuPage extends StatefulWidget {
  String title;
  int pageIndex;
  dynamic isManu;
  ManuPage(
      {super.key, required this.title, required this.pageIndex, this.isManu});

  @override
  State<ManuPage> createState() => _ManuPageState();
}

class _ManuPageState extends State<ManuPage> {
  BenefitsController controller = Get.put(BenefitsController());
  int isSelect = 0;
  String usertype = '';
  String adminUser = '';
  dynamic proUser;

  bool isCheckProUser = false;

  @override
  void initState() {
    super.initState();
    controller.checkProUserApi(context);
    checkAuth();
    GetApiService().checkProOrbasicUserApi();
  }

  void checkAuth() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      usertype = preferencesData.getString('log_type').toString();
      adminUser = preferencesData.getString('bot').toString();
      proUser = jsonDecode(preferencesData.getString('pro_user').toString());
    });
    checkUser();
  }

  void checkUser() {
    if (adminUser == 'null' && usertype != '5') {
      if (proUser != null) {
        setState(() {
          isCheckProUser = true;
        });
      }
    } else {
      setState(() {
        isCheckProUser = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      body: Obx(() {
        return controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: DynamicColor.gredient1),
              )
            : BackGroundWidget(
                backgroundImage: Assets.backgroundImage,
                bannerRequired: false,
                fit: BoxFit.fill,
                child: Stack(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipPath(
                          clipper: CurveClipper(),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: DynamicColor.gradientColorChange),
                            height: MediaQuery.of(context).size.height * 0.235,
                          ),
                        ),
                        whiteBorderContainer(
                            child: Image.asset(Assets.handshakeImage),
                            color: Colors.transparent,
                            height: SizeConfig.getSizeHeightBy(
                                context: context, by: 0.12),
                            width: SizeConfig.getSizeHeightBy(
                                context: context, by: 0.12),
                            cornerRadius: 25),
                      ],
                    ),
                    _buildBodyView(),
                    Column(
                      children: [
                        CustomAppbarWithWhiteBg(
                          title: widget.title,
                          checkNext: 'back',
                          isManuColor: 'check',
                          onPressad: () {},
                        ),
                      ],
                    ),
                    // NewCustomBottomBar(
                    //   index: widget.pageIndex,
                    //   isBack: widget.isManu,
                    //   isManuIcon: 'icon',
                    // ),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildBodyView() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.getSize15(context: context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return controller.isCheckProUser.value == 1
                ? CustomListBox(
                    title: TextStrings.textKey['become_pro']!,
                    singleSelectColor: isSelect,
                    isSingleSelect: 6,
                    onPressad: () {
                      setState(() {
                        isSelect = 6;
                      });
                      PageNavigateScreen().push(
                          context,
                          BenefitsPage(
                            pageIndex: widget.pageIndex,
                          ));
                    })
                : Container(
                    height: 6.5.h,
                  );
          }),
          CustomListBox(
              title: TextStrings.textKey['tutorial']!,
              singleSelectColor: isSelect,
              isSingleSelect: 1,
              onPressad: () {
                setState(() {
                  isSelect = 1;
                });
                PageNavigateScreen().push(
                    context,
                    TutorialsPage(
                      pageIndex: widget.pageIndex,
                    ));
              }),
          CustomListBox(
              title: TextStrings.textKey['faq']!,
              singleSelectColor: isSelect,
              isSingleSelect: 2,
              onPressad: () {
                setState(() {
                  isSelect = 2;
                });
                PageNavigateScreen().push(
                    context,
                    FQAPage(
                      pageIndex: widget.pageIndex,
                      isCheckPro: controller.isCheckProUser.value,
                    ));
              }),
          // CustomListBox(
          //     title: TextStrings.textKey['advrise']!,
          //     singleSelectColor: isSelect,
          //     isSingleSelect: 3,
          //     onPressad: () {
          //       setState(() {
          //         isSelect = 3;
          //       });
          //       if (isCheckProUser) {
          //         PageNavigateScreen().push(context, UnderDevLimitationPage());
          //       } else {
          //         PageNavigateScreen().push(context,
          //             ProUserLimitationPage(pageIndex: widget.pageIndex));
          //       }
          //     }),
          // CustomListBox(
          //     title: TextStrings.textKey['buy_pitch']!,
          //     singleSelectColor: isSelect,
          //     isSingleSelect: 4,
          //     onPressad: () {
          //       setState(() {
          //         isSelect = 4;
          //       });
          //       if (isCheckProUser) {
          //         PageNavigateScreen().push(context, UnderDevLimitationPage());
          //       } else {
          //         PageNavigateScreen().push(context,
          //             ProUserLimitationPage(pageIndex: widget.pageIndex));
          //       }
          //     }),
          CustomListBox(
              title: TextStrings.textKey['chat']!,
              singleSelectColor: isSelect,
              isSingleSelect: 5,
              onPressad: () {
                setState(() {
                  isSelect = 5;
                });
                if (isCheckProUser) {
                  if (usertype == '5') {
                    PageNavigateScreen().push(
                        context,
                        AdminUserChatListPage(
                          notifyID: '',
                        ));
                  } else {
                    PageNavigateScreen().push(
                        context,
                        ChatListPage(
                          notifyID: '',
                        ));
                  }
                } else {
                  PageNavigateScreen().push(
                      context,
                      ChatListPage(
                        notifyID: '',
                      ));
                  // PageNavigateScreen().push(context,
                  //     ProUserLimitationPage(pageIndex: widget.pageIndex));
                }
              }),
        ],
      ),
    );
  }
}
