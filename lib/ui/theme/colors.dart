import 'package:flutter/material.dart';

enum AppColors {
  primaryColor,
  whiteColor,
}

extension AppColorsExtension on AppColors {
  Color get color {
    switch (this) {
      case AppColors.primaryColor:
        return const Color(0xffD42026);
      case AppColors.whiteColor:
        return Colors.white;
    }
  }
}
