import 'package:flutter/material.dart';
import 'package:my_app/app/navigation/persistent_nav_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade400,
          primary: Colors.green.shade400,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[400],
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.green[400],
          unselectedItemColor: Colors.grey,
        ),
        useMaterial3: true,
      ),
      home: const PersistentNavPage(), // ✅ Uses persistent navigation
    );
  }
}
