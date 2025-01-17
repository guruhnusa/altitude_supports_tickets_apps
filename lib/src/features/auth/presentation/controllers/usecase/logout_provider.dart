import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/logout_usecase.dart';
import '../repository/auth_repository_provider.dart';

part 'logout_provider.g.dart';

@riverpod
LogoutUsecase logoutUsecase(Ref ref) {
  return LogoutUsecase(
    repository: ref.read(authRepositoryProvider),
  );
}
