import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/screens/businessIdeas/dashBoardScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20tutorial/home_tutorial.dart';
import 'package:pitch_me_app/screens/businessIdeas/home_filter.dart';
import 'package:pitch_me_app/screens/businessIdeas/home_manu.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/text/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/amateur_user_limitation.dart';
import '../../Phase 6/Guest UI/Guest limitation pages/pro_user_limitation.dart';
import '../../View/Demo Video/title_tutorial.dart';
import '../../View/Notification/notification_list.dart';
import '../../devApi Service/get_api.dart';
import '../../devApi Service/post_api.dart';
import '../../utils/styles/styles.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  HomePageController homePageController = Get.put(HomePageController());

  int currentIndexOfDashboard = 0;
  int selectIndex = 0;
  int swipeCount = 0;
  int countPost = 0;

  late Widget currentScreen;

  String title = '';
  String newUser = '';
  String businesstype = '';
  String adminUser = '';
  String checkGuestType = '';
  dynamic proUser;

  bool isCheckProUser = false;
  bool isCheck = false;
  bool isCheckTutorial = false;
  bool playTutorial = false;
  bool isLoading = false;
  bool _isInitialValue = false;
  bool isFilter = false;
  bool isManu = false;

  @override
  void initState() {
    getUserType();

    super.initState();
    currentScreen = DashBoardScreen(
      currentPage: (int index) {
        currentIndexOfDashboard = index;
        setState(() {});
      },
      onSwipe: (int index, String _title, bool isFinish) {
        print("index is $index and title is $title");
        title = _title;
        //setState(() {});
      },
    );
    //setState(() {});
  }

  getUserType() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    setState(() {
      checkGuestType = prefs.getString('guest').toString();

      if (checkGuestType != 'null') {
        businesstype = prefs.getString('log_type').toString();
        adminUser = prefs.getString('bot').toString();
        proUser = jsonDecode(prefs.getString('pro_user').toString());
        checkUser();
        checkLimite();
      }
      if (prefs.getBool('hometutorial') != null) {
        playTutorial = prefs.getBool('hometutorial')!;
        isCheckTutorial = prefs.getBool('hometutorial')!;
      }

      isLoading = false;
    });
  }

  void checkDontShow(bool check) async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      preferencesData.setBool('hometutorial', check).toString();
    });
    if (checkGuestType != 'null') {
      dynamic d = {
        "hometutorial": check,
      };
      try {
        PostApiServer().savedTutorialApi(d).then((value) {
          // log(value.toString());
        });
      } catch (e) {}
    }
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
            countPost = int.parse('${value['data']['postsave']}');
          }
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: isManu ? false : true,
      child: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: isLoading
              ? CircularProgressIndicator(
                  color: DynamicColor.gredient1,
                )
              : playTutorial == false
                  ? TitleTutorialPage(
                      title: 'Home',
                      pageIndex: 0,
                      checkPage: true,
                      isCheck: isCheckTutorial,
                      onPlay: () {
                        PageNavigateScreen()
                            .push(context, HomeTutorialPage())
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
                      },
                      onCheck: (value) {
                        setState(() {
                          isCheckTutorial = value!;
                          checkDontShow(isCheckTutorial);
                        });
                      },
                    )
                  : countPost > 29
                      ? AmateurUserLimitationPage(
                          showBottomBar: true,
                          pageIndex: 0,
                          onBack: 1,
                        )
                      : Stack(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _isInitialValue == true;
                                    _isInitialValue = false;
                                  });
                                },
                                child: isManu
                                    ? checkGuestType.isNotEmpty &&
                                            checkGuestType != 'null'
                                        ? HomeManuPage(
                                            pageIndex: 0,
                                          )
                                        : GuestManuPage(title: '', pageIndex: 0)
                                    : isFilter
                                        ? HomePageFilter()
                                        : currentScreen),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.getSize50(context: context)),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  child: isManu
                                      ? Text(
                                          'MENU',
                                          style: white17wBold,
                                        )
                                      : isFilter
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 0),
                                              child: Text(
                                                'FILTER',
                                                style: white17wBold,
                                              ))
                                          : roboto(
                                              size: SizeConfig.getFontSize25(
                                                  context: context),
                                              text: currentIndexOfDashboard == 0
                                                  ? ''
                                                  : "App Statistics",
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.getSize30(
                                              context: context) +
                                          MediaQuery.of(context).size.height *
                                              0.021,
                                      bottom: SizeConfig.getSize20(
                                          context: context),
                                      left: SizeConfig.getFontSize25(
                                          context: context),
                                      right: SizeConfig.getFontSize25(
                                          context: context)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      currentIndexOfDashboard == 0
                                          ? AppBarIconContainer(
                                              height: SizeConfig.getSize38(
                                                  context: context),
                                              width: SizeConfig.getSize38(
                                                  context: context),
                                              color: isManu || isFilter
                                                  ? DynamicColor.white
                                                  : null,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: loadSvg(
                                                    image:
                                                        'assets/image/menu.svg',
                                                    color: isManu
                                                        ? DynamicColor.darkBlue
                                                        : isFilter
                                                            ? DynamicColor
                                                                .gredient2
                                                            : null),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  isManu = !isManu;
                                                  isFilter = false;
                                                  if (isManu) {
                                                    homePageController
                                                        .hideNaveBar
                                                        .value = 'hide';
                                                  } else {
                                                    homePageController
                                                        .hideNaveBar.value = '';
                                                  }
                                                });
                                              },
                                            )
                                          : Container(),
                                      spaceHeight(5),
                                      if (currentIndexOfDashboard == 0)
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: AppBarIconContainer(
                                              height: SizeConfig.getSize38(
                                                  context: context),
                                              width: SizeConfig.getSize38(
                                                  context: context),
                                              color: isManu || isFilter
                                                  ? DynamicColor.white
                                                  : null,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: loadSvg(
                                                    image:
                                                        'assets/image/setting.svg',
                                                    color: isFilter == true
                                                        ? DynamicColor.darkBlue
                                                        : isManu
                                                            ? DynamicColor
                                                                .gredient2
                                                            : null),
                                              ),
                                              onTap: () {
                                                if (checkGuestType.isNotEmpty &&
                                                    checkGuestType != 'null') {
                                                  if (isCheckProUser) {
                                                    setState(() {
                                                      isFilter = !isFilter;
                                                      isManu = false;
                                                      homePageController
                                                          .hideNaveBar
                                                          .value = '';
                                                    });
                                                  } else {
                                                    PageNavigateScreen().push(
                                                        context,
                                                        ProUserLimitationPage(
                                                          pageIndex: 0,
                                                        ));
                                                  }
                                                } else {
                                                  Get.to(() =>
                                                      LoginLimitationPage());
                                                }
                                              },
                                            )),
                                    ],
                                  ),
                                ),
                                currentIndexOfDashboard == 0
                                    ? NotificationManuList(
                                        isManu: isManu,
                                        isFilter: isFilter,
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
        ),
      ),
    );
  }
}
