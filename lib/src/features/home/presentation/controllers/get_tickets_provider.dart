import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/ticket_model.dart';
import '../../domain/usecases/tickets_usecase.dart';
import 'usecase/tickets_usecase_provider.dart';

part 'get_tickets_provider.g.dart';

@riverpod
class GetTickets extends _$GetTickets {
  final List<TicketModel> listTicket = [];
  @override
  FutureOr<List<TicketModel>> build() async {
    TicketsUsecase ticket = ref.read(ticketUsecaseProvider);
    final result = await ticket(null);
    return result.fold(
      (error) {
        throw error;
      },
      (data) {
        listTicket.addAll(data);
        return data;
      },
    );
  }

  //fitler by status
}
