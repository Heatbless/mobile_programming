import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../repositories/order_repository.dart';
import '../view_models/order_history_view_model.dart' hide orderFilterViewModelProvider;
import '../view_models/order_filter_view_model.dart';
import 'widgets/order_item_card.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Load orders when screen is first shown
    Future.microtask(() {
      // Invalidate the order repository so the latest data is fetched from the API
      ref.invalidate(orderRepositoryProvider);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Whenever the route becomes active, refresh the orders so the list is always up-to-date
    final route = ModalRoute.of(context);
    if (route != null && route.isCurrent) {
      Future.microtask(() => ref.invalidate(orderRepositoryProvider));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orders = ref.watch(filteredOrderHistoryProvider);
    final selectedFilter = ref.watch(orderFilterViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
      ),
      body: Column(
        children: [
          // Status Filter
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                FilterChip(
                  label: const Text('Semua'),
                  selected: selectedFilter == null,
                  onSelected: (_) {
                    ref.read(orderFilterViewModelProvider.notifier)
                        .setFilter(null);
                  },
                ),
                const SizedBox(width: 8),
                ...OrderStatus.values.map(
                  (status) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(status.displayName),
                      selected: status == selectedFilter,
                      onSelected: (_) {
                        ref.read(orderFilterViewModelProvider.notifier)
                            .setFilter(status);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Orders List
          Expanded(
            child: orders.when(
              data: (orders) {
                if (orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: theme.colorScheme.primary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada pesanan',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.textTheme.titleMedium?.color
                                ?.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => ref
                      .read(orderHistoryViewModelProvider.notifier)
                      .refreshOrderHistory(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return OrderItemCard(
                        order: order,
                        onTap: () {
                          // Navigate to order detail
                          Navigator.pushNamed(
                            context,
                            '/order-detail',
                            arguments: order,
                          );
                        },
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text(
                  'Error: ${error.toString()}',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}