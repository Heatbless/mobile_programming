import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_state.g.dart';

// Model for Cart Item
class CartItem {
  final String id;
  final String name;
  final int price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

@riverpod
class Cart extends _$Cart {
  @override
  List<CartItem> build() {
    return [];
  }

  void addItem(String id, String name, int price) {
    final existingItemIndex = state.indexWhere((item) => item.id == id);

    if (existingItemIndex != -1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingItemIndex)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(id: id, name: name, price: price)];
    }
  }

  void updateItemQuantity(String id, int quantity) {
    if (quantity <= 0) {
      removeItem(id);
      return;
    }

    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(quantity: quantity) else item
    ];
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void clearCart() {
    state = [];
  }
}

// Add cart totals provider
@riverpod
({int quantity, int amount}) cartTotal(CartTotalRef ref) {
  final cart = ref.watch(cartProvider);
  return (
    quantity: cart.fold(0, (sum, item) => sum + item.quantity),
    amount: cart.fold(0, (sum, item) => sum + (item.price * item.quantity))
  );
}

