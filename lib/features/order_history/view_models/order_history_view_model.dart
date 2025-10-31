import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/order_model.dart';
import '../repositories/order_repository.dart';

part 'order_history_view_model.g.dart';

@riverpod
class OrderHistoryViewModel extends _$OrderHistoryViewModel {
  @override
  AsyncValue<List<OrderModel>> build() {
    // Delegate to the central OrderRepository provider which fetches from the API
    return ref.watch(orderRepositoryProvider);
  }

  Future<void> loadOrderHistory() async {
    // Force reload the underlying repository provider
    ref.invalidate(orderRepositoryProvider);
  }

  Future<void> refreshOrderHistory() async {
    await loadOrderHistory();
  }
}

@riverpod
class FilteredOrderHistoryViewModel extends _$FilteredOrderHistoryViewModel {
  @override
  AsyncValue<List<OrderModel>> build() {
    final orders = ref.watch(orderHistoryViewModelProvider);
    final filter = ref.watch(orderFilterViewModelProvider);

    return orders.whenData((orders) {
      if (filter == null) return orders;
      return orders.where((order) => order.status == filter).toList();
    });
  }
}

@riverpod
class OrderFilterViewModel extends _$OrderFilterViewModel {
  @override
  OrderStatus? build() => null;

  void setFilter(OrderStatus? status) => state = status;
}