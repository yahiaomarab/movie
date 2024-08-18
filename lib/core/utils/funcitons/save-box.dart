 import 'package:hive/hive.dart';
import 'package:movie/features/on-boarding/domain/entities/onboarding-entity.dart';

 void saveData(List<OnBoardingEntity> posters) {
    var box = Hive.box<OnBoardingEntity>('kOnBoardingBox');
    box.addAll(posters);
  }