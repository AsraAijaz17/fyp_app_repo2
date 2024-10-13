// import 'package:flutter/material.dart';
// import 'package:theiotlab/HomePage/homepage.dart';
// import 'package:theiotlab/INCOMPLETE/ProfileScreen/profile.dart';
// import 'package:theiotlab/INCOMPLETE/SettinScreen/setting.dart';
// import 'package:theiotlab/LoginScreen/login.dart';
// import 'package:theiotlab/signup_screen.dart/signup_screen.dart';

// class HomeScreen extends StatefulWidget {
//   final String username; // Add username parameter

//   HomeScreen({required this.username});
  
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0; // Selected tab index

//   // List of screens for each tab
//   final List<Widget> _screens = [
//     MyHomePage(username: username),
//     ProfileScreen(),
//     SettingScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Update selected index
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex], // Show the selected screen
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color.fromARGB(255, 34, 74, 183),
//         onTap: _onItemTapped, // Handle tap events
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:theiotlab/HomePage/homepage.dart';
import 'package:theiotlab/INCOMPLETE/ProfileScreen/profile.dart';
import 'package:theiotlab/INCOMPLETE/SettinScreen/setting.dart';

class HomeScreen extends StatefulWidget {
  final String username; // Add username parameter

  HomeScreen({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Selected tab index

  // List of screens for each tab
  late final List<Widget> _screens; // Declare _screens as late variable

  @override
  void initState() {
    super.initState();
    // Initialize _screens with the username from the widget
    _screens = [
      MyHomePage(username: widget.username), // Pass username here
      ProfileScreen(),
      SettingScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Show the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 34, 74, 183),
        onTap: _onItemTapped, // Handle tap events
      ),
    );
  }
}
