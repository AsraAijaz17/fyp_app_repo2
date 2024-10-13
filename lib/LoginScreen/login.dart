import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theiotlab/HomePage/CustomWidgets/bottomnav.dart';
import 'package:theiotlab/signup_screen.dart/signup_screen.dart';

import '../HomePage/homepage.dart';

class LoginScreen extends StatefulWidget {
  final String username; // Add username parameter

  const LoginScreen({super.key, required this.username});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = '';

  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Check if email is empty
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email is required.")),
      );
      return; // Stop execution if email is empty
    }

    // Check if password is empty
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password is required.")),
      );
      return; // Stop execution if password is empty
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetching uid and storing its name into a var
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc = await _firestore
          .collection("UsersRegister")
          .doc(credential.user!.uid)
          .get();

      setState(() {
        username = userDoc['username'];
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(username: username), // Pass username here
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Log the error code to debug
      print('Firebase Auth Error: ${e.code}'); // Log the error code

      if (e.code == 'invalid-email') {
        errorMessage = 'invalid email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'The email or password provided is invalid.';
      } else {
        errorMessage = 'An unknown error occurred.';
      }

      // Displaying the error message in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //forget pass

  Future<void> SendPasswordResetEmail() async {
    String email = emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Reset Password email sent")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $e"),
        backgroundColor: Colors.blue,
      ));
    }
  }

  //--------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // ab isky dono child text hein dono ko left align karne k liye isko Start kardo
              children: [
                Text(
                  "Welcome back! Glad",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A52C5)),
                ),
                Text(
                  "to see you, Again",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // ),

            //-----------------------------------------------------

            const SizedBox(
              height: 30,
            ),

            //---------------------------------------------------

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            //---------------------------------------------------

            const SizedBox(
              height: 10,
            ),

            //---------------------------------------------------

            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Enter your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),

            //---------------------------------------------------

            const SizedBox(
              height: 20,
            ),

            //---------------------------------------------------

            // const Row(
            //   children: [
            //     Spacer(),
            //     Padding(
            //       padding: EdgeInsets.only(right: 15),
            //       child: Text(
            //         "Forget Password?",
            //         style: TextStyle(
            //             color: Colors.black, fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //   ],
            // ),

            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Show dialog to reset password
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Reset Password"),
                        content: TextField(
                          controller: emailController,
                          decoration:
                              InputDecoration(hintText: "Enter your email"),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              SendPasswordResetEmail(); // Call the function to send email
                              Navigator.of(context)
                                  .pop(); // Close dialog box after sending email
                            },
                            child: Text("Send Email"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),

            //---------------------------------------------------

            const SizedBox(
              height: 20,
            ),

            //---------------------------------------------------

            Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1F57CA),
                    Color(0xFF000000),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  loginUser();
                },
                child: Container(
                  width: 331,
                  height: 56,
                  alignment: Alignment.center,
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            //---------------------------------------------------

            const SizedBox(height: 30), // 20 KI JAGA 30 KARDIA

            //---------------------------------------------------

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 100,
                //   child: Divider(
                //     color: Colors.grey,
                //     thickness: 0.5,
                //   ),
                // ),
                Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                Text(" Or Login With "),
                Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                //EXPANDED USE KARO YAHAN LEFT RIGHT ME AGAR SPACE BHI DENA HO YA KISI CHZ KO CENTER ME RAKHNA HO OR LEFT RIGHT ME BRABAR KI JAGA RAKGHNI HO TO EXPANDED USE KARO
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.facebook),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.apple),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.email),
                ),
              ],
            ),
            //---------------------------------------------------

            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupScreen(
                                username: '',
                              )));
                },
                child: Text("Dont have an account? Register!")),
          ],
        ),
      ),
    )
        // ),
        );
  }
}
