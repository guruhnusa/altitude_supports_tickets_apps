import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/usecase/usecases.dart';
import '../models/login_model.dart';
import '../repository/auth_repository.dart';
import 'param/login_param.dart';

class Login implements UseCase<LoginModel, LoginParam> {
  final AuthRepository repository;

  Login({required this.repository});
  @override
  Future<Either<Failure, LoginModel>> call(LoginParam params) {
    return repository.login(param: params);
  }
}
