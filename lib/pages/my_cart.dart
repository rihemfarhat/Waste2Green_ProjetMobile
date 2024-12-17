import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'BuyPage.dart';
import 'order_validation_page.dart';

void main() {
  runApp(const MyCart());
}

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Cart',
      theme: ThemeData(
        primaryColor: const Color(0xFF6A994E),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: CartPage(),
      routes: {
        '/home': (context) => BuyPage(),
        '/my_cart': (context) => CartPage(),
        '/profile': (context) => const ProfilePage(),
        // Add other routes as needed
      },
    );
  }
}

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartManager _cartManager = CartManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: Color(0xFF6A994E),
      ),
      body: _cartManager.cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty'),
            )
          : ListView.builder(
              itemCount: _cartManager.cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartManager.cartItems[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.asset(
                      item['imagePath']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']!),
                    subtitle: Text('${item['weight']} - ${item['price']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _cartManager.removeFromCart(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: _cartManager.cartItems.isEmpty
          ? null
          : Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total: ${_cartManager.total.toStringAsFixed(2)} dt',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderValidationPage(
                            total: _cartManager.total,
                          ),
                        ),
                      );
                    },
                    child: Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6A994E),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF6A994E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFooterIcon(Icons.home, Color(0xffbc4749), '/home', context),
          _buildFooterIcon(Icons.star, Color(0xffbc4749), '/rewards', context),
          _buildFooterIcon(Icons.add, Color(0xffbc4749), '/sell', context),
          _buildFooterIcon(Icons.shopping_cart, Color(0xffbc4749), '/my_cart', context),
          _buildFooterIcon(Icons.person, Color(0xffbc4749), '/profile', context),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, Color iconColor, String routePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (ModalRoute.of(context)?.settings.name != routePath) {
          Navigator.pushNamed(context, routePath);
        }
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
