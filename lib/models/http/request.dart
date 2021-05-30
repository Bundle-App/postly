import 'dart:io';

import 'package:meta/meta.dart';

abstract class HttpRequest {
  final String path;
  final String? overrideUrl;
  final Map<String, String>? headers;

  HttpRequest(this.path, this.headers, this.overrideUrl);

  bool get isJsonRequest => this is JsonRequest;

  dynamic get payload {
    return (this as JsonRequest).payload;
  }
}

class JsonRequest extends HttpRequest {
  final Map<String, String> payload;

  JsonRequest({
    required String path,
    this.payload = const <String, String>{},
    Map<String, String>? headers,
    String? overrideUrl,
  }) : super(
          path,
          headers,
          overrideUrl,
        );

  bool get hasPayload => this.payload.isNotEmpty;

  @override
  int get hashCode =>
      path.hashCode ^
      payload.hashCode ^
      headers.hashCode ^
      overrideUrl.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonRequest &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          payload == other.payload &&
          headers == other.headers &&
          overrideUrl == other.overrideUrl;
}
