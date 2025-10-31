import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/menu_item_model.dart';
import '../repositories/menu_repository.dart';

part 'menu_view_model.g.dart';

@riverpod
class CategoryViewModel extends _$CategoryViewModel {
  static const List<String> categories = [
    'Semua',
    'Kopi',
    'Non-Kopi',
    'Makanan Ringan',
    'Promo Hari Ini'
  ];

  @override
  String build() => categories.first;

  void selectCategory(String category) => state = category;
}

@riverpod
class MenuViewModel extends _$MenuViewModel {
  @override
  AsyncValue<List<MenuItemModel>> build() {
    final menuItems = ref.watch(menuRepositoryProvider);
    final selectedCategory = ref.watch(categoryViewModelProvider);
    
    return menuItems.whenData((items) {
      if (selectedCategory == 'Semua') return items;
      return items.where((item) => item.category == selectedCategory).toList();
    });
  }

  Future<void> refreshMenuItems() async {
    state = const AsyncValue.loading();
    try {
      final items = await ref.read(menuRepositoryProvider.notifier).getMenuItems();
      state = AsyncValue.data(items);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}