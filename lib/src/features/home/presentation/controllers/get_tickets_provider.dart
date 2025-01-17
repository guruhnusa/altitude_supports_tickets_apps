import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/ticket_model.dart';
import '../../domain/usecases/tickets_usecase.dart';
import 'usecase/tickets_usecase_provider.dart';

part 'get_tickets_provider.g.dart';

@riverpod
class GetTickets extends _$GetTickets {
  final List<TicketModel> _listTicket = [];
  @override
  FutureOr<List<TicketModel>> build() async {
    TicketsUsecase ticket = ref.read(ticketUsecaseProvider);
    final result = await ticket(null);
    return result.fold(
      (error) {
        throw error;
      },
      (data) {
        _listTicket.clear();
        _listTicket.addAll(data);
        return data;
      },
    );
  }

  //fitler by status

  void filterByStatus({required String status}) {
    // Update the state with filtered tickets based on the status
    if (status == 'all') {
      // Show all tickets when 'all' is selected
      state = AsyncData(_listTicket);
    } else {
      // Filter tickets by the given status
      final filteredTickets = _listTicket.where((ticket) => ticket.status == status).toList();
      state = AsyncData(filteredTickets);
    }
  }
}
