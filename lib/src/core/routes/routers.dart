import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/datasources/local/token_manager.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/domain/models/ticket_model.dart';
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
        redirect: (context, state) async {
          TokenManager manager = await TokenManager.init();
          final token = await manager.read();
          if (token != null) {
            return RouteName.home;
          } else {
            return RouteName.login;
          }
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
          final ticket = state.extra as TicketModel;
          return DetailTicketPage(
            ticket: ticket,
          );
        },
      ),
    ],
  );
}
