import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/register_usecase.dart';
import '../repository/auth_repository_provider.dart';

part 'register_provider.g.dart';

@riverpod
RegisterUsecase registerUsecase(Ref ref) {
  return RegisterUsecase(
    repository: ref.read(authRepositoryProvider),
  );
}
