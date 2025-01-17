import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/tickets_usecase.dart';
import '../repository/home_repository_provider.dart';

part 'tickets_usecase_provider.g.dart';

@riverpod
TicketsUsecase ticketUsecase(Ref ref) {
  return TicketsUsecase(
    repository: ref.read(homeRepositoryProvider),
  );
}
