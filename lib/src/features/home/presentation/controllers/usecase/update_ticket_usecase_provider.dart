import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/update_ticket_usecase.dart';
import '../repository/home_repository_provider.dart';

part 'update_ticket_usecase_provider.g.dart';

@riverpod
UpdateTicketUsecase updateTicketUsecase(Ref ref) {
  return UpdateTicketUsecase(
    repository: ref.read(homeRepositoryProvider),
  );
}
