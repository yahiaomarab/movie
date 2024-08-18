import 'package:hive/hive.dart';

part 'onboarding-entity.g.dart';

@HiveType(typeId: 0)
class OnBoardingEntity {
  @HiveField(0)
  final String posterImage;

  OnBoardingEntity({
    required this.posterImage,
  });
}
