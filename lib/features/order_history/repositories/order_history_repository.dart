import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../../menu/models/menu_item_model.dart';

final orderHistoryRepositoryProvider = Provider<OrderHistoryRepository>((ref) {
  return OrderHistoryRepository();
});

class OrderHistoryRepository {
  // TODO: Replace with actual API call
  Future<List<OrderModel>> getOrderHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data
    return [
      OrderModel(
        id: 'ORD001',
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
        items: [
          OrderItemModel(
            item: MenuItemModel(
              id: '1',
              name: 'Espresso',
              price: 18000,
              category: 'Kopi',
              imageUrl: 'assets/coffee.jpg',
            ),
            quantity: 2,
            subtotal: 36000,
          ),
        ],
        status: OrderStatus.completed,
        total: 36000,
      ),
      OrderModel(
        id: 'ORD002',
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
        items: [
          OrderItemModel(
            item: MenuItemModel(
              id: '2',
              name: 'Cappuccino',
              price: 24000,
              category: 'Kopi',
              imageUrl: 'assets/coffee.jpg',
            ),
            quantity: 1,
            subtotal: 24000,
          ),
          OrderItemModel(
            item: MenuItemModel(
              id: '4',
              name: 'Croissant',
              price: 15000,
              category: 'Makanan Ringan',
              imageUrl: 'assets/coffee.jpg',
            ),
            quantity: 2,
            subtotal: 30000,
          ),
        ],
        status: OrderStatus.completed,
        total: 54000,
      ),
      OrderModel(
        id: 'ORD003',
        orderDate: DateTime.now().subtract(const Duration(minutes: 30)),
        items: [
          OrderItemModel(
            item: MenuItemModel(
              id: '3',
              name: 'Green Tea Latte',
              price: 22000,
              category: 'Non-Kopi',
              imageUrl: 'assets/coffee.jpg',
            ),
            quantity: 1,
            subtotal: 22000,
          ),
        ],
        status: OrderStatus.processing,
        total: 22000,
      ),
    ];
  }
}