import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/widgets/snack.dart';
import 'package:movie/features/on-boarding/domain/entities/onboarding-entity.dart';
import 'package:movie/features/on-boarding/presentation/view-model/cubit.dart';
import 'package:movie/features/on-boarding/presentation/view-model/states.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<OnBoardingEntity> posters = [];
  final CarouselSliderController _carouselController1 = CarouselSliderController();
  final CarouselSliderController _carouselController2 = CarouselSliderController();
  var nextPage = 2;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state) {
        if (state is FetchOnBoardingSuccessState) {
          posters.addAll(state.posters);
        }
        if (state is FetchOnBoardingPaginationFailureState) {
          ErrorSnackBar(errorMessage: state.errorMsg);
        }
      },
      builder: (context, state) {
        bool isLoading = state is FetchOnBoardingPaginationLoadingState;

        if (state is FetchOnBoardingSuccessState || isLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // First Carousel
              CarouselSlider(
                items: posters.map((page) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: 130.w,
                        height: 180.h,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${page.posterImage}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Text('Failed to load image'));
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                            if (isLoading)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withOpacity(0.3),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
                carouselController: _carouselController1,
                options: CarouselOptions(
                  height: 160.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(milliseconds: 500),
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  autoPlayCurve: Curves.linear,
                  enlargeCenterPage: false,
                  viewportFraction: 0.38,
                  aspectRatio: 16 / 9,
                  pauseAutoPlayOnTouch: false,
                  onPageChanged: (index, reason) {
                    var thresholdIndex = (0.7 * posters.length).floor();
                    if (index >= thresholdIndex) {
                      BlocProvider.of<OnBoardingCubit>(context).fetchOnBoarding(
                        pageNumber: nextPage
                      );
                      nextPage++;
                    }
                  },
                ),
              ),
              SizedBox(height: 10.h),
              // Second Carousel
              CarouselSlider(
                items: posters.map((page) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: 130.w,
                        height: 180.h,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                    
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${page.posterImage}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Text('Failed to load image'));
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                            if (isLoading)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withOpacity(0.3),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
                carouselController: _carouselController2,
                options: CarouselOptions(
                  height: 160.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(milliseconds: 700),
                  autoPlayAnimationDuration: const Duration(milliseconds: 700),
                  autoPlayCurve: Curves.linear,
                  enlargeCenterPage: false,
                  viewportFraction: 0.38,
                  aspectRatio: 16 / 9,
                  pauseAutoPlayOnTouch: false,
                  onPageChanged: (index, reason) {
                    var thresholdIndex = (0.7 * posters.length).floor();
                    if (index >= thresholdIndex) {
                      BlocProvider.of<OnBoardingCubit>(context).fetchOnBoarding(
                        pageNumber: nextPage
                      );
                      nextPage++;
                    }
                  },
                ),
              ),
            ],
          );
        } else if (state is FetchOnBoardingFailureState) {
          return Text(state.errorMsg);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
