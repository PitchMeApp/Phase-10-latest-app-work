import 'package:flutter/material.dart';

// dev
class DynamicColor {
  static const Color black = Color(0xFF000000);
  static const Color lightBlack = Color.fromRGBO(61, 61, 61, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color trncperentWhite = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color trncperentWhiteLight = Color.fromRGBO(239, 239, 239, 0.3);
  static const Color lightwhite = Color.fromRGBO(221, 221, 221, 1);
  static const Color blue = Color(0xff377EB4);
  //0xff599CD0
  static const Color darkBlue = Color(0xFF0a2070);
  static const Color sky = Color.fromARGB(255, 52, 218, 165);
  static const Color lightGrey = Color(0xFFE1E1E1);
  static const Color contnclr = Color.fromRGBO(140, 140, 140, 1);
  static const Color hintclr = Color.fromRGBO(134, 134, 134, 1);
  static const Color butnClr2 = Color(0xFFE1E1E1);
  static const Color butnClr = Color(0xFF778ba5);
  static const Color lightColor = Color(0xFFE5E9FB);
  static const Color yellowColor = Color(0xFFFFBD3E);
  static const Color redColor = Color(0xFFFF0000);
  static const Color gredient1 = Color(0xFF12A4D7);
  static const Color gredient2 = Color(0xFF21C8D1);
  static const Color green = Color(0xff44D223);
  static const Color textColor = Color(0xff214252);
  static const Color selectedtextBGColor = Color.fromARGB(255, 101, 100, 100);

  // gradientColor
  static const gradientColorOnBegin = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [DynamicColor.gredient1, DynamicColor.gredient2],
  );
  static const gradientColorChange = LinearGradient(
    colors: [DynamicColor.gredient1, DynamicColor.gredient2],
  );
}

class Constants {
  static const int recordTimeLimit = 59;
}
