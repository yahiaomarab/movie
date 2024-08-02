import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/core/utils/widgets/text-field.dart';

// ignore: must_be_immutable
class SuccessfullyRegisterPage extends StatelessWidget {
  SuccessfullyRegisterPage({super.key});
  var emailController = TextEditingController();
   var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.97,
        padding: EdgeInsets.only(right: 26.w, left: 26.w, top: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete Your Sign Up ',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp,
                  color: HexColor('FFFFFF')),
            ),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
                controller: emailController,
                label: 'E-mail',
                hintText: '',
                type: TextInputType.emailAddress),
            SizedBox(
              height: 15.h,
            ),
            CustomTextField(
                controller: passwordController,
                label: 'Password',
                hintText: '',
                type: TextInputType.emailAddress),
            SizedBox(
              height: 28.h,
            ),
                   CustomTextField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                hintText: '',
                type: TextInputType.emailAddress),
            SizedBox(
              height: 28.h,
            ),
            const Spacer(),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: CustomButton(
                  buttonCircular: 16.r,
                  buttonColor: HexColor('EB2F3D'),
                  buttonHeight: 53.h,
                  buttonWeidth: double.infinity,
                  label: 'Continue',
                  labelColor: Colors.white,
                  ontap: () {}),
            ),
          ],
        ),
      ),
    ])));
  }
}
