import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/movies/home-details/data/models/movie-model.dart';

abstract class HomeDetailsRepo{
  Future<Either<Failure,MovieModel>>fetchMovieDetails({required int id});
}