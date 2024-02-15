import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/normal_user_chat_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/login_limitation.dart';
import '../../screens/businessIdeas/home biography/Chat/Admin User/chat_list.dart';
import '../../screens/businessIdeas/home biography/home_page_biography.dart';
import '../../utils/colors/colors.dart';
import '../../utils/extras/extras.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../Feedback/controller.dart';
import '../Feedback/feedback_detail.dart';
import '../Profile/Biography/biography.dart';
import '../Profile/Pitches/pitches_list.dart';
import 'notify_controller.dart';

class NotificationManuList extends StatefulWidget {
  dynamic colorTween;
  bool isManu;
  bool isFilter;
  NotificationManuList({
    super.key,
    this.colorTween,
    required this.isManu,
    required this.isFilter,
  });

  @override
  State<NotificationManuList> createState() => _NotificationManuListState();
}

class _NotificationManuListState extends State<NotificationManuList>
    with SingleTickerProviderStateMixin {
  NotificationController notificationController =
      Get.put(NotificationController());
  FeebackController feebackController = Get.put(FeebackController());

  late AnimationController animationController;
  late Animation _colorTween;
  bool _isInitialValue = false;

  String checkGuestType = '';
  @override
  void initState() {
    //Colors.white.withOpacity(0.3)
    checkGuest();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    if (widget.colorTween != null) {
      _colorTween =
          ColorTween(begin: DynamicColor.white, end: DynamicColor.white)
              .animate(animationController);
    } else {
      _colorTween = ColorTween(begin: DynamicColor.blue, end: DynamicColor.blue)
          .animate(animationController);
    }

    Future.delayed(const Duration(seconds: 0), () {
      animationController.status == AnimationStatus.completed
          ? animationController.reset()
          : animationController.forward();
    });
    // notificationController.startTimer(context);
    super.initState();
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    // log('filter  = ' + widget.isFilter.toString());
    // log('mnu = ' + widget.isManu.toString());
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.getSize30(context: context) +
              MediaQuery.of(context).size.height * 0.021,
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) {
                return AnimatedContainer(
                  height: _isInitialValue
                      ? sizeH * 0.5
                      : SizeConfig.getSize38(context: context),
                  width: _isInitialValue
                      ? sizeW * 0.70
                      : SizeConfig.getSize38(context: context),
                  decoration: BoxDecoration(
                      borderRadius: _isInitialValue == false
                          ? BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))
                          : BorderRadius.circular(20),
                      gradient: widget.isManu || widget.isFilter
                          ? _isInitialValue
                              ? DynamicColor.gradientColorChange
                              : null
                          : DynamicColor.gradientColorChange,
                      color: widget.isManu || widget.isFilter
                          ? _isInitialValue
                              ? null
                              : DynamicColor.white
                          : null),
                  duration: Duration(milliseconds: 300),
                  child: InkWell(
                    onTap: () {
                      if (checkGuestType.isNotEmpty &&
                          checkGuestType != 'null') {
                        setState(() {
                          _isInitialValue = !_isInitialValue;
                        });
                      } else {
                        Get.to(() => LoginLimitationPage());
                      }
                    },
                    child: _isInitialValue
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Obx(() {
                              return notificationController.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: DynamicColor.white,
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: notificationController
                                          .post.value.result!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            print("Click in notification");
                                            setState(() {
                                              _isInitialValue == true;
                                              _isInitialValue = false;
                                            });
                                            if (notificationController
                                                    .post
                                                    .value
                                                    .result![index]
                                                    .type ==
                                                5) {
                                              PageNavigateScreen().push(
                                                  context,
                                                  HomeBiographyPage(
                                                    type: 'Notification',
                                                    notifyID:
                                                        notificationController
                                                            .post
                                                            .value
                                                            .result![index]
                                                            .sId!,
                                                    userID:
                                                        notificationController
                                                            .post
                                                            .value
                                                            .result![index]
                                                            .senderID!,
                                                  ));
                                            } else if (notificationController
                                                    .post
                                                    .value
                                                    .result![index]
                                                    .type ==
                                                6) {
                                              PageNavigateScreen().push(
                                                  context,
                                                  FeedbackPage(
                                                    type: 'home',
                                                    notifyID:
                                                        notificationController
                                                            .post
                                                            .value
                                                            .result![index]
                                                            .sId!,
                                                    data: notificationController
                                                        .post
                                                        .value
                                                        .result![index],
                                                  ));
                                            } else if (notificationController
                                                    .post
                                                    .value
                                                    .result![index]
                                                    .type ==
                                                7) {
                                              PageNavigateScreen().push(
                                                  context,
                                                  PitchesListPage(
                                                      notifyID:
                                                          notificationController
                                                              .post
                                                              .value
                                                              .result![index]
                                                              .sId!));
                                            } else if (notificationController
                                                    .post
                                                    .value
                                                    .result![index]
                                                    .type ==
                                                8) {
                                              PageNavigateScreen().push(
                                                  context,
                                                  BiographyPage(
                                                    type: '',
                                                    notifyID:
                                                        notificationController
                                                            .post
                                                            .value
                                                            .result![index]
                                                            .sId!,
                                                  ));
                                            } else if (notificationController
                                                    .post
                                                    .value
                                                    .result![index]
                                                    .type ==
                                                11) {
                                              PageNavigateScreen().push(
                                                  context,
                                                  AdminUserChatListPage(
                                                    notifyID:
                                                        notificationController
                                                            .post
                                                            .value
                                                            .result![index]
                                                            .sId!,
                                                  ));
                                            } else if (notificationController
                                                    .post
                                                    .value
                                                    .result![index]
                                                    .type ==
                                                12) {
                                              PageNavigateScreen().push(
                                                  context,
                                                  ChatListPage(
                                                    notifyID:
                                                        notificationController
                                                            .post
                                                            .value
                                                            .result![index]
                                                            .sId!,
                                                  ));
                                            } else {
                                              feebackController.readAllNotiApi(
                                                  notificationController
                                                      .post
                                                      .value
                                                      .result![index]
                                                      .sId!);
                                            }
                                          },
                                          child: Container(
                                            height: sizeH * 0.06,
                                            width: sizeW * 0.65,
                                            // color: Colors.red,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(children: [
                                                Icon(
                                                    Icons
                                                        .notifications_active_outlined,
                                                    color: DynamicColor.white),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: sizeW * 0.03,
                                                    //top: sizeH * 0.01
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        // height:
                                                        //     sizeH * 0.02,
                                                        width: sizeW * 0.50,
                                                        alignment: Alignment
                                                            .centerLeft,

                                                        child: Text(
                                                          notificationController
                                                                  .post
                                                                  .value
                                                                  .result?[
                                                                      index]
                                                                  .title
                                                                  .toString() ??
                                                              "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: notificationController
                                                                      .post
                                                                      .value
                                                                      .result?[
                                                                          index]
                                                                      .unreadFlag ==
                                                                  0
                                                              ? TextStyle(
                                                                  color:
                                                                      DynamicColor
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)
                                                              : TextStyle(
                                                                  color:
                                                                      DynamicColor
                                                                          .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   value
                                                      //           .post.value                                                          //           ?.result?[
                                                      //               index]
                                                      //           .text!
                                                      //           .toString() ??
                                                      //       "",
                                                      //   overflow:
                                                      //       TextOverflow
                                                      //           .ellipsis,
                                                      //   style: TextStyle(
                                                      //       color: Colors
                                                      //           .white,
                                                      //       fontWeight:
                                                      //           FontWeight
                                                      //               .bold,
                                                      //       fontSize: 10),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: sizeW * 0.02,
                                              right: sizeW * 0.02),
                                          child: Divider(
                                            height: 2,
                                            color: DynamicColor.white,
                                          ),
                                        );
                                      },
                                    );
                            }),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: loadSvg(
                                image: 'assets/image/notifications.svg',
                                color: widget.isManu || widget.isFilter
                                    ? DynamicColor.gredient1
                                    : DynamicColor.white),
                          ),
                  ),
                );
              }),
          _isInitialValue == true
              ? Container()
              : Obx(() {
                  //FlutterBeep.playSysSound(iOSSoundIDs.SMSReceived_Alert1);
                  return Visibility(
                    visible: notificationController.totalNotiCount.value == 0
                        ? false
                        : true,
                    child: Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(left: 35, bottom: 25),
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: DynamicColor.redColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: FittedBox(
                        child: Text(
                          notificationController.totalNotiCount.value
                              .toString(),
                          style: TextStyle(color: DynamicColor.white),
                        ),
                      ),
                    ),
                  );
                })
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
