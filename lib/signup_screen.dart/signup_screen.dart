import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theiotlab/HomePage/CustomWidgets/bottomnav.dart';
import 'package:theiotlab/HomePage/homepage.dart';
import 'package:theiotlab/LoginScreen/login.dart';

class SignupScreen extends StatefulWidget {
  final String username;
  final String email;
  const SignupScreen({super.key, required this.username, required this.email});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  registerUser() async {
    String username = usernameController.text;
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    String confirmPassword = confirmPasswordController.text;

    // Check if passwords match
    if (password != confirmPassword) {
      print("Passwords do not match!");
      return; // Return early if passwords don't match
    }

    try {
      // Creating user
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Adding user data to Firestore
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore
          .collection("UsersRegister")
          .doc(credential.user!.uid)
          .set({
        'username': username,
        'email': email,
      });

      print("User registered successfully, ...");

      // Navigate to the Home page after successful registration
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("User registered successfully"),
        backgroundColor: Colors.blue,
      ));
      //clearing fields
      emailcontroller.clear();
      passwordcontroller.clear();
      usernameController.clear();
      confirmPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      print(
          "FirebaseAuthException: ${e.message}"); // Print specific error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("Exception: $e"); // Print any other exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 78,
                  width: 331,
                  child: const Column(
                    children: [
                      Text(
                        "Hello! Register to get started",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A52C5)),
                      ),
                      // Text(
                      //   "to see you, Again",
                      //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                ),

                //-----------------------------------------------------

                const SizedBox(
                  height: 30,
                ),

                //---------------------------------------------------

                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                //---------------------------------------------------

                const SizedBox(
                  height: 10,
                ),

                //---------------------------------------------------

                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Email"),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //---------------------------------------------------

                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: TextField(
                    obscureText: true,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Password"),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //---------------------------------------------------

                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: TextField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Confirm Password"),
                  ),
                ),

                //---------------------------------------------------

                //---------------------------------------------------

                const SizedBox(
                  height: 30,
                ),

                //---------------------------------------------------

                InkWell(
                  onTap: () {
                    registerUser();
                  },
                  child: Container(
                    width: 331,
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF1F57CA),
                              Color(0xFF000000),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft)),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //---------------------------------------------------

                SizedBox(height: 20),

                //---------------------------------------------------

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    ),
                    Text("Or Register With"),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 100,
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 105,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.facebook),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 56,
                      width: 105,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.apple),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 56,
                      width: 105,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.email),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                    username: widget.username,
                                    email: widget.email,
                                  )));
                    },
                    child: Text("already have an account? Login Now"))

                //---------------------------------------------------
              ],
            ),
          ),
        ),
      ),
    );
  }
}
