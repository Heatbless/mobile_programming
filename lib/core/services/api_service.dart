import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_service.g.dart';

@riverpod
ApiService apiService(ApiServiceRef ref) => ApiService();

class ApiService {
  static String get baseUrl => AppConfig.apiUrl;
  
  Future<void> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Server error (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Network error: Unable to connect to $baseUrl');
      }
      rethrow;
    }
  }

  Future<T> get<T>(String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      
      if (response.statusCode == 200) {
        return fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<List<T>> getList<T>(String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> post<T>(String endpoint, T data, {Map<String, String>? headers}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final body = jsonEncode(data);

      // Debug: print the full request payload and url to help diagnose server errors
      // ignore: avoid_print
      print('POST $url');
      // ignore: avoid_print
      print('Request headers: ${{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      }}');
      // ignore: avoid_print
      print('Request body: $body');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
        body: body,
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        // include body in exception so UI can show server details
        throw Exception('Server error (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Network error: Unable to connect to $baseUrl');
      }
      // ignore: avoid_print
      print('Post request error: $e');
      rethrow;
    }
  }
}