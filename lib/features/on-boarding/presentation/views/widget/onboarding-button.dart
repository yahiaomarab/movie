import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/widgets/button.dart';

class OnBoardingButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double buttonHeight;
  final double buttonWeidth;

  const OnBoardingButton({
    required this.label,
    required this.onTap,
    required this.buttonHeight,
    required this.buttonWeidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
      child: CustomButton(
        buttonCircular: 16.r,
        buttonColor: AppColors.buttonKColor,
        buttonHeight: buttonHeight,
        buttonWeidth: double.infinity,
        label: label,
        labelColor: AppColors.whiteKColor,
        ontap: onTap,
      ),
    );
  }
}
