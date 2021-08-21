import 'package:app/helpers/apiService.dart';
import 'package:app/models/Colorstheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/User.dart';

class StatsPage extends StatelessWidget {
  final User user;
  const StatsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiService().getstat(user.id),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return historyTile(snapshot.data![index], index, context);
                });
          }

          return Center();
        });
  }

  Widget historyTile(String nbr, int genre, BuildContext context) {
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
                  children: [iconType(genre)],
                ),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name(genre),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nbr + " envoyés au total",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colorth.white,
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

  Widget iconType(int f) {
    if (f == 0)
      return Image.asset(
        "assets/sms.png",
        height: 50.0,
        width: 50.0,
      );
    if (f == 1)
      return Image.asset(
        "assets/email.png",
        height: 50.0,
        width: 50.0,
      );
    if (f == 2)
      return Image.asset(
        "assets/both.png",
        height: 50.0,
        width: 50.0,
      );

    return Center();
  }

  String name(int f) {
    if (f == 0) {
      return "SMS";
    }
    if (f == 1) {
      return "Courriels";
    }
    return "";
  }
}
