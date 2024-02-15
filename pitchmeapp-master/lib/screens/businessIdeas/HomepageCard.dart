import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/swipe_limitation.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/models/post/postModel.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/extras/directVideoViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_viewer/domain/bloc/controller.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/amateur_user_limitation.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    Key? key,
    required this.controller,
    required this.onSwipe,
    required this.postModel,
  }) : super(key: key);
  final PageController controller;
  final Function(int index, String title, bool isFinish) onSwipe;
  final PostModel postModel;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with AutomaticKeepAliveClientMixin<HomePageWidget>, WidgetsBindingObserver {
  void _listenController() => setState(() {});
  HomePageController controller = Get.put(HomePageController());
  String checkGuestType = '';
  int swipeCount = 0;
  int newIndex = 0;
  int countPost = 0;
  int countSaved = 0;

  String businesstype = '';
  String adminUser = '';
  dynamic proUser;

  bool isCheckProUser = false;

  @override
  void initState() {
    super.initState();
    checkGuest();

    WidgetsBinding.instance.addObserver(this);
    controller.swipableStackController.addListener(_listenController);
    videoViewerControllerList.clear();
    videoViewerControllerList.addAll(List.generate(
        widget.postModel.result!.length, (index) => VideoViewerController()));
  }

  @override
  bool get wantKeepAlive => true;

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();

      if (checkGuestType != 'null') {
        businesstype = preferencesData.getString('log_type').toString();
        adminUser = preferencesData.getString('bot').toString();
        proUser = jsonDecode(preferencesData.getString('pro_user').toString());
        checkUser();
        checkLimite();
      }

      if (preferencesData.getString('count_swipe') != 'null') {
        swipeCount =
            int.parse(preferencesData.getString('count_swipe').toString());
      }
    });
  }

  void countSwipe(String count) async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();

    setState(() {
      preferencesData.setString('count_swipe', count);
    });
  }

  void checkLimite() async {
    try {
      await GetApiService().countApi().then((value) {
        setState(() {
          countPost = int.parse('${value['data']['postsave']}');
          countSaved = int.parse('${value['data']['postsaveCount']}');
        });
      });
    } catch (e) {
      log(e.toString());
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SwipableStack(
            onWillMoveNext: (index, direction) {
              final allowedActions = [
                SwipeDirection.right,
                SwipeDirection.left,
              ];
              return allowedActions.contains(direction);
            },
            detectableSwipeDirections: const {
              SwipeDirection.right,
              SwipeDirection.left,
            },
            allowVerticalSwipe: false,
            controller: controller.swipableStackController,
            stackClipBehaviour: Clip.none,
            onSwipeCompleted: (index, direction) {
              setState(() {
                newIndex = index + 1;

                if (widget.postModel.result!.isNotEmpty &&
                    widget.postModel.result!.length > (index + 1)) {
                  widget.onSwipe(
                      index + 1,
                      widget.postModel.result![index + 1].title!.toString(),
                      false);
                } else {
                  widget.onSwipe(index, "", true);
                }
              });

              if (checkGuestType == 'null') {
                controller.label =
                    direction == SwipeDirection.right ? 'Saved' : 'Seen';
                var i = swipeCount++;

                setState(() {
                  swipeCount = i;
                });
                controller.updateProgressOfCard(0.0);
                controller.updateDirectionOfCard(null);
                countSwipe(i.toString());
                if (widget.postModel.result![index].type == 3 &&
                    videoViewerControllerList[index].isPlaying) {
                  videoViewerControllerList[index].pause();
                  setState(() {});
                }
                controller.refreshed.value = false;
              } else {
                if (isCheckProUser == false) {
                  setState(() {
                    countPost++;
                  });

                  if (countPost > 29) {
                    PageNavigateScreen().push(
                        context,
                        AmateurUserLimitationPage(
                          showBottomBar: true,
                          pageIndex: 0,
                          onBack: 1,
                        ));
                  } else {
                    controller.label =
                        direction == SwipeDirection.right ? 'Saved' : 'Seen';
                    if (direction == SwipeDirection.right) {
                      setState(() {
                        countSaved++;
                      });
                      if (countSaved > 14) {
                        PageNavigateScreen().push(
                            context,
                            AmateurUserLimitationPage(
                              showBottomBar: true,
                              pageIndex: 0,
                              onBack: 1,
                            ));
                      } else {
                        controller.savedLikeSavedVideo(
                            widget.postModel.result![index].id, 1);
                      }
                    } else {
                      controller.savedLikeSavedVideo(
                          widget.postModel.result![index].id, 2);
                    }
                  }
                } else {
                  controller.label =
                      direction == SwipeDirection.right ? 'Saved' : 'Seen';
                  if (direction == SwipeDirection.right) {
                    controller.savedLikeSavedVideo(
                        widget.postModel.result![index].id, 1);
                  } else {
                    controller.savedLikeSavedVideo(
                        widget.postModel.result![index].id, 2);
                  }
                }
                if (kDebugMode) {
                  print('index is $index, direction is $direction');
                }

                controller.setVisibleSeen(true);
                Future.delayed(Duration(milliseconds: 500)).then((value) {
                  controller.setVisibleSeen(false);
                });
                //SEND INDEX AND TITLE

                controller.updateProgressOfCard(0.0);
                controller.updateDirectionOfCard(null);
                if (widget.postModel.result![index].type == 3 &&
                    videoViewerControllerList[index].isPlaying) {
                  videoViewerControllerList[index].pause();
                  setState(() {});
                }
                controller.refreshed.value = false;
              }
            },
            horizontalSwipeThreshold: 0.8,
            verticalSwipeThreshold: 0.8,
            swipeAnchor: SwipeAnchor.bottom,
            itemCount: widget.postModel.result!.length,
            builder: (context, properties) {
              final itemIndex =
                  properties.index % widget.postModel.result!.length;
              controller.currentItemIndex.value = itemIndex;
              if (mounted) {
                controller.updateProgressOfCard(properties.swipeProgress);
                controller.updateDirectionOfCard(
                    //checkGuestType == 'null' ? null :
                    properties.direction);
              }
              return Stack(
                children: [
                  swipeCount > 19
                      ? SwipeLimitationPage()
                      : widget.postModel.result!.isNotEmpty &&
                              widget.postModel.result!.length > (itemIndex)
                          ? controller.getSliderWidget(
                              post: widget.postModel.result![itemIndex],
                              context: context,
                              itemIndex: itemIndex)
                          : Container(),
                ],
              );
            },
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: controller.progressOfCard.value.toStringAsFixed(2) ==
                    "0.00" /* &&
                      controller.direction == null*/
                ? SizedBox()
                : AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: controller.progressOfCard.value * 25,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.4,
                      color: Colors.white,
                      height: 1,
                    ),
                    child: Text(
                      controller.direction == SwipeDirection.left
                          ? 'Seen'
                          : 'Saved',
                    ),
                  )),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              widget.controller.nextPage(
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
            child: Container(
              height: SizeConfig.getSize35(context: context),
              width: SizeConfig.getSize35(context: context),
              margin: EdgeInsets.only(
                  bottom: Platform.isAndroid
                      ? SizeConfig.getSize5(context: context)
                      : SizeConfig.getSize5(context: context)),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(71, 60, 60, 60).withOpacity(0.2),
                      blurRadius: 20,
                      offset: Offset(
                        0,
                        0,
                      ))
                ],
              ),
              child: Image.asset(
                  "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png"),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  controller.swipableStackController
                      .next(swipeDirection: SwipeDirection.right);
                },
                child: Container(
                  height: SizeConfig.getSize35(context: context),
                  width: SizeConfig.getSize35(context: context),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromARGB(71, 60, 60, 60).withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(
                            0,
                            0,
                          ))
                    ],
                  ),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(
                        "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png"),
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  controller.swipableStackController
                      .next(swipeDirection: SwipeDirection.left);
                },
                child: Container(
                  height: SizeConfig.getSize35(context: context),
                  width: SizeConfig.getSize35(context: context),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromARGB(71, 60, 60, 60).withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(
                            0,
                            0,
                          ))
                    ],
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Image.asset(
                        "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.getFontSize25(context: context),
            right: SizeConfig.getFontSize25(context: context),
            bottom: SizeConfig.getSize60(context: context) +
                SizeConfig.getSize50(context: context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.postModel.result!.length > newIndex
                  ? widget.postModel.result![newIndex].tags != null
                      ? HtmlWidget(
                          '${widget.postModel.result![newIndex].tags}',
                          onTapUrl: (url) {
                            launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);

                            return true;
                          },
                          textStyle: TextStyle(fontSize: 22),
                        )
                      : Container()
                  : Container(),
              // Text(

              //   //'Tag: Movlogs',
              //   style: white21wBold,
              // ),
              SizedBox(height: 5),
              // InkWell(
              //   onTap: () {},
              //   child: Text('Click here to open a website',
              //       style: gredient117boldWithUnderLine),
              // ),
              // InkWell(
              //   onTap: () {},
              //   child: Text('Click here to open a website',
              //       style: gredient117boldWithUnderLine),
              // ),
              // InkWell(
              //   onTap: () {},
              //   child: Text('Click here to open a website',
              //       style: gredient117boldWithUnderLine),
              // ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      controller.appIsInBackground.value = true;
    }
    if (state == AppLifecycleState.resumed) {
      debugPrint(
          "App is resumed and visibility is ${controller.videoVisibilityPercent.value}");
      controller.appIsInBackground.value = false;
      setState(() {});
    }
  }
}
