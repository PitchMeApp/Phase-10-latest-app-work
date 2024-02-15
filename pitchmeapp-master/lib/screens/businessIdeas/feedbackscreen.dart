import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/controller/businessIdeas/postPageController.dart';
import 'package:pitch_me_app/screens/businessIdeas/FeedbackApi.dart/postApi.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../View/Manu/manu.dart';
import '../../utils/extras/extras.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/images.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../../utils/widgets/containers/containers.dart';

class ratingScreen extends StatefulWidget {
  String receiverid;
  String postid;
  ratingScreen({
    super.key,
    required this.receiverid,
    required this.postid,
  });

  @override
  State<ratingScreen> createState() => _ratingScreenState();
}

class _ratingScreenState extends State<ratingScreen> {
  final formkey = GlobalKey<FormState>();
  var rating = 0.0;
  var rating_Two = 0.0;
  bool selectbutton = false;
  int isCheck = 0;

  String description = '';

  PostPageController _pageController = Get.put(PostPageController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    _pageController.notVideo = true;

    return Scaffold(
        //resizeToAvoidBottomInset: false,
        bottomNavigationBar: BannerWidget(onPressad: () {}),
        body: BackGroundWidget(
          backgroundImage: Assets.backgroundImage,
          fit: BoxFit.fill,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipPath(
                            clipper: CurveClipper(),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: DynamicColor.gradientColorChange),
                              height: MediaQuery.of(context).size.height * 0.27,
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
                      Column(children: [
                        SizedBox(
                          height: sizeH * 0.02,
                        ),
                        Text(
                          "Please give a Feedback",
                          style: TextStyle(
                              fontSize: sizeH * 0.030,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              color: DynamicColor.gredient1),
                        ),
                        Text(
                          "So They can Improve",
                          style: TextStyle(
                              fontSize: sizeH * 0.025,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              color: DynamicColor.lightBlack),
                        ),
                        SizedBox(
                          height: sizeH * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.getFontSize25(context: context),
                              right:
                                  SizeConfig.getFontSize25(context: context)),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "The Business",
                                      style: TextStyle(
                                          fontSize: sizeH * 0.016,
                                          letterSpacing: 0.5,
                                          color: DynamicColor.black),
                                    ),
                                  ),
                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      onRatingChanged: (value) {
                                        setState(() {
                                          rating = value;
                                        });
                                      },
                                      starCount: 5,
                                      rating: rating,
                                      size: 30.0,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_border,
                                      color: Color(0xffF8B706),
                                      borderColor: Color(0xffF8B706),
                                      spacing: 0.0),
                                  SizedBox(
                                    height: sizeH * 0.015,
                                  ),
                                  Center(
                                    child: Text(
                                      "The Sales Pitch",
                                      style: TextStyle(
                                          fontSize: sizeH * 0.016,
                                          letterSpacing: 0.5,
                                          color: DynamicColor.black),
                                    ),
                                  ),
                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      onRatingChanged: (value) {
                                        setState(() {
                                          rating_Two = value;
                                        });
                                      },
                                      starCount: 5,
                                      rating: rating_Two,
                                      size: 30.0,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_border,
                                      color: Color(0xffF8B706),
                                      borderColor: Color(0xffF8B706),
                                      spacing: 0.0),
                                  SizedBox(
                                    height: sizeH * 0.02,
                                  ),
                                  SizedBox(
                                    width: sizeW - 50,
                                    child: TextFormField(
                                      autofocus: false,
                                      maxLines: 5,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintText: 'Give a Brief Advice',
                                          contentPadding: EdgeInsets.only(
                                              top: 15, left: 5, right: 5),
                                          fillColor: Color(0xffF4F4F4),
                                          filled: true),
                                      onChanged: (value) {
                                        setState(() {
                                          description = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeH * 0.03,
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isCheck = 1;
                              });
                              final isvalidation =
                                  formkey.currentState!.validate();

                              print(" rating star ${rating_Two}");

                              if (description.isNotEmpty &&
                                  rating_Two != 0.0 &&
                                  rating != 0.0) {
                                postfeedback(widget.receiverid, widget.postid,
                                    rating, rating_Two, description, context);
                              } else {
                                myToast(context,
                                    msg: "Please give star and feedback");
                                selectbutton = true;
                              }
                            },
                            child: Container(
                                height: 48,
                                width: MediaQuery.of(context).size.width * 0.4,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: isCheck == 1
                                        ? DynamicColor.white
                                        : null,
                                    border: isCheck == 1
                                        ? Border.all(
                                            color: DynamicColor.gredient2)
                                        : null,
                                    gradient: isCheck == 1
                                        ? null
                                        : DynamicColor.gradientColorChange),
                                child: Text(
                                  "DONE",
                                  style: isCheck == 1
                                      ? gredient216bold
                                      : white16bold,
                                )),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isCheck = 2;
                                _pageController.left.value = false;
                              });
                              _pageController.savedVideo(
                                  widget.postid, widget.receiverid, 1, context);
                            },
                            child: Container(
                                height: 48,
                                width: MediaQuery.of(context).size.width * 0.4,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: isCheck == 2
                                        ? DynamicColor.white
                                        : null,
                                    border: isCheck == 2
                                        ? Border.all(
                                            color: DynamicColor.gredient2)
                                        : null,
                                    gradient: isCheck == 2
                                        ? null
                                        : DynamicColor.gradientColorChange),
                                child: Text(
                                  "SKIP",
                                  style: isCheck == 2
                                      ? gredient216bold
                                      : white16bold,
                                )),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              CustomAppbarWithWhiteBg(
                  title: 'Review',
                  backCheckBio: null,
                  onPressad: () {
                    PageNavigateScreen().push(
                        context,
                        ManuPage(
                          title: 'Review',
                          pageIndex: 1,
                          isManu: 'Manu',
                        ));
                  }),
            ],
          ),
        ));
  }
}
