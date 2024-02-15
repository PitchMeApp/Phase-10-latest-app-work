import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:video_viewer/video_viewer.dart';

List<VideoViewerController> videoViewerControllerList = [];

class DirectVideoViewer extends StatefulWidget {
  final String url;
  final int itemIndex;
  final int currentIndex;
  final bool isPlay;
  final double visibility;

  DirectVideoViewer(
      {Key? key,
      required this.url,
      required this.itemIndex,
      required this.currentIndex,
      required this.isPlay,
      required this.visibility})
      : super(key: key);

  @override
  State<DirectVideoViewer> createState() => _DirectVideoViewerState();
}

class _DirectVideoViewerState extends State<DirectVideoViewer> {
  bool isPlay = true;

  @override
  void initState() {
    super.initState();

    // videoViewerControllerList[widget.itemIndex].addListener(() {
    // });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "Current index is ${widget.currentIndex} and item index is ${widget.itemIndex} cotnroller length ${videoViewerControllerList.length} and visibility =${widget.visibility}");
    try {
      if (videoViewerControllerList[widget.itemIndex] != null) {
        if (widget.itemIndex == widget.currentIndex) {
          videoViewerControllerList[widget.itemIndex].play();
          isPlay = true;
          if (widget.visibility == 0) {
            videoViewerControllerList[widget.itemIndex].pause();
          }
        } else {
          isPlay = false;
        }
      }
    } catch (e) {
      debugPrint("Error on direct video viewer");
    }
    return Container(
      width: width(context),
      height: height(context),
      color: Color.fromARGB(255, 254, 254, 254),
      child: VideoViewer(
        controller: videoViewerControllerList[widget.itemIndex],
        autoPlay: isPlay,
        enableHorizontalSwapingGesture: false,
        enableVerticalSwapingGesture: false,
        volumeManager: VideoViewerVolumeManager.device,
        onFullscreenFixLandscape: false,
        forwardAmount: 5,
        defaultAspectRatio: 9 / 16,
        rewindAmount: -5,
        looping: true,
        enableShowReplayIconAtVideoEnd: false,
        style: VideoViewerStyle(
            playAndPauseStyle: PlayAndPauseWidgetStyle(
              background: Colors.transparent,
              circleRadius: 80.0,
              play: Center(
                child: Icon(
                  Icons.play_arrow,
                  size: 80,
                  color: DynamicColor.white,
                ),
              ),
              pause: Center(
                child: Icon(
                  Icons.pause,
                  size: 80,
                  color: DynamicColor.white,
                ),
              ),
            ),
            thumbnail: Image.network(''),
            loading: CircularProgressIndicator(
              color: DynamicColor.gredient1,
            )),
        source: {
          "Source": VideoSource(
            video: VideoPlayerController.network(Uri.encodeFull(widget.url
                .replaceAll('https://api.salespitchapp.com',
                    'http://191.101.229.245:9070'))),
          )
        },
      ),
    );
  }

  @override
  void dispose() {
    videoViewerControllerList[widget.itemIndex].pause();

    super.dispose();
  }
}
