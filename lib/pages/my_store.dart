import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'my_cart.dart';
import 'BuyPage.dart';

class MyStorePage extends StatelessWidget {
  const MyStorePage({super.key});

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
                    MaterialPageRoute(builder: (context) => MyCart()),
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
      body: Container(
        color: const Color(0xFFF2E8CF),  // Set the background color for the entire body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildItemSection(),
            const Spacer(),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // Profile Header section
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF6A994E), // Green background
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile.jpg'), // Use your actual image
          ),
          SizedBox(height: 10),
          Text(
            'Ahmed Haded',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '125 points',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 15),
          // Center the articles, subscribers, and subscriptions
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the items horizontally
            children: [
              _ProfileStats(title: '15 Articles'),
              _ProfileStats(title: '23 Subscribers'),
              _ProfileStats(title: '67 Subscriptions'),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Looking for great deals?\nCheck out my feed.\nSatisfaction guaranteed or your money back!',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Item section with Available, Sold, and Opinion
  Widget _buildItemSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ItemCategory(title: 'Available (14)', color: Color(0xffbc4749)),
              _ItemCategory(title: 'Sold (0)', color: Color(0xffbc4749)),
              _ItemCategory(title: 'Opinion (0)', color: Color(0xffbc4749)),
            ],
          ),
          SizedBox(height: 20),
          // Sample items for the store
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ItemCard(price: '15 dt', description: 'High-quality product, ready for use', image: 'assets/image_4.jpg'),
              _ItemCard(price: '20 dt', description: 'Affordable and reliable item', image: 'assets/image_5.jpg'),
            ],
          ),
        ],
      ),
    );
  }

  // Footer navigation bar with icons
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
        // Navigate to the specified route when the icon is tapped
        Navigator.pushNamed(context, routePath);
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: iconColor,  // Assign the color here
        ),
      ),
    );
  }
}

// Profile stats widget
class _ProfileStats extends StatelessWidget {
  final String title;
  const _ProfileStats({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Item category widget (Available, Sold, Opinion)
class _ItemCategory extends StatelessWidget {
  final String title;
  final Color color; // Fixed this part
  const _ItemCategory({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

// Item card widget (each product)
class _ItemCard extends StatelessWidget {
  final String price;
  final String description;
  final String image;
  const _ItemCard({required this.price, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 250, // Increased height to accommodate the description
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image, // Dynamic image based on the passed parameter
            fit: BoxFit.cover,
            height: 100, // Adjusted height for the image
          ),
          const SizedBox(height: 10),
          Text(
            price,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
