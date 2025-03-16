import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _pushNotifications = true;
  bool _emailAlerts = false;
  String _selectedLanguage = "English";

  final List<String> _languages = ["English", "Spanish", "French", "German"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nastavitve'),
        centerTitle: true,
        backgroundColor: Colors.white, // ✅ White Background
        elevation: 4, // ✅ Adds Bottom Shadow
        shadowColor: Colors.white, // ✅ Subtle shadow
        foregroundColor: Colors.black, // ✅ Black text/icons for contrast
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ✅ Account Settings
          const Text("Account Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildSwitchTile("Enable 2FA (Two-Factor Authentication)", Icons.lock, _isDarkMode, (value) {
            setState(() {
              _isDarkMode = value;
            });
          }),
          _buildSwitchTile("Manage Linked Devices", Icons.devices, _pushNotifications, (value) {
            setState(() {
              _pushNotifications = value;
            });
          }),
          const Divider(),

          // ✅ Notification Settings
          const Text("Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildSwitchTile("Push Notifications", Icons.notifications, _pushNotifications, (value) {
            setState(() {
              _pushNotifications = value;
            });
          }),
          _buildSwitchTile("Email Alerts", Icons.email, _emailAlerts, (value) {
            setState(() {
              _emailAlerts = value;
            });
          }),
          const Divider(),

          // ✅ App Preferences
          const Text("App Preferences", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildSwitchTile("Dark Mode", Icons.dark_mode, _isDarkMode, (value) {
            setState(() {
              _isDarkMode = value;
            });
          }),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              items: _languages.map((String lang) {
                return DropdownMenuItem<String>(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
            ),
          ),
          const Divider(),

          // ✅ Reset Settings
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isDarkMode = false;
                  _pushNotifications = true;
                  _emailAlerts = false;
                  _selectedLanguage = "English";
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Settings reset to default!")),
                );
              },
              icon: const Icon(Icons.restore),
              label: const Text("Reset to Default"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Helper function for switch toggles
  Widget _buildSwitchTile(String title, IconData icon, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      secondary: Icon(icon),
      value: value,
      onChanged: onChanged,
    );
  }
}
