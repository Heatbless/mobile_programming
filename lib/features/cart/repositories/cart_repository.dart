import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

part 'cart_repository.g.dart';

@riverpod
class CartRepository extends _$CartRepository {
  final List<CartItem> _items = [];

  @override
List<CartItem> build() {
  _loadCart();
  return _items;
}

Future<void> _loadCart() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('cart');
  if (jsonString != null) {
    final decoded = jsonDecode(jsonString) as List;
    _items.clear();
    _items.addAll(decoded.map((e) => CartItem.fromJson(e)));
    state = List.from(_items);
  }
}

Future<void> _saveCart() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(_items.map((e) => e.toJson()).toList());
  await prefs.setString('cart', jsonString);
}


  void addItem(CartItem item) {
  final existingIndex = _items.indexWhere((i) => i.id == item.id);
  if (existingIndex != -1) {
    _items[existingIndex] = _items[existingIndex].copyWith(
      quantity: _items[existingIndex].quantity + item.quantity,
    );
  } else {
    _items.add(item);
  }
  state = List.from(_items);
  // Persist updated cart
  _saveCart();
}


  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    state = List.from(_items);
    _saveCart();
  }

  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      final updatedItems = List<CartItem>.from(_items);
      if (quantity > 0) {
        updatedItems[index] = _items[index].copyWith(quantity: quantity);
      } else {
        updatedItems.removeAt(index);
      }
      state = updatedItems;
      _items
        ..clear()
        ..addAll(updatedItems);
      _saveCart();
    }
  }

  void clear() {
    _items.clear();
    state = [];
    _saveCart();
  }

  int get total => state.fold(0, (sum, item) => sum + (item.price * item.quantity));

}