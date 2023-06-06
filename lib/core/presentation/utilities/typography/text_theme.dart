import 'package:flutter/material.dart';

extension AppTextTheme on TextTheme {
  TextStyle get poppinsExtraBold => const TextStyle(
        fontSize: 13,
        color: Color(0xFF000000),
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.normal,
      );
  TextStyle get poppinsBold => const TextStyle(
        fontSize: 19,
        color: Color(0xFF333333),
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      );
  TextStyle get poppinsSemiBold => const TextStyle(
        fontSize: 18,
        color: Color(0xFF333333),
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      );

  TextStyle get poppinsMedium => const TextStyle(
        fontSize: 16,
        color: Color(0xFF333333),
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      );
  TextStyle get poppinsRegular => const TextStyle(
        fontSize: 14,
        color: Color(0xFF333333),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );
  TextStyle get poppinsLight => const TextStyle(
        fontSize: 18,
        color: Color(0xFF333333),
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      );
  TextStyle get poppinsSemi => const TextStyle(
        fontSize: 18,
        color: Color(0xFF333333),
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.normal,
      );
}
