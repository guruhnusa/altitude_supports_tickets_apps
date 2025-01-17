import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constant/app_colors.dart';
import '../../domain/models/ticket_model.dart';

class TicketItem extends StatelessWidget {
  final TicketModel ticket;
  final Function() onTap;
  const TicketItem({
    super.key,
    required this.ticket,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.indigo.withOpacity(0.1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.title,
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.neutral900,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    ticket.description,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.neutral700,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(4),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.indigo.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                ticket.status,
                style: TextStyle(
                
                  color: ticket.status == 'Open'
                      ? Colors.green.withOpacity(0.3)
                      : ticket.status == 'On Progress'
                          ? Colors.yellow.withOpacity(0.3)
                          : Colors.red.withOpacity(0.3),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
