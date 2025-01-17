import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/network/dio_provider.dart';
import '../../../data/datasources/remote/auth_remote_datasource.dart';
import '../../../data/repository/auth_repository_impl.dart';
import '../../../domain/repository/auth_repository.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    datasource: AuthRemoteDatasourceImpl(
      httpClient: ref.read(dioProvider),
    ),
  );
}
