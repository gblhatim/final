import 'package:app/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class Loginlist extends StatelessWidget {
  late final Future<List<dynamic>> listOfColumns;

  /*ret*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: listconn(),
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    List<Widget> loginl = [];

                    snapshot.data!.forEach((element) {
                      print("test");
                      loginl.add(Row(
                        children: [
                          Container(
                            child: Card(
                              child: Text(element.nom +
                                      "      " +
                                      element.email +
                                      "   " +
                                      element
                                          .etat /* +
                                  "" +
                                  element.id +
                                  "" +
                                  element.password*/
                                  ),
                            ),
                          )
                        ],
                      ));
                    });

                    return Column(
                      children: loginl,
                    );
                  });
            }

            return Center();
          }),
    );
  }

  Future<List<User>> listconn() async {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'gbl',
        db: 'lentonn1_pexicom');
    var conn = await MySqlConnection.connect(settings);
    var userId = 36;

    var results = await conn.query(
        'select nom, email, id, password, etat from connexion_u where id = ?',
        [userId]);

    List<User> list = [];

    for (var row in results) {
      User f = new User(
          nom: "${row[0]}",
          email: "${row[1]}",
          id: "${row[2]}",
          password: "${row[3]}",
          etat: "${row[4]}");

      list.add(f);
    }

    return list;
  }
}
