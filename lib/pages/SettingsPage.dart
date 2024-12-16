import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E8CF), // Set background color
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6A994E),
        elevation: 4,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _buildSettingOption(
                      context,
                      title: 'Change Profile Picture',
                      icon: Icons.camera_alt,
                      iconColor: const Color(0xffbc4749), // Passing icon color
                      onTap: () {
                        // Handle change profile picture logic
                      },
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Change Username',
                      icon: Icons.person,
                      iconColor: const Color(0xffbc4749), // Passing icon color
                      onTap: () {
                        // Handle change username logic
                      },
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Change Email',
                      icon: Icons.email,
                      iconColor: const Color(0xffbc4749),
                      onTap: () {
                        // Handle change email logic
                      },
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Change Password',
                      icon: Icons.lock,
                      iconColor: const Color(0xffbc4749),
                      onTap: () {
                        // Handle change password logic
                      },
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Log Out',
                      icon: Icons.exit_to_app,
                      iconColor: const Color(0xffbc4749),
                      onTap: () {
                        // Handle log out logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logged out successfully')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  // Method to create reusable list items for settings
  Widget _buildSettingOption(BuildContext context, {
    required String title,
    required IconData icon,
    Color iconColor = const Color(0xFF6A994E), // Default icon color
    required VoidCallback onTap
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor),  // Use icon color
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Icon(Icons.edit, color: Color(0xFF6A994E)),  // Pen icon for modification
          ],
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }

  // Footer widget with shadow and custom design
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

  // Reusable footer icon widget with context passed
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
          color: iconColor,
        ),
      ),
    );
  }
}
