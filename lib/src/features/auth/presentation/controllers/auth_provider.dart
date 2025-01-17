import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/param/login_param.dart';
import '../../domain/usecases/param/register_param.dart';
import '../../domain/usecases/register_usecase.dart';
import 'usecase/login_provider.dart';
import 'usecase/logout_provider.dart';
import 'usecase/register_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> login({required LoginParam param}) async {
    state = const AsyncLoading();
    LoginUsecase login = ref.read(loginUsecaseProvider);
    final result = await login(param);
    result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) {
        state = const AsyncData('Login Success');
      },
    );
  }

  Future<void> register({required RegisterParam param}) async {
    state = const AsyncLoading();
    RegisterUsecase register = ref.read(registerUsecaseProvider);
    final result = await register(param);
    result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) {
        state = const AsyncData('Register Success');
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    LogoutUsecase logout = ref.read(logoutUsecaseProvider);
    final result = await logout(null);
    result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) {
        state = const AsyncData('Logout Success');
      },
    );
  }
}
