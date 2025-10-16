import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/menu_item.dart';

part 'menu_state.g.dart';

@riverpod
class MenuState extends _$MenuState {
  final List<MenuItem> menuItems = [
    // Kopi
    MenuItem(
      id: 'coffee-1',
      name: 'Kopi Susu Gula Aren',
      price: 25000,
      imagePath: 'assets/coffee/kopi_susu.jpg',
      category: 'Kopi',
      description: 'Kopi susu dengan gula aren asli',
    ),
    MenuItem(
      id: 'coffee-2',
      name: 'Americano',
      price: 23000,
      imagePath: 'assets/coffee/americano.jpg',
      category: 'Kopi',
      description: 'Espresso dengan air panas',
    ),
    MenuItem(
      id: 'coffee-3',
      name: 'Cappuccino',
      price: 28000,
      imagePath: 'assets/coffee/cappuccino.jpg',
      category: 'Kopi',
      description: 'Espresso dengan steamed milk dan foam susu',
    ),
    MenuItem(
      id: 'coffee-4',
      name: 'Cafe Latte',
      price: 28000,
      imagePath: 'assets/coffee/cafe_latte.jpg',
      category: 'Kopi',
      description: 'Espresso dengan steamed milk',
    ),
    // Non-Kopi
    MenuItem(
      id: 'non-coffee-1',
      name: 'Matcha Latte',
      price: 28000,
      imagePath: 'assets/non_coffee/matcha.jpg',
      category: 'Non-Kopi',
      description: 'Green tea dengan susu',
    ),
    MenuItem(
      id: 'non-coffee-2',
      name: 'Hot Chocolate',
      price: 25000,
      imagePath: 'assets/non_coffee/hot_chocolate.jpg',
      category: 'Non-Kopi',
      description: 'Coklat panas dengan whipped cream',
    ),
    MenuItem(
      id: 'non-coffee-3',
      name: 'Thai Tea',
      price: 23000,
      imagePath: 'assets/non_coffee/thai_tea.jpg',
      category: 'Non-Kopi',
      description: 'Teh Thailand dengan susu',
    ),
    // Makanan Ringan
    MenuItem(
      id: 'food-1',
      name: 'Croissant',
      price: 20000,
      imagePath: 'assets/food/croissant.jpg',
      category: 'Makanan Ringan',
      description: 'Croissant butter original',
    ),
    MenuItem(
      id: 'food-2',
      name: 'Chocolate Muffin',
      price: 18000,
      imagePath: 'assets/food/muffin.jpg',
      category: 'Makanan Ringan',
      description: 'Muffin coklat dengan choco chips',
    ),
    MenuItem(
      id: 'food-3',
      name: 'Sandwich',
      price: 25000,
      imagePath: 'assets/food/sandwich.jpg',
      category: 'Makanan Ringan',
      description: 'Sandwich dengan ham dan keju',
    ),
    // Promo
    MenuItem(
      id: 'promo-1',
      name: 'Paket Sarapan',
      price: 35000,
      imagePath: 'assets/promo/breakfast.jpg',
      category: 'Promo Hari Ini',
      description: 'Kopi + Croissant',
    ),
    MenuItem(
      id: 'promo-2',
      name: 'Happy Hour Coffee',
      price: 20000,
      imagePath: 'assets/promo/happy_hour.jpg',
      category: 'Promo Hari Ini',
      description: 'Diskon 20% untuk semua kopi (2PM - 5PM)',
    ),
  ];

  @override
  List<MenuItem> build() {
    return menuItems;
  }

  List<MenuItem> getItemsByCategory(String category) {
    if (category == 'Semua') return state;
    return state.where((item) => item.category == category).toList();
  }
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String build() {
    return 'Semua';
  }

  void select(String category) {
    state = category;
  }
}