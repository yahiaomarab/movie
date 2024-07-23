
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';

class TrendingModel extends TrendingEntity{
  final String? backdropPath;
  final int id;
  final String? title;
  final String? originalTitle;
  final String? name;
  final String? originalName;
  final String overview;
  final String? posterPath;
  final String mediaType;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String? releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String? firstAirDate;
  final List<String>? originCountry;

  TrendingModel({
    this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    this.name,
    this.originalName,
    required this.overview,
    this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.firstAirDate,
    this.originCountry,
  }) : super(posterImage: posterPath!);

 factory TrendingModel.fromJson(Map<String, dynamic> json) {
  return TrendingModel(
    backdropPath: json['backdrop_path'],
    id: json['id'],
    title: json['title'],
    originalTitle: json['original_title'],
    name: json['name'],
    originalName: json['original_name'],
    overview: json['overview'],
    posterPath: json['poster_path'],
    mediaType: json['media_type'],
    adult: json['adult'] ?? false, // Handle nullable boolean with default value
    originalLanguage: json['original_language'] ?? '',
    genreIds: List<int>.from(json['genre_ids'] ?? []),
    popularity: json['popularity']?.toDouble() ?? 0.0,
    releaseDate: json['release_date'],
    video: json['video'] ?? false, // Handle nullable boolean with default value
    voteAverage: json['vote_average']?.toDouble() ?? 0.0,
    voteCount: json['vote_count'] ?? 0,
    firstAirDate: json['first_air_date'],
    originCountry: json['origin_country'] != null
        ? List<String>.from(json['origin_country'])
        : null,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'name': name,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaType,
      'adult': adult,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'release_date': releaseDate,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'first_air_date': firstAirDate,
      'origin_country': originCountry,
    };
  }
}
