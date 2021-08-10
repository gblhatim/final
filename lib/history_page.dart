import 'package:app/databasehelper.dart';
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
        future: Databasehelper().historyData(user.id),
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
}
