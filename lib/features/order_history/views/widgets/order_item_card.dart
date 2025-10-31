import 'package:flutter/material.dart';
import '../../models/order_model.dart';
import 'package:intl/intl.dart';

class OrderItemCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;

  const OrderItemCard({
    required this.order,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order ID and Date
              const SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.id}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    dateFormat.format(order.orderDate),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Status
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 8,
              //     vertical: 4,
              //   ),
              //   decoration: BoxDecoration(
              //     color: order.status.color.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Text(
              //     order.status.displayName,
              //     style: theme.textTheme.bodySmall?.copyWith(
              //       color: order.status.color,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 12),
              // Items
              ...order.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          '${item.quantity}x',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.item.name,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          'Rp ${NumberFormat.decimalPattern('id_ID').format(item.subtotal)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )),
              const Divider(),
              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp ${NumberFormat.decimalPattern('id_ID').format(order.total)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}