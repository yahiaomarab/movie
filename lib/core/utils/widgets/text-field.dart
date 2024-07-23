import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/styles/font-style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.type,
    this.suffix,
    this.prefix,
    this.validation,
    this.onChanged,
    this.onSubmit,
    this.isClickable = true,
    this.isPassword = false,
    this.onTap,
    this.onSuffixPressed,
    this.suffixIconColor,
    this.radiusBorder,
    this.borderColor,
  });

  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final String hintText;
  final IconData? prefix;
  final IconData? suffix;
  final String? Function(String?)? validation;
  final Function(String)? onChanged;
  final Function(String?)? onSubmit;
  final bool isPassword;
  final bool isClickable;
  final VoidCallback? onTap;
  final VoidCallback? onSuffixPressed;
  final Color? suffixIconColor;
  final Color? borderColor;
  final double? radiusBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusBorder ?? 15.0),
        border: Border.all(
          color: borderColor ?? HexColor('575757'),
        ),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white), // Set the input text color to white
        decoration: InputDecoration(
          floatingLabelStyle:AppTextStyle.textK14FontRegular,
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
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)), // Set the hint text color to white with some opacity
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder ?? 0),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: isPassword,
        validator: validation,
        keyboardType: type,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onTap: onTap,
      ),
    );
  }
}
