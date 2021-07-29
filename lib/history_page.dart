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
        builder: (context, AsyncSnapshot<List<Fields>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  List<Widget> historique = [];

                  snapshot.data!.forEach((element) {
                    print("test");
                    historique.add(Row(
                      children: [
                        Container(
                          child: Card(
                            child: Text(element.nom + "" + element.tel),
                          ),
                        )
                      ],
                    ));
                  });

                  return Column(
                    children: historique,
                  );
                });
          }

          return Center();
        });
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
                      )), 
                      
                      
                      
                      
                      
                      
                      */

  Future<List<Fields>> historyData() async {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'gbl',
        db: 'lentonn1_pexicom');
    var conn = await MySqlConnection.connect(settings);
    var userId = 36;

    var results = await conn
        .query('select nom, tele from liste_env where uid = ?', [userId]);

    List<Fields> list = [];

    for (var row in results) {
      Fields f = new Fields(nom: "${row[0]}", tel: "${row[1]}");

      list.add(f);
    }

    return list;
  }
}
