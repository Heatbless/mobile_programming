import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'cart_state.dart';

part 'order_history_state.g.dart';

class OrderItem {
  final String orderId;
  final String date;
  final String status;
  final int total;
  final List<CartItem> items;

  OrderItem({
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
  });
}

@riverpod
class OrderHistory extends _$OrderHistory {
  @override
  List<OrderItem> build() {
    return [];
  }

  void addOrder(List<CartItem> items, int total) {
    if (items.isEmpty) return;
    
    final now = DateTime.now();
    final orderId = 'ORD-${now.millisecondsSinceEpoch.toString().substring(5)}';
    
    state = [
      OrderItem(
        orderId: orderId,
        date: '${now.day} ${_getMonthName(now.month)} ${now.year}',
        status: 'Selesai',
        total: total,
        items: List.from(items),
      ),
      ...state,
    ];
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return months[month - 1];
  }
}