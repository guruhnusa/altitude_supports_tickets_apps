import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../domain/models/ticket_model.dart';
import '../../domain/repository/home_repository.dart';
import '../../domain/usecases/param/ticket_param.dart';
import '../datasources/remote/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource datasource;

  HomeRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, String>> addTicket({required TicketParam param}) {
    return datasource.addTicket(param: param);
  }

  @override
  Future<Either<Failure, List<TicketModel>>> tickets() async {
    try {
      final result = await datasource.tickets();
      return Right(result);
    } catch (e) {
      return const Left(Failure('Failed to load tickets'));
    }
  }

  @override
  Future<Either<Failure, String>> updateTicket({required TicketParam param}) {
    return datasource.updateTicket(param: param);
  }
}
