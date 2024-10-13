import 'package:hive/hive.dart';

part 'similar-movie-entity.g.dart';

@HiveType(typeId: 4)
class SimilarMovieEntity{
  @HiveField(0)
  final String image;
  @HiveField(1)
  final int ID;

  SimilarMovieEntity({
    required this.ID,
    required this.image,
  });
}