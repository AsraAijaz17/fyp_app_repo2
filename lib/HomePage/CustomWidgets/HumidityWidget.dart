import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HumidityWidget extends StatefulWidget {
  const HumidityWidget({super.key});

  @override
  State<HumidityWidget> createState() => _HumidityWidgetState();
}

class _HumidityWidgetState extends State<HumidityWidget> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  double Humidity = 0.0;

  @override
  void initState() {
    super.initState();
    _database.child("Humidity").onValue.listen((event) {
      setState(() {
        Humidity = double.parse(event.snapshot.value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
            Icons.water_drop,
            color: Colors.white,
            size: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$Humidity",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              Text("Lab Humidity",
                  style: TextStyle(fontSize: 15, color: Colors.white))
            ],
          )
        ],
      ),
    );
    ;
  }
}
