import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/features/home/domain/entity/trending/trending-entity.dart';
import 'package:movie/features/home/presentation/view-model/trending/trending-cubit.dart';
import 'package:movie/features/home/presentation/view-model/trending/trending-states.dart';

// ignore: must_be_immutable
class TrendingView extends StatelessWidget {
  TrendingView({super.key});
  List<TrendingEntity> trends = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrendingCubit, TrendingStates>(
      listener: (context, state) {
        if (state is FetchTrendingMoviesSuccessState) {
          trends = List.from(state.trends); // Reinitialize the list
        } else if (state is FetchTrendingMoviesFailureState) {
          print('Error fetching trending movies: ${state.failure}');
        }
      },
      builder: (context, state) {
        if (state is FetchTrendingMoviesSuccessState) {
          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                height: 265.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(48.r),
                  child: Image.network(
                      height: 265.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      'https://image.tmdb.org/t/p/w500${state.trends[0].image}'),
                ),
              ),
              Positioned(
                bottom: 0.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 15.w),
                      child: CustomButton(
                        buttonCircular: 26.r,
                        buttonColor: AppColors.secondaryKColor,
                        buttonHeight: 30.h,
                        buttonWeidth: 110.w,
                        label: 'Watch Trailer >>',
                        fontWeight: FontWeight.w400,
                        labelSize: 12.sp,
                        labelColor: Colors.white,
                        ontap: () {},
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 110.h,
                      width: 315.w,
                      padding: EdgeInsets.only(
                          top: 20.h, bottom: 10.h, left: 25.w, right: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(58.r),
                        color: AppColors.secondaryKColor,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trending',
                                style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Text(
                                state.trends[0].name,
                                style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Text(
                                'A .English',
                                style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              Text(
                                'HORHOR',
                                style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                  buttonCircular: 30.r,
                                  buttonColor: Colors.white,
                                  buttonHeight: 40.h,
                                  buttonWeidth: 75.w,
                                  label: 'Book',
                                  labelSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  labelColor: Colors.white,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF323232), // Color at 0%
                                      Color(0xFF767676), // Color at 49%
                                      Color(0xFF363535), // Color at 100%
                                    ],
                                    stops: [
                                      0.0,
                                      0.49,
                                      1.0
                                    ], // Percentages for each color stop
                                    begin: Alignment
                                        .topCenter, // Start of the gradient
                                    end: Alignment
                                        .bottomCenter, // End of the gradient
                                  ),
                                  ontap: () {}),
                              Text(
                                '2D.3D.4DX',
                                style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is FetchTrendingMoviesFailureState) {
          return const Text('error !!');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
