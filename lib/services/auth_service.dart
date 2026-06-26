import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl =
      'http://10.0.2.2:5000/apis/v1/users';

  static Future<bool> validarCodigo(String codigo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/validate-code'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'codigo': codigo,
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> login({
    required String codigo,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'codigo': codigo,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}