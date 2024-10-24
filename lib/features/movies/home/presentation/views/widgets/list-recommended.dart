import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/widgets/movie-item.dart';
import 'package:movie/features/movies/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/movies/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/movies/home/presentation/view-model/recommended/recommended-states.dart';

class RecommendedMoviesList extends StatefulWidget {
  const RecommendedMoviesList({super.key});

  @override
  State<RecommendedMoviesList> createState() => _RecommendedMoviesListState();
}

class _RecommendedMoviesListState extends State<RecommendedMoviesList> {
  final ScrollController _scrollController = ScrollController();
  int nextPage = 2;
  bool isLoading = false;
  List<RecommendedEntity>recommendeds=[];

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
      BlocProvider.of<RecommendedCubit>(context)
          .fetchRecommendedMovies(page: nextPage++)
          .then((_) {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecommendedCubit, RecommendedStates>(
      listener: (context, state) {
        if (state is FetchRecommendedMoviesFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failure)));
        }else if (state is FetchRecommendedMoviesSuccessState){
          recommendeds.addAll(state.recommendeds);
        }
      },
      builder: (context, state) {
  if (state is FetchRecommendedMoviesSuccessState ||
            state is FetchRecommendedMoviesPagenationLoadingState) {
          return SizedBox(
            height: 200.h,
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemBuilder: (context, index) =>
                      MovieItem(model: recommendeds[index]),
                  separatorBuilder: (context, index) => SizedBox(width: 5.w),
                  itemCount: recommendeds.length,
                ),
                if (state is FetchRecommendedMoviesPagenationLoadingState)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        } else if (state is FetchRecommendedMoviesFailureState) {
          return const Center(
              child: Text('Error fetching recommended movies!'));
        } else {
          return const Center(child: Text('No recommended movies found!'));
        }
      },
    );
  }
}
