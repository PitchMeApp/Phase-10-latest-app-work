// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/demo%20watch%20sales%20pitch/demo_watch_sales.dart';
import 'package:pitch_me_app/View/Notification/notification_list.dart';
import 'package:pitch_me_app/controller/businessIdeas/dashBoardController.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/screens/businessIdeas/dashBoardScreen_Two.dart';
import 'package:pitch_me_app/screens/businessIdeas/home_manu.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/directVideoViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/amateur_user_limitation.dart';
import '../../Phase 6/Guest UI/Guest limitation pages/user_type_limitation.dart';
import '../../Phase 6/demo watch sales pitch/controller.dart';
import '../../View/Demo Video/title_tutorial.dart';
import '../../View/Sales Pitch filter/filter_page.dart';
import '../../controller/businessIdeas/postPageController.dart';
import '../../devApi Service/get_api.dart';
import '../../devApi Service/post_api.dart';
import '../../utils/extras/extras.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/containers/containers.dart';

class mainHome_Two extends StatefulWidget {
  const mainHome_Two({super.key});

  @override
  State<mainHome_Two> createState() => _mainHome_TwoState();
}

class _mainHome_TwoState extends State<mainHome_Two> {
  PostPageController postPageController = Get.put(PostPageController());
  DashboardController dashboardController = Get.put(DashboardController());
  DemoWatchSalesPitchController watchSalesPitchController =
      Get.put(DemoWatchSalesPitchController());

  final HomePageController homePageController = Get.put(HomePageController());

  bool _isInitialValue = false;
  bool isManu = false;
  bool isCheck = false;
  bool isCheckTutorial = false;
  bool playTutorial = false;
  bool isLoading = false;
  bool isCheckProUser = false;

  String title = '';
  String businesstype = '';
  String newUser = '';
  String checkGuestType = '';
  String adminUser = '';

  dynamic proUser;

  int currentIndexOfDashboard = 0;
  int countPost = 0;
  int countSaved = 0;

  late Widget currentScreen;
  @override
  void initState() {
    super.initState();
    getUserType();

    currentScreen = DashBoardScreen_Two(
      userType: businesstype,
      currentPage: (int index) {
        currentIndexOfDashboard = index;
        if (!mounted) {
          return;
        }
        setState(() {});
      },
      onSwipe: (int index, String _title, bool isFinish) {
        print("index is $index and title is $title");
        title = _title;
        if (!mounted) {
          return;
        }
        setState(() {});
      },
    );
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  getUserType() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = prefs.getString('guest').toString();
      if (checkGuestType != 'null') {
        businesstype = prefs.getString('log_type').toString();
        newUser = prefs.getString('new_user').toString();
        adminUser = prefs.getString('bot').toString();
        proUser = jsonDecode(prefs.getString('pro_user').toString());
        checkUser();
        checkLimite();
      }

      if (prefs.getBool('salespitchtutorial') != null) {
        playTutorial = prefs.getBool('salespitchtutorial')!;
        isCheckTutorial = prefs.getBool('salespitchtutorial')!;

        isCheck = prefs.getBool('salespitchtutorial')!;
      } else {
        isCheck = false;
      }
      isLoading = false;
    });
  }

  void checkDontShow(bool check) async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      preferencesData.setBool('salespitchtutorial', check).toString();
      newUser = preferencesData.setString('new_user', 'Old User').toString();
    });
    dynamic d = {
      "salespitchtutorial": check,
    };
    try {
      PostApiServer().savedTutorialApi(d).then((value) {
        log(value.toString());
      });
    } catch (e) {}
  }

  void checkDontShow2() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      newUser = preferencesData.setString('new_user', 'Old User').toString();
    });
  }

  void checkUser() {
    if (adminUser == 'null' && businesstype != '5') {
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

  void checkLimite() async {
    try {
      await GetApiService().countApi().then((value) {
        setState(() {
          if (isCheckProUser == false) {
            countPost = int.parse('${value['data']['salespitchsaveModel']}') +
                int.parse('${value['data']['Feedback']}');
          }
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: isManu ? false : true,
      child: Scaffold(
          body: isLoading
              ? CircularProgressIndicator(
                  color: DynamicColor.gredient1,
                )
              : playTutorial == false
                  ? TitleTutorialPage(
                      title: 'Watch Sales Pitch',
                      pageIndex: 2,
                      checkPage: true,
                      isCheck: isCheckTutorial,
                      onPlay: () {
                        PageNavigateScreen()
                            .push(context, DemoWatchSalesPitch())
                            .then((value) {
                          setState(() {
                            playTutorial = true;
                          });
                        });
                      },
                      onNext: () {
                        setState(() {
                          playTutorial = true;
                        });
                        checkDontShow2();
                      },
                      onCheck: (value) {
                        setState(() {
                          isCheckTutorial = value!;
                          checkDontShow(isCheckTutorial);
                        });
                      },
                    )
                  : businesstype == '1' || businesstype == '2'
                      ? UserTypeLimitationPage(
                          title1: 'Only Investor and',
                          title2: 'Service Provider users can',
                          title3: 'access this page.',
                        )
                      : countPost > 9
                          ? AmateurUserLimitationPage(
                              showBottomBar: true,
                              pageIndex: 1,
                              onBack: 2,
                            )
                          : Stack(
                              children: [
                                isManu
                                    ? HomeManuPage(
                                        pageIndex: 1,
                                      )
                                    : currentScreen,
                                Obx(() {
                                  return postPageController.right.value ==
                                              true ||
                                          postPageController.left.value == true
                                      ? Container()
                                      : Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: SizeConfig.getSize30(
                                                          context: context) +
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.021,
                                                  bottom: SizeConfig.getSize20(
                                                      context: context),
                                                  left:
                                                      SizeConfig.getFontSize25(
                                                          context: context),
                                                  right:
                                                      SizeConfig.getFontSize25(
                                                          context: context)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  currentIndexOfDashboard == 0
                                                      ? _isInitialValue == true
                                                          ? Container()
                                                          : Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(top: 5),
                                                              height:
                                                                  sizeH * 0.04,
                                                              width:
                                                                  sizeW * 0.35,
                                                              child: isManu
                                                                  ? Center(
                                                                      child:
                                                                          Text(
                                                                        'MENU',
                                                                        style:
                                                                            white17wBold,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    )
                                                                  : Center(
                                                                      child: businesstype == '1' ||
                                                                              businesstype == '2' ||
                                                                              ((businesstype == '3' || businesstype == '4') && (newUser == 'New User'))
                                                                          ? Text(
                                                                              'Watch Sales Pitch',
                                                                              style: gredient116bold,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            )
                                                                          : Text(
                                                                              dashboardController.salespitch.value != null && dashboardController.salespitch.value.result != null
                                                                                  ? dashboardController.salespitch.value.result!.docs.isNotEmpty && dashboardController.salespitch.value.result!.docs.length > postPageController.swipableStackController.currentIndex
                                                                                      ? dashboardController.salespitch.value.result!.docs[postPageController.swipableStackController.currentIndex].title
                                                                                      : ''
                                                                                  : '',
                                                                              style: TextStyle(color: DynamicColor.gredient1, fontWeight: FontWeight.bold, fontSize: 16),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                    ),
                                                            )
                                                      : Container(),
                                                  Column(
                                                    children: [
                                                      currentIndexOfDashboard ==
                                                              0
                                                          ? AppBarIconContainer(
                                                              height: SizeConfig
                                                                  .getSize38(
                                                                      context:
                                                                          context),
                                                              width: SizeConfig
                                                                  .getSize38(
                                                                      context:
                                                                          context),
                                                              color: isManu
                                                                  ? DynamicColor
                                                                      .white
                                                                  : null,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: loadSvg(
                                                                    image:
                                                                        'assets/image/menu.svg',
                                                                    color: isManu ==
                                                                            true
                                                                        ? DynamicColor
                                                                            .darkBlue
                                                                        : null),
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  isManu =
                                                                      !isManu;
                                                                  watchSalesPitchController
                                                                          .isMenuCheck
                                                                          .value !=
                                                                      watchSalesPitchController
                                                                          .isMenuCheck
                                                                          .value;
                                                                  if (isManu) {
                                                                    homePageController
                                                                        .hideNaveBar
                                                                        .value = 'hide';
                                                                  } else {
                                                                    homePageController
                                                                        .hideNaveBar
                                                                        .value = '';
                                                                  }
                                                                });
                                                              },
                                                            )
                                                          : Container(),
                                                      currentIndexOfDashboard ==
                                                              0
                                                          ? Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: SizeConfig
                                                                      .getSize10(
                                                                          context:
                                                                              context)),
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      AppBarIconContainer(
                                                                    height: SizeConfig.getSize38(
                                                                        context:
                                                                            context),
                                                                    width: SizeConfig.getSize38(
                                                                        context:
                                                                            context),
                                                                    color: isManu
                                                                        ? DynamicColor
                                                                            .white
                                                                        : null,
                                                                    child: Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                8.0),
                                                                        child: loadSvg(
                                                                            image:
                                                                                'assets/image/setting.svg',
                                                                            color: isManu == true
                                                                                ? DynamicColor.gredient2
                                                                                : null)),
                                                                    onTap: () {
                                                                      PageNavigateScreen()
                                                                          .normalpushReplesh(
                                                                              context,
                                                                              FilterPage())
                                                                          .then(
                                                                              (value) {
                                                                        if (Platform
                                                                            .isIOS) {
                                                                          setState(
                                                                              () {
                                                                            videoViewerControllerList[postPageController.swipableStackController.currentIndex].pause();
                                                                          });
                                                                        }
                                                                      });
                                                                    },
                                                                  )),
                                                            )
                                                          : Container(),
                                                      currentIndexOfDashboard ==
                                                              0
                                                          ? spaceHeight(5)
                                                          : spaceHeight(0),
                                                      // currentIndexOfDashboard == 0
                                                      //     ? businesstype == '1' ||
                                                      //             businesstype == '2' ||
                                                      //             ((businesstype == '3' ||
                                                      //                     businesstype == '4') &&
                                                      //                 (newUser == 'New User'))
                                                      //         ? Container()
                                                      //         : backButton()
                                                      //     : Container(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            currentIndexOfDashboard == 0
                                                ? NotificationManuList(
                                                    isManu: isManu,
                                                    isFilter: false,
                                                  )
                                                : Container(),
                                          ],
                                        );
                                }),
                              ],
                            )),
    );
  }
}
