import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/businessIdeas/dashBoardController.dart';
import 'package:pitch_me_app/controller/businessIdeas/home_filter_controller.dart';
import 'package:pitch_me_app/screens/businessIdeas/HomepageCard.dart';
import 'package:pitch_me_app/screens/businessIdeas/statisticsPage.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/text/text.dart';

class DashBoardScreen extends StatefulWidget {
  final Function(int index) currentPage;
  final Function(int index, String title, bool isFinish) onSwipe;

  const DashBoardScreen(
      {Key? key, required this.currentPage, required this.onSwipe})
      : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _controller = PageController();
  DashboardController controller = Get.put(DashboardController());
  HomeFilterController homeFilterController = Get.put(HomeFilterController());
  bool ChangeButton = false;
  int swipeCount = 0;
  @override
  void initState() {
    super.initState();
    controller.getPost(widget.onSwipe, homeFilterController.selectedData.value);
    controller.getStatic();
    _controller.addListener(() {
      widget.currentPage(_controller.page!.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return PageView(
        controller: _controller,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          controller.isLoadingPost.value == true
              ? Center(
                  child: CircularProgressIndicator(
                  color: DynamicColor.gredient1,
                ))
              : controller.hasError.value
                  ? Center(child: roboto(size: 20, text: 'No post available'))
                  : controller.isFinish.value
                      ? Stack(
                          children: [
                            Center(
                                child: roboto(
                                    size: 20, text: 'No more post available')),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        SizeConfig.getSize10(context: context)),
                                child: GestureDetector(
                                  onTap: () {
                                    _controller.nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                  },
                                  child: Container(
                                    height:
                                        SizeConfig.getSize35(context: context),
                                    width:
                                        SizeConfig.getSize35(context: context),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Color.fromARGB(156, 0, 0, 0)
                                                      .withOpacity(0.5),
                                              blurRadius: 20,
                                              offset: Offset(
                                                0,
                                                0,
                                              ))
                                        ],
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png"))),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : HomePageWidget(
                          controller: _controller,
                          onSwipe: (int index, String title, bool isFinish) {
                            setState(() {
                              // /log("Is finish is $isFinish");
                              controller.isFinish.value = isFinish;
                              widget.onSwipe(index, title, isFinish);
                            });
                          },
                          postModel: controller.postModel.value,
                        ),
          controller.isLoadingStats.value == true
              ? Center(
                  child: CircularProgressIndicator(
                  color: DynamicColor.gredient1,
                ))
              : StatisticsPage(
                  pagecont: _controller,
                  statisticsModel: controller.staticModel.value,
                )
        ],
      );
    }));
  }
}
