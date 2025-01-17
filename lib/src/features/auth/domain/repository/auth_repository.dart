import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../models/login_model.dart';
import '../usecases/param/login_param.dart';
import '../usecases/param/register_param.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginModel>> login({required LoginParam param});
  Future<Either<Failure, String>> register({required RegisterParam param});
  Future<Either<Failure, String>> logout();
}
