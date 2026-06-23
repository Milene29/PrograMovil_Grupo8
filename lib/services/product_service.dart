import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';
import '../configs/generic_response.dart';
import '../models/category.dart';
import '../models/product.dart';

class ProductService {

  Future<GenericResponse<List<Category>>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/apis/v1/categories'),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      return GenericResponse.fromJson(
        json,
        fromJsonT: (data) => (data as List)
            .map((c) => Category.fromJson(c as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error de conexión',
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse<List<Product>>> fetchAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/apis/v1/products'),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      return GenericResponse.fromJson(
        json,
        fromJsonT: (data) => (data as List)
            .map((p) => Product.fromJson(p as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error de conexión',
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse<List<Product>>> fetchRecommended() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/apis/v1/products?recommended=true'),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      return GenericResponse.fromJson(
        json,
        fromJsonT: (data) => (data as List)
            .map((p) => Product.fromJson(p as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error de conexión',
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse<List<Product>>> fetchByCategory(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/apis/v1/products?category_id=$categoryId'),
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      return GenericResponse.fromJson(
        json,
        fromJsonT: (data) => (data as List)
            .map((p) => Product.fromJson(p as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error de conexión',
        error: e.toString(),
      );
    }
  }
}