import 'package:flutter/cupertino.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';

class SizeConfig {
  static leftRightPadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: width(context) / 6);

  static paddingHorizontalBy(
          {required BuildContext context, required int by}) =>
      EdgeInsets.symmetric(horizontal: width(context) / by);

  static double getSizeHeightBy(
          {required BuildContext context, required double by}) =>
      height(context) * by;

  static double getSizeWidthBy(
          {required BuildContext context, required double by}) =>
      width(context) * by;

  static double getSize10({required BuildContext context}) =>
      height(context) * 0.01;

  static double getSize5({required BuildContext context}) =>
      (height(context) * 0.01) / 2;

  static double getSize15({required BuildContext context}) =>
      height(context) * 0.015;

  static double getSize20({required BuildContext context}) =>
      height(context) * 0.02;

  static double getSize30({required BuildContext context}) =>
      height(context) * 0.035;

  static double getSize35({required BuildContext context}) =>
      height(context) * 0.040;
  static double getSize38({required BuildContext context}) =>
      height(context) * 0.050;
  static double getSize25({required BuildContext context}) =>
      height(context) * 0.028;

  static double getSize40({required BuildContext context}) =>
      height(context) * 0.055;

  static getSize50({required BuildContext context}) => height(context) * 0.06;

  static getSize55({required BuildContext context}) => height(context) * 0.073;

  static getSize58({required BuildContext context}) => height(context) * 0.08;

  static getSize60({required BuildContext context}) => height(context) * 0.09;

  static getSize80({required BuildContext context}) => height(context) * 0.14;

  static getSize100({required BuildContext context}) => height(context) * 0.18;

  static getFontSize16({required BuildContext context}) =>
      height(context) * 0.018;

  static getFontSize14({required BuildContext context}) =>
      height(context) * 0.016;

  static getFontSize18({required BuildContext context}) =>
      height(context) * 0.019;

  static getFontSize20({required BuildContext context}) =>
      height(context) * 0.026;

  static getFontSize19({required BuildContext context}) =>
      height(context) * 0.022;

  static getFontSize25({required BuildContext context}) =>
      height(context) * 0.030;

  static getFontSize28({required BuildContext context}) =>
      height(context) * 0.032;
}
