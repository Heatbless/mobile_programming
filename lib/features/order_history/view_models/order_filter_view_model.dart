import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/order_model.dart';
import 'order_history_view_model.dart';

part 'order_filter_view_model.g.dart';

@riverpod
class OrderFilterViewModel extends _$OrderFilterViewModel {
  @override
  OrderStatus? build() => null;  // null means no filter (show all)

  void setFilter(OrderStatus? status) {
    state = status;
  }
}

@riverpod
AsyncValue<List<OrderModel>> filteredOrderHistory(FilteredOrderHistoryRef ref) {
  final orders = ref.watch(orderHistoryViewModelProvider);
  final filter = ref.watch(orderFilterViewModelProvider);

  return orders.whenData((orders) {
    if (filter == null) return orders;
    return orders.where((order) => order.status == filter).toList();
  });
}