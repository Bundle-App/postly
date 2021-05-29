import 'package:meta/meta.dart';

abstract class ApiResponse<T> {
  final String message;
  final T extraData;

  ApiResponse(this.message, {this.extraData});
  bool get isSuccessful => this is SuccessResponse;
}

class SuccessResponse<T> extends ApiResponse<T> {
  SuccessResponse({
    String message = '',
    T extraData,
  }) : super(message, extraData: extraData);
}

class FailureResponse<T> extends ApiResponse<T> {
  static String _getErrorFromResponse(dynamic responseData) {
    final responseMap = Map<String, dynamic>.from(responseData);

    if (responseMap.containsKey('error')) return responseMap['error'];

    if (responseMap.containsKey('message')) return responseMap['message'];

    return null;
  }

  factory FailureResponse.errorFromResponse(dynamic responseData) {
    final errorMessage = _getErrorFromResponse(responseData);

    return FailureResponse(message: errorMessage);
  }

  FailureResponse({
    @required String message,
  }) : super(message);

  @override
  String toString() {
    return 'FailureResponse: $message';
  }
}
