import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import 'router_name.dart';

part 'routers.g.dart';

@riverpod
Raw<GoRouter> routers(Ref ref) {
  return GoRouter(
    initialLocation: RouteName.login,
    routes: [
      GoRoute(
        path: PathName.login,
        name: RouteName.login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ],
  );
}
