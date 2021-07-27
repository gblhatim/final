import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: pexicomSplash(context)));
  }
}

Widget pexicomSplash(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Powered by"),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/pexie.png',
            scale: MediaQuery.of(context).size.width * 0.006,
          )
        ],
      ),
    ),
  );
}
