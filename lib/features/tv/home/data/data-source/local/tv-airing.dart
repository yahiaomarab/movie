import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/tv/home/domain/entity/airing/tv-airing-entity.dart';

abstract class TvAiringLocalDataSource {
  List<TvAiringEntity> fetchTvAiringLocalData();
}

class TvAiringLocalDataSourceImp extends TvAiringLocalDataSource {
  @override
  List<TvAiringEntity> fetchTvAiringLocalData() {
   var box = Hive.box<TvAiringEntity>(KTvAiringBox);
    return box.values.toList();
  }
}
