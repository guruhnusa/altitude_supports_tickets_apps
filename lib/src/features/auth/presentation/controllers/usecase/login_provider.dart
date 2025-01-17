import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/login_usecase.dart';
import '../repository/auth_repository_provider.dart';

part 'login_provider.g.dart';

@riverpod
LoginUsecase loginUsecase(Ref ref) {
  return LoginUsecase(
    repository: ref.read(authRepositoryProvider),
  );
}
