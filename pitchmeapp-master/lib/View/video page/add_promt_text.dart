import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors/colors.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/containers/containers.dart';
import '../Deals Page/deals_page.dart';

class AddPromtText extends StatefulWidget {
  const AddPromtText({super.key});

  @override
  State<AddPromtText> createState() => _AddPromtTextState();
}

class _AddPromtTextState extends State<AddPromtText> {
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int isSelect = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPromt();
  }

  void getPromt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      if (prefs.getString("prompt") != null) {
        textEditingController.text = prefs.getString("prompt").toString();
      }
    });
  }

  void setPromt(promt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.setString("prompt", promt.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceHeight(MediaQuery.of(context).size.height * 0.06),
              Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.getSize35(context: context)),
                child: Align(
                  alignment: Alignment.topRight,
                  child: AppBarIconContainer(
                    height: SizeConfig.getSize38(context: context),
                    width: SizeConfig.getSize38(context: context),
                    color: DynamicColor.redColor,
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(
                      Icons.close,
                      color: DynamicColor.white,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              // spaceHeight(MediaQuery.of(context).size.height * 0.1),
              searchBar(),
              spaceHeight(MediaQuery.of(context).size.height * 0.1),
              button(),
              spaceHeight(10),
              isLoading
                  ? CircularProgressIndicator(color: DynamicColor.gredient1)
                  : Container()
            ],
          ),
        )),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Card(
        // height: 6.h,
        color: DynamicColor.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            cursorHeight: 22,
            controller: textEditingController,
            style: gredient116bold,
            maxLines: 18,
            cursorColor: DynamicColor.gredient1,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              fillColor: DynamicColor.lightGrey.withOpacity(0.3),
              filled: true,
              hintText:
                  'Type or paste the teleprompt text that will appear on screen for you to read while you record your Sales Pitch',
              // hintMaxLines: checkLine,
              hintStyle: TextStyle(
                  fontSize: 15, color: DynamicColor.textColor.withOpacity(0.5)),
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
            // validator: (value) {
            //   if (value!.length < 10) {
            //     return 'Enter minimum 100 characters';
            //   }
            //   return null;
            // },
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }

  Widget button() {
    return CustomListBox(
        title: 'SAVE',
        singleSelectColor: isSelect,
        isSingleSelect: 1,
        width: MediaQuery.of(context).size.width * 0.4,
        onPressad: () {
          if (textEditingController.text.isNotEmpty) {
            //  if (formKey.currentState!.validate() == true) {
            setState(() {
              isLoading = true;
              isSelect = 1;
            });
            setPromt(textEditingController.text);
            Timer(Duration(seconds: 1), () {
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).pop();
            });
            //}
          } else {
            myToast(context, msg: 'Plese enter some text');
          }
        });
  }
}
