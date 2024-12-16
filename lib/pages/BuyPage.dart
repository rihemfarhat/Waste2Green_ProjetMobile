import 'package:flutter/material.dart';
import 'my_cart.dart';
import 'profile_page.dart';
import 'rewards_page.dart';
import 'SellPage.dart';

class BuyPage extends StatelessWidget {
  final List<Map<String, String>> products = [
    {"name": "Peels and Food Scraps", "weight": "3kg", "price": "5dt"},
    {"name": "Coffee Waste", "weight": "2kg", "price": "4dt"},
    {"name": "Meat and Seafood Waste", "weight": "1kg", "price": "3dt"},
    {"name": "Cooked Food Waste", "weight": "5kg", "price": "15dt"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E8CF),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Color(0xffbc4749)),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xffbc4749)),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.green[50],
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green[50],
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Color(0xFF6A994E),
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Color(0xFF6A994E)),
                title: Text('Home', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BuyPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, color: Color(0xFF6A994E)),
                title: Text('Cart', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Color(0xFF6A994E)),
                title: Text('Profile', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF2E8CF),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for products',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                        Icon(Icons.search, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Products",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        String imagePath;
                        switch (product['name']) {
                          case "Peels and Food Scraps":
                            imagePath = 'assets/image_3.jpg';
                            break;
                          case "Coffee Waste":
                            imagePath = 'assets/image_6.jpg';
                            break;
                          case "Meat and Seafood Waste":
                            imagePath = 'assets/image_5.jpg';
                            break;
                          case "Cooked Food Waste":
                            imagePath = 'assets/image_4.jpg';
                            break;
                          default:
                            imagePath = 'assets/default_image.jpg';
                        }
                        return ProductCard(
                          name: product['name']!,
                          weight: product['weight']!,
                          price: product['price']!,
                          imagePath: imagePath,
                          onAdd: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Container(
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
            _buildFooterIcon(Icons.home, const Color(0xffbc4749), '/home', context),
            _buildFooterIcon(Icons.star, const Color(0xffbc4749), '/rewards', context),
            _buildFooterIcon(Icons.add, const Color(0xffbc4749), '/sell', context),
            _buildFooterIcon(Icons.shopping_cart, const Color(0xffbc4749), '/my_cart', context),
            _buildFooterIcon(Icons.person, const Color(0xffbc4749), '/profile', context),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, Color iconColor, String routePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routePath);
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

class ProductCard extends StatelessWidget {
  final String name;
  final String weight;
  final String price;
  final String imagePath;
  final VoidCallback onAdd;

  ProductCard({
    required this.name,
    required this.weight,
    required this.price,
    required this.imagePath,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFA7C957),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFA7C957), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text("$weight - $price"),
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}
