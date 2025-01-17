import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/build_context_ext.dart';
import '../../../../core/helpers/buttons/buttons.dart';
import '../../../../core/helpers/widgets/custom_appbar.dart';
import '../../../../core/routes/router_name.dart';
import '../../../../core/utils/constant/app_colors.dart';
import '../../../../core/utils/permission/notification_services.dart';
import '../../../auth/presentation/controllers/auth_provider.dart';
import '../../data/datasources/local/filter_local_data.dart';
import '../../domain/models/filter_model.dart';
import '../controllers/get_tickets_provider.dart';
import '../widgets/filter_item.dart';
import '../widgets/shimmer_ticket_item.dart';
import '../widgets/ticket_item.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<FilterModel> filterData = filterLocalData;

    final selectFilter = useState<FilterModel>(filterData.first);

    final ticketState = ref.watch(getTicketsProvider);

    final notificationServices = NotificationServices();

    useEffect(() {
      notificationServices.setupNotifications(context);
      notificationServices.setupNotificationInBacknTerminated(context);
      return null;
    }, []);

    return Scaffold(
      appBar: CustomAppBar(
        isBack: false,
        title: 'Ticket Support',
        actions: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Consumer(
                  builder: (context, ref, child) {
                    ref.listen(
                      authProvider,
                      (previous, next) {
                        if (next is AsyncData && next.value != null) {
                          context.pushReplacementNamed(PathName.login);
                        } else if (next is AsyncError) {
                          context.showErrorSnackbar(message: 'Failed to logout');
                        }
                      },
                    );
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            ref.read(authProvider.notifier).logout();
                            context.pop();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Gap(12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filterData.length,
                itemBuilder: (context, index) {
                  final data = filterData[index];
                  return FilterItem(
                    isSelected: selectFilter.value == data,
                    onTap: () {
                      selectFilter.value = data;
                      ref.read(getTicketsProvider.notifier).filterByStatus(status: data.value);
                    },
                    title: data.title,
                  );
                },
                separatorBuilder: (context, index) => const Gap(8),
              ),
            ),
            const Gap(12),
            RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(getTicketsProvider);
              },
              child: SingleChildScrollView(
                child: ticketState.when(
                  skipLoadingOnRefresh: false,
                  data: (data) {
                    if (data.isEmpty) {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //icon kosong
                          Icon(
                            Icons.hourglass_empty,
                            size: 100,
                            color: AppColors.neutral100,
                          ),
                          Gap(12),
                          Center(
                            child: Text(
                              'Ticket is Empty',
                              style: TextStyle(
                                color: AppColors.neutral100,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.separated(
                      itemCount: data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final ticket = data[index];
                        return TicketItem(
                          ticket: ticket,
                          onTap: () {
                            context.pushNamed(PathName.detailTicket, extra: ticket);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Gap(12),
                    );
                  },
                  error: (error, stackTrace) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Error Get Data',
                          style: TextStyle(color: Colors.red),
                        ),
                        const Gap(12),
                        Button.outlined(
                          width: 200,
                          onPressed: () {
                            ref.invalidate(getTicketsProvider);
                          },
                          label: 'Retry',
                        ),
                      ],
                    );
                  },
                  loading: () {
                    return const ShimmerTicketItem();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.indigo,
        onPressed: () {
          context.pushNamed(PathName.addTicket);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
