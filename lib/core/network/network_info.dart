import 'package:data_connection_checker/data_connection_checker.dart';

///NetworkInfo class that contains all network related methods
abstract class NetworkInfo {
  ///method that returns true if internet is connected and false otherwise
  Future<bool> get isConnected;
}

///Implementation of the NetworkInfo class
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);

  final DataConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
