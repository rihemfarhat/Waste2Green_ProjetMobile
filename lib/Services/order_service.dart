import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  static const String ORDERS_KEY = 'local_orders';

  static Future<Map<String, dynamic>> createOrder({
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> deliveryAddress,
    required String paymentMethod,
    required String token,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Créer la nouvelle commande
      final order = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'items': items,
        'deliveryAddress': deliveryAddress,
        'paymentMethod': paymentMethod,
        'orderDate': DateTime.now().toIso8601String(),
        'status': 'placed',
        'paymentStatus': 'completed',
      };

      // Récupérer les commandes existantes
      final existingOrdersJson = prefs.getString(ORDERS_KEY) ?? '[]';
      final List<dynamic> existingOrders = json.decode(existingOrdersJson);
      
      // Ajouter la nouvelle commande
      existingOrders.add(order);
      
      // Sauvegarder les commandes
      await prefs.setString(ORDERS_KEY, json.encode(existingOrders));

      return {
        'success': true,
        'message': 'Order created successfully',
        'data': order,
      };
    } catch (e) {
      print('Error creating order: $e');
      return {
        'success': false,
        'message': 'Failed to create order: ${e.toString()}',
      };
    }
  }

  static Future<List<Map<String, dynamic>>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getString(ORDERS_KEY) ?? '[]';
    final List<dynamic> orders = json.decode(ordersJson);
    return List<Map<String, dynamic>>.from(orders);
  }
} 