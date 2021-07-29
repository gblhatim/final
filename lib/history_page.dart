import 'package:app/models/Fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class HistoryPage extends StatelessWidget {
  late final Future<List<dynamic>> listOfColumns;

  /*ret*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: historyData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {}

        return Center();
      },
    );
  }

  /*
  DataRow(
                        cells: <DataCell>[
                          //Extracting from Map element the value

                          DataCell(Text(element["ID"].toString())),
                          DataCell(Text(element["Name"].toString())),
                          DataCell(Text(element["Date"].toString())),
                          DataCell(ElevatedButton(
                              onPressed: historyData, child: Text("test"))),
                        ],
                      )), */

  Future<List<Map<String, dynamic>>> historyData() async {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'gbl',
        db: 'lentonn1_pexicom');
    var conn = await MySqlConnection.connect(settings);
    var userId = 3;

    var results = await conn
        .query('select nom, tele from liste_env where uid = ?', [userId]);

    Map<String, String> map = {};
    List<Map<String, dynamic>> list = [];

    for (var row in results) {
      print('Name: ${row[0]}, email: ${row[1]}');
      map.putIfAbsent("name", () => "${row[0]}");
      map.putIfAbsent("tel", () => "${row[0]}");
      print("map:" + map.toString());

      list.add(map);
    }

    return list;
  }
}
