import 'package:flutter/material.dart';
import 'my_cart.dart';
import 'BuyPage.dart';
import 'profile_page.dart';

class OrderhistoryPage extends StatelessWidget {
  const OrderhistoryPage({super.key});

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
      backgroundColor: const Color(0xFFF2E8CF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20), // Add space before the footer
              _buildOrderDetailsSection(),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  // Order Details Section
  Widget _buildOrderDetailsSection() {
    return Container(
      color: const Color(0xFFF2E8CF), // Order Details section color
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle('Order details'),
          _buildOrderItem(
            title: 'Coffee Waste',
            subtitle: '2kg - 1.5 dt',
            color: Color(0xFFF2E8CF),
            imageUrl: 'assets/image_6.jpg',
          ),
          const SizedBox(height: 8.0),
          _buildOrderItem(
            title: 'Banana Peels',
            subtitle: '5kg - 2.0 dt',
            color: Color(0xFFF2E8CF),
            imageUrl: 'assets/image_7.jpg',
          ),
          const SizedBox(height: 16.0),
          _buildSectionTitle('Delivered to'),
          _buildEditableDetail('Technopole el Ghazela, Ariana'),
          const SizedBox(height: 16.0),
          _buildSectionTitle('Pick up Details'),
          _buildEditableDetail('Pick-up time: 5:30 AM'),
          _buildEditableDetail('Pick-up date: Thursday 29.11.2024'),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () {},
            child: const Text(
              '+ Add new order',
              style: TextStyle(
                color: Color(0xFF6A994E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A994E),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {},
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Color(0xffbc4749),
      ),
    );
  }

  Widget _buildOrderItem({required String title, required String subtitle, required String imageUrl, required Color color}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      color: const Color(0xFFA7C957), // Red container color
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl), // Local image
          radius: 30.0,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildEditableDetail(String detail) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            detail,
            style: const TextStyle(fontSize: 14.0),
          ),
          const Icon(
            Icons.edit,
            color: Color(0xFF6A994E),
          ),
        ],
      ),
    );
  }

  // Footer navigation bar with icons
  Widget _buildFooter(BuildContext context) {
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
