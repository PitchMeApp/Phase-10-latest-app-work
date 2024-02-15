import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:sizer/sizer.dart';

import '../../../View/offer_page/controller.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';

class NoMorePitchPage extends StatefulWidget {
  const NoMorePitchPage({super.key});

  @override
  State<NoMorePitchPage> createState() => _NoMorePitchPageState();
}

class _NoMorePitchPageState extends State<NoMorePitchPage> {
  OfferPageController controller = Get.put(OfferPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
          bannerRequired: false,
          backgroundImage: Assets.backgroundImage,
          fit: BoxFit.cover,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: SizeConfig.getSize30(context: context) +
                        MediaQuery.of(context).size.height * 0.021),
                Container(
                  height: SizeConfig.getSize38(context: context),
                  alignment: Alignment.center,
                  child: Text(
                    'Watch Sales Pitch'.toUpperCase(),
                    style: gredient117bold,
                  ),
                ),
                SizedBox(height: SizeConfig.getSize20(context: context)),
                Text(
                  'No Pitches Available',
                  style: textColor22,
                ),
                SizedBox(height: SizeConfig.getSize20(context: context)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Check:', style: textColor17Normal),
                    Text('1: Change the interest filters',
                        style: textColor17Normal),
                    Text('2: Verify your Biography Information',
                        style: textColor17Normal),
                  ],
                ),
                SizedBox(height: SizeConfig.getSize25(context: context)),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.getSize15(context: context),
                      right: SizeConfig.getSize15(context: context)),
                  child: AutoSizeText(
                    'Businesses when posting a pitch have a filter like this Buttons below, where they can select Who can watch their pitch',
                    style: textColor17w500,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                  ),
                ),
                SizedBox(height: SizeConfig.getSize30(context: context)),
                customBox(
                  controller.data[0]['value'],
                ),
                SizedBox(height: 10),
                customBox(
                  controller.data[1]['value'],
                ),
                SizedBox(height: 10),
                customBox(
                  controller.data[2]['value'],
                ),
                SizedBox(height: 10),
                customBox(
                  controller.data[3]['value'],
                ),
                SizedBox(height: 10),
                customBox(
                  controller.data[4]['value'],
                ),
                SizedBox(height: SizeConfig.getSize30(context: context)),
                Text('If you don´t have the', style: textColor17w500),
                Text('necessary verification on', style: textColor17w500),
                Text('your Biography, you will', style: textColor17w500),
                Text('see only a very limited', style: textColor17w500),
                Text('amount of Pitches', style: textColor17w500),
              ],
            ),
          )),
    );
  }

  Widget customBox(String string) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getSize40(context: context),
          right: SizeConfig.getSize40(context: context)),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          // onTap: onPressad,
          child: Container(
            height: 5.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: DynamicColor.gradientColorChange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              string,
              style: white16bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
