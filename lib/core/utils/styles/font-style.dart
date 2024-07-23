import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';

class AppTextStyle {
  static TextStyle textK14WhiteHint = GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.hintKWhiteColor);

  static TextStyle textK16WhiteHint = GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.hintKWhiteColor);

  static TextStyle textK22FontMedium = GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 22.sp,
      color: AppColors.whiteKColor);

  static TextStyle textK14FontRegular = GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,
      color: AppColors.whiteKColor);
}
