import 'package:movie/features/tv/home/domain/entity/airing/tv-airing-entity.dart';

class AiringTvModel extends TvAiringEntity {
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
  String? FirstAirDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  AiringTvModel(
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
      this.FirstAirDate,
      this.title,
      this.voteAverage,
      this.voteCount})
      : super(
            firstAirDate: FirstAirDate!,
            id: ID!,
            name: title!,
            image: posterPath!,
            rating: voteAverage!,
            ratingCount: voteCount!,
            language: originalLanguage!);

  factory AiringTvModel.fromJson(Map<String, dynamic> json) {
    return AiringTvModel(
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
      FirstAirDate: json['first_air_date'],
      title: json['name'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}
