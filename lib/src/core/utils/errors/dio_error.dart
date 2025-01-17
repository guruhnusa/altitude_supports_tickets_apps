import 'package:dio/dio.dart';

class DioErrorHandler {
  static Future<String> handleError(DioException e) async {
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 401:
          return 'Unauthorized';
        case 500:
          return 'Internal server error';
        case 404:
          return 'Not found';
        default:
          return 'HTTP Error: ${e.response!.statusCode}';
      }
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return 'Request timeout';
        case DioExceptionType.cancel:
          return 'Request cancelled';
        case DioExceptionType.connectionError:
          return 'Connection error';
        case DioExceptionType.unknown:
        default:
          return 'Dio Error: ${e.message}';
      }
    }
  }
}