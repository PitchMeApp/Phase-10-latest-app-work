import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Manu/benefits/benefits_confirmation.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors/colors.dart';
import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/styles.dart';
import '../../../utils/widgets/Navigation/custom_navigation.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../Custom header view/appbar_with_white_bg.dart';
import '../../Deals Page/deals_page.dart';
import '../manu.dart';
import 'controller/benefits_controller.dart';

class BenefitsPage extends StatefulWidget {
  int pageIndex;
  int? onBack = 0;
  BenefitsPage({super.key, required this.pageIndex, this.onBack});

  @override
  State<BenefitsPage> createState() => _BenefitsPageState();
}

class _BenefitsPageState extends State<BenefitsPage> {
  BenefitsController controller = Get.put(BenefitsController());
  int isSelect = 0;
  dynamic proUser;

  @override
  void initState() {
    super.initState();
    prouser();
    GetApiService().checkProOrbasicUserApi();
  }

  void prouser() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      // preferencesData.remove('pro_user');
      proUser = jsonDecode(preferencesData.getString('pro_user').toString());
      //   log('check = ' + proUser.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BannerWidget(onPressad: () {}),
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        bannerRequired: false,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(
                    height: SizeConfig.getSize100(context: context) +
                        SizeConfig.getSize55(context: context),
                  ),
                  //  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: DynamicColor.black))),
                    child: Text(
                      TextStrings.textKey['the_benefits']!,
                      style: textColor22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [features(), amateur(), pro()],
                  ),
                  const SizedBox(height: 20),
                  // newWidget(),
                  // const SizedBox(height: 10),
                  proUser == null
                      ? button()
                      : Text(
                          'Already Purchased',
                          style: textColor22,
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Obx(() {
                        return controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: DynamicColor.gredient1),
                              )
                            : Container();
                      }),
                    ),
                  ),
                ])),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: DynamicColor.gradientColorChange),
                    height: MediaQuery.of(context).size.height * 0.235,
                  ),
                ),
                whiteBorderContainer(
                    child: Image.asset(Assets.handshakeImage),
                    color: Colors.transparent,
                    height:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                    width:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                    cornerRadius: 25),
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: 'PRO',
              backCheckBio: 'back',
              backOnTap: () {
                if (proUser != null) {
                  PageNavigateScreen().back(context);
                } else {
                  PageNavigateScreen().normalpushReplesh(
                      context,
                      BenefitsConfirmationPage(
                        pageIndex: widget.pageIndex,
                        onBack: widget.onBack,
                      ));
                }
              },
              onPressad: () {
                PageNavigateScreen().push(
                    context,
                    ManuPage(
                      title: 'PRO',
                      pageIndex: widget.pageIndex,
                      isManu: 'Manu',
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget features() {
    return Card(
      elevation: 10,
      color: Color(0xff3486B7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: DynamicColor.white))),
                child: Text(
                  'FEATURES',
                  style: white17wBold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText('FEATURES', 'Post Sales Pitch'),
                customText('FEATURES', 'Watch Sales Pitch'),
                customText('FEATURES', 'Home Page Posts'),
                //customText('FEATURES', 'Sales Pitch Live'),
                customText('FEATURES', 'Liked Videos'),
                customText('FEATURES', 'Interested Pitches'),
                customText('FEATURES', 'Share Pitch'),
                customText('FEATURES', 'Upload Pitch'),
                customText('FEATURES', 'Teleprompter'),
                customText('FEATURES', 'Filters'),
                customText('FEATURES', 'Chat'),
                // customText('FEATURES', 'Contracts'),
                // customText('FEATURES', 'Investment'),
                // customText('FEATURES', 'Shares'),
                // customText('FEATURES', 'CRM'),
                // customText('FEATURES', 'Advertise'),
                // customText('FEATURES', 'Pitch Me Shares'),
                // customText('FEATURES', 'Escrow Account'),
                // customText('FEATURES', 'Trust Fund Service'),
                // customText('FEATURES', 'Business Consultant'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget amateur() {
    return Card(
      elevation: 10,
      color: Color(0xff2DA0C1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: DynamicColor.white))),
                child: Text(
                  'AMATEUR',
                  style: white17wBold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText('AMATEUR', '1'),
                customText('AMATEUR', '10'),
                customText('AMATEUR', '30'),
                //customText('AMATEUR', '7 Days'),
                customText('AMATEUR', '15'),
                customText('AMATEUR', '2'),
                customText('AMATEUR', 'No'),
                customText('AMATEUR', 'No'),
                customText('AMATEUR', 'No'),
                customText('AMATEUR', 'No'),
                customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
                // customText('AMATEUR', 'No'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget pro() {
    return Card(
      elevation: 10,
      color: Color(0xff21C8D1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: DynamicColor.white))),
                child: Text(
                  'PRO',
                  style: white17wBold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText('PRO', '5'),
                customText('PRO', 'Unlimited'),
                customText('PRO', 'Unlimited'),
                //customText('PRO', 'Unlimited'),
                customText('PRO', 'Unlimited'),
                customText('PRO', 'Unlimited'),
                customText('PRO', 'Yes'),
                customText('PRO', 'Yes'),
                customText('PRO', 'Yes'),
                customText('PRO', 'Yes'),
                customText('PRO', 'Yes'),
                // customText('PRO', 'Soon'),
                // customText('PRO', 'Soon'),
                // customText('PRO', 'Soon'),
                // customText('PRO', 'Soon'),
                // customText('PRO', 'Soon'),
                // customText('PRO', 'Soon'),
                // customText('PRO', 'Soon'),
                // customText('PRO', 'Soon'),
                // customText('PRO', 'Soon'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customText(type, title) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: type == 'FEATURES'
          ? Row(
              children: [
                Text(
                  ' • ',
                  style: TextStyle(color: DynamicColor.white, fontSize: 18),
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: DynamicColor.white, fontWeight: FontWeight.w500),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '',
                  style: TextStyle(color: DynamicColor.white, fontSize: 18),
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: DynamicColor.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
    );
  }

  Widget newWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Soon = ',
          style: textColor15,
        ),
        Text(
          'Underdevelopment but included',
          style: textColor15,
        )
      ],
    );
  }

  Widget button() {
    return CustomListBox(
        title: TextStrings.textKey['become_pro']!,
        singleSelectColor: isSelect,
        isSingleSelect: 1,
        onPressad: () {
          setState(() {
            isSelect = 1;
          });
          // startSdk(context);
          controller.generatepaymentApi(context);
        });
  }
}
