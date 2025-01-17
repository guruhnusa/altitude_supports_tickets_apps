import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/usecase/usecases.dart';
import '../repository/home_repository.dart';
import 'param/ticket_param.dart';

class AddTicketUsecase implements UseCase<String, TicketParam> {
  final HomeRepository repository;

  AddTicketUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(TicketParam params) {
    return repository.addTicket(param: params);
  }
}
