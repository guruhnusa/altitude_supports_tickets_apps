import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/register.dart';
import '../repository/auth_repository_provider.dart';

part 'register_provider.g.dart';

@riverpod
Register register(Ref ref) {
  return Register(
    repository: ref.read(authRepositoryProvider),
  );
}
