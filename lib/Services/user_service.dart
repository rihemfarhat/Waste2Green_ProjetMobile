import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String baseUrl = 'http://localhost:5000/api/users';
  static const String USER_KEY = 'user_data';
  static const String TOKEN_KEY = 'auth_token';

  static Future<void> updateProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      final prefs = await SharedPreferences.getInstance();
      final userData = json.decode(prefs.getString(USER_KEY) ?? '{}');
      userData['profilePicture'] = image.path;
      await prefs.setString(USER_KEY, json.encode(userData));
    }
  }

  static Future<void> updateUsername(String newUsername) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.decode(prefs.getString(USER_KEY) ?? '{}');
    userData['username'] = newUsername;
    await prefs.setString(USER_KEY, json.encode(userData));
  }

  static Future<void> updateEmail(String newEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.decode(prefs.getString(USER_KEY) ?? '{}');
    userData['email'] = newEmail;
    await prefs.setString(USER_KEY, json.encode(userData));
  }

  static Future<void> updatePassword(String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.decode(prefs.getString(USER_KEY) ?? '{}');
    userData['password'] = newPassword;
    await prefs.setString(USER_KEY, json.encode(userData));
  }

  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Supprimer toutes les données de l'utilisateur
      await prefs.remove(USER_KEY);
      await prefs.remove(TOKEN_KEY);
      await prefs.clear(); // Nettoyer toutes les données stockées
      print('Logout successful');
    } catch (e) {
      print('Error during logout: $e');
      throw Exception('Failed to logout');
    }
  }
} 