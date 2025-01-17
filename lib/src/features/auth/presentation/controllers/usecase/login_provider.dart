import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/login.dart';
import '../repository/auth_repository_provider.dart';

part 'login_provider.g.dart';

@riverpod
Login login(Ref ref) {
  return Login(
    repository: ref.read(authRepositoryProvider),
  );
}
