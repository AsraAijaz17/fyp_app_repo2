import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  final String username; // Username ko define karein

 
  const HomeHeader({super.key, required this.username});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 100,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.yellow,
            child: ClipOval(
              // This makes the image circular
              child: Image.asset(
                "assets/images/logo.jpg",
                height: 50, // Adjust the height
                width: 50, // Adjust the width
                fit: BoxFit
                    .cover, // Ensures the image covers the CircleAvatar space
              ),
            ),
          ),

          //---------------------------------------------------

          SizedBox(
            width: 10,
          ),

          //--------------------------------------------------

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to IOT Lab",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.username,
                style: TextStyle(
                    color: Color.fromARGB(255, 31, 5, 126),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),

          Spacer(),

          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                size: 30,
                color: Color.fromARGB(255, 18, 62, 166),
              )),

          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_box,
                size: 30,
                color: Color.fromARGB(255, 18, 62, 166),
              )),
        ],
      ),
    );
  }
}
