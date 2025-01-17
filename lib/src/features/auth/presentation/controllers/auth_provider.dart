import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/local/token_manager.dart';
import '../../data/datasources/local/user_manager.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/param/login_param.dart';
import '../../domain/usecases/param/register_param.dart';
import '../../domain/usecases/register_usecase.dart';
import 'fcm_token_provider.dart';
import 'is_agent_provider.dart';
import 'usecase/login_provider.dart';
import 'usecase/logout_provider.dart';
import 'usecase/register_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<String?> build() async {
    return null;
  }

  Future<void> login({required String username, required String password}) async {
    state = const AsyncLoading();
    final token = await ref.watch(fcmTokenProvider.future);
    log('FCM TOKEN : $fcmToken');
    LoginUsecase login = ref.read(loginUsecaseProvider);
    final result = await login(LoginParam(username: username, password: password, token: token));
    result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
        state = const AsyncData(null);
      },
      (data) async {
        TokenManager tokenManager = await TokenManager.init();
        await tokenManager.save(token: data.token!);
        UserManager userManager = await UserManager.init();
        await userManager.save(user: data.user!);
        ref.read(isAgentProvider);
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
