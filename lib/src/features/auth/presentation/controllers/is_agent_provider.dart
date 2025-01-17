import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/local/user_manager.dart';

part 'is_agent_provider.g.dart';

@riverpod
FutureOr<bool> isAgent(Ref ref) async {
  UserManager userManager = await UserManager.init();
  final user = await userManager.read();
  log('User ${user!.toJson()}');
  final isAgent = user.role == 'agent';
  return isAgent;
}
