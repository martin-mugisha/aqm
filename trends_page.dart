import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class TrendsPage extends StatelessWidget {
  const TrendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThingSpeakChart(
      thingSpeakData: ThingSpeakData(),
    );
  }
}

class ThingSpeakData {
  final List<FlSpot> field1Data = [];
  final List<FlSpot> field2Data = [];
  final List<FlSpot> field3Data = [];

  ThingSpeakData();

  Future<void> fetchData() async {
    final url = Uri.parse('https://api.thingspeak.com/channels/2455669/feeds.json?api_key=ZS30CEUIEABBY6WA&results=20'); // Limiting to last 20 entries
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final feeds = data['feeds'] as List;

      for (var feed in feeds) {
        final field1Value = double.tryParse(feed['field1'] ?? '0.0');
        final field2Value = double.tryParse(feed['field2'] ?? '0.0');
        final field3Value = double.tryParse(feed['field3'] ?? '0.0');

        if (field1Value != null) {
          field1Data.add(FlSpot(field1Data.length.toDouble(), field1Value));
        }

        if (field2Value != null) {
          field2Data.add(FlSpot(field2Data.length.toDouble(), field2Value));
        }

        if (field3Value != null) {
          field3Data.add(FlSpot(field3Data.length.toDouble(), field3Value));
        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}


class ThingSpeakChart extends StatelessWidget {
  final ThingSpeakData thingSpeakData;

  const ThingSpeakChart({super.key, required this.thingSpeakData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: thingSpeakData.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SingleChildScrollView( // Wrap with SingleChildScrollView
            child: Column(
              children: [
                CustomCard(
                  title: 'Particulate Matter (PM)',
                  subtitle: 'Graph showing the trend of particulate matter overtime',
                  child: LineChartCard(dataPoints: thingSpeakData.field1Data),
                ),
                CustomCard(
                  title: 'Liquidized Petroleum Gas (LPG)',
                  subtitle: 'Graph showing the trend of LPG gas matter overtime',
                  child: LineChartCard(dataPoints: thingSpeakData.field2Data),
                ),
                CustomCard(
                  title: 'Smoke',
                  subtitle: 'Graph showing the trend of toxicity overtime',
                  child: LineChartCard(dataPoints: thingSpeakData.field3Data),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}


class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const CustomCard({super.key, required this.title, required this.subtitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class LineChartCard extends StatelessWidget {
  final List<FlSpot> dataPoints;

  const LineChartCard({super.key, required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: dataPoints,
                  isCurved: true,
                  colors: [Colors.blue],
                  belowBarData: BarAreaData(show: true, colors: [Colors.blue.withOpacity(0.3)]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
