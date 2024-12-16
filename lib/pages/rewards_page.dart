import 'package:flutter/material.dart';
import 'my_cart.dart';
import 'profile_page.dart';
import 'SellPage.dart';
import 'BuyPage.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

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
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 60, // Reduced size
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF2E8CF), // Background color
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Discover Your Rewards',
                    style: TextStyle(
                      fontSize: 16, // Reduced font size
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A994E),
                    ),
                  ),
                  SizedBox(height: 4), // Reduced spacing
                  Text(
                    '🌟🌟🌟🌟🌟🌟',
                    style: TextStyle(fontSize: 14), // Adjusted text size
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildRewardCard(
                    'Free Shipping',
                    'Buy 50 kg of food waste or more in a single order: Free home delivery.',
                    'assets/images/shipping.jpg',
                    context,
                  ),
                  _buildRewardCard(
                    '20% Discount',
                    'Buy 100 kg of food waste or more in a single order: Get a 20% discount on your purchases.',
                    'assets/images/discount.jpg',
                    context,
                  ),
                  _buildRewardCard(
                    'Exclusive Access',
                    'Get exclusive access to upcoming sales.',
                    'assets/images/exclusive.jpg', // Example image for access
                    context,
                  ),
                  _buildRewardCard(
                    'Gift Voucher',
                    'Claim a 5TND gift voucher to spend on your next purchase.',
                    'assets/images/voucher.jpg', // Example image for voucher
                    context,
                  ),
                  SizedBox(height: 4),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF2E8CF), // Button background color
                        fixedSize: Size(400, 60), // Fixed size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Rounded button
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding
                      ),
                      child: Text(
                        'View My Points',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6A994E), // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }

  // Helper method to create individual reward cards
  Widget _buildRewardCard(String title, String description, String imagePath, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Spacing between cards
      elevation: 5, // Shadow effect for card
      color: const Color(0xFFA7C957), // Background color for the reward card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reward image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12), // Space between image and title
            // Title of the reward
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A994E), // Green color for title
              ),
            ),
            const SizedBox(height: 8), // Space between title and description
            // Description of the reward
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54, // Slightly lighter black color
              ),
            ),
            const SizedBox(height: 16), // Space before the button
            // Button to claim the reward
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reward claimed!')), // Confirmation message
                );
              },
              child: const Text(
                'Claim Reward',
                style: TextStyle(
                  color: Color(0xffbc4749), // Text color as specified
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2E8CF), // Background color for the button
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Rounded button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Footer widget for navigation
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
        Navigator.pushNamed(context, routePath);
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: iconColor, // Icon color
        ),
      ),
    );
  }
}
