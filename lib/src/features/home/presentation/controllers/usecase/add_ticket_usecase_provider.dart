import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/add_ticket_usecase.dart';
import '../repository/home_repository_provider.dart';

part 'add_ticket_usecase_provider.g.dart';

@riverpod
AddTicketUsecase addTicketUsecase(Ref ref) {
  return AddTicketUsecase(
    repository: ref.read(homeRepositoryProvider),
  );
}
