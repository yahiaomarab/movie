import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/routes.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/core/utils/widgets/text-field.dart';
import 'package:movie/features/profile/view-model/cubit.dart';
import 'package:movie/features/profile/view-model/states.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserData(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is UpdateUserProfileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
          } else if (state is UpdateUserProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          var profileCubit = ProfileCubit.get(context);
          var userModel = profileCubit.userModel;
          var profileImage = profileCubit.profileImage;

          if (state is GetUserDataLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetUserDataErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (userModel == null) {
            return const Center(child: Text('No user data available'));
          }

          // Use null-aware operators to avoid null errors
          nameController.text = userModel.userName;
          emailController.text = userModel.email;
          phoneController.text = userModel.phone;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Profile', style: AppTextStyle.textK22FontMedium),
              // leading: IconButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, Routes.settingsPath);
              //   },
              //   icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30.sp),
              // ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20.h),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 70.r,
                            backgroundColor: AppColors.buttonKColor,
                            backgroundImage: profileImage == null
                                ? NetworkImage(userModel.image!)
                                : FileImage(File(profileImage.path)) as ImageProvider,
                          ),
                          IconButton(
                            onPressed: () async {
                              await profileCubit.getProfileImage();
                              if (profileCubit.profileImage != null) {
                                profileCubit.uploadProfileImage();
                              }
                            },
                            icon: const Icon(Icons.camera_alt_rounded),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    _buildTextField('Name', nameController, TextInputType.text),
                    SizedBox(height: 10.h),
                    _buildTextField('Email', emailController, TextInputType.emailAddress),
                    SizedBox(height: 10.h),
                    _buildTextField('Phone', phoneController, TextInputType.phone),
                    SizedBox(height: 20.h),
                    Center(
                      child: CustomButton(
                        buttonCircular: 10.r,
                        buttonColor: AppColors.buttonKColor,
                        buttonHeight: 40.h,
                        buttonWeidth: double.infinity,
                        label: 'Save Changes',
                        labelColor: Colors.white,
                        ontap: () {
                          profileCubit.updateUserProfile(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, TextInputType type) {
    return CustomTextField(
      label: labelText,
      controller: controller,
       type:type, hintText: '',
    );
  }
}
