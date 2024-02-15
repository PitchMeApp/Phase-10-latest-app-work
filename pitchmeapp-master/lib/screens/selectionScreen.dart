import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/selectionController.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  SelectionController controller = Get.put(SelectionController());
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BannerWidget(onPressad: () {}),
      body: BackGroundWidget(
          imagebottom: true,
          fit: BoxFit.cover,
          backgroundImage: Assets.backgroundImage,
          child: Container(
            width: width(context),
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Text(
                              EMAIL.toUpperCase(),
                              style: white21wBold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              CONFIRMATION,
                              style: white21wBold,
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
                      )
                    ],
                  ),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.02)),
                  Center(
                      child: Text(
                    'What type better describes you?',
                    style: black15w5,
                  )),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.02)),
                  NewButtonContainer(
                      heroTage: 1,
                      singleSelectColor: isSelect,
                      isSingleSelect: 1,
                      onTap: () async {
                        setState(() {
                          isSelect = 1;
                        });
                        controller.submit(context, 1);
                      },
                      title: BUSINESSIDEA,
                      subTitle: 'Amazing Idea needs help to become a Reality'),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.01)),
                  NewButtonContainer(
                      heroTage: 2,
                      singleSelectColor: isSelect,
                      isSingleSelect: 2,
                      onTap: () async {
                        setState(() {
                          isSelect = 2;
                        });
                        controller.submit(context, 2);
                      },
                      title: BUSINESSOWNER,
                      subTitle:
                          'Active Business for Sale or seeking Expansion'),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.01)),
                  NewButtonContainer(
                      heroTage: 3,
                      singleSelectColor: isSelect,
                      isSingleSelect: 3,
                      onTap: () async {
                        setState(() {
                          isSelect = 3;
                        });

                        controller.submit(context, 3);
                      },
                      title: INVESTOR,
                      subTitle: 'Looking for Good Opportunity to Invest'),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.01)),
                  NewButtonContainer(
                      heroTage: 4,
                      singleSelectColor: isSelect,
                      isSingleSelect: 4,
                      onTap: () async {
                        setState(() {
                          isSelect = 4;
                        });

                        controller.submit(context, 4);
                      },
                      title: "Service Provider",
                      subTitle: 'Offer your Skills, Connections or Services'),
                ],
              ),
            ),
          )),
    );
  }
}
