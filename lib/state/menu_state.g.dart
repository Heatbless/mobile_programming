// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$menuStateHash() => r'6310be2ffd60a36c0bcf7b3ad4106dd7b304633f';

/// See also [MenuState].
@ProviderFor(MenuState)
final menuStateProvider =
    AutoDisposeNotifierProvider<MenuState, List<MenuItem>>.internal(
  MenuState.new,
  name: r'menuStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$menuStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MenuState = AutoDisposeNotifier<List<MenuItem>>;
String _$selectedCategoryHash() => r'b02742dc17d077e421986cda18c5141faf18fc45';

/// See also [SelectedCategory].
@ProviderFor(SelectedCategory)
final selectedCategoryProvider =
    AutoDisposeNotifierProvider<SelectedCategory, String>.internal(
  SelectedCategory.new,
  name: r'selectedCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCategory = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
