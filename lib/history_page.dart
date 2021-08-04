import 'package:app/models/Fields.dart';
import 'package:app/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:app/loginlist.dart';

class HistoryPage extends StatelessWidget {
  final User user;
  bool extended = false;
  HistoryPage({Key? key, required this.user}) : super(key: key);

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
                  return historyTile(snapshot.data![index], context);
                });
          }

          return Center();
        });
  }

  Widget historyTile(Fields f, BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 9.0, bottom: 9.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Column(
                  children: [iconType(f.type)],
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("HID : "),
                      Text("Nom : "),
                      Text("Date : "),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          f.id,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          f.nom,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          f.date,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(0.0, -2.0),
              blurRadius: 12.0,
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(0.0, 6.0),
              blurRadius: 12.0,
            ),
          ],
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

  Widget iconType(String f) {
    if (f == "1")
      return Image.asset(
        "assets/sms.png",
        height: 50.0,
        width: 50.0,
      );
    if (f == "2")
      return Image.asset(
        "assets/email.png",
        height: 50.0,
        width: 50.0,
      );
    if (f == "3")
      return Image.asset(
        "assets/both.png",
        height: 50.0,
        width: 50.0,
      );

    return Center();
  }

  Future<List<Fields>> historyData() async {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'gbl',
        db: 'lentonn1_pexicom');

    var conn = await MySqlConnection.connect(settings);

    var userId = user.id;

    var results = await conn.query(
        'select id, nom, date, type_e from liste_env where uid = ?', [userId]);
    conn.close();
    List<Fields> list = [];

    for (var row in results) {
      Fields f;

      f = new Fields(
          id: "${row[0]}",
          nom: "${row[1]}",
          date: "${row[2]}",
          type: "${row[3]}");

      list.add(f);
    }

    return list;
  }

  /*
  return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 9.0, bottom: 9.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: iconType(f.type),
                  ),
                  Expanded(
                    child: Text(
                      f.nom,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      f.id,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      f.date,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(0.0, -2.0),
              blurRadius: 12.0,
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(0.0, 6.0),
              blurRadius: 12.0,
            ),
          ],
        ),
      ),
    );
  */
}
