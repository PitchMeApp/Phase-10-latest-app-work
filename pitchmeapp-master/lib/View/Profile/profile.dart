import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Profile/Biography/biography.dart';
import 'package:pitch_me_app/View/Profile/Likes/likes_list.dart';
import 'package:pitch_me_app/View/Profile/Pitches/pitches_list.dart';
import 'package:pitch_me_app/View/Profile/Users/users.dart';
import 'package:pitch_me_app/View/Profile/profile_tutorial.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/delete_user_account.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/logout.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../devApi Service/post_api.dart';
import '../../screens/businessIdeas/BottomNavigation.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/containers/containers.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Add Image Page/controller.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../Demo Video/title_tutorial.dart';
import '../Fund Page/fund_neccessar_controller.dart';
import '../Funding Phase/fund_phase_cntroller.dart';
import '../Location Page/location_page_con.dart';
import '../Need page/need_page_controller.dart';
import '../Notification/notify_controller.dart';
import '../Select industry/industry_controller.dart';
import '../navigation_controller.dart';
import '../offer_page/controller.dart';
import '../video page/Controller/controller.dart';
import '../what need/who_need_page_controller.dart';
import 'Biography/controller/controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  NotificationController notificationController =
      Get.put(NotificationController());
  int isSelect = 0;

  String usertype = '';
  dynamic adminUser;
  dynamic switchUser;

  bool isCheckTutorial = false;
  bool playTutorial = false;
  bool isLoading = false;

  @override
  void initState() {
    checkAuth();

    super.initState();
  }

  void checkAuth() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      usertype = preferencesData.getString('log_type').toString();
      switchUser =
          jsonDecode(preferencesData.getString('switch_user').toString());
      adminUser =
          jsonDecode(preferencesData.getString('admin_user').toString());
      // log(adminUser.toString());
      if (preferencesData.getBool('profiletutorial') != null) {
        playTutorial = preferencesData.getBool('profiletutorial')!;
        isCheckTutorial = preferencesData.getBool('profiletutorial')!;
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  void checkDontShow(bool check) async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      preferencesData.setBool('profiletutorial', check).toString();
    });
    dynamic d = {
      "profiletutorial": check,
    };
    try {
      PostApiServer().savedTutorialApi(d).then((value) {
        log(value.toString());
      });
    } catch (e) {}
  }

  void getUserDataApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await GetApiService()
          .getUserBioGraphyApi(prefs.get('user_id'))
          .then((value) {
        if (value.result.docs.isNotEmpty) {
          var bioDoc = value.result.docs[0];
          prefs.setBool('hometutorial', bioDoc.user.hometutorial);
          prefs.setBool('salespitchtutorial', bioDoc.user.salespitchtutorial);
          prefs.setBool(
              'addsalespitchtutoria', bioDoc.user.addsalespitchtutoria);
          prefs.setBool('dealtutorial', bioDoc.user.dealtutorial);
          prefs.setBool('profiletutorial', bioDoc.user.profiletutorial);
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: isLoading
          ? CircularProgressIndicator(
              color: DynamicColor.gredient1,
            )
          : playTutorial == false
              ? TitleTutorialPage(
                  title: 'Profile',
                  pageIndex: 3,
                  isCheck: isCheckTutorial,
                  onPlay: () {
                    PageNavigateScreen()
                        .push(context, ProfileTutorialPage())
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
                              height:
                                  MediaQuery.of(context).size.height * 0.235,
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
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            usertype == '5'
                                ? CustomListBox(
                                    title: TextStrings.textKey['user']!,
                                    singleSelectColor: isSelect,
                                    isSingleSelect: 5,
                                    onPressad: () {
                                      setState(() {
                                        isSelect = 5;
                                      });
                                      PageNavigateScreen()
                                          .push(context, UsersPage());
                                    })
                                : Container(),
                            CustomListBox(
                                title: TextStrings.textKey['biography']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 1,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 1;
                                  });
                                  PageNavigateScreen().push(
                                      context,
                                      BiographyPage(
                                        type: 'Biography',
                                        notifyID: '',
                                      ));
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['likes']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 2,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 2;
                                  });
                                  PageNavigateScreen()
                                      .push(context, LikesListPage());
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['pitches']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 3,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 3;
                                  });
                                  PageNavigateScreen().push(
                                      context,
                                      PitchesListPage(
                                        notifyID: '',
                                      ));
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['logout']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 4,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 4;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) => LogoutPopUp());
                                }),
                            switchUser == null
                                ? Container()
                                : CustomListBox(
                                    title: TextStrings.textKey['back_acunt']!,
                                    singleSelectColor: isSelect,
                                    isSingleSelect: 5,
                                    onPressad: () {
                                      setState(() {
                                        isSelect = 5;
                                        switchAccount();
                                      });
                                    }),
                          ],
                        ),
                      ),
                      usertype == '5' || switchUser != null
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.getSizeHeightBy(
                                      context: context, by: 0.65)),
                              child: CustomListBox(
                                  title: TextStrings.textKey['delete_account']!,
                                  singleSelectColor: isSelect,
                                  isSingleSelect: 6,
                                  onPressad: () {
                                    setState(() {
                                      isSelect = 6;
                                    });
                                    showDialog(
                                        barrierDismissible: true,
                                        context: Get.context!,
                                        builder: (context) =>
                                            DeleteUserAccountPopUp());
                                  }),
                            ),
                      CustomAppbarWithWhiteBg(
                        title: TextStrings.textKey['profile']!,
                        onPressad: () {
                          PageNavigateScreen().push(
                              context,
                              ManuPage(
                                title: TextStrings.textKey['profile']!,
                                pageIndex: 3,
                                isManu: 'Manu',
                              ));
                        },
                      ),
                      NewCustomBottomBar(
                        index: 3,
                        isBack: true,
                      ),
                    ],
                  ),
                ),
    );
  }

  void switchAccount() async {
    openDilog();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getUserDataApi();
    prefs.remove('switch_user');
    prefs.remove('bot');
    prefs.remove('industry');
    prefs.remove('location');
    prefs.remove('needs');
    prefs.setString("user_id", adminUser["user"]["_id"].toString());
    prefs.setString("user_name", adminUser["user"]["username"].toString());
    prefs.setString("tok", adminUser["token"].toString());
    prefs.setString("log_type", adminUser["user"]["log_type"].toString());

    Get.delete<BiographyController>(force: true);
    Get.delete<InsdustryController>(force: true);
    Get.delete<LocationPageController>(force: true);
    Get.delete<WhoNeedController>(force: true);
    Get.delete<FundNacessaryController>(force: true);
    Get.delete<NeedPageController>(force: true);
    Get.delete<OfferPageController>(force: true);
    Get.delete<AddImageController>(force: true);
    Get.delete<VideoFirstPageController>(force: true);
    Get.delete<NavigationController>(force: true);
    Get.delete<FundingPhaseController>(force: true);
    // Get.delete<SalesPitchFilterController>(force: true);
    //Get.delete<NotificationController>(force: true);
    notificationController.totalNotiCount.value = 0;
    notificationController.post.value.result = [];
    notificationController.timer.cancel();

    Timer(const Duration(seconds: 4), () {
      Get.back();
      Get.offAll(() => Floatbar(0));
    });
  }

  void openDilog() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => showLoading());
  }

  Widget showLoading() {
    return Center(
        child: SizedBox(
            height: 170,
            width: 200,
            child: AlertDialog(
                backgroundColor: DynamicColor.lightGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: DynamicColor.gredient2),
                    SizedBox(height: 20),
                    Text(
                      'Switch...',
                      style: gredient115,
                    ),
                  ],
                ))));
  }
}
