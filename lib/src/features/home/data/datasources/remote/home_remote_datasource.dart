import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/errors/dio_error.dart';
import '../../../../../core/utils/errors/failure.dart';
import '../../../domain/models/ticket_model.dart';
import '../../../domain/usecases/param/ticket_param.dart';

abstract class HomeRemoteDatasource {
  Future<List<TicketModel>> tickets();
  Future<Either<Failure, String>> addTicket({required TicketParam param});
  Future<Either<Failure, String>> updateTicket({required TicketParam param});
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final Dio httpClient;

  HomeRemoteDatasourceImpl({required this.httpClient});
  @override
  Future<Either<Failure, String>> addTicket({required TicketParam param}) async {
    try {
      final response = await httpClient.post(
        'tickets',
        data: {
          "title": param.title,
          "description": param.description,
        },
      );
      if (response.statusCode == 200) {
        return const Right('Success add ticket');
      } else {
        return Left(Failure(response.data['message']));
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(Failure(error));
    } catch (e) {
      return const Left(Failure('Terjadi kesalahan'));
    }
  }

  @override
  Future<List<TicketModel>> tickets() async {
    try {
      final response = await httpClient.get(
        'tickets',
      );
      if (response.statusCode == 200) {
        final List<TicketModel> tickets = [];
        for (var item in response.data['data']['tickets']) {
          tickets.add(TicketModel.fromJson(item));
        }
        return tickets;
      } else {
        throw Exception('Failed to load tickets');
      }
    } on DioException catch (e) {
      throw DioErrorHandler.handleError(e);
    } catch (e) {
      throw Exception('Failed to load tickets');
    }
  }

  @override
  Future<Either<Failure, String>> updateTicket({required TicketParam param}) async {
    try {
      final response = await httpClient.put(
        'tickets/${param.id}',
        data: {
          "title": param.title,
          "description": param.description,
          if (param.status != null) "status": param.status,
        },
      );
      if (response.statusCode == 200) {
        return const Right('Success update ticket');
      } else {
        return Left(Failure(response.data['message']));
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left(Failure(error));
    } catch (e) {
      return const Left(Failure('Terjadi kesalahan'));
    }
  }
}
