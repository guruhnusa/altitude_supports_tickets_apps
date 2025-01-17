import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/datasources/local/token_manager.dart';
import '../routes/router_name.dart';
import '../routes/routers.dart';

part 'dio_provider.g.dart';

final baseUrl = dotenv.env['BASE_URL'];

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  dio.options.baseUrl = baseUrl!;
  dio.options.connectTimeout = const Duration(milliseconds: 20000);
  dio.options.receiveTimeout = const Duration(milliseconds: 20000);
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.validateStatus = (status) {
    return status != 401;
  };

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        TokenManager tokenManager = await TokenManager.init();
        final token = await tokenManager.read();
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          TokenManager tokenManager = await TokenManager.init();
          await tokenManager.delete();

          ref.read(routersProvider).pushReplacementNamed(PathName.login);
        }
        return handler.next(error);
      },
    ),
  );
  if (!kReleaseMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }
  return dio;
}
