import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/local/user_manager.dart';

part 'is_agent_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<bool> isAgent(Ref ref) async {
  UserManager user = await UserManager.init();
  final isAgent = await user.isAgent();
  return isAgent ?? false;
}
