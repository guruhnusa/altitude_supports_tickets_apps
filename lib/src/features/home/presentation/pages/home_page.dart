import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/helpers/widgets/custom_appbar.dart';
import '../../../../core/routes/router_name.dart';
import '../../../../core/utils/constant/app_colors.dart';
import '../../data/datasources/local/filter_local_data.dart';
import '../../domain/models/filter_model.dart';
import '../widgets/filter_item.dart';
import '../widgets/ticket_item.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<FilterModel> filterData = filterLocalData;

    final selectFilter = useState<FilterModel>(filterData.first);

    return Scaffold(
      appBar: CustomAppBar(
        isBack: false,
        title: 'Ticket Support',
        actions: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          onPressed: () {},
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
                    },
                    title: data.title,
                  );
                },
                separatorBuilder: (context, index) => const Gap(8),
              ),
            ),
            const Gap(12),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  return TicketItem(
                    onTap: () {
                      context.pushNamed(PathName.detailTicket);
                    },
                  );
                },
                separatorBuilder: (context, index) => const Gap(12),
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
