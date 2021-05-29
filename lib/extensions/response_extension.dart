import 'package:http/http.dart';

extension HttpResponseException on Response {
  bool get isSuccessful => this.statusCode >= 200 && this.statusCode <= 300;
}
