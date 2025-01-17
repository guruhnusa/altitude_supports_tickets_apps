import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../domain/models/login_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/param/login_param.dart';
import '../../domain/usecases/param/register_param.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, LoginModel>> login({required LoginParam param}) {
    return datasource.login(param: param);
  }

  @override
  Future<Either<Failure, String>> register({required RegisterParam param}) {
    return datasource.register(param: param);
  }

  @override
  Future<Either<Failure, String>> logout() {
    return datasource.logout();
  }
}
