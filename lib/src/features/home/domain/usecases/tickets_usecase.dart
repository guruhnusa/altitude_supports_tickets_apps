import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/usecase/usecases.dart';
import '../models/ticket_model.dart';
import '../repository/home_repository.dart';

class TicketsUsecase implements UseCase<List<TicketModel>, void> {
  final HomeRepository repository;

  TicketsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<TicketModel>>> call(void params) {
    return repository.tickets();
  }
}
