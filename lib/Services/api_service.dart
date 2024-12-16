import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://yourapiurl.com"; // Replace with your API URL

  // Generic method to fetch data from a specified endpoint
  Future<dynamic> fetchData(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Assuming JSON response
      } else {
        throw Exception('Failed to load data from $endpoint');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Method to fetch user profile
  Future<Map<String, dynamic>> fetchUserProfile(String userId) async {
    final String endpoint = 'user/profile/$userId';
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Assuming the response is a JSON map
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Method to update notifications
  Future<bool> updateNotifications(String userId, bool isEnabled) async {
    final String endpoint = 'user/notifications';
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'notificationsEnabled': isEnabled}),
      );
      return response.statusCode == 200; // Return true if successful
    } catch (e) {
      rethrow;
    }
  }
}
