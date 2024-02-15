import 'package:flutter/material.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';

import '../../../utils/colors/colors.dart';
import '../../../utils/widgets/Navigation/custom_navigation.dart';
import '../../Deals Page/deals_page.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackGroundWidget(
      backgroundImage: Assets.backgroundImage,
      fit: BoxFit.fitHeight,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.getSize60(context: context)),
          Image.asset('assets/imagess/payment.png'),
          SizedBox(height: SizeConfig.getSize10(context: context)),
          Text('Thank You!',
              style: TextStyle(
                fontSize: 30.0,
                color: DynamicColor.gredient1,
                fontWeight: FontWeight.bold,
              )),
          Text('Payment done Successfully', style: textColor12),
          SizedBox(height: SizeConfig.getSize30(context: context)),
          Text('You will be redirected to home page', style: textColor12),
          Text('click here', style: textColor12),
          SizedBox(height: SizeConfig.getSize50(context: context)),
          CustomListBox(
              title: 'Home',
              singleSelectColor: isSelect,
              isSingleSelect: 1,
              onPressad: () {
                setState(() {
                  isSelect = 1;
                });
                //controller.generatepaymentApi();
                PageNavigateScreen().pushRemovUntil(context, Floatbar(0));
              })
        ],
      ),
    ));
  }
}
