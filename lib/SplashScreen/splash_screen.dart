import 'package:flutter/material.dart';
import 'package:theiotlab/LoginScreen/login.dart';


class SplashScreen extends StatelessWidget {
  final String username; // Add username parameter
  final String email;

  const SplashScreen({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(
                  username: username,
                  email: email,
                )),
      );
    });
    return Scaffold(
        backgroundColor: Color(0xFF142D70),
        body: Center(
            child: Image.asset(
          "assets/images/iotlab.jpg",
          height: 300,
          width: 300,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'Error loading image',
              style: TextStyle(fontSize: 30, color: Colors.white),
            );
          },
        )));
  }
}
