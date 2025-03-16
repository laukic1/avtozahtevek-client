import 'package:flutter/material.dart';
import 'package:my_app/claims/file_claim_page.dart';
import 'package:my_app/claims/profile_page.dart';
import 'package:my_app/faq/help_page.dart';
import 'package:my_app/home/home_page.dart';
import 'package:my_app/home/status_page.dart';

class PersistentNavPage extends StatefulWidget {
  const PersistentNavPage({super.key});

  @override
  _PersistentNavPageState createState() => _PersistentNavPageState();
}

class _PersistentNavPageState extends State<PersistentNavPage> {
  int _selectedIndex = 0;
  bool _isInClaimPage = false;

  final List<Widget> _pages = const [
    HomePage(),
    StatusPage(),
    HelpPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isInClaimPage = false;
    });
  }

  void _openFileClaimPage(BuildContext context) {
    setState(() {
      _isInClaimPage = true;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FileClaimPage()),
    ).then((_) {
      setState(() {
        _isInClaimPage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ✅ Ensure the body is set inside AnimatedSwitcher
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // ✅ Smooth fade effect
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: IndexedStack(
          key: ValueKey<int>(_selectedIndex), // ✅ Helps maintain state
          index: _selectedIndex,
          children: _pages,
        ),
      ),

      // ✅ Floating Action Button for Filing Claims
      floatingActionButton: _isInClaimPage
          ? null
          : FloatingActionButton(
        onPressed: () => _openFileClaimPage(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, size: 30),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // ✅ Persistent Bottom Navigation Bar
      bottomNavigationBar: _isInClaimPage
          ? null
          : BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'Help'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
