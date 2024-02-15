import 'package:flutter/material.dart';

class PageNavigateScreen {
  Future<dynamic> push(BuildContext context, Widget page) {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(seconds: 1),
    //     pageBuilder: (BuildContext context, Animation<double> animation,
    //         Animation<double> secondaryAnimation) {
    //       return page;
    //     },
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       const begin = Offset(0.0, 1.0);
    //       const end = Offset.zero;
    //       final tween = Tween(begin: begin, end: end);
    //       final offsetAnimation = animation.drive(tween);

    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: child,
    //       );
    //     },
    //   ),
    // );
    //Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  void back(BuildContext context) {
    return Navigator.of(context).pop();
  }

  void pushReplesh(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  pushRepleshWithFadeAni(BuildContext context, Widget page) async {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> pushRemovUntil(BuildContext context, Widget page) async {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

  Future<dynamic> normalpushReplesh(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }
}
