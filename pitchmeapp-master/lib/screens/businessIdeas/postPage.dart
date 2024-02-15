import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/controller/businessIdeas/postPageController.dart';
import 'package:pitch_me_app/screens/businessIdeas/feedbackscreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/interestedSwipe.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/directVideoViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/amateur_user_limitation.dart';
import '../../devApi Service/get_api.dart';
import '../../utils/colors/colors.dart';
import '../../utils/widgets/containers/containers.dart';

class PostPageWidget extends StatefulWidget {
  const PostPageWidget({
    Key? key,
    required this.controller,
    required this.onSwipe,
    required this.postModel,
  }) : super(key: key);
  final PageController controller;
  final Function(int index, String title, bool isFinish) onSwipe;
  final SalesPitchListModel postModel;

  @override
  State<PostPageWidget> createState() => _PostPageWidgetState();
}

class _PostPageWidgetState extends State<PostPageWidget>
    with AutomaticKeepAliveClientMixin<PostPageWidget>, WidgetsBindingObserver {
  void _listenController() => setState(() {});
  PostPageController controller = Get.put(PostPageController());

  String checkGuestType = '';
  String businesstype = '';
  String userID = '';
  String adminUser = '';

  dynamic proUser;
  dynamic directionn;

  int swipeCount = 0;

  int countPost = 0;
  int countSaved = 0;

  bool isCheckProUser = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkGuest();

    controller.swipableStackController.addListener(_listenController);
    videoViewerControllerList.clear();

    videoViewerControllerList.addAll(List.generate(
        widget.postModel.result!.docs.length,
        (index) => VideoViewerController()));
  }

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

      userID = preferencesData.getString('user_id').toString();
      adminUser = preferencesData.getString('bot').toString();
      proUser = jsonDecode(preferencesData.getString('pro_user').toString());
    });
    checkUser();
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
          countPost = int.parse('${value['data']['salespitchsaveModel']}') +
              int.parse('${value['data']['Feedback']}');
          countSaved = int.parse('${value['data']['salespitchsaveModel']}');
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SwipableStack(
            swipeAssistDuration: Duration.zero,
            swipeAnchor: SwipeAnchor.bottom,
            dragStartDuration: Duration.zero,
            stackClipBehaviour: Clip.none,

            detectableSwipeDirections: const {
              SwipeDirection.right,
              SwipeDirection.left,
            },
            allowVerticalSwipe: false,
            controller: controller.swipableStackController,
            onWillMoveNext: (index, direction) {
              final allowedActions = [
                SwipeDirection.right,
                SwipeDirection.left,
              ];
              return allowedActions.contains(direction);
            },

            // stackClipBehaviour: Clip.hardEdge,
            onSwipeCompleted: (index, direction) {
              print("left123direction $index");

              if (isCheckProUser == false) {
                setState(() {
                  countPost++;
                });

                if (countPost > 9) {
                  PageNavigateScreen().push(
                      context,
                      AmateurUserLimitationPage(
                        showBottomBar: true,
                        pageIndex: 1,
                        onBack: 2,
                      ));
                } else {
                  controller.label =
                      direction == SwipeDirection.right ? 'Saved' : 'Seen';

                  if (direction == SwipeDirection.right) {
                    setState(() {
                      countSaved++;
                    });
                    if (countSaved > 2) {
                      PageNavigateScreen().push(
                          context,
                          AmateurUserLimitationPage(
                            showBottomBar: true,
                            pageIndex: 1,
                            onBack: 2,
                          ));
                    } else {
                      PageNavigateScreen()
                          .push(
                              context,
                              interestedSwipe(
                                userID:
                                    widget.postModel.result!.docs[index].userid,
                              ))
                          .then((value) {
                        setState(() {
                          if (widget.postModel.result!.docs.isNotEmpty &&
                              widget.postModel.result!.docs.length >
                                  (index + 1)) {
                            widget.onSwipe(
                                index + 1,
                                widget.postModel.result!.docs[index + 1].title
                                    .toString(),
                                false);
                          } else {
                            widget.onSwipe(index, "", true);
                            // widget.postModel.result!.docs[index + 1];
                          }
                        });
                      });
                      controller.savedVideo(
                          widget.postModel.result!.docs[index].id,
                          widget.postModel.result!.docs[index].userid,
                          0,
                          context);
                    }
                  } else {
                    PageNavigateScreen()
                        .push(
                            context,
                            ratingScreen(
                              receiverid:
                                  widget.postModel.result!.docs[index].userid,
                              postid: widget.postModel.result!.docs[index].id,
                            ))
                        .then((value) {
                      setState(() {
                        if (widget.postModel.result!.docs.isNotEmpty &&
                            widget.postModel.result!.docs.length >
                                (index + 1)) {
                          widget.onSwipe(
                              index + 1,
                              widget.postModel.result!.docs[index + 1].title
                                  .toString(),
                              false);
                        } else {
                          widget.onSwipe(index, "", true);
                          // widget.postModel.result!.docs[index + 1];
                        }
                      });
                    });
                  }
                }
              } else {
                controller.label =
                    direction == SwipeDirection.right ? 'Saved' : 'Seen';

                if (direction == SwipeDirection.right) {
                  PageNavigateScreen()
                      .push(
                          context,
                          interestedSwipe(
                            userID: widget.postModel.result!.docs[index].userid,
                          ))
                      .then((value) {
                    setState(() {
                      if (widget.postModel.result!.docs.isNotEmpty &&
                          widget.postModel.result!.docs.length > (index + 1)) {
                        log('index = ' + index.toString());
                        widget.onSwipe(
                            index + 1,
                            widget.postModel.result!.docs[index + 1].title
                                .toString(),
                            false);
                      } else {
                        widget.onSwipe(index, "", true);
                        // widget.postModel.result!.docs[index + 1];
                      }
                    });
                  });
                  controller.savedVideo(
                    widget.postModel.result!.docs[index].id,
                    widget.postModel.result!.docs[index].userid,
                    0,
                    context,
                  );
                } else {
                  PageNavigateScreen()
                      .push(
                          context,
                          ratingScreen(
                            receiverid:
                                widget.postModel.result!.docs[index].userid,
                            postid: widget.postModel.result!.docs[index].id,
                          ))
                      .then((value) {
                    setState(() {
                      if (widget.postModel.result!.docs.isNotEmpty &&
                          widget.postModel.result!.docs.length > (index + 1)) {
                        widget.onSwipe(
                            index + 1,
                            widget.postModel.result!.docs[index + 1].title
                                .toString(),
                            false);
                      } else {
                        widget.onSwipe(index, "", true);

                        // widget.postModel.result!.docs[index + 1];
                      }
                    });
                  });
                }
              }
              if (direction == SwipeDirection.left) {
                controller.left.value = !controller.left.value;
              }
              if (direction == SwipeDirection.right) {
                controller.right.value = !controller.right.value;
              }
              if (!mounted) {
                return;
              }
              setState(() {
                directionn = direction;
                controller.updateProgressOfCard(0.0);
                controller.updateDirectionOfCard(null);
              });
              print('index is $index, direction is $direction');

              controller.setVisibleSeen(true);
              Future.delayed(Duration(milliseconds: 200)).then((value) {
                controller.setVisibleSeen(false);
              });

              // if (directionn == SwipeDirection.left &&
              //     controller.left.value == true) {
              //   controller.swipableStackController.rewind();
              // }
              // if (directionn == SwipeDirection.right &&
              //     controller.right.value == true) {
              //   controller.swipableStackController.rewind();
              // }

              if (widget.postModel.result!.docs[index].status == 2 &&
                  videoViewerControllerList[index].isPlaying) {
                videoViewerControllerList[index].pause();
                if (!mounted) {
                  return;
                }
                setState(() {});
              }
              controller.refreshed.value = false;
            },
            horizontalSwipeThreshold: 0.8,
            verticalSwipeThreshold: 0.8,

            itemCount: widget.postModel.result!.docs.length,
            builder: (context, properties) {
              final itemIndex =
                  properties.index % widget.postModel.result!.docs.length;
              controller.currentItemIndex.value = itemIndex;

              if (mounted) {
                controller.updateProgressOfCard(properties.swipeProgress);
                controller.updateDirectionOfCard(properties.direction);
              }

              return Stack(
                children: [
                  widget.postModel.result!.docs.isNotEmpty &&
                          widget.postModel.result!.docs.length > (itemIndex)
                      ? controller.getSliderWidget2(
                          post: widget.postModel.result!.docs[itemIndex],
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
            child: controller.progressOfCard.value.toStringAsFixed(2) == "0.00"
                ? SizedBox()
                : AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: controller.progressOfCard.value * 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.4,
                      color: Colors.white,
                      height: 1,
                    ),
                    child: Text(
                      controller.direction == null
                          ? ''
                          : controller.direction == SwipeDirection.left
                              ? 'Not interested'
                              : 'Interested',
                    ),
                  )),
        // Padding(
        //   padding: EdgeInsets.only(
        //       bottom: Platform.isAndroid
        //           ? SizeConfig.getSize60(context: context)
        //           : SizeConfig.getSize60(context: context) +
        //               SizeConfig.getSize15(context: context),
        //       left: SizeConfig.getFontSize25(context: context),
        //       right: SizeConfig.getFontSize25(context: context)),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Container(
        //         decoration: BoxDecoration(
        //             gradient: DynamicColor.gradientColorChange,
        //             borderRadius: BorderRadius.only(
        //                 topRight: Radius.circular(10),
        //                 bottomLeft: Radius.circular(10))),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: InkWell(
        //             onTap: () async {
        //               if (isCheckProUser) {
        //                 // openDilog();
        //                 try {
        //                   // await GetApiService()
        //                   //     .shareVideoApi(
        //                   //         widget.postModel.result!.docs[newIndex].vid1)
        //                   //     .then((value) {
        //                   //   log(value.toString());
        //                   Share.share(
        //                     'http://salespitchapp.com/share.php?id=${widget.postModel.result!.docs[newIndex].id}',
        //                   );
        //                   //  });
        //                   // Navigator.of(context).pop();
        //                 } catch (e) {
        //                   log(e.toString());
        //                   //Navigator.of(context).pop();
        //                 }
        //               } else {
        //                 videoViewerControllerList[newIndex].pause();
        //                 PageNavigateScreen()
        //                     .push(
        //                         context,
        //                         ProUserLimitationPage(
        //                           pageIndex: 1,
        //                         ))
        //                     .then((value) {
        //                   videoViewerControllerList[newIndex].play();
        //                 });
        //               }
        //             },
        //             child: Image.asset(
        //               'assets/imagess/share.png',
        //               height: 30,
        //               width: 30,
        //               color: DynamicColor.white,
        //             ),
        //           ),
        //         ),
        //       ),
        Padding(
          padding: EdgeInsets.only(
            bottom: Platform.isAndroid
                ? SizeConfig.getSize20(context: context)
                : SizeConfig.getSize5(context: context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Business details', style: gredient116bold),
              Align(
                alignment: Alignment.bottomCenter,
                child: widget.postModel.result!.docs[0].id
                        .contains('6448e9494ff8f4cb69599465')
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          widget.postModel.result!.docs[0].id
                                  .contains('6448e9494ff8f4cb69599465')
                              ? null
                              : widget.controller.nextPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.linear);
                        },
                        child: Container(
                          height: SizeConfig.getSize35(context: context),
                          width: SizeConfig.getSize35(context: context),
                          child: Image.asset(
                            "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        //       widget.postModel.result!.docs.length > newIndex
        //           ? userID == widget.postModel.result!.docs[newIndex].user.id ||
        //                   businesstype == '5'
        //               ? Container(
        //                   decoration: BoxDecoration(
        //                       gradient: DynamicColor.gradientColorChange,
        //                       borderRadius: BorderRadius.only(
        //                           topLeft: Radius.circular(10),
        //                           bottomRight: Radius.circular(10))),
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: InkWell(
        //                       onTap: () async {
        //                         openDilog();
        //                         await GetApiService()
        //                             .shareVideoApi(widget
        //                                 .postModel.result!.docs[newIndex].vid1)
        //                             .then((value) {
        //                           downloadFile(value['message']);
        //                         });
        //                         Navigator.of(context).pop();
        //                       },
        //                       child: Image.asset(
        //                         'assets/imagess/download.png',
        //                         height: 30,
        //                         width: 30,
        //                         color: DynamicColor.white,
        //                       ),
        //                     ),
        //                   ),
        //                 )
        //               : SizedBox(
        //                   height: 50,
        //                   width: 50,
        //                 )
        //           : SizedBox(
        //               height: 50,
        //               width: 50,
        //             ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(
              bottom: Platform.isAndroid
                  ? SizeConfig.getSize25(context: context)
                  : SizeConfig.getSize15(context: context),
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.postModel.result!.docs[0].id
                      .contains('6448e9494ff8f4cb69599465')
                  ? Container()
                  : Align(
                      alignment: Alignment.bottomLeft,
                      child: AppBarIconContainer(
                        height: SizeConfig.getSize38(context: context),
                        width: SizeConfig.getSize38(context: context),
                        color: DynamicColor.redColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        child: Icon(
                          Icons.close,
                          color: DynamicColor.white,
                          size: 30,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: RotatedBox(
                        //     quarterTurns: 1,
                        //     child: Image.asset(
                        //       "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                        //       height: 30,
                        //       width: 30,
                        //       color: DynamicColor.white,
                        //     ),
                        //   ),
                        // ),
                        onTap: () {
                          controller.swipableStackController
                              .next(swipeDirection: SwipeDirection.left);
                        },
                      ),
                    ),
              Align(
                alignment: Alignment.bottomRight,
                child: AppBarIconContainer(
                  height: SizeConfig.getSize38(context: context),
                  width: SizeConfig.getSize38(context: context),
                  color: DynamicColor.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Icon(
                    Icons.check,
                    color: DynamicColor.white,
                    size: 30,
                  ),
                  onTap: () {
                    controller.swipableStackController
                        .next(swipeDirection: SwipeDirection.right);
                  },
                ),
              ),
              // BackArrow(
              //   alignment: Alignment.bottomRight,
              //   borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(10),
              //       bottomRight: Radius.circular(10)),
              //   direction: 3,
              //   onPressed: () {
              //     controller.swipableStackController
              //         .next(swipeDirection: SwipeDirection.right);
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
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
