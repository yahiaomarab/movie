import 'package:hive/hive.dart';
part 'tv-top-rated-entity.g.dart';
@HiveType(typeId: 7)
class TvTopRatedEntity {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final int ratingCount;

  @HiveField(5)
  final String language;

  @HiveField(6)
  final int id;

  TvTopRatedEntity({
    required this.description,
    required this.id,
    required this.image,
    required this.language,
    required this.name,
    required this.rating,
    required this.ratingCount,
  });
}
