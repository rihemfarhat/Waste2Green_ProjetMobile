import 'package:flutter/material.dart';
import '../Services/api_service.dart';
import 'BuyPage.dart';
import 'my_cart.dart';
import 'SettingsPage.dart';
import 'order_history_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Haded Ahmed";
  String userProfileImage = "assets/images/profile.jpg"; // Default image
  int userRating = 0;
  bool notificationsEnabled = true;
  bool isLoading = true;

  Future<void> _fetchUserData() async {
    try {
      final apiService = ApiService();
      final data = await apiService.fetchUserProfile("user123");
      if (mounted) {
        setState(() {
          userName = data['name'] ?? "User Name";
          userProfileImage = data['profileImage'] ?? "assets/images/profile.jpg";
          userRating = data['rating'] ?? 0;
          notificationsEnabled = data['notificationsEnabled'] ?? true;
          isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching user data: $error")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20), // Space above the profile section
              _buildUserProfileSection(),
              const SizedBox(height: 20), // Equal spacing between sections
              _buildAccountSection(),
              const SizedBox(height: 20), // Equal spacing between sections
              _buildNotificationSwitch(),
              const SizedBox(height: 20), // Equal spacing before footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return Transform.translate(
      offset: const Offset(0, -30), // Adjusted offset to move it up
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16), // Consistent padding
          decoration: BoxDecoration(
            color: const Color(0xFF6A994E),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: userProfileImage.startsWith('http')
                    ? NetworkImage(userProfileImage) // Use NetworkImage for URLs
                    : AssetImage(userProfileImage) as ImageProvider, // Use AssetImage for local assets
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: Color(0xFFF2E8CF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Icon(
                    Icons.star,
                    color: Color(0xFFFFC107), // Yellow for star
                    size: 28,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF6A994E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Color(0xFFF2E8CF),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.black26),
          const SizedBox(height: 10),
          _buildListTile(title: 'My Store', onTap: () => Navigator.pushNamed(context, '/store')),
          _buildListTile(title: 'Payment Details', onTap: () => Navigator.pushNamed(context, '/payment')),
          _buildListTile(title: 'Order History', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderhistoryPage()))),
          _buildListTile(title: 'Profile Settings', onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }),
        ],
      ),
    );
  }

  Widget _buildNotificationSwitch() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF6A994E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Color(0xFFF2E8CF),
                ),
              ),
              Switch(
                value: notificationsEnabled,
                onChanged: (value) async {
                  setState(() {
                    notificationsEnabled = value;
                  });
                  try {
                    if (mounted) {
                      await ApiService().updateNotifications("user123", value);
                    }
                  } catch (error) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to update notifications: $error")),
                      );
                    }
                  }
                },
                activeColor: const Color(0xFFA7C957),
              ),
            ],
          ),
          const SizedBox(height: 10), // Add spacing for description
          const Text(
            "Turn on notifications",
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
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
          _buildFooterIcon(Icons.home, Color(0xffbc4749), '/home'),
          _buildFooterIcon(Icons.star, Color(0xffbc4749), '/rewards'),
          _buildFooterIcon(Icons.add, Color(0xffbc4749), '/sell'),
          _buildFooterIcon(Icons.shopping_cart, Color(0xffbc4749), '/my_cart'),
          _buildFooterIcon(Icons.person, Color(0xffbc4749), '/profile'),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, Color iconColor, String routePath) {
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

Widget _buildListTile({required String title, required VoidCallback onTap}) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontFamily: 'Roboto')),
    onTap: onTap,
    trailing: const Icon(Icons.arrow_forward_ios),
  );
}
