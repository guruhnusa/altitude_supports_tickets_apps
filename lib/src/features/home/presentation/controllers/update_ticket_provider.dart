import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/param/ticket_param.dart';
import '../../domain/usecases/update_ticket_usecase.dart';
import 'get_tickets_provider.dart';
import 'usecase/update_ticket_usecase_provider.dart';

part 'update_ticket_provider.g.dart';

@riverpod
class UpdateTicket extends _$UpdateTicket {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> action({required TicketParam param}) async {
    state = const AsyncLoading();
    UpdateTicketUsecase updateTicket = ref.read(updateTicketUsecaseProvider);
    final result = await updateTicket(param);
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
