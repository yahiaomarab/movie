import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/features/tv/home/domain/entity/airing/tv-airing-entity.dart';
import 'package:movie/features/tv/home/presentation/view-model/airing/cubit.dart';
import 'package:movie/features/tv/home/presentation/view-model/airing/states.dart';

class TVAiring extends StatefulWidget {
  const TVAiring({super.key});

  @override
  State<TVAiring> createState() => _TVAiringState();
}

class _TVAiringState extends State<TVAiring> {
   List<TvAiringEntity> tvAirs = [];
  int index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer to update the index every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (tvAirs.isNotEmpty) {
        setState(() {
          index = (index + 1) % tvAirs.length; // Update index and loop it
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
    return BlocConsumer<TvAiringCubit,TvAiringStates>(
        listener: (context, state) {
        if (state is FetchTvAiringDataSuccessState) {
          tvAirs = List.from(state.data);
        } else if (state is FetchTvAiringDataFailureState) {
          print('Error fetching Airing movies: ${state.failure}');
        }
      },
      builder: (context, state) {
         if (state is FetchTvAiringDataSuccessState && tvAirs.isNotEmpty){
           return Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.r),
                bottomRight: Radius.circular(50.r),
              ),
              gradient: LinearGradient(
              colors: [Colors.black, Colors.black.withOpacity(0.80)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.14, 0.4],
            ),
            ),
            
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${tvAirs[index].image}',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Column(
                  children: [
                    Text(
                      'New episodes • Season 4',
                      style: AppTextStyle.textK12ForSeason,
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        'STRANGER THINGS',
                        style: GoogleFonts.cinzelDecorative(
                          fontSize: 30.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 25.w),
                        _buildInfoTag('16+'),
                        SizedBox(width: 15.w),
                        _buildInfoTag('Science Fiction'),
                        SizedBox(width: 15.w),
                        _buildInfoTag('Netflix'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
         }else if (state is FetchTvAiringDataFailureState) {
          return const Text('error !!');
        } else {
          return const CircularProgressIndicator();
        }
       
      },
      
    );
  }

  Widget _buildInfoTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      height: 20.h,
      decoration: BoxDecoration(
        color: AppColors.buttonKColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
