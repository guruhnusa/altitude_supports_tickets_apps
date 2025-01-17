import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/usecase/usecases.dart';
import '../repository/auth_repository.dart';
import 'param/register_param.dart';

class Register implements UseCase<String, RegisterParam> {
  final AuthRepository repository;

  Register({required this.repository});
  @override
  Future<Either<Failure, String>> call(RegisterParam params) {
    return repository.register(param: params);
  }
}
