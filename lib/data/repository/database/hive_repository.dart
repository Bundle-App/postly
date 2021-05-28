import 'package:hive/hive.dart';
import 'package:Postly/data/repository/database/hive_interface.dart';

class HiveRepository implements IRepository {
  HiveRepository();

  static openHives(List<String> boxNames) async {
    var boxHives = boxNames.map((name) => Hive.openBox(name));
    print("trying to open hive boxes");
    await Future.wait(boxHives);
    print("Hive boxes opened");
  }

  @override
  add<T>({T item, String key, String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    box.put(key, item);
  }

  @override
  T get<T>({String key, String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    return box.get(key);
  }

  @override
  remove<T>({String key, String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    return box.delete(key);
  }

  checkBoxState(box) {
    if (box == null) throw Exception('Box has not been set');
  }

  @override
  clear<T>({String name}) async {
    var box = Hive.box(name);
    checkBoxState(box);
    await box.clear();
  }
}
