import 'package:app/models/Fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:app/loginlist.dart';

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
            List<Widget> historique = [];

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print(snapshot.data![index].id);

                  return historyTile(snapshot.data![index], context);
                });
          }

          return Center();
        });
  }

  Widget historyTile(Fields f, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 2.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 9,
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: Stack(
            children: [
              Positioned(
                top: 20.0,
                child: Text(
                  f.nom,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      backgroundColor: Colors.green),
                ),
              ),
              Positioned(
                top: 40.0,
                right: 10.0,
                child: Text(
                  f.id,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      backgroundColor: Colors.green),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
          color: Colors.red,
        ),
      ),
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
        .query('select nom, tele, id from liste_env where uid = ?', [userId]);

    List<Fields> list = [];

    for (var row in results) {
      Fields f;

      f = new Fields(nom: "${row[0]}", tel: "${row[1]}", id: "${row[2]}");

      list.add(f);
      print("herere");
      print(list.length);
    }

    return list;
  }
}
