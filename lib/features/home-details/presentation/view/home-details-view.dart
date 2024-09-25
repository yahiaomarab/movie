import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/features/home-details/presentation/view-model/cubit.dart';
import 'package:movie/features/home-details/presentation/view-model/states.dart';
import 'package:movie/features/home-details/presentation/widgets/devidor-line.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDetailsCubit, HomeDetailsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is FetchHomeDetailsSuccessState){
          return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(55.r),
                      bottomRight: Radius.circular(55.r),
                    )),
                child: Image.asset(
                  'assets/images/movie.png',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.only(
                    left: 12.h, right: 12.w, top: 20.h, bottom: 2.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 23.r,
                          backgroundColor: AppColors.secondaryKColor,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 23.r,
                          backgroundColor: AppColors.secondaryKColor,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48.r),
                        color: AppColors.secondaryKColor,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'EVIL DEAD RISE',
                                    style: AppTextStyle.textK16ForMovieName
                                        .copyWith(fontSize: 14.sp),
                                  ),
                                  Text('HORHOR 2D.3D.4DX',
                                      style: AppTextStyle.textK12ForQuality),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26.r),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(
                                          0xFF1F1F1F), // Start: #1F1F1F at 0%
                                      Color(
                                          0xFF41403E), // Middle: #41403E at 100%
                                      Color(
                                          0xFF333333), // End: #333333 at 100%
                                    ],
                                    stops: [
                                      0.0, // Starting at 0%
                                      0.5, // 50% (mid-point for #41403E)
                                      1.0, // 100% (for #333333)
                                    ],
                                    begin: Alignment
                                        .topLeft, // Gradient starts from the top
                                    end: Alignment
                                        .bottomRight, // Gradient ends at the bottom
                                  ),
                                ),
                                padding: EdgeInsets.only(right: 15.w),
                                child: CustomButton(
                                  buttonCircular: 26.r,
                                  buttonColor: Colors.transparent,
                                  buttonHeight: 30.h,
                                  buttonWeidth: 110.w,
                                  label: 'Watch Trailer >>',
                                  fontWeight: FontWeight.w400,
                                  labelSize: 12.sp,
                                  labelColor: Colors.white,
                                  ontap: () {},
                                ),
                              ),
                            ],
                          ),
                          devidorLine(),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Censor Rating',
                                    style:
                                        AppTextStyle.textK14ForDetailsMovie,
                                  ),
                                  Text(
                                    'A',
                                    style:
                                        AppTextStyle.textK14ForDetailsMovie,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 35.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration',
                                    style:
                                        AppTextStyle.textK14ForDetailsMovie,
                                  ),
                                  Text(
                                    '1hr:38min',
                                    style:
                                        AppTextStyle.textK14ForDetailsMovie,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    'Release date',
                                    style:
                                        AppTextStyle.textK14ForDetailsMovie,
                                  ),
                                  Text(
                                    '21 April 2023',
                                    style:
                                        AppTextStyle.textK14ForDetailsMovie,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available in language`s',
                                style: AppTextStyle.textK14ForDetailsMovie,
                              ),
                              Text(
                                'English',
                                style: AppTextStyle.textK14ForDetailsMovie,
                              ),
                            ],
                          ),
                          devidorLine(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Story Plot',
                                style: AppTextStyle.textK16ForMovieName,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                'Evil Dead is a 2013 American supernatural horror film directed by Fede Álvarez who co-wrote the screenplay with Rodo Sayagues. Dubbed a "re-imagining" of ',
                                style: AppTextStyle.textK14ForDetailsMovie,
                              ),
                            ],
                          ),
                          devidorLine(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cast',
                                style: AppTextStyle.textK16ForMovieName,
                              ),
                              Container(
                                height: 50.h,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        Container(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.r)),
                                            child: Image.asset(
                                              'assets/images/movie.png',
                                              width: 53.w,
                                              fit: BoxFit.cover,
                                            )),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                    itemCount: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 12.w,
                right: 12.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryKColor, // Amber background
                    borderRadius:
                        BorderRadius.circular(15.r), // Rounded corners
                  ),
                  height: 62.h, // Height of the container
                  width: double
                      .infinity, // Ensure the container takes the full width
                  padding: EdgeInsets.symmetric(
                      horizontal: 16
                          .w), // Optional: Adds padding inside the container
                  child: Center(
                    // Center the button inside the container
                    child: CustomButton(
                      buttonCircular: 8.r,
                      buttonColor: AppColors.buttonKColor, // Button color
                      buttonHeight:
                          42.h, // Button height (smaller than container)
                      buttonWeidth: MediaQuery.of(context).size.width *
                          0.9, // Button width (smaller than container width)
                      label: 'Book Tickets',
                      labelColor: Colors.white,
                      ontap: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        }else if (state is FetchHomeDetailsFailureState){
          return Text(state.failure.toString());
        }else{
          return const Center(child: CircularProgressIndicator());
        }
        
      },
    );
  }
}
