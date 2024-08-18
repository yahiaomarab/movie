 import 'package:hive/hive.dart';

 void saveData<T>(List<T> items,String boxName) {
    var box = Hive.box<T>(boxName);
    box.addAll(items);
  }