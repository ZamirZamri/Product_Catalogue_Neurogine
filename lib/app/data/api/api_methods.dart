import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constant.dart';
import 'api_models/product_model.dart';
import 'api_models/product_response_model.dart';

class ApiMethods {
  // 1. Get paginated product list
  static Future<ProductResponseModel> getProducts({int limit = 20, int skip = 0}) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/products?limit=$limit&skip=$skip'));
    
    if (response.statusCode == 200) {
      return ProductResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load products. Status Code: ${response.statusCode}');
    }
  }

  // 2. Search products (Also supports pagination!)
  static Future<ProductResponseModel> searchProducts(String query, {int limit = 20, int skip = 0}) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/products/search?q=$query&limit=$limit&skip=$skip'));
    
    if (response.statusCode == 200) {
      return ProductResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Search failed. Status Code: ${response.statusCode}');
    }
  }

  // 3. Get a single product's details
  static Future<ProductModel> getProductDetail(int id) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/products/$id'));
    
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }
}