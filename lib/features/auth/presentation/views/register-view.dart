import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/core/utils/widgets/text-field.dart';


// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
   var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: AlignmentDirectional.topEnd,
                padding: EdgeInsets.only(top: 50.h, right: 15.w),
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: HexColor('D4D4D4')),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 60.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
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
                    type: TextInputType.visiblePassword,
                    suffix: Icons.visibility_off,
                  ),
                    SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: '',
                    type: TextInputType.visiblePassword,
                    suffix: Icons.visibility_off,
                  ),
               
                 
                  SizedBox(
                    height: 28.h,
                  ),
                  CustomButton(
                      buttonCircular: 16.r,
                      buttonColor: HexColor('EB2F3D'),
                      buttonHeight: 53.h,
                      buttonWeidth: double.infinity,
                      label: 'Sign Up',
                      labelColor: Colors.white,
                      ontap: () {}),
                  SizedBox(
                    height: 29.h,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 140.w,
                        height: 1,
                        color: HexColor('404040'),
                      ),
                      Text(
                        'or',
                        style: GoogleFonts.poppins(
                            color: HexColor('D4D4D4'),
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w),
                        width: 140.w,
                        height: 1,
                        color: HexColor('404040'),
                      ),
                      SizedBox(
                        height: 29.h,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    height: 45.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                        height: 45.h,
                        width: 94.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: HexColor('#1e1e1e')),
                        child: iconsbuttons[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 13.w,
                      ),
                      itemCount: iconsbuttons.length,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: HexColor('979797'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.loginPath);
                  },
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: HexColor('ffffff'),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> iconsbuttons = [
    IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.facebook,
          color: Colors.white,
        )),
    IconButton(
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.google,
          color: Colors.white,
        )),
    IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.apple,
          color: Colors.white,
        )),
  ];
}
