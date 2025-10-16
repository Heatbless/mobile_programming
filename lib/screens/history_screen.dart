import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/cart_state.dart';
import '../state/order_history_state.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Order')),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada riwayat pesanan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return HistoryItemCard(
                  orderId: order.orderId,
                  date: order.date,
                  status: order.status,
                  total: order.total,
                );
              },
            ),
    );
  }
}

class HistoryItemCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final int total;

  const HistoryItemCard({
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.check_circle_outline, color: Colors.teal.shade400),
        title: Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanggal: $date'),
            Text('Status: $status', style: const TextStyle(color: Colors.green)),
          ],
        ),
        trailing: Text(
          'Rp ${total.toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}