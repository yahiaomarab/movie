import 'package:movie/features/search/domain/entity/search-entity.dart';

class SearchModel extends SearchEntity {
  String? backdropPath;
  int? id;
  String? title;
  String? originalName;
  String? overview;
  String? posterPath;
  String? mediaType;
  bool? adult;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;
  List<String>? originCountry;

  SearchModel(
      {this.backdropPath,
      this.id,
      this.title,
      this.originalName,
      this.overview,
      this.posterPath,
      this.mediaType,
      this.adult,
      this.originalLanguage,
      this.genreIds,
      this.popularity,
      this.firstAirDate,
      this.voteAverage,
      this.voteCount,
      this.originCountry})
      : super(ID: id!, name: title!, image: posterPath!);

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      backdropPath: json['backdrop_path'],
      id: json['id'],
      title: json['name'],
      originalName: json['original_name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      mediaType: json['media_type'],
      adult: json['adult'],
      originalLanguage: json['original_language'],
      genreIds: json['genre_ids'].cast<int>(),
      popularity: json['popularity'],
      firstAirDate: json['first_air_date'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      originCountry: json['origin_country'].cast<String>(),
    );
  }
}
