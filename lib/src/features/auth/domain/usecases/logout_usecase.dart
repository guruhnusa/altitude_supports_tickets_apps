import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/usecase/usecases.dart';
import '../repository/auth_repository.dart';

class LogoutUsecase implements UseCase<String, void> {
  final AuthRepository repository;

  LogoutUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(void params) {
    return repository.logout();
  }
}
