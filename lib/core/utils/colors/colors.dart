import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  static Color buttonKColor = HexColor('EB2F3D');
  static Color scaffoldKColor = HexColor('#121011');
  static Color whiteKColor = HexColor('ffffff');
  static Color hintKWhiteColor = HexColor('D4D4D4');
  static Color secondaryKColor = HexColor('1E1E1E');
   static const LinearGradient customGradient = LinearGradient(
    colors: [
      Color(0xFFD02626), // Start color at 0%
      Color(0xFF200B0B), // Second color at 100%
      Color(0xFFFFFFFF), // White at 100%
    ],
    stops: [0.0, 0.9, 1.0], // Define stops for each color
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}