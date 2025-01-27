import 'dart:convert';
import 'package:http/http.dart' as http;

//tanya chatgpt ini buat apa
class CHTTPHelper {
  static const String _baseUrl = 'http://localhost.com'; //ganti pake base URL API

  //helper buat GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
    );
    return _handleResponse(response);
  }

  //helper buat POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  //helper buat PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint;'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  //helper buat DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
    );
    return _handleResponse(response);
  }

  //handle HTTP responses
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: $response.statusCode');
    }
  }
}
