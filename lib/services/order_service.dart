import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/constants.dart';
import '../configs/generic_response.dart';

class OrderService {
  Future<Map<String, String>> _buildHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<GenericResponse<Map<String, dynamic>>> createOrder({
    required List<Map<String, dynamic>> items,
    String status = 'listo',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/apis/v1/orders'),
        headers: await _buildHeaders(),
        body: jsonEncode({
          'items': items,
          'status': status,
        }),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 201 || response.statusCode == 200) {
        return GenericResponse.fromJson(
          json,
          fromJsonT: (data) => data as Map<String, dynamic>,
        );
      } else {
        return GenericResponse(
          success: false,
          message: json['message'] ?? 'Error al crear la orden',
          error: json['error'],
        );
      }
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error de conexión',
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse<List<Map<String, dynamic>>>> getMyOrders() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/apis/v1/orders'),
        headers: await _buildHeaders(),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return GenericResponse.fromJson(
          json,
          fromJsonT: (data) => (data as List)
              .map((o) => o as Map<String, dynamic>)
              .toList(),
        );
      } else {
        return GenericResponse(
          success: false,
          message: json['message'] ?? 'Error al obtener órdenes',
          error: json['error'],
        );
      }
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error de conexión',
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse<Map<String, dynamic>>> getOrderById(int orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/apis/v1/orders/$orderId'),
        headers: await _buildHeaders(),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return GenericResponse.fromJson(
          json,
          fromJsonT: (data) => data as Map<String, dynamic>,
        );
      } else {
        return GenericResponse(
          success: false,
          message: json['message'] ?? 'Orden no encontrada',
          error: json['error'],
        );
      }
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error de conexión',
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse<Map<String, dynamic>>> updateOrderStatus({
    required int orderId,
    required String status,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/apis/v1/orders/$orderId/status'),
        headers: await _buildHeaders(),
        body: jsonEncode({'status': status}),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return GenericResponse.fromJson(
          json,
          fromJsonT: (data) => data as Map<String, dynamic>,
        );
      } else {
        return GenericResponse(
          success: false,
          message: json['message'] ?? 'Error al actualizar orden',
          error: json['error'],
        );
      }
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error de conexión',
        error: e.toString(),
      );
    }
  }
}
