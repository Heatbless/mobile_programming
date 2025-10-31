class OrderItemModel {
  final String itemId;
  final String name;
  final int price;
  final int quantity;

  OrderItemModel({
    required this.itemId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      itemId: json['item_id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'name': name,
    'price': price,
    'quantity': quantity,
  };

  int get subtotal => price * quantity;
}