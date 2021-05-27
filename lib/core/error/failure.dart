///general/base failure class
abstract class Failure {}

///server failure class that represents failure from remote data calls
class ServerFailure extends Failure {}

///cache failure class that represents failure from local data calls
class CacheFailure extends Failure {}
