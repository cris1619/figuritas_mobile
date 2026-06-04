import 'package:flutter/material.dart';

class Responsive {

  static bool isMobile(BuildContext context) {

    return MediaQuery.of(context)
            .size
            .width <
        600;
  }

  static bool isTablet(BuildContext context) {

    return MediaQuery.of(context)
                .size
                .width >=
            600 &&
        MediaQuery.of(context)
                .size
                .width <
            1100;
  }

  static bool isDesktop(BuildContext context) {

    return MediaQuery.of(context)
            .size
            .width >=
        1100;
  }

  static double padding(
      BuildContext context) {

    if (isMobile(context)) {
      return 16;
    }

    if (isTablet(context)) {
      return 24;
    }

    return 40;
  }

  static int gridCount(
      BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    if (width < 500) {
      return 4;
    }

    if (width < 800) {
      return 6;
    }

    if (width < 1200) {
      return 8;
    }

    return 10;
  }
}