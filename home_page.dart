import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThingSpeakDataFetcher {
  final String apiKey;
  final String channelId;

  ThingSpeakDataFetcher({required this.apiKey, required this.channelId});

  Future<dynamic> fetchDataForField(int fieldNumber) async {
    try {
      final url = Uri.parse('https://api.thingspeak.com/channels/$channelId/fields/$fieldNumber/last.json?api_key=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['field${fieldNumber.toString()}'];
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

class HomePage extends StatefulWidget {
  final ThingSpeakDataFetcher dataFetcher;

  const HomePage({super.key, required this.dataFetcher});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? field1Data;
  String? field2Data;
  String? field3Data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final field1 = await widget.dataFetcher.fetchDataForField(1);
    final field2 = await widget.dataFetcher.fetchDataForField(2);
    final field3 = await widget.dataFetcher.fetchDataForField(3);

    setState(() {
      field1Data = field1;
      field2Data = field2;
      field3Data = field3;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Data'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('PM sensor'),
                    subtitle: Text('value: ${field1Data ?? "N/A"}'),
                  ),
                  ListTile(
                    title: const Text('Liquidized Petroleum Gas'),
                    subtitle: Text('Value: ${field2Data ?? "N/A"}'),
                  ),
                  ListTile(
                    title: const Text('Smoke'),
                    subtitle: Text('Value: ${field3Data ?? "N/A"}'),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Air Quality details'),
                    subtitle: Text(
                      'Air quality details refer to specific information regarding the cleanliness and purity of the air in a given area. This information typically includes data on various pollutants present in the air, such as particulate matter (PM2.5 and PM10), nitrogen dioxide (NO2), sulfur dioxide (SO2), carbon monoxide (CO), and ozone (O3). Air quality details also encompass the Air Quality Index (AQI), which provides a standardized measure of the overall air quality and associated health risks.\n\n Check the current air quality index (AQI) in your area. Monitor pollutant levels such as PM2.5, PM10, NO2, SO2, CO, and O3. Stay informed about air quality trends and take necessary precautions for your health and well-being.'
                    ),

                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Dangers of Poor Air Quality'),
                    subtitle: Text(
                      'Poor air quality poses significant health risks, including respiratory problems such as asthma and bronchitis, cardiovascular diseases, and even premature death. Exposure to pollutants like PM2.5, NO2, and CO can exacerbate existing health conditions and lead to long-term health issues. Children, the elderly, and individuals with pre-existing health conditions are particularly vulnerable. Prolonged exposure to polluted air also increases the risk of lung cancer and other respiratory illnesses. It \'s essential to be aware of air quality hazards and take proactive measures to protect yourself and your loved ones, such as avoiding outdoor activities during high pollution days, using air purifiers indoors, and supporting policies aimed at reducing air pollution levels.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}