import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'BuyPage.dart';

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
      home: const CartPage(),
      routes: {
        '/home': (context) => BuyPage(),
        '/my_cart': (context) => const CartPage(),
        '/profile': (context) => const ProfilePage(),
        // Add other routes as needed
      },
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> quantities = [2, 4];

  void _incrementQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A994E),
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: quantities.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          index == 0
                              ? 'assets/image_2.jpg'
                              : 'assets/image_3.jpg',
                        ),
                      ),
                      title: Text(index == 0 ? 'Coffee Waste' : 'Organic Waste'),
                      subtitle: const Text('1kg - 1 dt'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Color(0xffbc4749)),
                            onPressed: () => _decrementQuantity(index),
                          ),
                          Text(
                            '${quantities[index]}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle, color: Color(0xffbc4749)),
                            onPressed: () => _incrementQuantity(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A994E),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                // Handle "Next" button press
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  color: Color(0xFFF2E8CF),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
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
