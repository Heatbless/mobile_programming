import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

part 'cart_view_model.g.dart';

@riverpod
class CartViewModel extends _$CartViewModel {
  @override
  List<CartItem> build() {
    // Mirror repository state so this view-model always reflects stored cart items.
    // When the CartRepository's state changes, this build will re-run and the
    // notifier's state will be updated accordingly.
    return ref.watch(cartRepositoryProvider);
  }

  void addToCart(CartItem item) {
    ref.read(cartRepositoryProvider.notifier).addItem(item);
  }

  void removeFromCart(String id) {
    ref.read(cartRepositoryProvider.notifier).removeItem(id);
  }

  void updateQuantity(String id, int quantity) {
    ref.read(cartRepositoryProvider.notifier).updateQuantity(id, quantity);
  }

  void clearCart() {
    ref.read(cartRepositoryProvider.notifier).clear();
  }

  int get total => ref.read(cartRepositoryProvider.notifier).total;

  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);
}