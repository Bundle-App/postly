import 'package:hive/hive.dart';

class BoxHelper<T> {
  Box<T> getBox(boxName) => Hive.box(boxName);
}
