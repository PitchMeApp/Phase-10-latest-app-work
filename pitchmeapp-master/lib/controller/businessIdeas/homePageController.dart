import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/devApi%20Service/post_api.dart';
import 'package:pitch_me_app/models/post/postModel.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/widgets/extras/directVideoViewer.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePageController extends GetxController {
  RxInt PageIndexData = 0.obs;
  RxString hideNaveBar = ''.obs;
  var visibleSaveSeen = false.obs,
      progressOfCard = 0.0.obs,
      isPlay = true.obs,
      currentItemIndex = 0.obs,
      videoVisibilityPercent = 0.0.obs,
      appIsInBackground = false.obs,
      refreshed = false.obs;
  final SwipableStackController swipableStackController =
      SwipableStackController();
  SwipeDirection? direction;
  bool left = false, right = false;

  //dev
  final postserver = PostApiServer();

  var images = [
    Assets.dashBackgroundImage,
    Assets.postImage2,
    Assets.dashBackgroundImage,
    Assets.postImage2,
    Assets.dashBackgroundImage,
    Assets.postImage2,
  ];
  String label = "Seen";

  updateProgressOfCard(double value) {
    progressOfCard.value = value;
  }

  updateDirectionOfCard(SwipeDirection? value) {
    direction = value;
  }

  setVisibleSeen(bool value) {
    visibleSaveSeen.value = value;
  }

  savedLikeSavedVideo(postID, swipeType) {
    postserver.savedLikeVideoApi(postID, swipeType);
  }

  List<String> videoUrls = [
    "https://saturncube.com/temp-video/video11.mov",
    "https://saturncube.com/temp-video/video12.mov",
    "https://saturncube.com/temp-video/video13.mov",
    "https://saturncube.com/temp-video/video14.mov",
    "https://saturncube.com/temp-video/video15.mov",
    "https://saturncube.com/temp-video/video11.mov",
    "https://saturncube.com/temp-video/video12.mov",
    "https://saturncube.com/temp-video/video13.mov",
    "https://saturncube.com/temp-video/video14.mov",
    "https://saturncube.com/temp-video/video15.mov",
    "https://saturncube.com/temp-video/video11.mov",
    "https://saturncube.com/temp-video/video12.mov",
    "https://saturncube.com/temp-video/video13.mov",
    "https://saturncube.com/temp-video/video14.mov",
    "https://saturncube.com/temp-video/video15.mov",
  ];
  Widget getSliderWidget(
      {required Results post,
      required BuildContext context,
      required int itemIndex}) {
    debugPrint("Post type is ${post.type}");

    switch (post.type) {
      case 1:
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.only(
              left: SizeConfig.getSize20(context: context),
              right: SizeConfig.getSize20(context: context),
              bottom: SizeConfig.getSize40(context: context),
              top: SizeConfig.getSize100(context: context)),
          child: Center(
              child: SingleChildScrollView(
                  child:
                      Center(child: HtmlWidget('<center>${post.text}</center>')
                          // Text(
                          //   post.text,
                          //   style: TextStyle(fontSize: 17),
                          // ),
                          ))),
        );
      case 2:
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          // /*decoration: BoxDecoration(
          //       color: Colors.white,
          //       image: DecorationImage(
          //         image: NetworkImage(
          //           '${post.file!}',
          //         ),
          //       ))*/
          child: CachedNetworkImage(
              imageUrl: '${post.file}',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ],
                  )),
        );
      case 3:
        debugPrint(
            "App is in background =${appIsInBackground.value} and visibility ${videoVisibilityPercent.value}");
        return VisibilityDetector(
            key: Key('my-widget-key'),
            onVisibilityChanged: (visibilityInfo) {
              var visiblePercentage = visibilityInfo.visibleFraction * 100;
              debugPrint(
                  'Widget ${visibilityInfo.key.toString()} is ${visiblePercentage}% visible');
              try {
                videoVisibilityPercent.value = visiblePercentage;
                if (visiblePercentage < 90) {
                  videoViewerControllerList[itemIndex].pause();
                }
                if (visiblePercentage > 90 &&
                    videoViewerControllerList[itemIndex].isPlaying == false &&
                    swipableStackController.currentIndex == itemIndex) {
                  videoViewerControllerList[itemIndex].play();
                }
              } catch (e) {
                print("Error is ${e.toString()}");
              }
              debugPrint("Swipe $direction");
              debugPrint("left $left");
            },
            child:
                // Center(child: Text(post.id.toString())),

                DirectVideoViewer(
              url: post.file,
              itemIndex: itemIndex,
              currentIndex: swipableStackController.currentIndex,
              isPlay: isPlay.value,
              visibility: videoVisibilityPercent.value,
            )

            // child: direction == SwipeDirection.right
            //     ? ratingScreen()
            //     : interestedSwipe(),
            );
      default:
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(
                  images[0],
                ),
                fit: BoxFit.cover,
              )),
        );
    }
  }
}
