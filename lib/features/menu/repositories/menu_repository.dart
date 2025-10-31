import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/menu_item_model.dart';

part 'menu_repository.g.dart';

@riverpod
class MenuRepository extends _$MenuRepository {
  @override
  AsyncValue<List<MenuItemModel>> build() {
    return AsyncValue.data(_getMockMenuItems());
  }

  Future<List<MenuItemModel>> getMenuItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _getMockMenuItems();
  }

  List<MenuItemModel> _getMockMenuItems() {
    return [
      MenuItemModel(
        id: '1',
        name: 'Espresso',
        description: 'Rich and bold espresso shot',
        price: 18000.0,
        category: 'Kopi',
        imageUrl: 'assets/coffee.jpg',
      ),
      MenuItemModel(
        id: '2',
        name: 'Cappuccino',
        description: 'Espresso topped with foamy milk and chocolate',
        price: 24000.0,
        category: 'Kopi',
        imageUrl: 'assets/coffee.jpg',
      ),
      MenuItemModel(
        id: '3',
        name: 'Green Tea Latte',
        description: 'Premium matcha green tea with steamed milk',
        price: 22000.0,
        category: 'Non-Kopi',
        imageUrl: 'assets/coffee.jpg',
      ),
      MenuItemModel(
        id: '4',
        name: 'Croissant',
        description: 'Buttery and flaky French pastry',
        price: 15000.0,
        category: 'Makanan Ringan',
        imageUrl: 'assets/coffee.jpg',
      ),
    ];
  }
}