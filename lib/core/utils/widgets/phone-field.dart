import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CustomPhoneTextField extends StatelessWidget {
  const CustomPhoneTextField({
    super.key,
    required this.controller,
    required this.validation,
    required this.label,
    required this.hintText,
    required this.type,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.onSubmit,
    this.isClickable = true,
    this.isPassword = false,
    this.onTap,
    this.onSuffixPressed,
    this.suffixIconColor,
    this.radiusBorder,
    this.borderColor,
    this.onInputChanged, // Add this callback to capture input changes
  });

  final TextEditingController controller;
  final TextInputType type;
  final Function(String?)? onSubmit;
  final VoidCallback? onTap;
  final Function(PhoneNumber)? onChanged;
  final String? Function(String?)? validation;
  final String label;
  final IconData? prefix;
  final IconData? suffix;
  final bool isPassword;
  final bool isClickable;
  final VoidCallback? onSuffixPressed;
  final String hintText;
  final Color? suffixIconColor;
  final Color? borderColor;
  final double? radiusBorder;
  final Function(String)? onInputChanged; // New callback for input changes

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusBorder ?? 15.0.r),
        border: Border.all(
          color: borderColor ?? HexColor('575757'),
        ),
      ),
      child: InternationalPhoneNumberInput(
        selectorTextStyle: TextStyle(color: HexColor('6D7278')),
        onInputChanged: (PhoneNumber number) {
          // Call the provided onChanged callback
          if (onChanged != null) {
            onChanged!(number);
          }

          // Call the new onInputChanged callback
          if (onInputChanged != null) {
            // Pass the full international phone number to the callback
            onInputChanged!(number.phoneNumber ?? '');
          }
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          useBottomSheetSafeArea: true,
        ),
        textFieldController: controller,
        keyboardType: type,
        inputDecoration: InputDecoration(
          prefixIcon: prefix != null ? Icon(prefix) : null,
          suffixIcon: suffix != null
              ? GestureDetector(
                  onTap: onSuffixPressed,
                  child: Icon(suffix),
                )
              : null,
          suffixIconColor: suffixIconColor,
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder ?? 0),
            borderSide: BorderSide.none,
          ),
          hintStyle: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: HexColor('6D7278'),
          ),
          labelStyle: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: HexColor('6D7278'),
          ),
        ),
      ),
    );
  }
}
