import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/pro_user_limitation.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Deals%20Page/deal_tutorial.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/Admin%20User/chat_list.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/normal_user_chat_list.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/under_progress_limitation.dart';
import '../../devApi Service/post_api.dart';
import '../../utils/strings/images.dart';
import '../../utils/widgets/containers/containers.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../Demo Video/title_tutorial.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key});

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  int isSelect = 0;
  String usertype = '';
  String adminUser = '';
  dynamic proUser;

  bool isCheckProUser = false;
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
      if (preferencesData.getBool('dealtutorial') != null) {
        playTutorial = preferencesData.getBool('dealtutorial')!;
        isCheckTutorial = preferencesData.getBool('dealtutorial')!;
      }
      adminUser = preferencesData.getString('bot').toString();
      proUser = jsonDecode(preferencesData.getString('pro_user').toString());
    });
    checkUser();
    setState(() {
      isLoading = false;
    });
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

  void checkDontShow(bool check) async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      preferencesData.setBool('dealtutorial', check).toString();
    });
    dynamic d = {
      "dealtutorial": check,
    };
    try {
      PostApiServer().savedTutorialApi(d).then((value) {
        log(value.toString());
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? CircularProgressIndicator(
              color: DynamicColor.gredient1,
            )
          : playTutorial == false
              ? TitleTutorialPage(
                  title: 'Deals',
                  pageIndex: 3,
                  isCheck: isCheckTutorial,
                  onPlay: () {
                    PageNavigateScreen()
                        .push(context, DealTutorialPage())
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
                            // CustomAppbar(title: TextStrings.textKey['deals']!),
                            CustomListBox(
                                title: TextStrings.textKey['chat']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 1,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 1;
                                  });
                                  if (isCheckProUser) {
                                    if (usertype == '5') {
                                      log('message');
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
                                        ProUserLimitationPage(
                                          pageIndex: 3,
                                        ));
                                  }
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['contract']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 2,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 2;
                                  });
                                  if (isCheckProUser) {
                                    PageNavigateScreen().push(
                                        context, UnderDevLimitationPage());
                                  } else {
                                    PageNavigateScreen().push(
                                        context,
                                        ProUserLimitationPage(
                                          pageIndex: 3,
                                        ));
                                  }
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['investment']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 3,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 3;
                                  });
                                  if (isCheckProUser) {
                                    PageNavigateScreen().push(
                                        context, UnderDevLimitationPage());
                                  } else {
                                    PageNavigateScreen().push(
                                        context,
                                        ProUserLimitationPage(
                                          pageIndex: 3,
                                        ));
                                  }
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['share']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 4,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 4;
                                  });
                                  if (isCheckProUser) {
                                    PageNavigateScreen().push(
                                        context, UnderDevLimitationPage());
                                  } else {
                                    PageNavigateScreen().push(
                                        context,
                                        ProUserLimitationPage(
                                          pageIndex: 3,
                                        ));
                                  }
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['update']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 5,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 5;
                                  });
                                  if (isCheckProUser) {
                                    PageNavigateScreen().push(
                                        context, UnderDevLimitationPage());
                                  } else {
                                    PageNavigateScreen().push(
                                        context,
                                        ProUserLimitationPage(
                                          pageIndex: 3,
                                        ));
                                  }
                                }),
                          ],
                        ),
                      ),
                      CustomAppbarWithWhiteBg(
                        title: TextStrings.textKey['deals']!,
                        onPressad: () {
                          PageNavigateScreen().push(
                              context,
                              ManuPage(
                                title: TextStrings.textKey['deals']!,
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
}

class CustomListBox extends StatefulWidget {
  String title;
  bool? titleColor;
  int? singleSelectColor;
  int? isSingleSelect;
  double? width;
  VoidCallback onPressad;

  CustomListBox({
    super.key,
    required this.title,
    this.titleColor,
    this.singleSelectColor,
    this.isSingleSelect,
    required this.onPressad,
    this.width,
  });

  @override
  State<CustomListBox> createState() => _CustomListBoxState();
}

class _CustomListBoxState extends State<CustomListBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 5,
            left: SizeConfig.getFontSize25(context: context),
            right: SizeConfig.getFontSize25(context: context)),
        child: SizedBox(
          height: 6.5.h,
          width: widget.width == null
              ? MediaQuery.of(context).size.width * 0.7
              : widget.width!,
          child: InkWell(
            onTap: widget.onPressad,
            child: widget.singleSelectColor != null
                ? Card(
                    elevation: widget.singleSelectColor == widget.isSingleSelect
                        ? 0
                        : 10,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient:
                              widget.singleSelectColor == widget.isSingleSelect
                                  ? null
                                  : DynamicColor.gradientColorChange,
                          color:
                              widget.singleSelectColor == widget.isSingleSelect
                                  ? DynamicColor.white
                                  : null,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              widget.singleSelectColor == widget.isSingleSelect
                                  ? Border.all(color: DynamicColor.gredient2)
                                  : null),
                      child: Text(
                        widget.title.toUpperCase(),
                        style: widget.singleSelectColor != null
                            ? widget.singleSelectColor == widget.isSingleSelect
                                ? gredient116bold
                                : white16bold
                            : white16bold,
                      ),
                    ),
                  )
                : Card(
                    elevation: widget.titleColor! ? 0 : 10,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: widget.titleColor!
                              ? null
                              : DynamicColor.gradientColorChange,
                          color: widget.titleColor! ? DynamicColor.white : null,
                          borderRadius: BorderRadius.circular(10),
                          border: widget.titleColor!
                              ? Border.all(color: DynamicColor.gredient2)
                              : null),
                      child: Text(
                        widget.title.toUpperCase(),
                        style: widget.titleColor != null
                            ? widget.titleColor == true
                                ? gredient116bold
                                : white16bold
                            : white16bold,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
