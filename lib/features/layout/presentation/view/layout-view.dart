import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/features/layout/presentation/view-model/layout-cubit.dart';
import 'package:movie/features/layout/presentation/view-model/layout-states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            body: IndexedStack(
              index: cubit.currentIndex,
              children: cubit.screens,
            ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: HexColor('#1e1e1e'),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 4.h,
                  bottom: 4.h,
                  left: 12.w,
                  right: 12.w,
                ),
                child: GNav(
                  rippleColor: Colors.white,
                  hoverColor: Colors.white,
                  haptic: true,
                  tabBorderRadius: 15,
                  curve: Curves.easeOutExpo,
                  duration: const Duration(milliseconds: 200),
                  gap: 4,
                  color: Colors.black,
                  activeColor: Colors.white,
                  iconSize: 30,
                  tabBackgroundColor: AppColors.buttonKColor,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                  tabs: [
                    GButton(
                      leading: _buildNavImage(
                        'assets/images/movies-icon.png',
                        isActive: cubit.currentIndex == 0,
                      ),
                      text: 'Movies',
                      icon: Icons.circle,
                      iconColor: Colors.transparent,
                    ),
                    GButton(
                      leading: _buildNavImage(
                        'assets/images/series-icon.png',
                        isActive: cubit.currentIndex == 1,
                      ),
                      icon: Icons.circle,
                      text: 'Series',
                      iconColor: Colors.transparent,
                    ),
                    GButton(
                      leading: _buildNavImage(
                        'assets/images/categories.png',
                        isActive: cubit.currentIndex == 2,
                      ),
                      text: 'Categories',
                      icon: Icons.circle,
                      iconColor: Colors.transparent,
                    ),
                    GButton(
                      leading: _buildNavImage(
                        'assets/images/more_icon.png',
                        isActive: cubit.currentIndex == 3,
                      ),
                      text: 'More',
                      icon: Icons.circle,
                      iconColor: Colors.transparent,
                    ),
                  ],
                  onTabChange: (int index) {
                    cubit.changeBottomNavIndex(index);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavImage(String imageIcon, {required bool isActive}) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: isActive ? AppColors.buttonKColor : HexColor('#2d2d2d'),
      child: Image.asset(imageIcon),
    );
  }
}
