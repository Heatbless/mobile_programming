import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_service.dart';
import '../models/order_model.dart';
import '../../cart/models/cart_item.dart';

part 'order_repository.g.dart';

@riverpod
class OrderRepository extends _$OrderRepository {
  @override
  Future<List<OrderModel>> build() async {
    return _loadOrders();
  }

  Future<List<OrderModel>> _loadOrders() async {
    try {
      final response = await ref.read(apiServiceProvider).getList<OrderModel>(
        '/api/orders',
        (json) => OrderModel.fromJson(json),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<OrderModel> getOrderById(String id) async {
    try {
      final response = await ref.read(apiServiceProvider).get<OrderModel>(
        '/api/orders/$id',
        (json) => OrderModel.fromJson(json),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load order details: $e');
    }
  }

  Future<void> createOrder(List<CartItem> items, int total) async {
    try {
      // Generate a unique order ID (you might want to improve this)
      final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
      
      final itemsList = items
          .map<Map<String, dynamic>>((item) => {
                'id': item.id,
                'name': item.name,
                'price': item.price,
                'quantity': item.quantity,
              })
          .toList();

      final orderPayload = {
        'id': orderId,
        'date': DateTime.now().toIso8601String(),
        'status': 'pending',
        'total': total,
        'items': itemsList,
      };

      // ignore: avoid_print
      print('Posting order payload: ' + orderPayload.toString());
      await ref.read(apiServiceProvider).post('/api/orders', orderPayload);
      
      // Refresh orders list
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }
}