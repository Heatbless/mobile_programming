// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartTotalHash() => r'efa2f8b2d8dda92cde775115b5ab44a736c66545';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider =
    AutoDisposeProvider<({int quantity, int amount})>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartTotalRef = AutoDisposeProviderRef<({int quantity, int amount})>;
String _$cartHash() => r'7b7a99cdff648b5b20c835b6f0737740ff6876e1';

/// See also [Cart].
@ProviderFor(Cart)
final cartProvider = AutoDisposeNotifierProvider<Cart, List<CartItem>>.internal(
  Cart.new,
  name: r'cartProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Cart = AutoDisposeNotifier<List<CartItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
