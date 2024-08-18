import 'package:hive/hive.dart';

part 'recommended-entity.g.dart';

@HiveType(typeId: 2)
class RecommendedEntity {
  @HiveField(0)
  final String image;
  @HiveField(1)
  final String name;

  RecommendedEntity({
    required this.image,
    required this.name,
  });
}
