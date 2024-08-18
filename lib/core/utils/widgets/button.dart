import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double buttonHeight;
  final double buttonWeidth;
  final Color buttonColor;
  final double buttonCircular;
  final Color labelColor;
  final Function()? ontap;
  final double? labelSize;
  final FontWeight? fontWeight;
  final Gradient? gradient;

  const CustomButton(
      {super.key,
      required this.buttonCircular,
      required this.buttonColor,
      required this.buttonHeight,
      required this.buttonWeidth,
      required this.label,
      required this.labelColor,
      required this.ontap,
      this.labelSize,
      this.fontWeight,
      this.gradient
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child:  Container(
        height: buttonHeight,
        width: buttonWeidth,
        decoration: BoxDecoration(
          gradient: gradient,
          color: buttonColor,
          borderRadius: BorderRadius.circular(buttonCircular),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: labelSize?? 15.sp, fontWeight: fontWeight??FontWeight.bold,color:labelColor),
          ),
        ),
      ),
    );
  }
}
