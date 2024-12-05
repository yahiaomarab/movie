import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/widgets/movie-item.dart';
import 'package:movie/features/tv/home/domain/entity/top-rated/tv-top-rated-entity.dart';
import 'package:movie/features/tv/home/presentation/view-model/top-rated/cubit.dart';
import 'package:movie/features/tv/home/presentation/view-model/top-rated/states.dart';

class TvTopRated extends StatefulWidget {
  const TvTopRated({super.key});

  @override
  State<TvTopRated> createState() => _TvTopRatedState();
}

class _TvTopRatedState extends State<TvTopRated> {
   final ScrollController _scrollController = ScrollController();
  int nextPage = 2;
  bool isLoading = false;
  List<TvTopRatedEntity> tvTopRateds = [];

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
      BlocProvider.of<TvTopRatedCubit>(context)
          .fetchTvTopRatedData(page: nextPage++)
          .then((_) {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TvTopRatedCubit, TvTopRatedStates>(
      listener: (context, state) {
        if (state is FetchTvTopRatedDataFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failure)));
        } else if (state is FetchTvTopRatedDataSuccessState) {
          setState(() {
            tvTopRateds.addAll(state.data);
          });
        }
      },
      builder: (context, state) {
        if (state is FetchTvTopRatedDataSuccessState ||
            state is FetchTvTopRatedDataPaginationLoadingState) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            height: 200.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index < tvTopRateds.length) {
                  return MovieItem(model: tvTopRateds[index]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemCount: isLoading ? tvTopRateds.length + 1 : tvTopRateds.length,
            ),
          );
        } else if (state is FetchTvTopRatedDataFailureState) {
          return const Center(child: Text('Error fetching recommended tvs!'));
        } else {
          return const Center(child: Text('No recommended tvs found!'));
        }
      },
    );
  }
}