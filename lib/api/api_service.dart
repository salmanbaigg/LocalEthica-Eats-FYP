import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';

  // Public headers used in all requests
  static const Map<String, String> commonHeaders = {
    'Content-Type': 'application/json',
  };

  // Public method to get Authorization headers with the token
  static Map<String, String> getAuthorizationHeaders(String token) {
    return {
      ...commonHeaders,
      'Authorization': 'Bearer $token',
    };
  }

  // Register User
  Future<Map<String, dynamic>> registerUser(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: commonHeaders,
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return json.decode(response.body); // Successful response
      } else {
        final errorData = json.decode(response.body);
        throw Exception('Failed to register user: ${errorData['message']}');
      }
    } catch (e) {
      throw Exception('Error occurred during registration: $e');
    }
  }

  // Get user profile
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: getAuthorizationHeaders(token),
      ).timeout(const Duration(seconds: 10));

      print('Response Body: ${response.body}'); // Print raw response for debugging

      if (response.statusCode == 200) {
        return json.decode(response.body); // Successful response
      } else {
        final errorData = json.decode(response.body);
        throw Exception('Failed to load profile: ${errorData['message']}');
      }
    } catch (e) {
      throw Exception('Error occurred while loading profile: $e');
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(String name, String email, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/profile'),
        headers: getAuthorizationHeaders(token),
        body: json.encode({'name': name, 'email': email}),
      ).timeout(const Duration(seconds: 10));

      print('Response Body: ${response.body}'); // Print raw response for debugging

      if (response.statusCode == 200) {
        return true; // Successful update
      } else {
        final errorData = json.decode(response.body);
        throw Exception('Failed to update profile: ${errorData['message']}');
      }
    } catch (e) {
      throw Exception('Error occurred while updating profile: $e');
    }
  }
}
