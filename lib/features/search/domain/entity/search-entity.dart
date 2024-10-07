import 'package:hive/hive.dart';
part 'search-entity.g.dart';

@HiveType(typeId: 3)
class SearchEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final int ID;

  SearchEntity({
    required this.image,
    required this.name,
    required this.ID,
  });
}
