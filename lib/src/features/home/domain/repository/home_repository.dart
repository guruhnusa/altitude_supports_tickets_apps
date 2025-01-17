import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../models/ticket_model.dart';
import '../usecases/param/ticket_param.dart';

abstract class HomeRepository {
  Future<Either<Failure,List<TicketModel>>> tickets();
  Future<Either<Failure,String>> addTicket({required TicketParam param});
  Future<Either<Failure,String>> updateTicket({required TicketParam param});
}