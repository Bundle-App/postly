class ApiFailureException implements Exception {
  dynamic message;
  ApiFailureException([this.message]);
  @override
  String toString() => message.toString();
}
