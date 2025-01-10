// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:intl/intl.dart'; // For formatting date and time

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   runApp(DoorLockApp());
// }

// class DoorLockApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DoorLockScreen(),
//     );
//   }
// }

// class DoorLockScreen extends StatefulWidget {
//   @override
//   _DoorLockScreenState createState() => _DoorLockScreenState();
// }

// class _DoorLockScreenState extends State<DoorLockScreen> {
//   final DatabaseReference _dbRef =
//       FirebaseDatabase.instance.reference(); // Database reference
//   bool isLocked = true; // Default state of the door
//   List<String> history = []; // To store history of lock/unlock events

//   @override
//   void initState() {
//     super.initState();
//     _fetchDoorState();
//   }

//   // Fetch DoorState from Firebase Realtime Database
//   void _fetchDoorState() {
//     _dbRef.child('DoorState').onValue.listen((event) {
//       final dynamic doorState = event.snapshot.value; // Fetch DoorState value
//       final String timestamp = DateFormat('dd/MM/yyyy hh:mm a')
//           .format(DateTime.now()); // Get current timestamp
//       setState(() {
//         if (isLocked != (doorState == 0)) {
//           isLocked = doorState == 0; // Update lock state
//           history.insert(0,
//               "${isLocked ? "Locked" : "Unlocked"} at $timestamp"); // Add to history
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: Icon(Icons.menu, color: Colors.grey[800]),
//         title: Text(
//           "SKYLOK SYSTEMS",
//           style: TextStyle(
//             color: Colors.grey[800],
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           Icon(Icons.battery_full, color: Colors.grey[800]),
//           SizedBox(width: 10),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 150,
//                     width: 150,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       shape: BoxShape.circle,
//                       boxShadow: isLocked
//                           ? [
//                               // Neumorphism Effect (Locked)
//                               BoxShadow(
//                                 color: Colors.grey[500]!,
//                                 offset: Offset(4, 4),
//                                 blurRadius: 15,
//                               ),
//                               BoxShadow(
//                                 color: Colors.white,
//                                 offset: Offset(-4, -4),
//                                 blurRadius: 15,
//                               ),
//                             ]
//                           : [
//                               // Inset Effect (Unlocked)
//                               BoxShadow(
//                                 color: Colors.white,
//                                 offset: Offset(4, 4),
//                                 blurRadius: 15,
//                                 spreadRadius: -2,
//                               ),
//                               BoxShadow(
//                                 color: Colors.grey[500]!,
//                                 offset: Offset(-4, -4),
//                                 blurRadius: 15,
//                                 spreadRadius: -2,
//                               ),
//                             ],
//                     ),
//                     child: Icon(
//                       isLocked ? Icons.lock : Icons.lock_open, // Change Icon
//                       size: 60,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     isLocked
//                         ? "Door is Locked"
//                         : "Door is Unlocked", // Display lock status
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Divider(
//               height: 1,
//               color:
//                   Colors.grey[400]), // Divider between lock screen and history
//           Container(
//             height: 200, // History section height
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "History",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: history.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: Icon(
//                           history[index].contains("Locked")
//                               ? Icons.lock
//                               : Icons.lock_open,
//                           color: Colors.blue,
//                         ),
//                         title: Text(
//                           history[index],
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[800],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; // For formatting date and time
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(DoorLockApp());
}

class DoorLockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoorLockScreen(),
    );
  }
}

class DoorLockScreen extends StatefulWidget {
  @override
  _DoorLockScreenState createState() => _DoorLockScreenState();
}

class _DoorLockScreenState extends State<DoorLockScreen> {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.reference(); // Database reference
  bool isLocked = true; // Default state of the door
  List<String> history = []; // To store history of lock/unlock events

  @override
  void initState() {
    super.initState();
    _fetchDoorState();
    _loadHistory(); // Load saved history from shared preferences
  }

  // Fetch DoorState from Firebase Realtime Database
  void _fetchDoorState() {
    _dbRef.child('DoorState').onValue.listen((event) {
      final dynamic doorState = event.snapshot.value; // Fetch DoorState value
      final String timestamp = DateFormat('dd/MM/yyyy hh:mm a')
          .format(DateTime.now()); // Get current timestamp
      setState(() {
        if (isLocked != (doorState == 0)) {
          isLocked = doorState == 0; // Update lock state
          String newHistory =
              "${isLocked ? "Locked" : "Unlocked"} at $timestamp"; // History string
          history.insert(0, newHistory); // Add to history
          _saveHistory(); // Save updated history to shared preferences
        }
      });
    });
  }

  // Load history from shared preferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList('doorHistory') ??
          []; // Load history or empty list
    });
  }

  // Save history to shared preferences
  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('doorHistory', history); // Save history to prefs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.grey[800]),
        title: Text(
          "DoorLock System",
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.battery_full, color: Colors.grey[800]),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                      boxShadow: isLocked
                          ? [
                              // Neumorphism Effect (Locked)
                              BoxShadow(
                                color: Colors.grey[800]!,
                                offset: Offset(4, 4),
                                blurRadius: 15,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4, -4),
                                blurRadius: 15,
                              ),
                            ]
                          : [
                              // Inset Effect (Unlocked)
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(4, 4),
                                blurRadius: 15,
                                spreadRadius: -2,
                              ),
                              BoxShadow(
                                color: Colors.grey[800]!,
                                offset: Offset(-4, -4),
                                blurRadius: 15,
                                spreadRadius: -2,
                              ),
                            ],
                    ),
                    child: Icon(
                      isLocked ? Icons.lock : Icons.lock_open, // Change Icon
                      size: 80,
                      color: Color.fromARGB(255, 11, 48, 169),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    isLocked
                        ? "Door is Locked"
                        : "Door is Unlocked", // Display lock status
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
              height: 1,
              color:
                  Colors.grey[400]), // Divider between lock screen and history
          Container(
            height: 200, // History section height
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "History",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          history[index].contains("Locked")
                              ? Icons.lock
                              : Icons.lock_open,
                          color: Color.fromARGB(255, 10, 72, 179),
                        ),
                        title: Text(
                          history[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
