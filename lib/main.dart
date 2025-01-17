import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:theiotlab/HomePage/CustomWidgets/bottomnav.dart';
import 'package:theiotlab/HomePage/CustomWidgets/header.dart';
import 'package:theiotlab/INCOMPLETE/DoorLockScreen/doorlock.dart';

import 'package:theiotlab/LoginScreen/login.dart';
import 'package:theiotlab/HomePage/homepage.dart';
import 'package:theiotlab/SplashScreen/splash_screen.dart';
import 'package:theiotlab/firebase_options.dart';

import 'package:theiotlab/signup_screen.dart/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SplashScreen(
      username: "",
      email: '',
    ));
  }
}


// MaterialApp(home: SplashScreen(username: "", email: '',))