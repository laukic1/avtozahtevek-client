import 'package:flutter/material.dart';
import 'package:my_app/profile/edit_profile_page.dart'; // ✅ Profile Editing Page
import 'package:my_app/profile/settings_page.dart'; // ✅ Settings Page
import 'package:my_app/profile/support_page.dart'; // ✅ Support Page

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget _buildProfileOption(BuildContext context,
      {required IconData icon, required String title, required Widget destination}) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: Colors.white, // ✅ White Background
        elevation: 4, // ✅ Adds Bottom Shadow
        shadowColor: Colors.white, // ✅ Subtle shadow
        foregroundColor: Colors.black, // ✅ Black text/icons for contrast
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ✅ Edit Profile
          _buildProfileOption(
            context,
            icon: Icons.person,
            title: 'Edit Profile',
            destination: const EditProfilePage(),
          ),

          // ✅ Support Page
          _buildProfileOption(
            context,
            icon: Icons.support_agent,
            title: 'Support',
            destination: const SupportPage(),
          ),

          // ✅ Settings (Future page)
          _buildProfileOption(
            context,
            icon: Icons.settings,
            title: 'Settings',
            destination: const SettingsPage(), // Replace with actual Settings Page later
          ),

          // ✅ Logout (Temporary Action)
          ListTile(
            leading: const Icon(Icons.exit_to_app, size: 28, color: Colors.red),
            title: const Text(
                'Logout', style: TextStyle(fontSize: 18, color: Colors.red)),
            onTap: () {
              // TODO: Implement Logout functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logging out...')),
              );
            },
          ),
        ],
      ),
    );
  }
}
