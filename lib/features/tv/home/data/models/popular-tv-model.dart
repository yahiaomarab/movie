// ignore_for_file: file_names

import 'package:movie/features/tv/home/domain/entity/tv-popular-entity.dart';

class PopularTVModel extends TvPopularEntity {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? ID;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  PopularTVModel(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.ID,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.firstAirDate,
      this.title,
      this.voteAverage,
      this.voteCount})
      : super(
            id: ID ?? 0,
            description: overview ?? '',
            name: title ?? '',
            language: originalLanguage ?? 'En',
            rating: voteAverage ?? 0.0,
            ratingCount: voteCount ?? 0,
            image: posterPath ?? '');

  factory PopularTVModel.fromJson(Map<String, dynamic> json) {
    return PopularTVModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'].cast<int>(),
      ID: json['id'],
      originCountry: json['origin_country'].cast<String>(),
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      firstAirDate: json['first_air_date'],
      title: json['name'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}
