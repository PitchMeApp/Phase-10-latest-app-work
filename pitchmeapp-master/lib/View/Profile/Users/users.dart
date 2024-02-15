import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Users/Model/model.dart';

import '../../../utils/colors/colors.dart';
import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/styles.dart';
import '../../../utils/widgets/Navigation/custom_navigation.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';
import '../../Custom header view/appbar_with_white_bg.dart';
import '../../Custom header view/new_bottom_bar.dart';
import '../../Deals Page/deals_page.dart';
import '../../Manu/manu.dart';
import 'controller/user_controller.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  UsersController controller = Get.put(UsersController());
  @override
  void initState() {
    controller.getAllUsersApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Stack(
          children: [
            Column(
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
                        cornerRadius: 25)
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(child: Obx(() {
                    return controller.isLoading.value
                        ? SizedBox(
                            height: SizeConfig.getSizeHeightBy(
                                context: context, by: 0.5),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: DynamicColor.gredient1,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              comanWidget('Business Idea',
                                  controller.businessIdeaUsersList),
                              comanWidget('Business Owner',
                                  controller.businessOwnerUsersList),
                              comanWidget(
                                  'Investor', controller.investorUsersList),
                              comanWidget('Service Provider',
                                  controller.facilitatorUsersList),
                              SizedBox(
                                height: SizeConfig.getSizeHeightBy(
                                    context: context, by: 0.1),
                              )
                            ],
                          );
                  })),
                ),
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: TextStrings.textKey['user']!,
              backCheckBio: 'back',
              backOnTap: () {
                Navigator.of(context).pop();
              },
              onPressad: () {
                PageNavigateScreen().push(
                    context,
                    ManuPage(
                      title: TextStrings.textKey['user']!,
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

  Widget comanWidget(String title, List<Doc> list) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            title,
            style: textColor20,
          ),
        ),
        //SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: list.length,
            itemBuilder: (context, index) {
              Doc data = list[index];

              return CustomListBox(
                  title: data.username,
                  titleColor: data.isSelected,
                  onPressad: () {
                    setState(() {
                      controller.onselectValue(index, list, context);
                    });
                  });
            })
      ],
    );
  }
}
