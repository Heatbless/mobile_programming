import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/app_config.dart';

class Order {
  final String id;
  final String date;
  final String status;
  final int total;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      total: json['total'] as int,
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'status': status,
        'total': total,
        'items': items.map((item) => item.toJson()).toList(),
      };
}

class OrderItem {
  final String id;
  final String name;
  final int price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
      };
}

class ApiService {
  static String get baseUrl => AppConfig.apiUrl;

  Future<List<Order>> getOrders() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/orders'));
      
      if (response.statusCode == 200) {
        final List<dynamic> ordersJson = jsonDecode(response.body);
        return ordersJson.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> createOrder(Map<String, dynamic> orderData) async {
    try {
  final url = Uri.parse('$baseUrl/api/orders');
      print('Attempting to connect to: $url'); // Debug print

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(orderData),
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode != 201) {
        throw Exception(
          'Server error (${response.statusCode}): ${response.body}',
        );
      }
    } catch (e) {
      print('Error details: $e'); // Debug print
      if (e is http.ClientException) {
        throw Exception('Network error: Unable to connect to $baseUrl');
      }
      rethrow;
    }
  }
}