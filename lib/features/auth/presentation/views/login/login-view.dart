import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/mixin/validations/email.dart';
import 'package:movie/core/mixin/validations/password.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/core/utils/widgets/text-field.dart';
import 'package:movie/features/auth/presentation/view-model/login/cubit.dart';
import 'package:movie/features/auth/presentation/view-model/login/states.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget
    with EmailValidation, PasswordValidation {
  LoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Logined'),
              backgroundColor: Colors.green,
            ),
          );
          GoRouter.of(context).pushReplacement(AppRouter.homePath);
        } else if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: AlignmentDirectional.topEnd,
                      padding: EdgeInsets.only(top: 50.h, right: 15.w),
                      child: Text('Skip', style: AppTextStyle.textK16WhiteHint)),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 26.w, vertical: 75.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign In', style: AppTextStyle.textK22FontMedium),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomTextField(
                            controller: emailController,
                            label: 'E-mail',
                            validation: (String? value) =>
                                validateEmail(context, value),
                            hintText: '',
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          isPassword: LoginCubit.get(context).isPassword,
                          onSuffixPressed: LoginCubit.get(context).changePasswordVisibility,
                          validation: (String? value) =>
                              validatePassword(context, value),
                          hintText: '',
                          type: TextInputType.visiblePassword,
                          suffix: Icons.visibility_off,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Text('Forgot password?',
                              style: AppTextStyle.textK14WhiteHint),
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        CustomButton(
                            buttonCircular: 16.r,
                            buttonColor: AppColors.buttonKColor,
                            buttonHeight: 53.h,
                            buttonWeidth: double.infinity,
                            label: 'Sign in',
                            labelColor: AppColors.whiteKColor,
                            ontap: () {
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).loginUser(email: emailController.text, password: passwordController.text);
                              }
                            }),
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
                                  color: AppColors.hintKWhiteColor,
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
                        'Don`t you have an account?',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: HexColor('979797'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.registerPath);
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.whiteKColor,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> iconsbuttons = [
    IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.facebook,
          color: AppColors.whiteKColor,
        )),
    IconButton(
        onPressed: () {},
        icon: Icon(
          FontAwesomeIcons.google,
          color: AppColors.whiteKColor,
        )),
    IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.apple,
          color: AppColors.whiteKColor,
        )),
  ];
}
