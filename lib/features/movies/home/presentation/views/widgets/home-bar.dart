import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/routes.dart';
import 'package:movie/features/profile/view-model/cubit.dart';
import 'package:movie/features/profile/view-model/states.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserData(),
      child: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (BuildContext context, ProfileStates state) {
          // Check if the state is loaded and userModel is available
          if (state is GetUserDataLoadingState) {
            return Center(child: CircularProgressIndicator()); // Show loader while loading
          } else if (state is GetUserDataSuccessState) {
            return Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Hey, ${state.userModel.userName}\n', // Access userName from the state
                        style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                      TextSpan(
                        text: '${state.userModel.email} >',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.buttonKColor,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.searchViewPath);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.secondaryKColor,
                    radius: 25.r,
                    backgroundImage: const AssetImage('assets/images/search.png'),
                  ),
                ),
                SizedBox(width: 13.w),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profilePath);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.secondaryKColor,
                    radius: 25.r,
                    backgroundImage: const AssetImage('assets/images/person.png'),
                  ),
                ),
              ],
            );
          } else if (state is GetUserDataErrorState) {
            return Center(child: Text('Error: ${state.error}')); // Display error message
          } else {
            return Center(child: Text('Unknown state')); // Handle unknown state
          }
        },
      ),
    );
  }
}
