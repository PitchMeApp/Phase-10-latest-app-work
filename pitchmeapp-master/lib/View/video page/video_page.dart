import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Likes/detail_page.dart';
import 'package:pitch_me_app/View/selected_data_view/selected_page.dart';
import 'package:pitch_me_app/View/video%20page/Controller/controller.dart';
import 'package:pitch_me_app/View/video%20page/video_play_page.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';

import '../../utils/colors/colors.dart';
import '../../utils/extras/extras.dart';
import '../../utils/strings/images.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../Deals Page/deals_page.dart';
import 'camera_page.dart';

class VideoPageMain extends StatefulWidget {
  String type;
  VideoPageMain({super.key, required this.type});

  @override
  State<VideoPageMain> createState() => _VideoPageMainState();
}

class _VideoPageMainState extends State<VideoPageMain> {
  final VideoFirstPageController _videoFirstPageController =
      Get.put(VideoFirstPageController());

  final _controller = PageController();

  int selectIndex = 2;
  int nextPage = 0;
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DynamicColor.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  nextPage = value;
                });
              },
              children: [
                BackGroundWidget(
                  backgroundImage: Assets.backgroundImage,
                  fit: BoxFit.fill,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: SizeConfig.getSize100(context: context) +
                                SizeConfig.getSize55(context: context),
                          ),

                          //const SizedBox(height: 120),
                          Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.getSize55(context: context),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextFormField(
                                  controller: _videoFirstPageController
                                      .editingController,
                                  keyboardType: TextInputType.name,
                                  cursorColor: DynamicColor.gredient1,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: DynamicColor.gredient1,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                  maxLength: 15,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      hintText: "Enter Business Name",
                                      hintStyle: TextStyle(
                                          fontSize: 25,
                                          color: DynamicColor.lightGrey,
                                          fontWeight: FontWeight.w700)),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              //const SizedBox(height: 20),
                              widget.type == 'upload'
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          left: SizeConfig.getSize20(
                                              context: context)),
                                      child: InkWell(
                                          onTap: () {
                                            if (_videoFirstPageController
                                                .editingController
                                                .text
                                                .isNotEmpty) {
                                              Get.to(() => const CameraPage(),
                                                  arguments:
                                                      _videoFirstPageController
                                                          .editingController
                                                          .text
                                                          .toString());
                                            } else {
                                              myToast(context,
                                                  msg: 'Please enter title');
                                            }
                                          },
                                          child: Image.asset(
                                            'assets/imagess/video.png',
                                            //  height: 70,
                                            width: 70,
                                          )),
                                    ),
                              widget.type == 'upload'
                                  ? Container()
                                  : Text(
                                      'Self Record 1Min Pitch',
                                      style: textColor12,
                                    ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        SizeConfig.getSize55(context: context)),
                                child: CustomListBox(
                                    title: 'Pitch Example',
                                    singleSelectColor: isSelect,
                                    isSingleSelect: 1,
                                    onPressad: () {
                                      setState(() {
                                        isSelect = 1;
                                      });
                                      PageNavigateScreen().push(
                                          context,
                                          ShowFullVideoPage(
                                              url:
                                                  'https://d2vaqd2kfxjiiz.cloudfront.net/pitchme/examplepitch.mp4'));
                                    }),
                              ),
                            ],
                          ),

                          const SizedBox(height: 50),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Text('Pitch details', style: gredient116bold),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    bottom: Platform.isAndroid
                                        ? SizeConfig.getSize55(context: context)
                                        : SizeConfig.getSize60(
                                                context: context) +
                                            SizeConfig.getSize15(
                                                context: context),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.nextPage(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.linear);
                                    },
                                    child: RotatedBox(
                                        quarterTurns: 4,
                                        child: Image.asset(
                                          "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                          height: SizeConfig.getSize35(
                                              context: context),
                                          width: SizeConfig.getSize35(
                                              context: context),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomHeaderView(
                        progressPersent: 1,
                        checkNext: widget.type == 'upload' ? 'upload' : null,
                        backOnTap: () {
                          setState(() {
                            _videoFirstPageController.videoUrl.value = '';
                          });
                          Navigator.of(context).pop();
                        },
                        nextOnTap: () {
                          if (_videoFirstPageController
                              .editingController.text.isNotEmpty) {
                            Get.to(() => VideoPage(
                                  filePath: _videoFirstPageController
                                      .videoUrl.value
                                      .toString(),
                                  title: _videoFirstPageController
                                      .editingController.text
                                      .toString(),
                                ));
                          } else {
                            myToast(context, msg: 'Please enter title');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SelectedPage(
                  showIcon: nextPage,
                  pageController: _controller,
                )
              ],
            ),
            NewCustomBottomBar(
              index: 2,
            ),
          ],
        ));
  }
}
