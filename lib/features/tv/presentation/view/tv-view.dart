import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/core/widgets/movie-item.dart';
import 'package:movie/features/tv/data/repos/tv-popular-repo.dart';
import 'package:movie/features/tv/domain/entity/tv-entity.dart';
import 'package:movie/features/tv/domain/use-case/tv-popular-use-case.dart';
import 'package:movie/features/tv/presentation/view-model/cubit.dart';
import 'package:movie/features/tv/presentation/view-model/states.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key});

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  final ScrollController _scrollController = ScrollController();
  int nextPage = 2;
  bool isLoading = false;
  List<TvEntity> tvPopulars = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScrollExtent = _scrollController.position.pixels;
    final threshold = 0.7 * maxScrollExtent;

    if (currentScrollExtent >= threshold && !isLoading) {
      isLoading = true;
      BlocProvider.of<TvPopularCubit>(context)
          .fetchTvPopularData(page: nextPage++)
          .then((_) {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => TvPopularCubit(
          TvPopularUseCase(
            locator.get<TvPopularRepoImpl>(),
          ),
        )..fetchTvPopularData(),
        child: BlocConsumer<TvPopularCubit, TvPopularStates>(
          listener: (context, state) {
            if (state is FetchTvPopularDataFailureState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.failure)));
            } else if (state is FetchTvPopularDataSuccessState) {
              tvPopulars.addAll(state.data);
            }
          },
          builder: (context, state) {
            if (state is FetchTvPopularDataPaginationLoadingState ||
                state is FetchTvPopularDataSuccessState) {
              return SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Image.asset(
                      'assets/images/tvbackground.png',
                      height: MediaQuery.of(context).size.height * .5,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          Column(
                            children: [
                              Text(
                                'New episodes • Season 4',
                                style: AppTextStyle.textK12ForSeason,
                              ),
                              SizedBox(height: 15.h),
                              Container(
                                  width: 250.w,
                                  child: Text(
                                    'STRANGER THINGS',
                                    style: GoogleFonts.cinzelDecorative(
                                        fontSize: 30.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.buttonKColor
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      '16+',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.buttonKColor
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      'Science Fiction',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.buttonKColor
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      'Netflix',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              CustomButton(
                                gradient: AppColors.customGradient,
                                buttonCircular: 10.r,
                                buttonColor: Colors.white,
                                buttonHeight: 58.h,
                                buttonWeidth: double.infinity,
                                label: 'Continue Watch',
                                labelColor: Colors.white,
                                ontap: () {},
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Know for ',
                                        style: AppTextStyle.textK14FontRegular,
                                      )),
                                  const Spacer(),
                                  Text(
                                    'See all',
                                    style: GoogleFonts.inter(
                                        color: AppColors.buttonKColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                 
                                ],
                              ),
                              SizedBox(height: 15.h,),
                               SizedBox(
                                 height: 150
                                     .h, // Adjust height based on your needs
                                 child: ListView.separated(
                                   scrollDirection: Axis.horizontal,
                                   itemBuilder: (context, index) =>
                                       MovieItem(model: tvPopulars[index]),
                                   separatorBuilder: (context, index) =>
                                       SizedBox(width: 10.w),
                                   itemCount: tvPopulars.length,
                                 ),
                               ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is FetchTvPopularDataFailureState) {
              return const Center(child: Text('Error fetching TV Populars!'));
            } else {
              return const Center(child: Text('No Popular TVs found!'));
            }
          },
        ),
      ),
    );
  }
}
