import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Info(), // Change this to MyHomePage() if it's your main entry point
    );
  }
}

class Info extends HelpPage {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    TableData tableData = TableData(
      title: 'My Table',
      columnTitles: ['Gas', 'Range', 'Effects'],
      cellContents: [
        ["Carbon Monoxide (CO)", "0-50 ppm", "No adverse effects for long-term exposure"],
        ["", "51-200 ppm", "Mild headache, dizziness, nausea"],
        ["", "201-800 ppm", "Headache intensifies, impaired vision"],
        ["", "801-1600 ppm", "Nausea, vomiting, confusion"],
        ["", "1601-3200 ppm", "Headache, dizziness, confusion, unconsciousness"],
        ["", "3201-6400 ppm", "Headache, dizziness, unconsciousness, death"],
        ["", ">6400 ppm", "Fatal within minutes"],
        ["Hydrogen Sulfide (H2S)", "0.0005-0.01 ppm", "Odor threshold"],
        ["", "10 ppm", "Threshold limit value (TLV) for 8-hour exposure"],
        ["", "50 ppm", "Maximum recommended exposure for 10 minutes"],
        ["", "100 ppm", "Immediate danger to life and health"],
        ["", "500-700 ppm", "Rapid unconsciousness, death may occur"],
        ["", ">1000 ppm", "Immediate unconsciousness, death likely"],
        ["Ammonia (NH3)", "25 ppm", "Threshold limit value (TLV) for 8-hour exposure"],
        ["", "35 ppm", "Immediately dangerous to life and health (IDLH)"],
        ["", "300 ppm", "Severe irritation to the eyes, nose, throat"],
        ["", "500 ppm", "Immediate danger to life and health"],
        ["", ">1000 ppm", "Rapidly fatal through inhalation"]
      ],
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomsCard(
            title: 'AIR QUALITY INDEX(AQI)',
            subtitle: 'Understand Air Quality Index',
            child: Image(
              image: AssetImage(
                'assets/images/aqi.png',
              ),
              width:1000,
              height: 300,
            ),
          ),
          CustomsCard(
            title: 'GAS TOXICITY',
            subtitle: 'Relevancy of the gas levels',
            child: TableWidget(tableData: tableData),
          ),
          const CustomsCard(
            title: 'How to interpret Values',
            subtitle:
            'PM2.5 indicates the concentration of fine particle in the air. \n Gas levels indicate the concentration of harmful gases in the air.\n Overall Low level values are better and high values indicate a health risk.',
            child: TextWidget(),
          ),
        ],
      ),
    );
  }
}

class CustomsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const CustomsCard({
    required this.title,
    required this.subtitle,
    required this.child,
    super.key,
  });

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


class TableData {
  final String title;
  final List<String> columnTitles;
  final List<List<String>> cellContents;

  TableData({
    required this.title,
    required this.columnTitles,
    required this.cellContents,
  });
}

class TableWidget extends StatelessWidget {
  final TableData tableData;

  const TableWidget({
    super.key,
    required this.tableData,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: tableData.columnTitles
              .map(
                (title) => TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
              .toList(),
        ),
        ...tableData.cellContents.map(
              (row) => TableRow(
            children: row
                .map(
                  (cell) => TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cell),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'For emergencies please contact \n NEMA: +256-414-425-068 \n MoH(Toll Free): 0800-100-066 \n Police and Hospital: 911',
    );
  }
}