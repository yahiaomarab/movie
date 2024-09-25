import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/mixin/validations/email.dart';
import 'package:movie/core/mixin/validations/password.dart';
import 'package:movie/core/utils/routing/routes.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/core/utils/widgets/text-field.dart';
import 'package:movie/features/auth/presentation/view-model/register/cubit.dart';
import 'package:movie/features/auth/presentation/view-model/register/states.dart';

// ignore: must_be_immutable
class SuccessfullyRegisterPage extends StatelessWidget
    with EmailValidation, PasswordValidation {
  SuccessfullyRegisterPage({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if(state is RegisterUserSuccessState){
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully registered'),
              backgroundColor: Colors.green,
            ),
          );
          context.pushNamed(Routes.loginPath);
        }else if (state is RegisterUserErrorState){
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
          
        }
      },
      builder: (context, state) {
        if(state is RegisterUserLoadingState) {
          return const Scaffold(
          body: Center(child: CircularProgressIndicator(),),
         );
        }
        return Scaffold(
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.97,
              padding: EdgeInsets.only(right: 26.w, left: 26.w, top: 60.h),
              child: Form(
                key: formKey,
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
                      controller: nameController,
                      label: 'Name',
                      hintText: '',
                      type: TextInputType.name,
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      controller: emailController,
                      label: 'E-mail',
                      validation: (String? value) =>
                          validateEmail(context, value),
                      hintText: '',
                      type: TextInputType.emailAddress,
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      hintText: '',
                      isPassword: RegisterCubit.get(context).isPassword,
                      type: TextInputType.emailAddress,
                      prefix: Icons.lock,
                      validation: (String? value) =>
                          validatePassword(context, value),
                      suffix: RegisterCubit.get(context).suffix,
                      onSuffixPressed:
                          RegisterCubit.get(context).changePasswordVisibility,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      controller: confirmPasswordController,
                      label: 'Confirm Password',
                      hintText: '',
                      validation: (String? value) => validateConfirmPassword(
                          context, value!, passwordController.text.toString()),
                      type: TextInputType.emailAddress,
                      prefix: Icons.lock,
                    ),
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
                          ontap: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).registerUser(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ])));
      },
    );
  }
}
