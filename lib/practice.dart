import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;



class TempGraph extends StatelessWidget {
  final List<TimeTempData> data = [
    TimeTempData(DateTime.now().subtract(Duration(minutes: 4)), 13),
    TimeTempData(DateTime.now().subtract(Duration(minutes: 3)), 15),
    TimeTempData(DateTime.now().subtract(Duration(minutes: 2)), 12),
    TimeTempData(DateTime.now().subtract(Duration(minutes: 1)), 14),
    TimeTempData(DateTime.now(), 13),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TimeTempData, DateTime>> series = [
      charts.Series(
        id: 'Temperature',
        data: data,
        domainFn: (TimeTempData tempData, _) => tempData.time,
        measureFn: (TimeTempData tempData, _) => tempData.temperature,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Temperature Graph')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: charts.TimeSeriesChart(
          series,
          animate: true,
          dateTimeFactory: charts.LocalDateTimeFactory(),
        ),
      ),
    );
  }
}

class TimeTempData {
  final DateTime time;
  final int temperature;

  TimeTempData(this.time, this.temperature);
}
