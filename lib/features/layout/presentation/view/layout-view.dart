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
            body: cubit.screens[cubit.currentIndex],
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
                      icon: Icons.movie_creation_outlined,
                      iconColor: cubit.currentIndex == 0 ? Colors.white : Colors.transparent,
                      leading: cubit.currentIndex == 0 ? null : _buildInactiveIcon(Icons.movie_creation_outlined),
                      text: 'Movies',
                    ),
                    GButton(
                      icon: Icons.apps,
                      iconColor: cubit.currentIndex == 1 ? Colors.white : Colors.transparent,
                      leading: cubit.currentIndex == 1 ? null : _buildInactiveIcon(Icons.apps),
                      text: 'Categories',
                    ),
                    GButton(
                      icon: Icons.favorite,
                      iconColor: cubit.currentIndex == 2 ? Colors.white : Colors.transparent,
                      leading: cubit.currentIndex == 2 ? null : _buildInactiveIcon(Icons.favorite),
                      text: 'Favorites',
                    ),
                    GButton(
                      icon: Icons.settings,
                      iconColor: cubit.currentIndex == 3 ? Colors.white : Colors.transparent,
                      leading: cubit.currentIndex == 3 ? null : _buildInactiveIcon(Icons.settings),
                      text: 'Settings',
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

  Widget _buildInactiveIcon(IconData icon) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: HexColor('#2d2d2d'),
      child: Icon(icon, color: Colors.white),
    );
  }
}
