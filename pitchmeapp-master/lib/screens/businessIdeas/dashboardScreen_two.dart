import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/no_more_pitch.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/controller/businessIdeas/dashBoardController.dart';
import 'package:pitch_me_app/controller/businessIdeas/detail_controller.dart';
import 'package:pitch_me_app/controller/businessIdeas/postPageController.dart';
import 'package:pitch_me_app/screens/businessIdeas/StatisticsPage_Two.dart';
import 'package:pitch_me_app/screens/businessIdeas/postPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen_Two extends StatefulWidget {
  final Function(int index) currentPage;
  final Function(int index, String title, bool isFinish) onSwipe;
  String userType;
  DashBoardScreen_Two(
      {Key? key,
      required this.currentPage,
      required this.onSwipe,
      required this.userType})
      : super(key: key);

  @override
  State<DashBoardScreen_Two> createState() => _DashBoardScreen_TwoState();
}

class _DashBoardScreen_TwoState extends State<DashBoardScreen_Two> {
  final _controller = PageController();
  DashboardController controller = Get.put(DashboardController());
  PostPageController postPageController = Get.put(PostPageController());
  DetailController detailController = Get.put(DetailController());

  bool checkData = false;

  String businesstype = '';
  String newUser = '';

  int newIndex = 0;
  @override
  void initState() {
    super.initState();
    getUserType();

    controller.getStatic();

    _controller.addListener(() {
      widget.currentPage(_controller.page!.toInt());
      setState(() {});
    });
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      businesstype = prefs.getString('log_type').toString();
      newUser = prefs.getString('new_user').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.getPost2(widget.onSwipe);
    return Scaffold(body: Obx(() {
      return PageView(
        controller: _controller,
        physics: ((businesstype == '1' || businesstype == '2') ||
                    newUser == 'New User') ||
                controller.isFinish2.value ||
                controller.salespitch == null ||
                controller.salespitch.value.result == null ||
                controller.salespitch.value.result!.docs.isEmpty
            ? NeverScrollableScrollPhysics()
            : ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          FutureBuilder<SalesPitchListModel?>(
              future: controller.businessIdeasApi.getPost2(),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }

                if (snapshot.hasError) {
                  return NoMorePitchPage();
                } else if (snapshot.data == null) {
                  return Center(
                      // child: roboto(size: 20, text: 'No post available')
                      );
                } else if (snapshot.data!.result!.docs.isEmpty) {
                  return NoMorePitchPage();
                } else if (controller.isFinish2.value) {
                  return NoMorePitchPage();
                } else {
                  // print('check = ' +
                  //     postPageController.swipableStackController.currentIndex
                  //         .toString());
                  return detailController.salespitch.value != null &&
                          detailController.salespitch.value.result != null &&
                          detailController
                              .salespitch.value.result!.docs.isNotEmpty &&
                          detailController
                                  .salespitch.value.result!.docs.length >
                              postPageController
                                  .swipableStackController.currentIndex
                      ? PostPageWidget(
                          controller: _controller,
                          onSwipe: (int index, String title, bool isFinish) {
                            setState(() {
                              newIndex = index;
                            });
                            print("indexs $newIndex");
                            print(
                                'indexs 2 = ${postPageController.swipableStackController.currentIndex}');
                            setState(() {
                              controller.isFinish2.value = isFinish;
                              widget.onSwipe(index, title, isFinish);
                            });
                          },
                          postModel: detailController.salespitch.value,
                        )
                      : Container();
                }
              }),
          controller.isLoadingStats.value == true
              ? Center(child: CircularProgressIndicator())
              : detailController.salespitch != null &&
                      detailController.salespitch.value.result != null
                  ? detailController.salespitch.value.result!.docs.isNotEmpty &&
                          detailController
                                  .salespitch.value.result!.docs.length >
                              postPageController
                                  .swipableStackController.currentIndex
                      ? StatisticsPage_Two(
                          pagecont: _controller,
                          salesDoc:
                              detailController.salespitch.value.result!.docs[
                                  postPageController
                                      .swipableStackController.currentIndex],
                          newIndex: newIndex,
                          postModel: detailController.salespitch.value,
                        )
                      : Container()
                  : Container()
        ],
      );
    }));
  }
}
