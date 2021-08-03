import 'package:app/databasehelper.dart';
import 'package:app/history_page.dart';
import 'package:app/home.dart';
import 'package:app/models/User.dart';
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
  late User u = new User.init();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child:
                  getLoginStat() ? HomePage(getLoggedInUser()) : LoginPage())),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ThemeData.light()
              .colorScheme
              .copyWith(primary: Color.fromRGBO(0, 114, 255, 1))),
    );
  }

  bool getLoginStat() {
    bool isLoggedIn = false;

    SharedPreferences.getInstance().then((value) {
      pref = value;
    });

    isLoggedIn = pref.getBool("isLoggedIn")!;

    return isLoggedIn;
  }

  User getLoggedInUser() {
    Databasehelper db = new Databasehelper();

    SharedPreferences.getInstance().then((value) async {
      pref = value;
    });

    db.listconnid(pref.getString("UID")!).then((value) => u = value);

    return u;
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
