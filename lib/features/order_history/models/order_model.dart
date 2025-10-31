import 'package:flutter/material.dart';
import '../../menu/models/menu_item_model.dart';

enum OrderStatus {
  pending,
  processing,
  completed,
  cancelled;

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Menunggu';
      case OrderStatus.processing:
        return 'Diproses';
      case OrderStatus.completed:
        return 'Selesai';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }
}

class OrderItemModel {
  final MenuItemModel item;
  final int quantity;
  final double subtotal;

  OrderItemModel({
    required this.item,
    required this.quantity,
    required this.subtotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    // Support two possible shapes coming from the backend:
    // 1) { "item": { ...menu item... }, "quantity": x, "subtotal": y }
    // 2) { "id": "itemId", "name": "...", "price": 123, "quantity": x }
    final itemJson = json['item'];
    MenuItemModel item;
    if (itemJson != null && itemJson is Map<String, dynamic>) {
      item = MenuItemModel.fromJson(itemJson);
    } else {
      // Build a MenuItemModel from flat fields if the backend returns a flattened item
      final priceVal = (json['price'] ?? json['unit_price'] ?? 0) as num;
      item = MenuItemModel(
        id: ((json['id'] ?? json['item_id'] ?? '')).toString(),
        name: ((json['name'] ?? '')).toString(),
        description: json['description'] as String?,
        price: priceVal.toDouble(),
        imageUrl: json['imageUrl'] as String?,
        category: (json['category'] ?? 'default') as String,
        isAvailable: json['isAvailable'] as bool? ?? true,
      );
    }

    final quantityVal = json['quantity'] ?? json['qty'] ?? 0;
    final quantity = (quantityVal is int) ? quantityVal : int.tryParse(quantityVal.toString()) ?? 0;
    final subtotalVal = json['subtotal'] ?? (json['price'] != null ? (json['price'] as num) * quantity : 0);
    final subtotal = (subtotalVal is num) ? subtotalVal.toDouble() : double.tryParse(subtotalVal.toString()) ?? 0.0;

    return OrderItemModel(
      item: item,
      quantity: quantity,
      subtotal: subtotal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }
}

class OrderModel {
  final String id;
  final DateTime orderDate;
  final List<OrderItemModel> items;
  final OrderStatus status;
  final double total;
  final String? notes;

  OrderModel({
    required this.id,
    required this.orderDate,
    required this.items,
    required this.status,
    required this.total,
    this.notes,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // Helper to safely extract string-like values
    String _string(dynamic v) {
      if (v == null) return '';
      if (v is String) return v;
      return v.toString();
    }

    final idVal = json['id'] ?? json['order_id'] ?? json['orderId'];
    final id = _string(idVal);

    // Support both 'orderDate' and 'date' keys from different backends
    final dateStr = json['orderDate'] ?? json['date'] ?? json['created_at'];
    DateTime orderDate;
    if (dateStr == null) {
      orderDate = DateTime.now();
    } else {
      try {
        orderDate = DateTime.parse(dateStr as String);
      } catch (_) {
        // fallback: try parsing numeric timestamp or use now
        if (dateStr is num) {
          orderDate = DateTime.fromMillisecondsSinceEpoch(dateStr.toInt());
        } else {
          orderDate = DateTime.now();
        }
      }
    }

    final itemsRaw = json['items'] as List<dynamic>? ?? <dynamic>[];
    final items = itemsRaw
        .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
        .toList();

    final statusStr = json['status'] as String? ?? '';
    final status = OrderStatus.values.firstWhere(
      (s) => s.name == statusStr || s.displayName == statusStr,
      orElse: () => OrderStatus.pending,
    );

    final totalNum = json['total'] ?? json['grand_total'] ?? items.fold<double>(0.0, (s, it) => s + it.subtotal);
    final total = (totalNum is num) ? totalNum.toDouble() : double.tryParse(totalNum.toString()) ?? 0.0;

    return OrderModel(
      id: id,
      orderDate: orderDate,
      items: items,
      status: status,
      total: total,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderDate': orderDate.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'status': status.name,
      'total': total,
      'notes': notes,
    };
  }
}