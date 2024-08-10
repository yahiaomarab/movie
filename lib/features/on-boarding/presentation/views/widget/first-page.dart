import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/widgets/snack.dart';
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';
import 'package:movie/features/on-boarding/presentation/view-model/cubit.dart';
import 'package:movie/features/on-boarding/presentation/view-model/states.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<TrendingEntity> posters = [];

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
        if (state is FetchOnBoardingSuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           CarouselSlider(
  items: state.posters.map((page) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: 130.w,
          height: 180.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
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
        );
      },
    );
  }).toList(),
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
      // Handle page change if needed
    },
  ),
),

              SizedBox(
                height: 10.h,
              ),
            CarouselSlider(
  items: state.posters.map((page) {
     print("Image URL: ${page.posterImage}");
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: 130.w,
          height: 180.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
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
        );
      },
    );
  }).toList(),
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
      // Handle page change if needed
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
