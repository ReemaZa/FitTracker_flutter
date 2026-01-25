// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppColors {
  static const Color brandPrimary = Color(0xFF595CFF); // hsla(230, 96%, 78%, 1)
  static const Color brandSecondary = Color(0xFFC6F8FF); // hsla(215, 98%, 80%, 1)

  // Secondary
  static const Color secondaryPurple = Color(0xFF696EFF);
  static const Color secondaryPink = Color(0xFFF8ACFF);

  // Neutral
  static const Color black = Color(0xFF1D1617);
  static const Color white = Color(0xFFFFFFFF);

  static const Color grayDark = Color(0xFF7B6F72);
  static const Color grayMedium = Color(0xFFADA4A5);
  static const Color grayLight = Color(0xFFDDDADA);

  static const Color borderColor = Color(0xFFF7F8F8);

  // Gradient helper




  static const LinearGradient splashScreenGradient = LinearGradient(
    colors: [
      brandPrimary, // rgba(105, 110, 255, 1)
      brandSecondary, // rgba(248, 172, 255, 1)
    ],
    stops: [0.0, 1.0],
    begin: Alignment(-1.7, 0.9),   // converted from 339°
    end: Alignment(1.7, -0.9),
  );

  /*static const LinearGradient splashScreenGradient2 = LinearGradient(
    colors: [
      secondaryPurple, // rgba(89, 92, 255, 1)
      secondaryPink, // rgba(198, 248, 255, 1)
    ],
    stops: [0.0, 1.0],
    begin: Alignment(-1.7, 0.9),   // 339°
    end: Alignment(1.7, -0.9),
  );*/


  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      Color(0xFFC58BF2), // rgba(197, 139, 242, 1)
      Color(0xFFEEA4CE), // rgba(238, 164, 206, 1)
    ],
    stops: [0.0, 1.0],

    // 213° → diagonal down-left → up-right
    begin: Alignment(1.5, -1.3),
    end: Alignment(-1.5, 1.3),
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF93A6FD), // rgba(147, 166, 253, 1)
      Color(0xFF9AC1FE), // rgba(154, 193, 254, 1)
    ],
    stops: [0.0, 1.0],

    // 213° → diagonal down-left → up-right
    begin: Alignment(1.5, -1.3),
    end: Alignment(-1.5, 1.3),
  );

}
