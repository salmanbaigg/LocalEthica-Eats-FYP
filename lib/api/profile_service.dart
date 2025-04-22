import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  // Example URL for API call to fetch user profile
  static const String _profileUrl = 'https://yourapi.com/api/profile';

  // Fetch Profile Data
  static Future<Map<String, dynamic>> fetchProfile() async {
    final response = await http.get(Uri.parse(_profileUrl));

    if (response.statusCode == 200) {
      // Parse the JSON data and return as a Map
      return json.decode(response.body);
    } else {
      // If the server doesn't return a 200 OK response, throw an exception
      throw Exception('Failed to load profile');
    }
  }
}
