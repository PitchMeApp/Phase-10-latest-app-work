import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';

import '../../../utils/colors/colors.dart';
import '../../Deals Page/deals_page.dart';

class PaymentFaildPage extends StatefulWidget {
  const PaymentFaildPage({super.key});

  @override
  State<PaymentFaildPage> createState() => _PaymentFaildPageState();
}

class _PaymentFaildPageState extends State<PaymentFaildPage> {
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
          Image.asset(
            'assets/imagess/payment-faild.png',
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          SizedBox(height: SizeConfig.getSize10(context: context)),
          Text('Your payment has failed',
              style: TextStyle(
                fontSize: 30.0,
                color: DynamicColor.gredient1,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: SizeConfig.getSize30(context: context)),
          Text('You can retry the payment below to', style: textColor15),
          Text('continue this', style: textColor15),
          SizedBox(height: SizeConfig.getSize50(context: context)),
          CustomListBox(
              title: 'Try Again',
              singleSelectColor: isSelect,
              isSingleSelect: 1,
              onPressad: () {
                setState(() {
                  isSelect = 1;
                });
                //controller.generatepaymentApi();
                Navigator.of(context).pop();
              })
        ],
      ),
    ));
  }
}
