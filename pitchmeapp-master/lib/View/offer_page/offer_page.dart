import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/offer_page/controller.dart';
import 'package:pitch_me_app/View/offer_page/selection_person.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final OfferPageController _offerPageController =
      Get.put(OfferPageController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  int checkLine = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: SizeConfig.getSize100(context: context) +
                        SizeConfig.getSize55(context: context),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: DynamicColor.black))),
                    child: Text(
                      TextStrings.textKey['offer']!,
                      style: textColor22,
                    ),
                  ),
                  _searchBar()
                ],
              ),
              CustomHeaderView(
                progressPersent: 0.6,
                checkNext:
                    _offerPageController.offrerTextController.text.isNotEmpty
                        ? 'next'
                        : null,
                nextOnTap: () {
                  try {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (formKey.currentState!.validate() == true) {
                      if (_navigationController.navigationType.value ==
                          'Post') {
                        PageNavigateScreen().push(
                            context,
                            SelectionPersonPage(
                              key: abcKey,
                            ));
                      } else {
                        Navigator.of(context).pop();
                      }
                    }
                  } catch (e) {}
                },
              ),
              NewCustomBottomBar(
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Card(
            // height: 6.h,
            color: DynamicColor.white,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorHeight: 22,
                controller: _offerPageController.offrerTextController,
                style: gredient116bold,
                maxLines: 8,
                maxLength: 200,
                textInputAction: TextInputAction.done,
                cursorColor: DynamicColor.gredient1,
                decoration: InputDecoration(
                  fillColor: DynamicColor.lightGrey.withOpacity(0.3),
                  filled: true,
                  counterText: '',
                  hintText:
                      'Ex: Every 10.000 USD = 5% Equity.Build the Website = 5% Equity. Etc',
                  hintMaxLines: checkLine,
                  hintStyle: TextStyle(
                      fontSize: 15,
                      color: DynamicColor.textColor.withOpacity(0.5)),
                  contentPadding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  // enabledBorder: outlineInputBorderBlue,
                  // focusedBorder: outlineInputBorderBlue,
                  // errorBorder: outlineInputBorderBlue,
                  // focusedErrorBorder: outlineInputBorderBlue
                ),
                onChanged: (value) {
                  setState(() {
                    if (_offerPageController
                        .offrerTextController.text.isNotEmpty) {
                      checkLine = 1;
                    } else {
                      checkLine = 2;
                    }
                  });
                },
                validator: (value) {
                  if (value!.length < 10) {
                    return 'Enter minimum 10 characters';
                  }
                  return null;
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
