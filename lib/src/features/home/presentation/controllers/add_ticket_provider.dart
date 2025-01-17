import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/add_ticket_usecase.dart';
import '../../domain/usecases/param/ticket_param.dart';
import 'get_tickets_provider.dart';
import 'usecase/add_ticket_usecase_provider.dart';

part 'add_ticket_provider.g.dart';

@riverpod
class AddTicket extends _$AddTicket {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> action({required TicketParam param}) async {
    state = const AsyncLoading();
    AddTicketUsecase addTicket = ref.read(addTicketUsecaseProvider);
    final result = await addTicket(param);
    result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) {
        ref.invalidate(getTicketsProvider);
        state = AsyncData(data);
      },
    );
  }
}
