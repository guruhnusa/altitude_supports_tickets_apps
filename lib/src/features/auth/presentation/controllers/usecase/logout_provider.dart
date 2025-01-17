import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/logout.dart';
import '../repository/auth_repository_provider.dart';

@riverpod
Logout logout(Ref ref) {
  return Logout(
    repository: ref.read(authRepositoryProvider),
  );
}
