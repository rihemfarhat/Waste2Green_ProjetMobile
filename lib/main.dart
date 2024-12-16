import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';  // Import Stripe package
import '/pages/my_cart.dart' as MyCart;  // Import MyCart page
import '/pages/profile_page.dart' as ProfilePage;  // Import ProfilePage with a prefix
import '/pages/payment_page.dart';
import '/pages/order_history_page.dart';
import '/pages/rewards_page.dart' as RewardsPage;
import '/pages/my_store.dart';
import '/pages/SellPage.dart';
import '/pages/SettingsPage.dart' as SettingsPage;
import '/pages/SplashPage.dart';
import '/pages/BuyPage.dart';


void main() {
  // Initialize Stripe with your publishable key from your Stripe account
  Stripe.publishableKey = 'your-publishable-key';  // Use your actual Stripe publishable key

  runApp(const Waste2GreenApp());
}

class Waste2GreenApp extends StatelessWidget {
  const Waste2GreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
      title: 'Waste2Green App',
      initialRoute: '/profile',  // Set the initial route to '/profile'
      routes: {
        '/profile': (context) => const ProfilePage.ProfilePage(),  // Route for Profile Page with prefix
        '/payment': (context) => const PaymentPage(),  // Route for Payment Page
        '/order_history': (context) => const OrderhistoryPage(),  // Route for Order History Page
        '/my_cart': (context) => const MyCart.MyCart(),
        '/rewards': (context) => const RewardsPage.RewardsPage(),
        '/store': (context) => const MyStorePage(),
        '/settings': (context) => const SettingsPage.SettingsPage(),
        '/home': (context) => BuyPage(),
        '/sell': (context) => SellPage(),

      },
      theme: ThemeData(
        primarySwatch: Colors.green,  // Set the primary color to green
      ),
    );
  }
}





