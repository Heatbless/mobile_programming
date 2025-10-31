// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderHistoryViewModelHash() =>
    r'14577faca77b3108507853b66958e0ed9c7f8674';

/// See also [OrderHistoryViewModel].
@ProviderFor(OrderHistoryViewModel)
final orderHistoryViewModelProvider = AutoDisposeNotifierProvider<
    OrderHistoryViewModel, AsyncValue<List<OrderModel>>>.internal(
  OrderHistoryViewModel.new,
  name: r'orderHistoryViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderHistoryViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderHistoryViewModel
    = AutoDisposeNotifier<AsyncValue<List<OrderModel>>>;
String _$filteredOrderHistoryViewModelHash() =>
    r'0cbdd3b7993dbea7cb7548cb10904f466f78fbdc';

/// See also [FilteredOrderHistoryViewModel].
@ProviderFor(FilteredOrderHistoryViewModel)
final filteredOrderHistoryViewModelProvider = AutoDisposeNotifierProvider<
    FilteredOrderHistoryViewModel, AsyncValue<List<OrderModel>>>.internal(
  FilteredOrderHistoryViewModel.new,
  name: r'filteredOrderHistoryViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredOrderHistoryViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilteredOrderHistoryViewModel
    = AutoDisposeNotifier<AsyncValue<List<OrderModel>>>;
String _$orderFilterViewModelHash() =>
    r'57e7ef0b6d1359b448e4bff8b7770da49dd9cc97';

/// See also [OrderFilterViewModel].
@ProviderFor(OrderFilterViewModel)
final orderFilterViewModelProvider =
    AutoDisposeNotifierProvider<OrderFilterViewModel, OrderStatus?>.internal(
  OrderFilterViewModel.new,
  name: r'orderFilterViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderFilterViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderFilterViewModel = AutoDisposeNotifier<OrderStatus?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
