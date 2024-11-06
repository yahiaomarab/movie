import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/widgets/movie-item.dart';
import 'package:movie/features/tv/home/domain/entity/tv-popular-entity.dart';
import 'package:movie/features/tv/home/presentation/view-model/cubit.dart';
import 'package:movie/features/tv/home/presentation/view-model/states.dart';

class TVPopular extends StatefulWidget {
  const TVPopular({super.key});

  @override
  State<TVPopular> createState() => _TVPopularState();
}

class _TVPopularState extends State<TVPopular> {
  final ScrollController _scrollController = ScrollController();
  int nextPage = 2;
  bool isLoading = false;
  List<TvPopularEntity> tvPopulars = [];

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
    return BlocConsumer<TvPopularCubit, TvPopularStates>(
      listener: (context, state) {
        if (state is FetchTvPopularDataFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failure)));
        } else if (state is FetchTvPopularDataSuccessState) {
          setState(() {
            tvPopulars.addAll(state.data);
          });
        }
      },
      builder: (context, state) {
        if (state is FetchTvPopularDataSuccessState ||
            state is FetchTvPopularDataPaginationLoadingState) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            height: 200.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index < tvPopulars.length) {
                  return MovieItem(model: tvPopulars[index]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemCount: isLoading ? tvPopulars.length + 1 : tvPopulars.length,
            ),
          );
        } else if (state is FetchTvPopularDataFailureState) {
          return const Center(child: Text('Error fetching recommended tvs!'));
        } else {
          return const Center(child: Text('No recommended tvs found!'));
        }
      },
    );
  }
}
