import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Profile Screen"),
//       ),
//     );
//   }
// }

// class ProfileScreen extends StatefulWidget {
//   final String username;
//   final String email; //yenayaadd
//   const ProfileScreen({super.key, required this.username, required this.email});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         centerTitle: true,
//         backgroundColor: Color(0xFF1F57CA),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             // CircleAvatar(
//             //   radius: 50,
//             //   backgroundColor: Colors.teal,
//             //   child: const CircleAvatar(
//             //     radius: 45,
//             //     backgroundColor: Colors.white,
//             //     child: Icon(Icons.edit, color: Colors.teal, size: 30),
//             //   ),
//             // ),
//             CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.white,
//               child: ClipOval(
//                 // This makes the image circular
//                 child: Image.asset(
//                   "assets/images/logo.jpg",
//                   height: 80, // Adjust the height
//                   width: 80, // Adjust the width
//                   fit: BoxFit
//                       .cover, // Ensures the image covers the CircleAvatar space
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               widget.username,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               widget.email,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Profile details'),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 // Navigate to Profile Details Screen
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 // Navigate to Settings Screen
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.notifications),
//               title: const Text('Push Notifications'),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 // Navigate to Notifications Screen
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.support),
//               title: const Text('Support'),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 // Navigate to Support Screen
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 // Handle Logout
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart'; // FirebaseAuth import
import 'package:flutter/material.dart';
import 'package:theiotlab/LoginScreen/login.dart'; // Import LoginScreen

class ProfileScreen extends StatefulWidget {
  final String username;
  final String email;

  const ProfileScreen({super.key, required this.username, required this.email});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Logout function
  Future<void> _logout() async {
    try {
      await _auth.signOut(); // Sign out from Firebase
      // Redirect to Login Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(
                  email: '',
                  username: '',
                )),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Color(0xFF1F57CA),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logo.jpg",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.username,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile details'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Profile Details Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Settings Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Push Notifications'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Notifications Screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text('Support'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Support Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _logout, // Logout on tap
            ),
          ],
        ),
      ),
    );
  }
}
