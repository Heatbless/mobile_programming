// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryViewModelHash() => r'418bdcef88d99e92f03c42135040408a2765a38c';

/// See also [CategoryViewModel].
@ProviderFor(CategoryViewModel)
final categoryViewModelProvider =
    AutoDisposeNotifierProvider<CategoryViewModel, String>.internal(
  CategoryViewModel.new,
  name: r'categoryViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoryViewModel = AutoDisposeNotifier<String>;
String _$menuViewModelHash() => r'92a380bfeb7959995ed4a8a3e361371938b5dee2';

/// See also [MenuViewModel].
@ProviderFor(MenuViewModel)
final menuViewModelProvider = AutoDisposeNotifierProvider<MenuViewModel,
    AsyncValue<List<MenuItemModel>>>.internal(
  MenuViewModel.new,
  name: r'menuViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$menuViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MenuViewModel = AutoDisposeNotifier<AsyncValue<List<MenuItemModel>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
