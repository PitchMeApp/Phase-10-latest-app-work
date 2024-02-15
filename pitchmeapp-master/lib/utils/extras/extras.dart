import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
//import 'package:fluttertoast/fluttertoast.dart';

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Widget loadSvg(
    {required String image, double? height, double? width, Color? color}) {
  return SvgPicture.asset(
    image,
    height: height,
    width: width,
    color: color,
  );
}

Widget loadSvgNetwork(
    {required String image, double? height, double? width, Color? color}) {
  return SvgPicture.network(
    image,
    height: height,
    width: width,
    color: color,
  );
}

none() {}

bool hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}

Widget spaceHeight(height) {
  return SizedBox(
    height: double.parse(height.toString()),
  );
}

spaceWidth(width) {
  return SizedBox(
    width: double.parse(width.toString()),
  );
}

Future getTo({required BuildContext context, required Widget to}) async {
  return await Navigator.push(
      context, new MaterialPageRoute(builder: (BuildContext context) => to));
}

Future getPushReplacement(
    {required BuildContext context, required Widget to}) async {
  return await Navigator.pushReplacement(
      context, new MaterialPageRoute(builder: (BuildContext context) => to));
}

getBack({required BuildContext context, dynamic result}) {
  Navigator.of(context).pop(result);
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

String removeDecimal(double? value) {
  return value!.toStringAsFixed(0);
}

//
// myToast({required String msg}) {
//   Fluttertoast.showToast(msg: msg);
// }
closeKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

String pleaseEnter(String text) => 'Please enter $text';

late FToast fToast;

myToast(BuildContext context, {required String msg}) {
  fToast = FToast();
  fToast.init(context);

  fToast.showToast(
    gravity: ToastGravity.TOP,
    fadeDuration: Duration(milliseconds: 50),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: DynamicColor.black,
      ),
      child: Text(
        msg,
        style: TextStyle(color: DynamicColor.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

//dev
OutlineInputBorder outlineInputBorderBlue = OutlineInputBorder(
  borderSide: const BorderSide(color: DynamicColor.gredient1),
  borderRadius: BorderRadius.circular(10),
);
