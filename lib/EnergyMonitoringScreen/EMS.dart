// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class EnergyMonitoringScreen extends StatefulWidget {
//   @override
//   _EnergyMonitoringScreenState createState() => _EnergyMonitoringScreenState();
// }

// class _EnergyMonitoringScreenState extends State<EnergyMonitoringScreen> {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();

//   // Variables to hold data
//   String bulbStatus = "Loading...";
//   String buzzerStatus = "Loading...";
//   String fanStatus = "Loading...";
//   double humidity = 0.0;
//   String motionStatus = "Loading...";
//   double temperature = 0.0;

//   // List to hold temperature data with time
//   List<Map<String, dynamic>> temperatureData = [];

//   @override
//   void initState() {
//     super.initState();
//     _database.child("Bulb").onValue.listen((event) {
//       setState(() {
//         bulbStatus = event.snapshot.value.toString();
//       });
//     });

//     _database.child("Buzzer").onValue.listen((event) {
//       setState(() {
//         buzzerStatus = event.snapshot.value.toString();
//       });
//     });

//     _database.child("Fan").onValue.listen((event) {
//       setState(() {
//         fanStatus = event.snapshot.value.toString();
//       });
//     });

//     _database.child("Humidity").onValue.listen((event) {
//       setState(() {
//         humidity = double.parse(event.snapshot.value.toString());
//       });
//     });

//     _database.child("Motion").onValue.listen((event) {
//       setState(() {
//         motionStatus = event.snapshot.value.toString();
//       });
//     });

//     _database.child("Temperature").onValue.listen((event) {
//       setState(() {
//         temperature = double.parse(event.snapshot.value.toString());
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('IoT Lab'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Bulb Status: $bulbStatus', style: TextStyle(fontSize: 20)),
//             Text('Buzzer Status: $buzzerStatus',
//                 style: TextStyle(fontSize: 20)),
//             Text('Fan Status: $fanStatus', style: TextStyle(fontSize: 20)),
//             Text('Humidity: $humidity %', style: TextStyle(fontSize: 20)),
//             Text('Motion Status: $motionStatus',
//                 style: TextStyle(fontSize: 20)),
//             Text('Temperature: $temperature °C',
//                 style: TextStyle(fontSize: 20)),
//           ],
//         ),
//       ),
//     );
//   }
// }

//---------both humid + temp------------

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TempData {
  final int time; // Use int for numeric representation of time
  final double temperature;
  final double humidity; // Add humidity field

  TempData(this.time, this.temperature, this.humidity);
}

class TempChart extends StatelessWidget {
  final List<charts.Series<TempData, int>>
      temperatureSeriesList; // For temperature
  final List<charts.Series<TempData, int>> humiditySeriesList; // For humidity

  TempChart(this.temperatureSeriesList, this.humiditySeriesList);

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      temperatureSeriesList + humiditySeriesList, // Combine both series
      animate: true,
      behaviors: [
        charts.ChartTitle('Time (minutes since start)',
            behaviorPosition: charts.BehaviorPosition.bottom),
        charts.ChartTitle('Value',
            behaviorPosition: charts.BehaviorPosition.start),
      ],
    );
  }
}

class EnergyMonitoringScreen extends StatefulWidget {
  @override
  _EnergyMonitoringScreenState createState() => _EnergyMonitoringScreenState();
}

class _EnergyMonitoringScreenState extends State<EnergyMonitoringScreen> {
  final databaseRef = FirebaseDatabase.instance.ref();
  List<TempData> tempDataList = []; // Store temperature and humidity data
  int currentTimeInMinutes = 0; // Track time in minutes

  @override
  void initState() {
    super.initState();
    _listenToTemperatureAndHumidityChanges();
  }

  void _listenToTemperatureAndHumidityChanges() {
    databaseRef.onValue.listen((event) {
      final temperatureValue =
          double.parse(event.snapshot.child('Temperature').value.toString());
      final humidityValue =
          double.parse(event.snapshot.child('Humidity').value.toString());

      // Debugging log to see the received values
      print(
          'Received temperature: $temperatureValue, humidity: $humidityValue at time: $currentTimeInMinutes minutes');

      setState(() {
        tempDataList.add(
            TempData(currentTimeInMinutes, temperatureValue, humidityValue));
        currentTimeInMinutes += 1; // Increment time for next data point
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ensure we have enough data to display
    if (tempDataList.isEmpty) {
      return Center(
          child:
              CircularProgressIndicator()); // Show loading indicator while waiting for data
    }

    // Create the chart series
    final temperatureSeries = charts.Series<TempData, int>(
      id: 'Temperature',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (TempData temps, _) => temps.time, // X-axis (minutes)
      measureFn: (TempData temps, _) => temps.temperature, // Y-axis
      data: tempDataList,
    );

    final humiditySeries = charts.Series<TempData, int>(
      id: 'Humidity',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TempData temps, _) => temps.time, // X-axis (minutes)
      measureFn: (TempData temps, _) => temps.humidity, // Y-axis
      data: tempDataList,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Real-Time Temperature and Humidity Chart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TempChart([temperatureSeries],
            [humiditySeries]), // Pass both series to TempChart
      ),
    );
  }
}
