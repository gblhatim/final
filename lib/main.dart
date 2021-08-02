import 'package:app/history_page.dart';
import 'package:app/home.dart';
import 'package:app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

void main() async {
  runApp(MyApp());
}

/* does sharedpref flutter support ios and android with same base code ?*/
class MyApp extends StatelessWidget {
  late SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    /*return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, AsyncSnapshot snapshot) {
        /*if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {*/
        // Loading is done, return the app:
        return MaterialApp(
          home: Scaffold(body: Center(child: LoginPage())),
          theme: ThemeData(
              colorScheme: ThemeData.light()
                  .colorScheme
                  .copyWith(primary: Color.fromRGBO(0, 114, 255, 1))),
        );
        //}
      },
    );*/
/* 1: sms 2:courriel */

    return MaterialApp(
      home: Scaffold(body: Center(child: LoginPage())),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ThemeData.light()
              .colorScheme
              .copyWith(primary: Color.fromRGBO(0, 114, 255, 1))),
    );
  }

  bool getLoginStat() {
    bool isLoggedIn;

    SharedPreferences.getInstance().then((value) {
      pref = value;
      isLoggedIn = pref.getBool("isLoggedIn")!;

      return isLoggedIn;
    });

    return false;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ji"),
    );
  }
}
