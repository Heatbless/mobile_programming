import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_service.dart';
import '../models/cart_item.dart';

part 'order_repository.g.dart';

@riverpod
class OrderRepository extends _$OrderRepository {
  @override
  Future<void> build() async {}

  Future<void> createOrder(List<CartItem> items, int total) async {
    try {
      // match DB schema: orders {id, date, status, total} and order_items rows
      final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';

      final now = DateTime.now();
      final formattedDate = '${now.year.toString().padLeft(4, '0')}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')} '
          '${now.hour.toString().padLeft(2, '0')}:'
          '${now.minute.toString().padLeft(2, '0')}:'
          '${now.second.toString().padLeft(2, '0')}';

      // Build concrete items list
      final itemsList = items
          .map<Map<String, dynamic>>((item) => {
                'id': item.id,
                'name': item.name,
                'price': item.price,
                'quantity': item.quantity,
              })
          .toList();

      // Flat payload expected by the server: { id, date, status, total, items }
      final orderPayload = {
        'id': orderId,
        'date': formattedDate,
        'status': 'pending',
        'total': total,
        'items': itemsList,
      };

      // Log and send the single payload
      // ignore: avoid_print
      print('Posting order payload: ' + orderPayload.toString());
      await ref.read(apiServiceProvider).post('/api/orders', orderPayload);
    } catch (e) {
      print('Error creating order: $e'); // Debug print
      throw Exception('Failed to create order: $e');
    }
  }
}