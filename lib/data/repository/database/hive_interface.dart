abstract class IRepository {
  add<T>({T item, String key, String name});
  T get<T>({String key, String name});
  remove<T>({String key, String name});
  clear<T>({String name});
}
