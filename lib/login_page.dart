import 'dart:convert';

import 'package:app/databasehelper.dart';
import 'package:app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mysql1/mysql1.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/User.dart';

class LoginPage extends StatelessWidget {
  late BuildContext c;
  late SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    c = context;
    return Container(
        child: Center(
      child: FlutterLogin(
          onRecoverPassword: _recoverPassword,
          onLogin: _authUser,
          onSignup: _authUser,
          logo: 'assets/logo.png',
          hideForgotPasswordButton: true,
          hideSignUpButton: true,
          logoTag: 'assets/logo.png',
          theme: LoginTheme(
              logoWidth: 10.0,
              errorColor: HexColor("#fc5454"),
              primaryColor: HexColor("#e8e9ed"),
              accentColor: Color(0xF6B850),
              textFieldStyle: TextStyle(color: Colors.black),
              buttonTheme:
                  LoginButtonTheme(backgroundColor: HexColor("#0072ff")),
              inputTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Color.fromRGBO(0, 114, 255, 1),
                border: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(212, 214, 222, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(0, 114, 255, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                errorBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(252, 84, 84, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ))),
    ));
  }

//gbl@gmail.com

  Future<String> _authUser(LoginData data) async {
    User f = await Databasehelper().listconn(
        data.name, md5.convert(utf8.encode(data.password)).toString());

    print("test");
    return Future.delayed(Duration(seconds: 1)).then((_) {
      if (Databasehelper.userExists) {
        SharedPreferences.getInstance().then((value) {
          value.setBool("isLoggedIn", true).then(
              (value) => print("setting isloggednin:" + value.toString()));
          value
              .setString("UID", f.id)
              .then((value) => print("setting uid:" + value.toString()));
        });
        Navigator.of(c)
            .push(MaterialPageRoute(builder: (context) => HomePage(f)));
      } else if (!Databasehelper.userExists) {
        SharedPreferences.getInstance().then((value) {
          value.setBool("isLoggedIn", false);
        });

        return 'User not exists';
      }

      return '';
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(Duration(seconds: 1)).then((_) {
      return 'User not exists';
    });
  }
}
