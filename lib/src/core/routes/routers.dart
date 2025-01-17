import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/add_ticket_page.dart';
import '../../features/home/presentation/pages/detail_ticket_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
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
      GoRoute(
        path: PathName.register,
        name: RouteName.register,
        builder: (context, state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: PathName.home,
        name: RouteName.home,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: PathName.addTicket,
        name: RouteName.addTicket,
        builder: (context, state) {
          return const AddTicketPage();
        },
      ),
      GoRoute(
        path: PathName.detailTicket,
        name: RouteName.detailTicket,
        builder: (context, state) {
          return const DetailTicketPage();
        },
      ),
    ],
  );
}
