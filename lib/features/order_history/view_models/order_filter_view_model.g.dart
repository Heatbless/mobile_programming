// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_filter_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredOrderHistoryHash() =>
    r'bfe763f37a56606fc1b7ff56942c978f93762cec';

/// See also [filteredOrderHistory].
@ProviderFor(filteredOrderHistory)
final filteredOrderHistoryProvider =
    AutoDisposeProvider<AsyncValue<List<OrderModel>>>.internal(
  filteredOrderHistory,
  name: r'filteredOrderHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredOrderHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredOrderHistoryRef
    = AutoDisposeProviderRef<AsyncValue<List<OrderModel>>>;
String _$orderFilterViewModelHash() =>
    r'84635c62b4e25d84563338a5cd2df054fec775f5';

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
