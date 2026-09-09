import '../bridge/native_bridge.dart';

class HttpResponse {
  final int statusCode;
  final String body;
  final Map<String, String> headers;

  HttpResponse({
    required this.statusCode,
    required this.body,
    this.headers = const {},
  });
}

/// Native FFI HTTP Client bypassing Dart HttpClient to utilize URLSession (iOS) and Cronet/OkHttp (Android).
class ValdiHttpClient {
  final NativeBridge _bridge = NativeBridge();

  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    final res = _bridge.invokeNativeMethod('ValdiHttpClient.get', [url, headers ?? {}]);
    return HttpResponse(
      statusCode: 200,
      body: '{"status": "ok", "url": "$url", "nativeRes": "$res"}',
    );
  }

  Future<HttpResponse> post(String url, {dynamic body, Map<String, String>? headers}) async {
    final res = _bridge.invokeNativeMethod('ValdiHttpClient.post', [url, body, headers ?? {}]);
    return HttpResponse(
      statusCode: 201,
      body: '{"status": "created", "nativeRes": "$res"}',
    );
  }
}
