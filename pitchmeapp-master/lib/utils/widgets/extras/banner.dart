import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerWidget extends StatelessWidget {
  String? imgUrl;
  VoidCallback onPressad;
  BannerWidget({
    super.key,
    this.imgUrl,
    required this.onPressad,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Platform.isAndroid
          ? MediaQuery.of(context).size.height * 0.08
          : MediaQuery.of(context).size.height * 0.10,
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse(
                  //'https://www.budgiepr.com'
                  'https://www.equidam.com/?r=bZM7KxFuars8IR0feJdNiLR02YlfhgjbqlBoNhLz'),
              mode: LaunchMode.externalApplication);
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: DynamicColor.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 5),
                child: Image.asset(
                  'assets/imagess/banner.png',
                  //fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
