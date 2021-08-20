import 'dart:convert';
import 'dart:io';
import 'package:app/apiService.dart';
import 'package:app/models/Fields.dart';
import 'package:app/models/Profiles.dart';
import 'package:http/http.dart' as http;
import 'package:app/home.dart';
import 'package:app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'databasehelper.dart';
import 'models/Colorstheme.dart';
import 'models/User.dart';

void main() async {
  runApp(MyApp());
}

/* does sharedpref flutter support ios and android with same base code ?*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        home: Scaffold(
            body: Center(
                child: MyHomePage(
          title: "app",
        ))),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // fontFamily: "Sanserifiic",
            colorScheme: ThemeData.light()
                .colorScheme
                .copyWith(primary: Colorth.tyellow)),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false;
  String uid = "";

  User u = new User.init();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isLoggedIn ? HomePage(getLoggedInUser()) : LoginPage()
        /*MaterialButton(
        onPressed: () async {
          apiService().getUser("info@laby.ca", "laby@2585");
        },
        child: Text('test'),
      ),*/
        );
  }

  User getLoggedInUser() {
    return u;
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      isLoggedIn = value.getBool("isLoggedIn") ?? false;
      uid = value.getString("UID") ?? "";
      // ignore: unnecessary_null_comparison

      apiService d = new apiService();

      if (uid != "") {
        d.getUserbyID(uid).then((value) {
          u = value;
          setState(() {});
        });
      }
    });
  }
}
