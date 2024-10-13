import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const Options(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 161,
        width: 162,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5, // Spread radius (how far the shadow spreads)
                blurRadius: 5, // Blur radius (how soft the shadow looks)
                offset: Offset(0, 3), // Changes position of shadow (x, y)
              ),
            ],
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 204, 201, 201),
              ),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
