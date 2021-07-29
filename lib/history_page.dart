import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, String>> listOfColumns = [
    {"ID": "1", "Name": "AAAAAA", "Date": "13/03/2021", "Type": "SMS"},
    {"ID": "2", "Name": "BBBBBB", "Date": "12/03/2021", "Type": "SMS"},
    {"ID": "3", "Name": "CCCCCC", "Date": "12/03/2021", "Type": "SMS"},
    {"ID": "4", "Name": "DDDDDD", "Date": "13/03/2021", "Type": "SMS"},
  ];
/*texst */
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(
            'ID.',
            textAlign: TextAlign.center,
          )),
          DataColumn(
              label: Text(
            'Nom.',
            textAlign: TextAlign.center,
          )),
          DataColumn(
              label: Text(
            'Date.',
            textAlign: TextAlign.center,
          )),
          DataColumn(
              label: Text(
            'Type.',
            textAlign: TextAlign.center,
          )),
        ],
        rows:
            listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                .map(
                  ((element) => DataRow(
                        cells: <DataCell>[
                          //Extracting from Map element the value

                          DataCell(Text(element["ID"].toString())),
                          DataCell(Text(element["Name"].toString())),
                          DataCell(Text(element["Date"].toString())),
                          DataCell(Text(element["Type"].toString())),
                        ],
                      )),
                )
                .toList(),
      ),
    );
  }
}
