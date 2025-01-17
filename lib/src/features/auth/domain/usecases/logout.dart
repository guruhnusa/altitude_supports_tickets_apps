import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/usecase/usecases.dart';
import '../repository/auth_repository.dart';

class Logout implements UseCase<String, void> {
  final AuthRepository repository;

  Logout({required this.repository});
  @override
  Future<Either<Failure, String>> call(void params) {
    return repository.logout();
  }
}
