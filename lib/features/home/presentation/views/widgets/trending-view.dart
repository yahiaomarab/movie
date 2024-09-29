import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/routes.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/features/home/domain/entity/trending/trending-entity.dart';
import 'package:movie/features/home/presentation/view-model/trending/trending-cubit.dart';
import 'package:movie/features/home/presentation/view-model/trending/trending-states.dart';

class TrendingView extends StatefulWidget {
  const TrendingView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TrendingViewState createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  List<TrendingEntity> trends = [];
  int index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer to update the index every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (trends.isNotEmpty) {
        setState(() {
          index = (index + 1) % trends.length; // Update index and loop it
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrendingCubit, TrendingStates>(
      listener: (context, state) {
        if (state is FetchTrendingMoviesSuccessState) {
          trends = List.from(state.trends);
        } else if (state is FetchTrendingMoviesFailureState) {
          print('Error fetching trending movies: ${state.failure}');
        }
      },
      builder: (context, state) {
        if (state is FetchTrendingMoviesSuccessState && trends.isNotEmpty) {
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
                    fit: BoxFit.fill,
                    'https://image.tmdb.org/t/p/w500${trends[index].image}', // Use current index
                  ),
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
                          Container(
                            width: 160.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trending',
                                  style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Expanded(
                                  child: Text(
                                    trends[index].name, // Use current index
                                    style: AppTextStyle.textK16ForMovieName,
                                    maxLines:
                                        2, // Ensure the text is only one line
                                    overflow: TextOverflow
                                        .ellipsis, // Display '...' if the text overflows
                                  ),
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
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                ontap: () {
                                  if (trends[index].Id != null) {
                                    Navigator.pushNamed(
                                        context, Routes.homeDetailsViewPath,
                                        arguments: trends[index].Id);
                                  } else {
                                    // Handle the case where Id is null, e.g., show a message
                                    print('Movie Id is null');
                                  }
                                },
                              ),
                              Text(
                                '2D.3D.4DX',
                                style: AppTextStyle.textK12ForQuality,
                              ),
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
