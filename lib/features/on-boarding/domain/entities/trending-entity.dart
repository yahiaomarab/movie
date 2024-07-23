import 'package:hive/hive.dart';

part 'trending-entity.g.dart';

@HiveType(typeId: 0)
class TrendingEntity {

  @HiveField(0)
  final String posterImage;

  TrendingEntity({
    required this.posterImage,
  });
}
