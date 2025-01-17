import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/errors/dio_error.dart';
import '../../../../../core/utils/errors/failure.dart';
import '../../../domain/models/login_model.dart';
import '../../../domain/usecases/param/login_param.dart';
import '../../../domain/usecases/param/register_param.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, LoginModel>> login({required LoginParam param});
  Future<Either<Failure, String>> register({required RegisterParam param});
  Future<Either<Failure, String>> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio httpClient;

  AuthRemoteDatasourceImpl({required this.httpClient});
  @override
  Future<Either<Failure, LoginModel>> login({required LoginParam param}) async {
    try {
      final response = await httpClient.post(
        'users/login',
        data: {'username': param.username, 'password': param.password, 'fcmToken': param.token},
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );
      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(response.data['data']);
        return Right(loginModel);
      } else {
        return const Left(Failure('Login Gagal'));
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(Failure(error));
    } catch (e) {
      return const Left(Failure('Terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, String>> register({required RegisterParam param}) async {
    try {
      final response = await httpClient.post(
        'users/register',
        data: {
          'username': param.username,
          'email': param.email,
          'password': param.password,
          'role': 'customer',
        },
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );
      if (response.statusCode == 201) {
        return const Right('Registrasi berhasil');
      } else {
        return Left(Failure(response.data['message']));
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(Failure(error));
    } catch (e) {
      return const Left(Failure('Terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final response = await httpClient.post(
        'users/logout',
      );
      if (response.statusCode == 200) {
        return const Right('Logout berhasil');
      } else {
        return Left(Failure(response.data['message']));
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(Failure(error));
    } catch (e) {
      return const Left(Failure('Terjadi kesalahan'));
    }
  }
}
