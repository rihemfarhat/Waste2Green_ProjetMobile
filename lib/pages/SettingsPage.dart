import 'package:flutter/material.dart';
import '../services/user_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _showUpdateDialog(BuildContext context, String title, String field) async {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'New $title',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                try {
                  switch (field) {
                    case 'username':
                      await UserService.updateUsername(controller.text);
                      break;
                    case 'email':
                      await UserService.updateEmail(controller.text);
                      break;
                    case 'password':
                      await UserService.updatePassword(controller.text);
                      break;
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title updated successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating $title: $e')),
                  );
                }
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E8CF),
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
                      iconColor: const Color(0xffbc4749),
                      onTap: () async {
                        try {
                          await UserService.updateProfilePicture();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile picture updated')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error updating profile picture: $e')),
                          );
                        }
                      },
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Change Username',
                      icon: Icons.person,
                      iconColor: const Color(0xffbc4749),
                      onTap: () => _showUpdateDialog(context, 'Username', 'username'),
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Change Email',
                      icon: Icons.email,
                      iconColor: const Color(0xffbc4749),
                      onTap: () => _showUpdateDialog(context, 'Email', 'email'),
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Change Password',
                      icon: Icons.lock,
                      iconColor: const Color(0xffbc4749),
                      onTap: () => _showUpdateDialog(context, 'Password', 'password'),
                    ),
                    _buildSettingOption(
                      context,
                      title: 'Log Out',
                      icon: Icons.exit_to_app,
                      iconColor: const Color(0xffbc4749),
                      onTap: () async {
                        try {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Confirm Logout'),
                              content: Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffbc4749),
                                  ),
                                  child: Text('Logout'),
                                ),
                              ],
                            ),
                          ) ?? false;

                          if (confirm) {
                            await UserService.logout();
                            
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login',
                              (Route<dynamic> route) => false,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Logged out successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error logging out: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
