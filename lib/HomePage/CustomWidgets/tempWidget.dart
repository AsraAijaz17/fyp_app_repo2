import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TempretureWidget extends StatefulWidget {
  const TempretureWidget({super.key});

  @override
  State<TempretureWidget> createState() => _TempretureWidgetState();
}

class _TempretureWidgetState extends State<TempretureWidget> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  double temperature = 0.0;

  @override
  void initState() {
    super.initState();
    _database.child("Temperature").onValue.listen((event) {
      setState(() {
        temperature = double.parse(event.snapshot.value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(colors: [
            Color(0xFF1F57CA),
            Color(0xFF000000),
          ], begin: Alignment.bottomLeft, end: Alignment.topLeft)),
      child: Row(
        children: [
          Icon(
            Icons.thermostat,
            color: Colors.white,
            size: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$temperature",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              Text("Lab Temperature",
                  style: TextStyle(fontSize: 15, color: Colors.white))
            ],
          )
        ],
      ),
    );
  }
}
