import 'package:hive/hive.dart';

part 'trending-entity.g.dart';

@HiveType(typeId: 1)
class TrendingEntity {
  @HiveField(0)
  final String image;
  @HiveField(1)
  final String kind;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String status;
  @HiveField(5)
  final int ID;
  TrendingEntity({
    required this.image,
    required this.kind,
    required this.name,
    required this.price,
    required this.status,
    required this.ID,
  });
}
