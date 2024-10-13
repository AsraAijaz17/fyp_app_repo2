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

// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class TempData {
//   final int time; // Use int for numeric representation of time
//   final double temperature;
//   final double humidity; // Add humidity field

//   TempData(this.time, this.temperature, this.humidity);
// }

// class TempChart extends StatelessWidget {
//   final List<charts.Series<TempData, int>>
//       temperatureSeriesList; // For temperature
//   final List<charts.Series<TempData, int>> humiditySeriesList; // For humidity

//   TempChart(this.temperatureSeriesList, this.humiditySeriesList);

//   @override
//   Widget build(BuildContext context) {
//     return charts.LineChart(
//       temperatureSeriesList + humiditySeriesList, // Combine both series
//       animate: true,
//       behaviors: [
//         charts.ChartTitle('Time (minutes since start)',
//             behaviorPosition: charts.BehaviorPosition.bottom),
//         charts.ChartTitle('Value',
//             behaviorPosition: charts.BehaviorPosition.start),
//       ],
//     );
//   }
// }

// class EnergyMonitoringScreen extends StatefulWidget {
//   @override
//   _EnergyMonitoringScreenState createState() => _EnergyMonitoringScreenState();
// }

// class _EnergyMonitoringScreenState extends State<EnergyMonitoringScreen> {
//   final databaseRef = FirebaseDatabase.instance.ref();
//   List<TempData> tempDataList = []; // Store temperature and humidity data
//   int currentTimeInMinutes = 0; // Track time in minutes

//   @override
//   // void initState() {
//   //   super.initState();
//   //   _listenToTemperatureAndHumidityChanges();
//   // }

//   // void _listenToTemperatureAndHumidityChanges() {
//   //   databaseRef.onValue.listen((event) {
//   //     final temperatureValue =
//   //         double.parse(event.snapshot.child('Temperature').value.toString());
//   //     final humidityValue =
//   //         double.parse(event.snapshot.child('Humidity').value.toString());

//   //     // Debugging log to see the received values
//   //     print(
//   //         'Received temperature: $temperatureValue, humidity: $humidityValue at time: $currentTimeInMinutes minutes');

//   //     setState(() {
//   //       tempDataList.add(
//   //           TempData(currentTimeInMinutes, temperatureValue, humidityValue));
//   //       currentTimeInMinutes += 1; // Increment time for next data point
//   //     });
//   //   });
//   // }
//   void _fetchInitialData() async {
//     // Fetch the initial data from the Firebase Database
//     final DataSnapshot snapshot = await databaseRef.get();

//     // Extract temperature and humidity from the snapshot
//     final double initialTemperature =
//         double.parse(snapshot.child('Temperature').value.toString());
//     final double initialHumidity =
//         double.parse(snapshot.child('Humidity').value.toString());

//     // Initialize the chart with this initial data
//     setState(() {
//       tempDataList.add(
//           TempData(currentTimeInMinutes, initialTemperature, initialHumidity));
//     });

//     // Start the time tracking (you could save this in shared prefs if needed)
//     currentTimeInMinutes++;
//   }

//   void _listenToTemperatureAndHumidityChanges() {
//     databaseRef.onValue.listen((event) {
//       final temperatureValue =
//           double.parse(event.snapshot.child('Temperature').value.toString());
//       final humidityValue =
//           double.parse(event.snapshot.child('Humidity').value.toString());

//       print(
//           'Received temperature: $temperatureValue, humidity: $humidityValue at time: $currentTimeInMinutes minutes');

//       setState(() {
//         tempDataList.add(
//             TempData(currentTimeInMinutes, temperatureValue, humidityValue));
//         currentTimeInMinutes += 1; // Increment time for next data point
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchInitialData(); // Fetch initial data first
//     _listenToTemperatureAndHumidityChanges();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Ensure we have enough data to display
//     if (tempDataList.isEmpty) {
//       return Center(
//           child:
//               CircularProgressIndicator()); // Show loading indicator while waiting for data
//     }

//     // Create the chart series
//     final temperatureSeries = charts.Series<TempData, int>(
//       id: 'Temperature',
//       colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
//       domainFn: (TempData temps, _) => temps.time, // X-axis (minutes)
//       measureFn: (TempData temps, _) => temps.temperature, // Y-axis
//       data: tempDataList,
//     );

//     final humiditySeries = charts.Series<TempData, int>(
//       id: 'Humidity',
//       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//       domainFn: (TempData temps, _) => temps.time, // X-axis (minutes)
//       measureFn: (TempData temps, _) => temps.humidity, // Y-axis
//       data: tempDataList,
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Real-Time Temperature and Humidity Chart"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TempChart([temperatureSeries],
//             [humiditySeries]), // Pass both series to TempChart
//       ),
//     );
//   }
// }

//-------------------------------------------
//------------------------------------------
//--------new code---------------------------

import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../services/shared_prefrences/shared_pref_helper.dart';

class TempData {
  final int time;
  final double temperature;
  final double humidity;

  TempData(this.time, this.temperature, this.humidity);

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'temperature': temperature,
      'humidity': humidity,
    };
  }

  // Convert from Map
  factory TempData.fromMap(Map<String, dynamic> map) {
    return TempData(
      map['time'],
      map['temperature'],
      map['humidity'],
    );
  }
}

class TempChart extends StatelessWidget {
  final List<charts.Series<TempData, int>>
      temperatureSeriesList; // For temperature
  final List<charts.Series<TempData, int>> humiditySeriesList; // For humidity

  const TempChart(this.temperatureSeriesList, this.humiditySeriesList,
      {super.key});

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
  const EnergyMonitoringScreen({super.key});

  @override
  _EnergyMonitoringScreenState createState() => _EnergyMonitoringScreenState();
}

class _EnergyMonitoringScreenState extends State<EnergyMonitoringScreen> {
  final databaseRef = FirebaseDatabase.instance.ref();
  List<TempData> tempDataList = [];
  int currentTimeInMinutes = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData(); // Load data from SharedPreferences or Firebase
  }

  void _loadData() async {
    SharedPreferencesHelper sharedPrefs = SharedPreferencesHelper();

    // Check if we have saved data
    List<Map<String, dynamic>>? savedData = await sharedPrefs.getData();

    if (savedData != null) {
      // Use saved data to populate the chart
      setState(() {
        tempDataList = savedData.map((item) => TempData.fromMap(item)).toList();
        currentTimeInMinutes = tempDataList.length; // Update time tracking
        _isLoading = false;
      });
    } else {
      _fetchInitialData();
    }

    _listenToTemperatureAndHumidityChanges();
  }

  void _fetchInitialData() async {
    // Fetch initial data from Firebase
    final DataSnapshot snapshot = await databaseRef.get();

    // Extract data
    final double initialTemperature = double.tryParse(
            snapshot.child('Temperature').value?.toString() ?? '') ??
        0.0;
    final double initialHumidity =
        double.tryParse(snapshot.child('Humidity').value?.toString() ?? '') ??
            0.0;

    setState(() {
      tempDataList.add(
          TempData(currentTimeInMinutes, initialTemperature, initialHumidity));
      currentTimeInMinutes++;
      _isLoading = false;
    });

    _updateSharedPreferences();
  }

  void _listenToTemperatureAndHumidityChanges() {
    databaseRef.onValue.listen((event) {
      final temperatureValue = double.tryParse(
              event.snapshot.child('Temperature').value?.toString() ?? '') ??
          0.0;
      final humidityValue = double.tryParse(
              event.snapshot.child('Humidity').value?.toString() ?? '') ??
          0.0;

      setState(() {
        tempDataList.add(
            TempData(currentTimeInMinutes, temperatureValue, humidityValue));
        currentTimeInMinutes++;
      });

      _updateSharedPreferences();
    });
  }

  void _updateSharedPreferences() {
    SharedPreferencesHelper sharedPrefs = SharedPreferencesHelper();

    // Save the data in SharedPreferences
    List<Map<String, dynamic>> tempDataListMap =
        tempDataList.map((data) => data.toMap()).toList();
    sharedPrefs.saveData(tempDataListMap);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tempDataList.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    // Create chart series
    final temperatureSeries = charts.Series<TempData, int>(
      id: 'Temperature',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (TempData temps, _) => temps.time,
      measureFn: (TempData temps, _) => temps.temperature,
      data: tempDataList,
    );

    final humiditySeries = charts.Series<TempData, int>(
      id: 'Humidity',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TempData temps, _) => temps.time,
      measureFn: (TempData temps, _) => temps.humidity,
      data: tempDataList,
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 22, 79, 211),
          title: const Text(
            "Real-Time Temperature and Humidity Chart",
            style: TextStyle(fontSize: 15),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TempChart([temperatureSeries], [humiditySeries]),
      ),
    );
  }
}
